
Function Set-MaxResDisplays {
    $IDs = gwmi -NameSpace 'root\wmi' -Class WmiMonitorId

    # This gies the available resolutions
    $monitors = gwmi -N 'root\wmi' -Class WmiMonitorListedSupportedSourceModes

    foreach($monitor in $monitors) {
        # Get the id for this monitor
        $currentId = $IDs |? { $_.InstanceName -eq $monitor.InstanceName }

        # Sort the availale modes by
        $sortedModes = $monitor.MonitorSourceModes | sort -property { $_.HorizontalActivePixels * $_.VerticalActivePixels }
        Write-Output $sortedModes

        #$maxModes = $sortedModes | select @{N="MaxRes";E={"$($_.HorizontalActivePixels)x$($_.VerticalActivePixels)"}}

        #$mode = ($sortedModes | select -last 1)
        #
        #Write-Output "Horizontal: $mode.HorizontalActivePixels"
        #Write-Output "Vertical: $mode.VerticalActivePixels"
    }

}
