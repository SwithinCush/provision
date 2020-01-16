
$global:restartKey = 'Restart-And-Resume'

Function Clear-AnyRestart
{
	[CmdletBinding(SupportShouldProcess=$True)]
	param(
		[string]$key=$global:restartKey
	)
	
    if (Test-Key $global:RegRunKey $key) {
        Remove-Key $global:RegRunKey $key
    }
}
