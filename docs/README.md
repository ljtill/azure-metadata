# Azure Metadata

## Pre-requistes

### Azurite
```shell
docker rm $(docker ps -a -q)

docker pull arafato/azurite

docker run -d -t -p 10000:10000 -p 10001:10001 -p 10002:10002 -v /path/to/folder:/opt/azurite/folder arafato/azurite
```

### PSDepends
```powershell
Invoke-PSDepends
```
