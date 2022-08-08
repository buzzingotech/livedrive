# Check if computer locked
#$logon = Get-Process LogonUI
#if ($null -ne $logon){
#    exit 1
#}

$liveFolder = Test-Path $env:LOCALAPPDATA\Livedrive

if (!$liveFolder){
    # Create folder
    New-Item -Path $env:LOCALAPPDATA\Livedrive -ItemType Directory
}

$img = Test-Path $env:LOCALAPPDATA\Livedrive\livedrive-screenshot.jpg

if ($img){
    Remove-Item $env:LOCALAPPDATA\Livedrive\livedrive-screenshot.jpg
}

Start-Process $env:programdata\Syncro\bin\livedrive\Livedrive-monitor.exe -ArgumentList "$((Get-Process Livedrive).Id)"
