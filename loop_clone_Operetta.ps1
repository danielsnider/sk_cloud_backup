net use z: \\carbon.research.sickkids.ca\rkafri
$base = "OPRETTA\Operetta Raw Data\Mammalian cells"
$log_dir = "Z:\DanielS\Projects\Cloud Backup\logs"

# Get log file list of already done folder backups
$done_folders = Get-ChildItem "$log_dir" | sort LastWriteTime -Descending

# Delete log file of the most recent done folder backup incase it is didn't finish
Remove-Item -path $done_folders[0].FullName

Get-ChildItem "Z:\$base" | ?{ $_.PSIsContainer } | Where{$_.LastWriteTime -gt (Get-Date).AddDays(-265)} |
Foreach-Object {
    
    $target = $_.Name
    
    # Skip folders that are done. ie. of the done folder names, if any match the current target, skip
    if($done_folders.FullName -match $target) {
      echo "Skipping target: $target"
      return
    }

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
