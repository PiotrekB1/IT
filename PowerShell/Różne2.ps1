Get-NetAdapter -Name Wi-Fi
Get-NetIPInterface
Get-NetIPInterface -ConnectionState Connected
Get-NetIPConfiguration
netsh interface ip show config

Set-Item wsman:\localhost\client\trustedhosts -Value LAPTOP-Lenovo