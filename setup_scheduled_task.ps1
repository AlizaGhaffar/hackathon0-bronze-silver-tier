# Run this script as Administrator (right-click → Run as Administrator)
# Creates: "AI Employee - Daily Triage" scheduled task

$action = New-ScheduledTaskAction -Execute "claude" -Argument "/triage" -WorkingDirectory "D:\hack0aliza"
$trigger = New-ScheduledTaskTrigger -AtLogOn
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries

Register-ScheduledTask `
    -TaskName "AI Employee - Daily Triage" `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -Description "Runs Claude Code triage on user logon to process pending items in Needs_Action/"

Write-Host "Task created successfully!" -ForegroundColor Green
Write-Host "Verify with: Get-ScheduledTask -TaskName 'AI Employee - Daily Triage'"
