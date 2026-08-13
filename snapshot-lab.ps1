[CmdletBinding()]
param(
    [Parameter(Mandatory, Position = 0)]
    [ValidatePattern('^[A-Za-z0-9][A-Za-z0-9._-]*$')]
    [string] $Name,

    [string] $Comment = "",

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

function Assert-SnapshotDoesNotExist {
    param(
        [Parameter(Mandatory)][string] $Instance,
        [Parameter(Mandatory)][string] $Snapshot
    )

    & multipass info "$Instance.$Snapshot" *> $null

    if ($LASTEXITCODE -eq 0) {
        throw "Snapshot '$Instance.$Snapshot' already exists."
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

foreach ($Instance in $Instances) {
    Assert-InstanceExists $Instance
    Assert-SnapshotDoesNotExist -Instance $Instance -Snapshot $Name
}

Write-Host ""
Write-Host "Stopping CKA lab VMs..."

$Stopped = $false

try {
    Invoke-Multipass -Arguments (@("stop") + $Instances)
    $Stopped = $true

    Write-Host ""
    Write-Host "Creating checkpoint '$Name'..."

    foreach ($Instance in $Instances) {
        Write-Host "  $Instance"

        $Arguments = @(
            "snapshot",
            $Instance,
            "--name",
            $Name
        )

        if ($Comment) {
            $Arguments += @("--comment", $Comment)
        }

        Invoke-Multipass -Arguments $Arguments
    }

    Write-Host ""
    Write-Host "Checkpoint '$Name' created successfully for all four VMs."
}
finally {
    if ($Stopped -and -not $LeaveStopped) {
        Write-Host ""
        Write-Host "Starting CKA lab VMs..."

        & multipass start @Instances

        if ($LASTEXITCODE -ne 0) {
            Write-Warning "The snapshots were created, but one or more VMs failed to start."
        }
    }
}

Write-Host ""
Write-Host "Snapshots:"
& multipass list --snapshots
