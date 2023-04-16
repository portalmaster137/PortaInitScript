
if ( (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    Write-Host "Warning! Running with administrator-privileges is not recommended."
}
Write-Host "Installing Scoop..."
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
Write-Host "Installing Git for bucket support via Scoop..."
scoop install git
Write-Host "Installing Extras bucket..."
scoop bucket add extras
Write-Host "Installing VS Code..."
scoop install vscode
Write-Host "Adding Jabba"
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://github.com/shyiko/jabba/raw/master/install.ps1')