#Check if PSWindowsUpdate Is Installed
if (Get-Module -ListAvailable -Name PSWindowsUpdate) 
    {
         Write-Host "Windows Updates Required."  
         Exit 1   
        
    }
    else
    {
        Write-Host "No Windows Updates Required" 
        Exit 0
    }
