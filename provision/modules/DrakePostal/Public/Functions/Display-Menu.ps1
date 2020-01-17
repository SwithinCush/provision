
Function Display-Menu($MenuStartIndex, $MenuEndIndex, $MenuName, $MenuFunctionName, $MenuOption1, $MenuFunction1, $MenuOption2, $MenuFunction2, $MenuOption3, $MenuFunction3, $MenuOption4, $MenuFunction4, $MenuOption5, $MenuFunction5, $MenuOption6, $MenuFunction6, $MenuOption7, $MenuFunction7, $MenuOption8, $MenuFunction8, $MenuOption9, $MenuFunction9, $MenuOption10, $MenuFunction10)
{
    Write-Host "`n$MenuName`n" -Fore Magenta
    if($MenuOption1 -ne $null){Write-Host "`t`t$MenuOption1" -Fore Green}
    if($MenuOption2 -ne $null){Write-Host "`t`t$MenuOption2" -Fore Green}
    if($MenuOption3 -ne $null){Write-Host "`t`t$MenuOption3" -Fore Green}
    if($MenuOption4 -ne $null){Write-Host "`t`t$MenuOption4" -Fore Green}
    if($MenuOption5 -ne $null){Write-Host "`t`t$MenuOption5" -Fore Green}
    if($MenuOption6 -ne $null){Write-Host "`t`t$MenuOption6" -Fore Green}
    if($MenuOption7 -ne $null){Write-Host "`t`t$MenuOption7" -Fore Green}
    if($MenuOption8 -ne $null){Write-Host "`t`t$MenuOption8" -Fore Green}
    if($MenuOption9 -ne $null){Write-Host "`t`t$MenuOption9" -Fore Green}
    [int]$MenuOption = Read-Host "`n`t`tPlease select an option"

    if(($MenuOption -lt $MenuStart) -or ($MenuOption -gt $MenuEnd)) {
        Write-Host "`t`nPlease select one of the options available.`n" -Fore Red
        Start-Sleep -Seconds 1
        Invoke-Expression $MenuFunctionName
    }
    else {
        if($MenuOption -eq $MenuStart) {Invoke-Expression $MenuFunction1}
        if($MenuOption -eq ($MenuStart + "1")) {Invoke-Expression $MenuFunction2}
        if($MenuOption -eq ($MenuStart + "2")) {Invoke-Expression $MenuFunction3}
        if($MenuOption -eq ($MenuStart + "3")) {Invoke-Expression $MenuFunction4}
        if($MenuOption -eq ($MenuStart + "4")) {Invoke-Expression $MenuFunction5}
        if($MenuOption -eq ($MenuStart + "5")) {Invoke-Expression $MenuFunction6}
        if($MenuOption -eq ($MenuStart + "6")) {Invoke-Expression $MenuFunction7}
        if($MenuOption -eq ($MenuStart + "7")) {Invoke-Expression $MenuFunction8}
        if($MenuOption -eq ($MenuStart + "8")) {Invoke-Expression $MenuFunction9}
        if($MenuOption -eq ($MenuStart + "9")) {Invoke-Expression $MenuFunction10}

    }
}
					  