cGet-Content -Encoding Default
Write-Host "Starting..." -ForegroundColor Red
Write-Host "Piotrek..." -BackgroundColor DarkMagenta -ForegroundColor Yellow
Set-Alias gd Get-Disk
gd
Get-Alias gd
Remove-item alias:\gd
Get-Command -Noun *ipaddr*
Get-Help Get-Process
Get-Help Get-Process -ShowWindow
Get-Help Get-Process -Examples
Get-Help *computer*
Get-Help Checkpoint-Computer
Get-Command -noun *disk*
Get-Command -Module WindowsUpdate
Get-Help Get-Content
Get-Help about_redirection
Get-Help About*
//---------------------------------
Get-NetAdapter
Get-NetAdapter -Name *Ethernet*
Get-NetAdapter -Name *Ethernet* -Physical
Get-ItemProperty -Path C:\Windows
Get-ItemProperty -Path C:\users,C:\windows
Get-ItemProperty -Path $folders='c:\users','c:\windows'
Get-ItemProperty $FoldersFromFile = Get-content C:\temp\files.txt 
*---------------------------------
Restart-Computer -WhatIf
Stop-Computer -WhatIf
Stop-Computer -Confirm
ls c:\windows > c:\temp\listing.txt
del C:\temp\listing.txt -Confirm
del C:\temp\listing.txt #Nie było dodatkowych pytań
*---------------------------------
Get-Command *printer*
Get-Printer
Get-Printer -Name XeroxWorkCentre
Get-Content C:\temp\a.txt | Out-printer -Name XeroxWorkCentre 
lub 
'Hello printer!' | Out-printer -Name XeroxWorkCentre
Get-PrintJob -PrinterName XeroxWorkCentre
Get-PrintJob -PrinterName XeroxWorkCentre | out-file c:\temp\printjobs.txt
Get-PrintJob -PrinterName XeroxWorkCentre | Out-GridView
Get-PrintJob -PrinterName XeroxWorkCentre | Get-Member
Get-Printer -Name XeroxWorkCentre | Get-Member
Get-PrintJob -PrinterName XeroxWorkCentre -ID 8
Remove-PrintJob -PrinterName XeroxWorkCentre -ID 8 Get-PrintJob -PrinterName XeroxWorkCentre
Get-PrintJob -PrinterName XeroxWorkCentre | Remove-PrintJob 
Get-PrintJob -PrinterName XeroxWorkCentre
*---------------------------------
Get-Process
Get-Process | Sort-Object CPU lub Get-Process | Sort-Object -Property CPU
Get-Process | Sort-Object -Property CPU -Descending
Get-Process | Sort-Object -Property Name, CPU -Descending
Get-Process | Get-Member lub Get-Process | GM
Get-Process | Sort-Object -Property TotalProcessorTime -Descending
*---------------------------------
Get-HotFix
Get-HotFix | Measure-Object
Get-ChildItem Cert:\LocalMachine -Recurse
Get-ChildItem Cert:\LocalMachine -Recurse | Measure-Object
Get-ChildItem Cert:\LocalMachine -Recurse | Measure-Object -Property NotAfter -Minimum
ls -Recurse c:\windows\system | measure -Property Length -Minimum
ls -Recurse c:\windows\system | measure -Property Length -Maximum

Get-ChildItem C:\C# | Sort -Property Length -Descending

Get-Volume
Get-Volume| GM
Get-Volume | Select DriveLetter, Size, SizeRemaining
Get-Volume | Select DriveLetter, Size, SizeRemaining | Sort SizeRemaining -Descending
Get-Volume | Select DriveLetter, Size, SizeRemaining | Sort SizeRemaining -Descending | Select -First 1
Get-Process
Get-Process | Sort CPU -Descending
Get-Process | Sort CPU -Descending | Select -First 5
Get-EventLog -LogName Application -Newest 1000
Get-EventLog -LogName Application -Newest 1000 | Select -Property Source
Get-EventLog -LogName Application -Newest 1000 | Select -Property Source -Unique