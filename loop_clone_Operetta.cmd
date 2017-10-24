PowerShell -Command "Set-ExecutionPolicy Unrestricted -Scope CurrentUser" >> "Z:\DanielS\Projects\Cloud Backup\backup_startup.log" 2>&1
cd "Z:\DanielS\Projects\Cloud Backup\"
PowerShell -executionpolicy remotesigned -File "loop_clone_Operetta.ps1" >> "Z:\DanielS\Projects\Cloud Backup\backup_startup.log" 2>&1
