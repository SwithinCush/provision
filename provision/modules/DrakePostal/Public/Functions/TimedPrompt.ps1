
Function TimedPrompt($prompt, $secondsToWait) {
    Write-Host -NoNewline $prompt
    $secondsCounter = 0
    $subConter = 0

    While ( (!$host.UI.RawUI.KeyAvailable) -and ($secondsCounter -lt $secondsToWait) ) {
        Start-Sleep -m 10
        $subCounter = $subCounter + 10
        if ($subCounter -eq 1000) {
            $secondsCounter++
            $subCounter = 0
            Write-Host -NoNewline '.'
        }
        If ($secondsCounter -eq $secondsToWait) {
            Write-Host "`r`n"
            return $false
        }
    }
    Write-Host "`r`n"
    return $true
}
