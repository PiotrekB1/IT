# Dodawanie grupy Serwis
dsadd group "CN=Serwis, CN=Users, DC=Firma, DC=local" -secgrp yes -scope g

# Tworzenie użytkownika - user100 z hasłem Password
$Password = Read-Host -AsSecureString
New-LocalUser "user100" -Password $Password -FullName "user100" -Description "Konto serwisowe"

# Dodawanie do grup
dsmod group "CN=Serwis, CN=Users, DC=firma, DC=local" -addmbr "CN=user100, CN=Users, DC=firma, DC=local"

# Tworzenie wielu użytkowników
dsadd user "CN=informatyk1,OU=informatycy,DC=firma,DC=local" -samid informatyk01 -upn informatyk01@firma.loca -pwd L@to2018! -mustchpwd yes -canchpwd yes -disabled no
dsadd user "CN=informatyk2,OU=informatycy,DC=firma,DC=local" -samid informatyk02 -upn informatyk02@firma.loca -pwd L@to2018! -mustchpwd yes -canchpwd yes -disabled no
dsadd user "CN=informatyk3,OU=informatycy,DC=firma,DC=local" -samid informatyk03 -upn informatyk03@firma.loca -pwd L@to2018! -mustchpwd yes -canchpwd yes -disabled no