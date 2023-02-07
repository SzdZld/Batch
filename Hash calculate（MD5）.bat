@echo off
set locate= %1
set location = %~p1
certutil -hashfile %locate% MD5 >> MD5.txt
powershell -command "get-content %location%MD5.txt | select-string -pattern 'CertUtil' -notmatch | Out-File %location%MD51.txt"
powershell -command "get-content %location%MD51.txt | select-string -pattern 'MD5' -notmatch | Out-File %location%MD52.txt"

powershell -command "Select-String -Pattern "\w" -Path %location%MD52.txt | ForEach-Object { $_.line} | Set-Content -Path %location%MD5.txt"

powershell -command "remove-item %location%MD51.txt"
powershell -command "remove-item %location%MD52.txt"