#Requires -Modules @{ ModuleName = "Az.Resources"; ModuleVersion = "1.1.0" }

param ($req, $TriggerMetadata)

$cmdletParameters = $req.Query
$cmdletParameters.ErrorAction = "Stop"

function Invoke-Trigger {

    param (
        [Parameter()]
        $req,

        [Parameter()]
        $TriggerMetadata
    )

    begin {
        Write-Verbose -Message "PowerShell HTTP trigger function processed a request." -Verbose
    
        $pass = ConvertTo-SecureString $env:SECRET -AsPlainText -Force
        $cred = New-Object -TypeName pscredential -ArgumentList $env:APPLICATIONID, $pass
        Connect-AzAccount -ServicePrincipal -Tenant $env:TENANTID -Credential $cred
    }
    
    process {
        $pass = ConvertTo-SecureString $env:SECRET -AsPlainText -Force
        $cred = New-Object -TypeName pscredential -ArgumentList $env:APPLICATIONID, $pass
        Connect-AzAccount -ServicePrincipal -Tenant $env:TENANTID -Credential $cred
    }
    
    end {
        Write-Verbose -Message "PowerShell HTTP trigger function completed a request." -Verbose
    }
}

Invoke-Trigger -req $req -TriggerMetadata $TriggerMetadata

Push-OutputBinding -Name res -Value ([HttpResponseContext]@{
    StatusCode = 200
})
