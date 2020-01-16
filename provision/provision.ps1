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

New-EventLog -LogName 'Provision' -Source 'provision.ps1'

# Setup Local Admin User
$user = Get-LocalUser | Where-Object { $_.Name -eq 'C3PO' }
if (-not $user) {
	Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message 'Creating C3PO user'
    Create-NewLocalAdmin 'C3PO' (ConvertTo-SecureString -String 'r2d2' -AsPlainText -Force)
	Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message 'Creating C3PO user... Done'
}

Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message 'Setting C3PO user for autologin'
Set-AutoLogon -DefaultUsername 'C3PO' -DefaultPassword 'r2d2'
Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message 'Setting C3PO user for autologin... Done'

# UAC off
Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message 'Turning UAC off'
Set-ItemProperty -Path REGISTRY::HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Policies\System -Name ConsentPromptBehaviorAdmin -Value 0
Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message 'Turning UAC off... Done'

$newComputerName = Read-Host "What this the new name of this computer? "

# Read computer name from provision.ini
if ($env:COMPUTERNAME -ne $newComputerName) {
	Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message "Renaming computer to $newComputerName"
    Rename-Computer -NewName $newComputerName
	Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message "Renaming computer to $newComputerName... Done"
}

$workgroup = (Get-WmiObject -Class Win32_ComputerSystem).Workgroup
if ($workgroup -ne 'POSTAL') {
	Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message "Adding computer to POSTAL workgroup"
    Add-Computer -WorkgroupName 'POSTAL'
	Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message "Adding computer to POSTAL workgroup... Done"
}

# Setup Ansible
Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message "Setting up Ansible"
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/ansible/ansible/devel/examples/scripts/ConfigureRemotingForAnsible.ps1'))
Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message "Setting up Ansible... Done"

Write-EventLog -LogName 'Provision' -Source 'provision.ps1' -EntryType 'Information' -EventID 1 -Message "Restarting computer"
Restart-Computer
