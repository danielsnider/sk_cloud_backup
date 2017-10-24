net use z: \\carbon.research.sickkids.ca\rkafri
$base = "OPRETTA\Operetta Raw Data\Mammalian cells"
$log_dir = "Z:\DanielS\Projects\Cloud Backup\logs"
Remove-Item -path $log_dir\*.log
Get-ChildItem "Z:\$base" | ?{ $_.PSIsContainer } | Where{$_.LastWriteTime -gt (Get-Date).AddDays(-265)} |
Foreach-Object {
    $target = $_.Name
    echo "Rcloning target: $target"
    $date_full = (Get-Date)
    $date = (Get-Date).ToString('yyyyMMdd')
    echo "starting copy today: $date_full"
    
    rclone copy "Z:\$base\$target" dropbox:"\Backup\$base\$target" --log-file "$log_dir\backup_$date_$target.log" --transfers 7 --size-only --filter-from filter-dropbox.txt -v
    <#
    #>
}


# WATCH LOGS
# tail -f /z/DanielS/Projects/Cloud Backup/logs/*
# tail -f /z/DanielS/Projects/Cloud Backup/backup_startup.log
