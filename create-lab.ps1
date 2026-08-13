param(
    [ValidateSet(
        "Create",
        "Networking",
        "Cluster"
    )]
    [string] $From = "Create"
)

$NodeCloudInit  = ".\cloud-init\k8s-node.yaml"
$ShellCloudInit = ".\cloud-init\cka-shell.yaml"

$SwitchName   = "CKA-Lab"
$HostIp       = "10.13.31.1"
$PrefixLength = 24

$Machines = @(
    @{
        Name      = "cka-shell"
        Ip        = "10.13.31.20"
        Mac       = "52:54:00:13:31:20"
        CPUs      = 2
        Memory    = "2G"
        Disk      = "10G"
        CloudInit = $ShellCloudInit
        KubernetesNode = $false
    },
    @{
        Name      = "controlplane"
        Ip        = "10.13.31.10"
        Mac       = "52:54:00:13:31:10"
        CPUs      = 2
        Memory    = "3G"
        Disk      = "20G"
        CloudInit = $NodeCloudInit
        KubernetesNode = $true
    },
    @{
        Name      = "worker01"
        Ip        = "10.13.31.11"
        Mac       = "52:54:00:13:31:11"
        CPUs      = 2
        Memory    = "2G"
        Disk      = "20G"
        CloudInit = $NodeCloudInit
        KubernetesNode = $true
    },
    @{
        Name      = "worker02"
        Ip        = "10.13.31.12"
        Mac       = "52:54:00:13:31:12"
        CPUs      = 2
        Memory    = "2G"
        Disk      = "20G"
        CloudInit = $NodeCloudInit
        KubernetesNode = $true
    }
)

#
# Verify Multipass is using Hyper-V.
#
$Driver = (multipass get local.driver).Trim()

if ($Driver -ne "hyperv") {
    throw @"
This script creates a Hyper-V internal switch, but Multipass is using:

    $Driver

Run:

    multipass networks

and either switch Multipass to Hyper-V or use an existing network from that list.
"@
}

#
# Create a dedicated internal Hyper-V switch.
#
Write-Host "Configuring CKA lab network..."

$Switch = Get-VMSwitch -Name $SwitchName -ErrorAction SilentlyContinue

if (-not $Switch) {
    Write-Host "Creating Hyper-V switch '$SwitchName'..."

    New-VMSwitch `
        -Name $SwitchName `
        -SwitchType Internal | Out-Null
}

$AdapterName = "vEthernet ($SwitchName)"

#
# Give the Windows side of the network a permanent IP.
#
$ExistingHostIp = Get-NetIPAddress `
    -InterfaceAlias $AdapterName `
    -AddressFamily IPv4 `
    -ErrorAction SilentlyContinue |
    Where-Object {
        $_.IPAddress -eq $HostIp
    }

if (-not $ExistingHostIp) {
    Write-Host "Assigning $HostIp/$PrefixLength to host..."

    New-NetIPAddress `
        -InterfaceAlias $AdapterName `
        -IPAddress $HostIp `
        -PrefixLength $PrefixLength | Out-Null
}

#
# Launch VM.
#
function New-LabMachine {
    param (
        [hashtable] $Machine
    )

    Write-Host "Creating $($Machine.Name)..."

    multipass launch 24.04 `
        --name $Machine.Name `
        --cpus $Machine.CPUs `
        --memory $Machine.Memory `
        --disk $Machine.Disk `
        --cloud-init $Machine.CloudInit `
        --network "name=$SwitchName,mode=manual,mac=$($Machine.Mac)"
}

#
# Configure the second NIC inside Ubuntu.
#
function Set-LabStaticIp {
    param (
        [hashtable] $Machine
    )

    $ExpectedAddress = "$($Machine.Ip)/$PrefixLength"

    Write-Host "Assigning $($Machine.Ip) to $($Machine.Name)..."

    #
    # Check every interface, not specifically cka0.
    #
    multipass exec $Machine.Name -- `
        bash -lc "ip -4 -o addr show | grep -Fq '$ExpectedAddress'"

    if ($LASTEXITCODE -eq 0) {
        Write-Host "  Already configured: $ExpectedAddress"

        #
        # Still ensure kubelet has the correct node IP.
        #
        if ($Machine.KubernetesNode) {
            multipass exec $Machine.Name -- `
                sudo bash -c "echo 'KUBELET_EXTRA_ARGS=--node-ip=$($Machine.Ip)' > /etc/default/kubelet"
        }

        return
    }

    #
    # Match the additional NIC by MAC address, but DON'T rename it.
    #
    $Netplan = @"
