##########################################################################
#
# This script shows a timeout menu
# (Y)es to continue with install
# (N)o to exit
# Default is No.
#
# If the script is being run from a location other than c:\provision,
#  copy the files from this directory to c:\provision
#
# Continue executing c:\provision\install.ps1
#
##########################################################################



#Get the path where this script is
$autorunDir = Split-Path -parent $PSCommandPath

Import-Module -Name "$autorunDir\provision\modules\DrakePostal\DrakePostal.psm1" -WarningAction Ignore

Invoke-RequireAdmin $MyInvocation

if (-not (TimedPrompt 'Press ANY Key to Continue Install' 10)) {
    exit
}

if ($autorunDir -ne 'C:\provision') {
    
    #Make a new drive with Provision's source follder as the root.
    New-PSDrive -Name 'Source' -PSProvider 'FileSystem' -Root "$autorunDir\provision"

    if (-not (Test-Path 'c:\provision')) {
        MD 'c:\provision'
    }

    #Make a new drive with Provision's destination folder as the root.
    New-PSDrive -Name 'Dest' -PSProvider 'FileSystem' -Root 'c:\provision'

    Copy-Item -Path 'Source:\*' -Destination 'Dest:' -Recurse -Force

    #Be a good citizen and remove the drive we created
    Remove-PSDrive -Name Dest
    Remove-PSDrive -Name Source
}

. 'c:\provision\install\install.ps1'
