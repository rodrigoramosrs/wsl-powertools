echo OFF
CLS
Write-Host "== WSL IMAGE SIZE OPTIMIZATOR                             =="
Write-Host "== REPO: https://github.com/rodrigoramosrs/wsl-powertools =="

#Requires -RunAsAdministrator
$hyperv = Get-WindowsOptionalFeature -FeatureName Microsoft-Hyper-V-All -Online
# Check if Hyper-V is enabled
if($hyperv.State -eq "Enabled") {
    Write-Host "STOPING SERVICES ..."

    net stop com.docker.service
    taskkill /IM "docker.exe" /F
    taskkill /IM "Docker Desktop.exe" /F
    wsl --shutdown

    Write-Host "OPTIMIZING WSL SIZE ..."
    Optimize-VHD -Path "$($env:LOCALAPPDATA)\Docker\wsl\data\ext4.vhdx" -Mode Full
    Write-Host "DONE!"
} else {
    Write-Host "Hyper-V is disabled. To reduce WSL image size you need to install Hyper-V"
    Write-Host "command: Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Hyper-V -All"
}