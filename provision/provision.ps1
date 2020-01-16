[CmdletBinding(SupportsShouldProcess=$True)]
param()

################################################################
#
# This script will...
#
# 1. Import module from 'c:\provision\modules' directory'
#
################################################################

Import-Module -Name 'c:\provision\modules\DrakePostal\DrakePostal.psm1' -Verbose -WarningAction Ignore

Invoke-RequireAdmin $MyInvocation

if (TimedPrompt 'Press ANY Key to Abort' 10) {
    exit
}

# Setup Local Admin User
$user = Get-LocalUser | Where-Object { $_.Name -eq 'C3PO' }
if (-not $user) {
    Create-NewLocalAdmin 'C3PO' (ConvertTo-SecureString -String 'r2d2' -AsPlainText -Force)
}

Set-AutoLogon -DefaultUsername 'C3PO' -DefaultPassword 'r2d2'

# UAC off
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0

$newComputerName = Read-Host "What this the new name of this computer? "

# Read computer name from provision.ini
if ($env:COMPUTERNAME -ne $newComputerName) {
    Rename-Computer -NewName $newComputerName
}

$workgroup = (Get-WmiObject -Class Win32_ComputerSystem).Workgroup
if ($workgroup -ne 'POSTAL') {
    Add-Computer -WorkgroupName 'POSTAL'
}

# Setup Ansible
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1'))

Restart-Computer
