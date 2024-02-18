rundll32.exe user32.dll,LockWorkStation //Blokowanie komputera
Get-CimInstance -ClassName Win32_Desktop
Get-CimInstance -ClassName Win32_BIOS
Get-CimInstance -ClassName Win32_ComputerSystem
Get-CimInstance -ClassName Win32_QuickFixEngineering
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property BuildNumber,BuildType,OSType,ServicePackMajorVersion,ServicePackMinorVersion
Get-CimInstance -ClassName Win32_Service | Select-Object -Property Status,Name,DisplayName