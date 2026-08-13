[CmdletBinding()]
param(
    [Parameter(Mandatory, Position = 0)]
    [ValidatePattern('^[A-Za-z0-9][A-Za-z0-9._-]*$')]
    [string] $Name,

    [switch] $LeaveStopped
)

$ErrorActionPreference = "Stop"

$Instances = @(
    "controlplane",
    "worker01",
    "worker02",
    "cka-shell"
)

function Assert-Multipass {
    if (-not (Get-Command multipass -ErrorAction SilentlyContinue)) {
        throw "multipass was not found in PATH."
    }
}

function Assert-InstanceExists {
    param([Parameter(Mandatory)][string] $Instance)

    & multipass info $Instance *> $null

    if ($LASTEXITCODE -ne 0) {
        throw "Multipass instance '$Instance' does not exist."
    }
}

function Assert-SnapshotExists {
    param(
        [Parameter(Mandatory)][string] $Instance,
        [Parameter(Mandatory)][string] $Snapshot
    )

    & multipass info "$Instance.$Snapshot" *> $null

    if ($LASTEXITCODE -ne 0) {
        throw "Required snapshot '$Instance.$Snapshot' does not exist. Nothing has been restored."
    }
}

function Invoke-Multipass {
    param(
        [Parameter(Mandatory)]
        [string[]] $Arguments
    )

    & multipass @Arguments

    if ($LASTEXITCODE -ne 0) {
        throw "multipass $($Arguments -join ' ') failed with exit code $LASTEXITCODE."
    }
}

Assert-Multipass

Write-Host "Preflight checks..."

# Validate the complete checkpoint before touching any VM.
foreach ($Instance in $Instances) {
    Assert-InstanceExists $Instance
    Assert-SnapshotExists -Instance $Instance -Snapshot $Name
}

Write-Host ""
Write-Host "Restoring CKA checkpoint '$Name'..."
Write-Host "This discards the current state of all four lab VMs."

$AllRestored = $false

try {
    Write-Host ""
    Write-Host "Stopping CKA lab VMs..."
    Invoke-Multipass -Arguments (@("stop") + $Instances)

    foreach ($Instance in $Instances) {
        Write-Host "  Restoring $Instance.$Name"

        # --destructive avoids Multipass prompting to create another
        # pre-restore snapshot for every VM.
        Invoke-Multipass -Arguments @(
            "restore",
            "$Instance.$Name",
            "--destructive"
        )
    }

    $AllRestored = $true

    Write-Host ""
    Write-Host "Checkpoint '$Name' restored successfully."
}
finally {
    if ($AllRestored -and -not $LeaveStopped) {
        Write-Host ""
        Write-Host "Starting CKA lab VMs..."

        & multipass start @Instances

        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Restore completed, but one or more VMs failed to start."
        }
    }
    elseif (-not $AllRestored) {
        Write-Warning "Restore did not complete for every VM. The lab has been left stopped to avoid starting a partially restored cluster."
    }
}

if ($AllRestored -and -not $LeaveStopped) {
    Write-Host ""
    Write-Host "Current instances:"
    & multipass list

    Write-Host ""
    Write-Host "Once Kubernetes has started, verify with:"
    Write-Host "  multipass exec controlplane -- kubectl get nodes -o wide"
}