network:
  version: 2
  ethernets:
    cka-lab:
      match:
        macaddress: "$($Machine.Mac)"
      dhcp4: false
      addresses:
        - $ExpectedAddress
"@

    $EncodedNetplan = [Convert]::ToBase64String(
        [Text.Encoding]::UTF8.GetBytes($Netplan)
    )

    Write-Host "  Writing Netplan configuration..."

    multipass exec $Machine.Name -- `
        bash -lc "echo '$EncodedNetplan' | base64 -d | sudo tee /etc/netplan/10-cka-static.yaml >/dev/null"

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to write Netplan configuration for $($Machine.Name)."
    }

    multipass exec $Machine.Name -- `
        sudo chmod 600 /etc/netplan/10-cka-static.yaml

    #
    # Validate before applying.
    #
    multipass exec $Machine.Name -- `
        sudo netplan generate

    if ($LASTEXITCODE -ne 0) {
        throw "Invalid Netplan configuration for $($Machine.Name)."
    }

    Write-Host "  Bringing lab interface up..."

    #
    # We already know its MAC, so discover the actual Linux interface name.
    #
    $Interface = (
        multipass exec $Machine.Name -- `
            bash -lc "ip -o link | awk -v mac='$($Machine.Mac)' 'tolower(`$0) ~ tolower(mac) {gsub(`":`", `"`", `$2); print `$2}'"
    ).Trim()

    if (-not $Interface) {
        throw "Could not find lab NIC with MAC $($Machine.Mac) on $($Machine.Name)."
    }

    Write-Host "  Found interface: $Interface"

    #
    # Configure it immediately.
    #
    # Netplan remains the persistent configuration for future boots.
    #
    multipass exec $Machine.Name -- `
        sudo ip link set $Interface up

    multipass exec $Machine.Name -- `
        sudo ip addr replace $ExpectedAddress dev $Interface

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to configure $ExpectedAddress on $($Machine.Name)."
    }

    #
    # Verify.
    #
    multipass exec $Machine.Name -- `
        bash -lc "ip -4 -o addr show | grep -Fq '$ExpectedAddress'"

    if ($LASTEXITCODE -ne 0) {
        throw "Static IP $ExpectedAddress was not configured on $($Machine.Name)."
    }

    Write-Host "  Configured: $ExpectedAddress on $Interface"

    #
    # Kubernetes nodes must advertise the permanent lab address.
    #
    if ($Machine.KubernetesNode) {
        multipass exec $Machine.Name -- `
            sudo bash -c "echo 'KUBELET_EXTRA_ARGS=--node-ip=$($Machine.Ip)' > /etc/default/kubelet"

        if ($LASTEXITCODE -ne 0) {
            throw "Failed to configure kubelet node IP on $($Machine.Name)."
        }

        multipass exec $Machine.Name -- `
            sudo systemctl daemon-reload

        multipass exec $Machine.Name -- `
            sudo systemctl restart kubelet
    }
}

function Invoke-MultipassBash {
    param (
        [Parameter(Mandatory)]
        [string] $Instance,

        [Parameter(Mandatory)]
        [string] $Script
    )

    # PowerShell scripts on Windows normally use CRLF.
    # Bash inside Linux expects LF, so remove carriage returns.
    $Script = $Script.Replace("`r", "")

    multipass exec $Instance -- bash -lc $Script

    if ($LASTEXITCODE -ne 0) {
        throw "Bash command failed on '$Instance' with exit code $LASTEXITCODE."
    }
}

