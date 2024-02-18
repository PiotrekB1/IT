#------ Pingowanie po adresach w sieci ------
$names=Get-content "D:\hname.txt"
foreach($name in $names){
if(Test-Connection -ComputerName $name -Count 1 -ErrorAction SilentlyContinue){
Write-Host "$name is up" -ForegroundColor Green
$output+="$name is up,"+"`n"
}
else{
Write-Host "$name is down" -ForegroundColor Red
$output+="$name is down,"+"`n"
}
}
$output | Out-File "D:\result.txt"
Start-Sleep -s 15

#----- wyświetlenie profili WiFi -----
netsh wlan show profiles

#----- export profili do pliku -----
netsh wlan export profile key=clear folder="D:\Profile_WiFi"