﻿function Set-PowerPlan ($powerPlan = "balanced") {
    try {
        $powerPlan = $powerPlan.toLower()
        $perf = powercfg -l | %{if($_.toLower().contains($powerPlan)) {$_.split()[3]}}
        $currentPlan = $(powercfg -getactivescheme).split()[3]

        if ($currentPlan -ne $perf) {
            powercfg -setactive $perf
        }
    } catch {
        Write-Warning -Message "Unabled to set power plan to $powerPlan"
    }
}