#
# Launch all machines.
#
if ($From -eq "Create") {
    foreach ($Machine in $Machines) {
        New-LabMachine $Machine
    }

    Write-Host ""
    Write-Host "Waiting for cloud-init..."

    foreach ($Machine in $Machines) {
        Write-Host "Waiting for $($Machine.Name)..."

        multipass exec $Machine.Name -- `
            cloud-init status --wait
    }
}

#
# Assign permanent addresses.
#
if ($From -in @("Create", "Networking")) {
    Write-Host ""
    Write-Host "Configuring static lab addresses..."

    foreach ($Machine in $Machines) {
        Set-LabStaticIp $Machine
    }

    #
    # Add convenient hostname mappings to all VMs.
    #
$Hosts = @"

# CKA lab
10.13.31.10 controlplane
10.13.31.11 worker01
10.13.31.12 worker02
10.13.31.20 cka-shell
"@

    $EncodedHosts = [Convert]::ToBase64String(
        [Text.Encoding]::UTF8.GetBytes($Hosts)
    )

    foreach ($Machine in $Machines) {
        multipass exec $Machine.Name -- `
            bash -c "echo '$EncodedHosts' | base64 -d | sudo tee -a /etc/hosts > /dev/null"
    }
}

# ---------------------------------------------------------------------------
# Kubernetes cluster bootstrap
# ---------------------------------------------------------------------------

$ControlPlaneIp       = "10.13.31.10"
$ControlPlaneEndpoint = "controlplane:6443"
$PodNetworkCidr       = "10.244.0.0/16"

# Official Flannel release manifest.
$FlannelManifest = `
    "https://github.com/flannel-io/flannel/releases/latest/download/kube-flannel.yml"


Write-Host ""
Write-Host "================================================="
Write-Host " Initialising Kubernetes cluster"
Write-Host "================================================="
Write-Host ""

#
# Sanity check before doing anything destructive/expensive.
#
Write-Host "Checking Kubernetes tooling..."

foreach ($Node in @("controlplane", "worker01", "worker02")) {
    $CheckCommand = "set -e; command -v kubeadm >/dev/null; command -v kubelet >/dev/null; command -v containerd >/dev/null"

    multipass exec $Node -- bash -lc $CheckCommand

    if ($LASTEXITCODE -ne 0) {
        throw "Kubernetes tooling is missing on $Node. Check k8s-node.yaml."
    }

    Write-Host "  $Node OK"
}


# ---------------------------------------------------------------------------
# Initialise control plane
# ---------------------------------------------------------------------------

Write-Host ""
Write-Host "Initialising control plane..."

multipass exec controlplane -- `
    sudo kubeadm init `
        "--apiserver-advertise-address=$ControlPlaneIp" `
        "--control-plane-endpoint=$ControlPlaneEndpoint" `
        "--pod-network-cidr=$PodNetworkCidr"

if ($LASTEXITCODE -ne 0) {
    throw "kubeadm init failed."
}


# ---------------------------------------------------------------------------
# Configure kubectl on controlplane
# ---------------------------------------------------------------------------

Write-Host ""
Write-Host "Configuring kubectl on controlplane..."

$ConfigureKubectl = 'set -e; mkdir -p "$HOME/.kube"; sudo cp /etc/kubernetes/admin.conf "$HOME/.kube/config"; sudo chown "$(id -u):$(id -g)" "$HOME/.kube/config"'

multipass exec controlplane -- bash -lc $ConfigureKubectl

if ($LASTEXITCODE -ne 0) {
    throw "Failed to configure kubectl on controlplane."
}


# ---------------------------------------------------------------------------
# Install Flannel
# ---------------------------------------------------------------------------

Write-Host ""
Write-Host "Installing Flannel..."

multipass exec controlplane -- `
    kubectl apply -f $FlannelManifest

if ($LASTEXITCODE -ne 0) {
    throw "Failed to install Flannel."
}


# ---------------------------------------------------------------------------
# Force Flannel to use the permanent lab NIC
#
# Without this Flannel may choose Multipass's DHCP/NAT interface.
# ---------------------------------------------------------------------------

Write-Host "Configuring Flannel to use cka0..."

$FlannelPatch = @"
spec:
  template:
    spec:
      containers:
        - name: kube-flannel
          args:
            - --ip-masq
            - --kube-subnet-mgr
            - --iface=eth1
"@

$EncodedFlannelPatch = [Convert]::ToBase64String(
    [Text.Encoding]::UTF8.GetBytes($FlannelPatch)
)

