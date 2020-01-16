function Set-ScreenSaverTimeout([Int32]$value)
{
    $seconds = $value * 60
    Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name ScreenSaveTimeOut -Value $seconds

    if ($value -eq 0) {
        Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name ScreenSaveActive -Value 0
    }
    else {
        Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop\' -Name ScreenSaveActive -Value 1
    }
}