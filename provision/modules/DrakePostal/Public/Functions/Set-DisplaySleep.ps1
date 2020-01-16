function Set-DisplaySleep {
	[CmdletBinding(SupportShouldProcess=$True)]
	param(
		[int]$monitor = 15, 
		[int]$sleep = 30, 
		[int]$screenSaver = 10) 
	)
	
    POWERCFG -change -standby-timeout-ac $sleep;
    POWERCFG -change -monitor-timeout-ac $monitor;
    Set-ScreenSaverTimeout $screenSaver;
}