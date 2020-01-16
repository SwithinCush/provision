
$global:powershell = (Join-Path $env:windir "system32\WindowsPowerShell\v1.0\powershell.exe")

Function Restart-AndResume([string] $script, [string] $step)
{
    Restart-AndRun $global:restartKey "$global:powershell $script -step $step"
}
