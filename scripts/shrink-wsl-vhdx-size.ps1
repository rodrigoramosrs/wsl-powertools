echo OFF
CLS
ECHO "== WSL IMAGE SIZE OPTIMIZATOR                             =="
ECHO "== REPO: https://github.com/rodrigoramosrs/wsl-powertools =="
ECHO "STOPING SERVICES ..."

net stop com.docker.service
taskkill /IM "docker.exe" /F
taskkill /IM "Docker Desktop.exe" /F
wsl --shutdown
CLS
ECHO "OPTIMIZING WSL FILE SIZE ..."
Optimize-VHD -Path "$($env:LOCALAPPDATA)\Docker\wsl\data\ext4.vhdx" -Mode Full
ECHO "DONE!"