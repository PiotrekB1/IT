$SourcePath = C:\Profil
$DestinationPath = \\10.146.0.0\Profil
robocopy.exe $SourcePath $DestinationPath /LOG:c:\log.txt

#--- Mirror -- usuwanie plku
robocopy.exe C:\Empty \\10.146.0.0\Profil /MIR

#--------------------------------------------------------
# This file contains the list of servers you want to copy files/folders to
$computers = Get-Content "C:\PS\Servers.txt"

# This is the file/folder(s) you want to copy to the servers in the $computer variable
$source = "C:\PS\TestFile.txt"

# The destination location you want the file/folder(s) to be copied to
$destination = "c$\ProgramData\TestFolder\"

foreach ($computer in $computers) {
if ((Test-Path -Path \\$computer\$destination)) {
Copy-Item $source -Destination \\$computer\$destination -Verbose
} 

$text = "Computers that did not respond"

else {

$text = $text + "\\$computer\$destination is not reachable or does not exist"

}
}
$text | Export-Csv "c:\List.csv"
}

Remove-Item -Path


wuauclt /updatenow
