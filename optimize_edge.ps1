<#
.SYNOPSIS
    Aggressively optimizes Microsoft Edge RAM usage by enforcing policies via Registry.
    Must be run as Administrator.

.DESCRIPTION
    This script modifies the registry to:
    - Enable Sleeping Tabs and set timeout to 5 minutes.
    - Enable Efficiency Mode.
    - Disable Startup Boost.
    - Disable background apps when Edge is closed.
#>

$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Edge"

if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

Write-Host "--- Applying Edge RAM Optimizations ---" -ForegroundColor Cyan

# Enable Sleeping Tabs
Set-ItemProperty -Path $registryPath -Name "SleepingTabsEnabled" -Value 1
Write-Host "[OK] Sleeping Tabs Enabled"

# Set Sleeping Tabs Timeout (300 seconds = 5 minutes)
Set-ItemProperty -Path $registryPath -Name "SleepingTabsTimeout" -Value 300
Write-Host "[OK] Sleeping Tabs Timeout set to 5 minutes"

# Enable Efficiency Mode
Set-ItemProperty -Path $registryPath -Name "EfficiencyModeEnabled" -Value 1
Write-Host "[OK] Efficiency Mode Enabled"

# Disable Startup Boost
Set-ItemProperty -Path $registryPath -Name "StartupBoostEnabled" -Value 0
Write-Host "[OK] Startup Boost Disabled"

# Disable Background Mode (Running apps when closed)
Set-ItemProperty -Path $registryPath -Name "BackgroundModeEnabled" -Value 0
Write-Host "[OK] Background Mode Disabled"

Write-Host "`nOptimizations applied. Please restart Microsoft Edge for changes to take effect." -ForegroundColor Green
