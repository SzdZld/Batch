@echo off
set locate= %1
set location = %~p1

set /p var=请输入您想执行的哈希值算法（MD2,MD4,MD5,%var%,SHA256,SHA384,SHA512)----
echo 正在计算该文件的%var%值  


certutil -hashfile %locate% %var% >> %var%.txt
powershell -command "get-content %location%%var%.txt | select-string -pattern 'CertUtil' -notmatch | Out-File %location%%var%1.txt"
powershell -command "get-content %location%%var%1.txt | select-string -pattern '%var%' -notmatch | Out-File %location%%var%2.txt"

powershell -command "Select-String -Pattern "\w" -Path %location%%var%2.txt | ForEach-Object { $_.line} | Set-Content -Path %location%%var%.txt"

powershell -command "remove-item %location%%var%1.txt"
powershell -command "remove-item %location%%var%2.txt"