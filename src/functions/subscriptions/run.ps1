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
            $subscriptions = Get-AzSubscription
            $subscriptionNames = $subscriptions.Name
            $subscriptionNames | ForEach-Object {
                Write-Verbose -Message ("Subscription: " + $_) -Verbose
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
