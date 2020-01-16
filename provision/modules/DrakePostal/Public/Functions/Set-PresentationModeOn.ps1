function Set-PresentationModeOn() {
    Set-DisplaySleep -monitor 0 -sleep 0 -screenSaver 0;
    Set-PowerHighPerformance;
}