# Check if LiveDrive folder exists
$liveFolder = Test-Path $env:LOCALAPPDATA\Livedrive

if (!$liveFolder){
    # Create folder
    New-Item -Path $env:LOCALAPPDATA\Livedrive -ItemType Directory
    Write-Host "LocalApp LiveDrive folder not found. The folder was created"
}

Start-Transcript -Path "$env:LOCALAPPDATA\Livedrive\script.log"

# Check if computer locked
$logon = Get-Process LogonUI
if ($null -ne $logon){
    Write-Host "LogonUI process found running. Exiting script"
    exit 1
}

$livedrive = Get-Process Livedrive

if (!$livedrive){
    # Start LiveDrive
    Start-Process ${env:ProgramFiles(x86)}\Livedrive\Livedrive.exe
    Write-Host "LiveDrive process was not running. Opening..."
    Start-Sleep -Seconds 30
}

$process = $livedrive | Select-Object -Last 1

$img = Test-Path $env:LOCALAPPDATA\Livedrive\livedrive-screenshot.jpg

if ($img){
    Remove-Item $env:LOCALAPPDATA\Livedrive\livedrive-screenshot.jpg
}

Write-Host "Starting executablee task"

Start-Process $env:programdata\Syncro\bin\livedrive\Livedrive-monitor.exe -ArgumentList "$($process.Id)"
