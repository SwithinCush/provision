
Set-ExecutionPolicy Unrestricted -Scope Process -Force -Verbose

Import-Module -Name 'c:\provision\modules\DrakePostal\DrakePostal.psm1' -Verbose -WarningAction Ignore

Invoke-RequireAdmin $MyInvocation -Verbose

# http://patorjk.com/software/taag/#p=display&f=Standard&t=Provision
 Write-Host "
  ____                 _     _             
 |  _ \ _ __ _____   _(_)___(_) ___  _ __  
 | |_) | '__/ _ \ \ / / / __| |/ _ \| '_ \ 
 |  __/| | | (_) \ V /| \__ \ | (_) | | | |
 |_|   |_|  \___/ \_/ |_|___/_|\___/|_| |_|

"

Write-Host "
  ____  _           _      _                     
 / ___|| |__  _   _| |_ __| | _____      ___ __  
 \___ \| '_ \| | | | __/ _` |/ _ \ \ /\ / / '_ \ 
  ___) | | | | |_| | || (_| | (_) \ V  V /| | | |
 |____/|_| |_|\__,_|\__\__,_|\___/ \_/\_/ |_| |_|
                                                                                              
"

Write-Host 'Updating Virus Signatures'
Update-MpSignature -Verbose

Write-Host 'Performing a Quick Virus Scan'
Start-MpScan -ScanType QuickScan -Verbose

Write-Host 'Removing any virus threats'
Remove-MpThreat -Verbose | Out-File "c:\provision\logs\$(get-date -f yyyy-MM-dd)-RemoveVirusTreats.log" -force

Write-Host 'Updating Windows'
Install-WindowsUpdate -AcceptAll -Install -AutoReboot | Out-File "c:\provision\logs\$(get-date -f yyyy-MM-dd)-WindowsUpdate.log" -force

Write-Host 'Done (Waiting for 10 seconds)'
Start-Sleep -Second 10
