$host.version - Wyświetla wersję hosta PowerShell.
$PSVersionTable - Wyświetla tablicę zawierającą informacje o wersji PowerShell.
Get-Command - Zwraca listę wszystkich dostępnych poleceń w bieżącej sesji PowerShell.
Test-Connection - Testuje połączenie sieciowe poprzez pingowanie określonego hosta.
Geclst-Member - Wygląda na błąd pisowni. Prawdopodobnie chodziło o Get-Member, które zwraca informacje o właściwościach i metodach obiektu.
Get-ChildItem | Sort-Object -Property Length -Descending - Zwraca listę elementów w bieżącym katalogu, a następnie sortuje je według wielkości w kolejności malejącej (rozmiar pliku).
Get-EventLog - Zwraca zdarzenia z dziennika zdarzeń systemowych.
Get-CimInstance -ClassName Win32_BIOS - Zwraca informacje o BIOS-ie komputera.
Get-CimInstance -ClassName Win32_ComputerSystem | Select-Object -Property SystemType - Zwraca informacje o typie systemu komputerowego.
Get-CimInstance -ClassName Win32_ComputerSystem - Zwraca informacje o systemie komputerowym, takie jak producent, model, nazwa komputera itp.
Get-CimInstance -ClassName Win32_OperatingSystem | Select-Object -Property BuildNumber,BuildType,OSType,ServicePackMajorVersion,ServicePackMinorVersion - Zwraca informacje o systemie operacyjnym, takie jak numer kompilacji, typ, wersja usługi itp.
Ten skrypt można wykorzystać do zbierania różnych informacji diagnostycznych o systemie operacyjnym i sprzęcie komputerowym przy użyciu PowerShell.