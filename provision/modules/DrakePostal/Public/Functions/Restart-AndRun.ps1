
$global:RegRunKey = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run'

Function Restart-AndRun([string]$key, [string] $run)
{
    Set-Key $global:RegRunKey $key $run
    Restart-Computer
    exit
}
