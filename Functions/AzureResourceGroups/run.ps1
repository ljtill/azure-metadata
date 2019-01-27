param ($req, $TriggerMetadata)

Write-Verbose -Message "PowerShell HTTP trigger function processed a request." -Verbose

$status = 200

Push-OutputBinding -Name res -Value ([HttpResponseContext]@{
    StatusCode = $status
})
