$host.version
$PSVersionTable

Get-Command
Test-Connection
Geclst-Member

Get-ChildItem | Sort-Object -Property Length -Descending

Get-EventLog 

Get-CimInstance -ClassName Win32_BIOS

Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property SystemType

Get-CimInstance -ClassName Win32_ComputerSystem

Get-CimInstance -ClassName Win32_OperatingSystem |
  Select-Object -Property BuildNumber,BuildType,OSType,ServicePackMajorVersion,ServicePackMinorVersion

