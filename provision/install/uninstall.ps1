####################################################
#
# This script creates a $profile
# and sources in modules

Import-Module -Name 'C:\provision\modules\DrakePostal\DrakePostal.psm1' -WarningAction Ignore

Invoke-RequireAdmin $MyInvocation

if (TimedPrompt 'Press ANY Key to Abort' 10) {
    exit
}

Remove-Item –Path "$env:ProgramFiles\WindowsPowerShell\Modules\DrakePostal\*" -Recursive
