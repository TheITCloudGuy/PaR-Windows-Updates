#This Script will Check for Windows Updates using the PSWindowsUpdate Module and return a 1 if updates are required and 0 if no updates are required.
 function CheckForUpdates {
     $Updates = Get-WUList
     $UpdateCount = Get-WUList
     if ($Updates.Count -gt 0) {
         Write-Host " "
         Write-Host "Updates Available - " $Updates.Count -ForegroundColor Yellow
         Write-Host " "
         foreach ($Update in $Updates) {
            #Get All Windows Updates and Accept All
             Install-WindowsUpdate -AcceptAll -IgnoreReboot
         }
         Write-Host " "
         Write-Host "Updates Complete - " $UpdateCount.Count -ForegroundColor Green
         Write-Host " "
         exit 1
     }
     else {
        #Check for Windows Updates if none are available return success
            $ReCheck = Get-WUList
            if ($ReCheck.Count -gt 0) {
                CheckForUpdates               
            }
            else {
                Write-Host " "
                Write-Host "No Updates Available - " $ReCheck.Count -ForegroundColor Red
                Write-Host " "
                exit 1
            }
     }
 } 

 function ModuleCheck{
    Write-Host " "
    Write-Host "Checking to see if windows installer powershell module is installed..." -ForegroundColor Cyan
    Write-Host " "

    If(-not(Get-InstalledModule pswindowsupdate -ErrorAction silentlycontinue))
    {
        Install-PackageProvider NuGet -Force
        Set-PSRepository PSGallery -InstallationPolicy Trusted
        Install-Module pswindowsupdate -Confirm:$False -Force
    }
 }

 ModuleCheck
 CheckForUpdates
 




