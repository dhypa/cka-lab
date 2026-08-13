[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$Instances = @(
    "controlplane",
    "worker01",
    "worker02",
    "cka-shell"
)

if (-not (Get-Command multipass -ErrorAction SilentlyContinue)) {
    throw "multipass was not found in PATH."
}

$Csv = & multipass list --snapshots --format csv

if ($LASTEXITCODE -ne 0) {
    throw "Unable to list Multipass snapshots."
}

$Snapshots = $Csv |
    ConvertFrom-Csv |
    Where-Object { $_.Instance -in $Instances }

if (-not $Snapshots) {
    Write-Host "No snapshots found for the CKA lab."
    exit 0
}

$Snapshots |
    Sort-Object Snapshot, Instance |
    Format-Table Instance, Snapshot, Parent, Comment -AutoSize
