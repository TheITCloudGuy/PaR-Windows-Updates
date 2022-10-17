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


#Check if PSWindowsUpdate Is Installed
if ($Updates.Count -gt 1 ) 
    {
         Write-Host "Windows Updates Required."  
         Exit 1   
        
    }
    else
    {
        Write-Host "No Windows Updates Required" 
        Exit 0
    }

    