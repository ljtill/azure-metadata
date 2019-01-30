Write-Verbose -Message "Terminating Docker containers..." -Verbose
Invoke-Expression -Command "docker kill $(docker ps -a -q)" | Out-Null
Start-Sleep -Seconds 2.5
Write-Verbose -Message "Removing Docker containers..." -Verbose
Invoke-Expression -Command "docker rm $(docker ps -a -q)"| Out-Null
Start-Sleep -Seconds 2.5
Write-Verbose -Message "Removing temporary application directory/files..."
Remove-Item /Users/ljtill/Developer/Tools/azurite/__azurite_db_blob__.json -Force
Remove-Item /Users/ljtill/Developer/Tools/azurite/__azurite_db_table__.json -Force
Remove-Item /Users/ljtill/Developer/Tools/azurite/__blobstorage__/ -Recurse -Force
Start-Sleep -Seconds 2.5
Write-Verbose -Message "Starting Docker container..." -Verbose
Invoke-Expression -Command "docker run -d -t -p 10000:10000 -p 10001:10001 -p 10002:10002 -v /Users/ljtill/Developer/Tools/azurite:/opt/azurite/folder arafato/azurite" | Out-Null