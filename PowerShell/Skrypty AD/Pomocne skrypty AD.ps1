# Tworzenie grupy w AD o nazwie Serwis domenie Firma
dsadd group "CN=Serwis,CN=Users,DC=Firma,DC=local" -secgrp yes -scope g 

# Tworzenie konta
$Password = Read-Host -AsSecureString 
>> New-LocalUser "user100" -Password $Password -FullName "user100" -Description "Konto Servisowe"

# Dodanie konta do grupy
dsmod group "CN=Serwis,CN=Users,DC=Firma,DC=local" addmbr "CN=user100,CN=Users,DC=Firma,DC=local"