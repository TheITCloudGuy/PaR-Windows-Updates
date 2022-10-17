
try{
    Write-Host " "
    Write-Host "Checking to see if windows installer powershell module is installed..." -ForegroundColor Cyan
    Write-Host " "

    If(-not(Get-InstalledModule pswindowsupdate -ErrorAction silentlycontinue))
    {
        Install-PackageProvider NuGet -Force
        Set-PSRepository PSGallery -InstallationPolicy Trusted
        Install-Module pswindowsupdate -Confirm:$False -Force
    }


    Import-Module PSWindowsUpdate

    $Updates = Get-WUList

    foreach ($Update in $Updates) {
        Install-WindowsUpdate -AcceptAll -IgnoreReboot
    }

    $UpdateCount = Get-WUHistory

    Write-Host " "
    Write-Host "Updates Complete - " $UpdateCount.Count -ForegroundColor Green
    Write-Host " "
    exit 0 

}
catch{ $errMsg = $_.Exception.Message
    Write-host $errMsg
    exit 1
    }


