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
        try {
            Write-Verbose -Message "Azure authentication processed a request." -Verbose
            $azureClientSecret = ConvertTo-SecureString $env:AzureClientSecret -AsPlainText -Force
            $azureCredential = New-Object -TypeName pscredential -ArgumentList $env:AzureClientId, $azureClientSecret
            Connect-AzAccount -ServicePrincipal -Tenant $env:AzureTenantId -Credential $azureCredential | Out-Null
            Write-Verbose -Message "Azure authentication completed a request." -Verbose
        }
        catch {
            Write-Warning -Message "PowerShell HTTP trigger function encountered an error."
            Write-Error $_
            return
        }
    }
    
    process {
        try {
            $resourceGroups = Get-AzResourceGroup
            $resourceGroupNames = $resourceGroups.ResourceGroupName
            $resourceGroupNames | ForEach-Object {
                Write-Verbose -Message ("Resource Group: " + $_) -Verbose
            }
        }
        catch {
            Write-Warning -Message "PowerShell HTTP trigger function encountered an error."
            Write-Error $_
            return
        }
    }
    
    end {
        Write-Verbose -Message "PowerShell HTTP trigger function completed a request." -Verbose
    }
}

Invoke-Trigger -req $req -TriggerMetadata $TriggerMetadata

Push-OutputBinding -Name res -Value ([HttpResponseContext]@{
    StatusCode = 200
})