multipass exec controlplane -- `
    bash -lc "echo '$EncodedFlannelPatch' | base64 -d > /tmp/flannel-patch.yaml"

multipass exec controlplane -- `
    kubectl `
        --namespace kube-flannel `
        patch daemonset kube-flannel-ds `
        --patch-file /tmp/flannel-patch.yaml

if ($LASTEXITCODE -ne 0) {
    throw "Failed to configure Flannel interface."
}


# ---------------------------------------------------------------------------
# Wait for control plane networking
# ---------------------------------------------------------------------------

Write-Host ""
Write-Host "Waiting for Flannel..."

multipass exec controlplane -- `
    kubectl `
        --namespace kube-flannel `
        rollout status daemonset/kube-flannel-ds `
        --timeout=180s

if ($LASTEXITCODE -ne 0) {
    throw "Flannel failed to become ready."
}


# ---------------------------------------------------------------------------
# Create worker join command
# ---------------------------------------------------------------------------

Write-Host ""
Write-Host "Generating kubeadm join command..."

$JoinCommand = (
    multipass exec controlplane -- `
        kubeadm token create --print-join-command
).Trim()

if (-not $JoinCommand.StartsWith("kubeadm join")) {
    throw "Could not obtain kubeadm join command: $JoinCommand"
}

Write-Host ""
Write-Host "Join command:"
Write-Host $JoinCommand
Write-Host ""


# ---------------------------------------------------------------------------
# Join workers
# ---------------------------------------------------------------------------

foreach ($Worker in @("worker01", "worker02")) {
    Write-Host "Joining $Worker..."

    multipass exec $Worker -- `
        bash -lc "sudo $JoinCommand"

    if ($LASTEXITCODE -ne 0) {
        throw "Failed to join $Worker."
    }
}


# ---------------------------------------------------------------------------
# Wait for all Kubernetes nodes
# ---------------------------------------------------------------------------

Write-Host ""
Write-Host "Waiting for all Kubernetes nodes to become Ready..."

multipass exec controlplane -- `
    kubectl wait `
        --for=condition=Ready `
        node/controlplane `
        node/worker01 `
        node/worker02 `
        --timeout=300s

if ($LASTEXITCODE -ne 0) {
    Write-Warning "Not all nodes reached Ready state within timeout."
}


# ---------------------------------------------------------------------------
# Give cka-shell kubectl access
# ---------------------------------------------------------------------------

Write-Host ""
Write-Host "Configuring kubectl access from cka-shell..."

$EncodedAdminConfig = (
    multipass exec controlplane -- `
        sudo base64 -w 0 /etc/kubernetes/admin.conf
).Trim()

if ($LASTEXITCODE -ne 0 -or -not $EncodedAdminConfig) {
    throw "Failed to read admin.conf from controlplane."
}

multipass exec cka-shell -- bash -lc `
    "mkdir -p ~/.kube && echo '$EncodedAdminConfig' | base64 -d > ~/.kube/config && chmod 600 ~/.kube/config"

if ($LASTEXITCODE -ne 0) {
    throw "Failed to configure kubectl on cka-shell."
}

# ---------------------------------------------------------------------------
# Verify cluster
# ---------------------------------------------------------------------------

Write-Host ""
Write-Host "================================================="
Write-Host " Kubernetes cluster ready"
Write-Host "================================================="
Write-Host ""

multipass exec controlplane -- `
    kubectl get nodes -o wide

Write-Host ""

multipass exec controlplane -- `
    kubectl get pods -A

Write-Host ""
Write-Host "Cluster topology:"
Write-Host ""
Write-Host "  controlplane  10.13.31.10"
Write-Host "  worker01      10.13.31.11"
Write-Host "  worker02      10.13.31.12"
Write-Host "  cka-shell     10.13.31.20"
Write-Host ""
Write-Host "  Pod CIDR      10.244.0.0/16"
Write-Host "  API endpoint  controlplane:6443"
Write-Host ""

Write-Host "Test from exam shell with:"
Write-Host ""
Write-Host "  multipass shell cka-shell"
Write-Host "  kubectl get nodes"
Write-Host ""

Write-Host ""
Write-Host "CKA lab machines are ready:"
multipass list

Write-Host ""
Write-Host "Static lab addresses:"
Write-Host "  controlplane  10.13.31.10"
Write-Host "  worker01      10.13.31.11"
Write-Host "  worker02      10.13.31.12"
Write-Host "  cka-shell     10.13.31.20"
Write-Host ""
Write-Host "Host:"
Write-Host "  Windows       10.13.31.1"