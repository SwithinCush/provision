[CmdletBinding(SupportsShouldProcess=$True)]
param()

################################################################
#
# This script will...
#
# 1. Import module from 'c:\provision\modules' directory'
#
################################################################

Import-Module -Name 'c:\provision\modules\DrakePostal\DrakePostal.psm1' -WarningAction Ignore

Invoke-RequireAdmin $MyInvocation

Write-Host "
  _____                _     _             
 |  __ \              (_)   (_)            
 | |__) | __ _____   ___ ___ _  ___  _ __  
 |  ___/ '__/ _ \ \ / / / __| |/ _ \| '_ \ 
 | |   | | | (_) \ V /| \__ \ | (_) | | | |
 |_|   |_|  \___/ \_/ |_|___/_|\___/|_| |_|
                                           
" -Fore Cayan

if (TimedPrompt 'Press ANY Key to Abort' 10) {
    exit
}

# Setup Local Admin User
$user = Get-LocalUser | Where-Object { $_.Name -eq 'C3PO' }
if (-not $user) {
    Write-Host 'Setting up C3PO User' -Fore Green
    Create-NewLocalAdmin 'C3PO' (ConvertTo-SecureString -String 'r2d2' -AsPlainText -Force)
    Write-Host 'Setting C3PO to be default login user' -Fore Green
    Set-AutoLogon -DefaultUsername 'C3PO' -DefaultPassword 'r2d2'
    Write-Host 'Done' -Fore Green
}


# UAC off
Write-Host 'Turning UAC off' -Fore Green
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
Write-Host 'Done' -Fore Green

$newComputerName = Read-Host "`nWhat this the new name of this computer? "
$newComputerName = $newComputerName.ToUpper()

# Read computer name from provision.ini
if ($env:COMPUTERNAME -ne $newComputerName) {
    Write-Host "Setting computer name to $newComputerName" -Fore Green
    Rename-Computer -NewName $newComputerName
    Write-Host 'Done' -Fore Green
}

$workgroup = (Get-WmiObject -Class Win32_ComputerSystem).Workgroup
if ($workgroup -ne 'POSTAL') {
    Write-Host 'Adding computer to POSTAL workgroup' -Fore Green
    Add-Computer -WorkgroupName 'POSTAL'
    Write-Host 'Done' -Fore Green
}

# Setup Ansible
Write-Host 'Setting up Ansible settings' -Fore Green
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1'))
Write-Host 'Done' -Fore Green

Write-Host 'Restarting Computer in 10 seconds' -Fore Green
Start-Sleep -Seconds 10
Restart-Computer
