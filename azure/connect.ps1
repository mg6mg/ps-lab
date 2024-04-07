# Set your TenantId and SubscriptionName
$tenantID = "<tenantId>"
$subscriptionName = "<subscriptionName>"

# Connect with Az Powershell
Connect-AzAccount -Tenant $tenantID
$subscriptionId = (Get-AzSubscription -SubscriptionName $subscriptionName).Id
Select-AzSubscription -SubscriptionId $subscriptionId
Get-AzContext

# Connect with Az Command
az login --tenant $tenantID
$subscriptionId = az account subscription list --query "[? contains(displayName, $subscriptionName)].id"
az account set --subscription $subscriptionId
az account show
