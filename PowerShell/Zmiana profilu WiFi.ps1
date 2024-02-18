#---- Test komunikacji --------
$names = Get-content "C:\Zakres_IP.txt"
foreach($name in $names)
   {
    if(Test-Connection -ComputerName $name -Count 1 -ErrorAction SilentlyContinue)
        {
            Write-Host "$name is up" -ForegroundColor Green
            $output_up+="$name is up,"+"`n"
        }
    else
        {
            Write-Host "$name is down" -ForegroundColor Red
            $output_down+="$name is down,"+"`n"
        }
      }
    $output_up | Out-File "C:\Up\Adresy_IP.txt"
    $output_down | Out-File "C:\Down\Adresy_IP.txt"
  Start-Sleep -s 15

#--- wyświetlanie profili WiFi -----
netsh wlan show profiles

#--- export profilu WiFi ------
netsh wlan export profile WMS1856 key=clear

#--- kopiowanie plku -----
$computers = Get-Content "C:\Up\Adresy_IP.txt"
$fileToCopy = "C:\Profil\profil.xml"
ForEach($computer in $computers){
    Copy-Item -Path $fileToCopy -Destination "\\$computer\C$\Profil"
}

#--- usuwanie plku -----
$computers = Get-Content "C:\Up\Adresy_IP.txt"
$fileToCopy = "C:\Profil\profil.xml"
ForEach($computer in $computers){
    Remove-Item -Path $fileToCopy -Destination "\\$computer\C$\Profil"
}

#--- Import na komputery -----
$computers = Get-Content "C:\Up\Adresy_IP.txt"
ForEach($computer in $computers){
psexec \\$computer netsh wlan add profile filename=”C:\Profil\nazwa.xml”
}



