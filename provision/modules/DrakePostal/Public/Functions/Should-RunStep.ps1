
$global:started = $false

Function Should-RunStep([string]$prospectStep) 
{
    if ($global:startingStep -eq $prospectStep -or $global:started) {
        $global:started = $true
    }
    return $global:started
}
