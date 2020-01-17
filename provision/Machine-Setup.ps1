[CmdletBinding(SupportsShouldProcess=$True)]
param()

################################################################
#
# This script will...
#
# 1. Import module from 'c:\provision\modules' directory'
#
################################################################

Import-Module -Name 'c:\provision\modules\DrakePostal\DrakePostal.psm1'

Invoke-RequireAdmin $MyInvocation

Write-Host "
  _____                _     _             
 |  __ \              (_)   (_)            
 | |__) | __ _____   ___ ___ _  ___  _ __  
 |  ___/ '__/ _ \ \ / / / __| |/ _ \| '_ \ 
 | |   | | | (_) \ V /| \__ \ | (_) | | | |
 |_|   |_|  \___/ \_/ |_|___/_|\___/|_| |_|
                                           
" -Fore Cyan

Write-Host "
   _____      _               
  / ____|    | |              
 | (___   ___| |_ _   _ _ __  
  \___ \ / _ \ __| | | | '_ \ 
  ____) |  __/ |_| |_| | |_) |
 |_____/ \___|\__|\__,_| .__/ 
                       | |    
                       |_|    
" -Fore Green

Function Menu_Exit {
    Exit
}

Function Menu_ini_Save {
	Write-Host 'Saving...'
	Menu_Main
}


Function Menu_ini {
	Write-Host 'Not implemented yet.' -Fore Red
	do {
		Display-Menu 1 2 'Edit provision.ini' Menu_ini `
			'1. Save and Exit' Menu_ini_Save `
			'2. Exit without saving' Menu_Main
	} while ($true)
}

Function Menu_Guest {
	Write-Host 'Guest Setup.' -Fore Red
	. c:\provision\scripts\setup_guest.ps1
}

Function Menu_POS {
	Write-Host 'POS Setup.' -Fore Red
}

Function Menu_Server {
	Write-Host 'Server Setup.' -Fore Red
}

Function Menu_Other {
	Write-Host 'Other Setup.' -Fore Red
}

Function Menu_Main {
    do {
		Display-Menu 1 6 'Provision Machine Setup' Menu_Main `
				'1. Setup provision.ini' Menu_ini `
				'2. Setup Guest Machine' Menu_Guest `
				'3. Setup POS Machine' Menu_POS `
				'4. Setup Server Machine' Menu_Server `
				'5. Setup Other' Menu_Other `
				'6. Quit' Menu_Exit
	} while ($true)
}


Menu_Main
