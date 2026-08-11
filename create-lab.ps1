$NodeCloudInit = ".\cloud-init\k8s-node.yaml"
$ShellCloudInit = ".\cloud-init\cka-shell.yaml"

Write-Host "Creating CKA shell..."
multipass launch 24.04 `
    --name cka-shell `
    --cpus 2 `
    --memory 2G `
    --disk 10G `
    --cloud-init $ShellCloudInit

Write-Host "Creating control plane..."
multipass launch 24.04 `
    --name controlplane `
    --cpus 2 `
    --memory 3G `
    --disk 20G `
    --cloud-init $NodeCloudInit

Write-Host "Creating worker01..."
multipass launch 24.04 `
    --name worker01 `
    --cpus 2 `
    --memory 2G `
    --disk 20G `
    --cloud-init $NodeCloudInit

Write-Host "Creating worker02..."
multipass launch 24.04 `
    --name worker02 `
    --cpus 2 `
    --memory 2G `
    --disk 20G `
    --cloud-init $NodeCloudInit

Write-Host "Waiting for cloud-init..."

multipass exec cka-shell -- cloud-init status --wait
multipass exec controlplane -- cloud-init status --wait
multipass exec worker01 -- cloud-init status --wait
multipass exec worker02 -- cloud-init status --wait

Write-Host ""
Write-Host "CKA lab machines are ready:"
multipass list