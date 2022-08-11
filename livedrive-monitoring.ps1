# Check if LiveDrive folder exists
$liveFolder = Test-Path $env:LOCALAPPDATA\Livedrive

if (!$liveFolder){
    # Create folder
    New-Item -Path $env:LOCALAPPDATA\Livedrive -ItemType Directory
}

# Check if computer locked
$logon = Get-Process LogonUI
if ($null -ne $logon){
    exit 1
}

Start-Transcript -Path "$env:LOCALAPPDATA\Livedrive\script.log"

$livedrive = Get-Process Livedrive

if (!$livedrive){
    # Start LiveDrive
    Start-Process ${env:ProgramFiles(x86)}\Livedrive\Livedrive.exe
    Start-Sleep -Seconds 30
}

$process = $livedrive | Select-Object -Last 1

$img = Test-Path $env:LOCALAPPDATA\Livedrive\livedrive-screenshot.jpg

if ($img){
    Remove-Item $env:LOCALAPPDATA\Livedrive\livedrive-screenshot.jpg
}

Start-Process $env:programdata\Syncro\bin\livedrive\Livedrive-monitor.exe -ArgumentList "$($process.Id)"
