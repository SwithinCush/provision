####################################################
#
# This script creates a $profile
# and sources in modules

Import-Module -Name 'C:\provision\modules\DrakePostal\DrakePostal.psm1' -WarningAction Ignore

Invoke-RequireAdmin $MyInvocation

if (TimedPrompt 'Press ANY Key to Abort' 10) {
    exit
}

Copy-Item –Path “C:\provision\Modules\*” –Destination “$env:ProgramFiles\WindowsPowerShell\Modules” –Recurse

Install-Module -Name PSWindowsUpdate
