
if ( (New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator))
{
    Write-Host "Warning! Running with administrator-privileges is not recommended."
}
Write-Host "Setting Execution Policy to RemoteSigned on CurrentUser..."
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

#check for D drive
if (Test-Path "D:\")
{
    Write-Host "D Drive found, chaning SCOOP to D:\Scoop"
    mkdir "D:\Scoop"
    [environment]::SetEnvironmentVariable("SCOOP", "D:\Scoop", "User")
}

#check for scoop command
if (Get-Command scoop -ErrorAction SilentlyContinue)
{
    Write-Host "Scoop already installed, updating..."
    scoop update
} else {
    Write-Host "Installing Scoop..."
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

#refresh env vars
$env:Path = [Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [Environment]::GetEnvironmentVariable("Path", "User")

Write-Host "Installing Git for bucket support via Scoop..."
scoop install git
Write-Host "Installing Extras bucket..."
scoop bucket add extras
Write-Host "Installing VS Code..."
scoop install vscode
Write-Host "Adding Jabba"
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://github.com/shyiko/jabba/raw/master/install.ps1')
Write-Host "Installing Java 8"
jabba install adopt-openj9@1.8.0-292
Write-Host "Installing Java 17"
jabba install openjdk@1.17.0
Write-Host "Installing IDEA"
scoop install idea
Write-Host "Installing Discord"
scoop install discord
Write-Host "Installing Steam"  
scoop install steam
Write-Host "### Done! ###"