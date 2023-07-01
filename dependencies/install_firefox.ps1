$workdir = "c:\installer\"
If (Test-Path -Path $workdir -PathType Container)
{ Write-Host "$workdir already exists" -ForegroundColor Red}
ELSE
{ New-Item -Path $workdir  -ItemType directory }
$source = "https://download.mozilla.org/?product=firefox-latest&os=win64&lang=en-US"
$destination = "$workdir\firefox.exe"
if (Get-Command 'Invoke-Webrequest')
{
     Invoke-WebRequest $source -OutFile $destination
}
else
{
    $WebClient = New-Object System.Net.WebClient
    $webclient.DownloadFile($source, $destination)
}
Start-Process -FilePath "$workdir\firefox.exe" -ArgumentList "/S"
Start-Sleep -s 35
rm -Force $workdir/firefox*
