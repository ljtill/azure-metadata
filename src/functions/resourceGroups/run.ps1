#Requires -Modules @{ ModuleName = "Az.Resources"; ModuleVersion = "1.1.0" }

param ($req, $TriggerMetadata)

$cmdletParameters = $req.Query

$cmdletParameters.ErrorAction = "Stop"

Write-Verbose -Message "PowerShell HTTP trigger function processed a request." -Verbose

Push-OutputBinding -Name res -Value ([HttpResponseContext]@{
    StatusCode = 200
})
