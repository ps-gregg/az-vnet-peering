return

$SubscriptionId = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
$TenantId = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
Connect-AzureAD -TenantId $TenantId 
Connect-AzAccount -Tenant $TenantId -SubscriptionId $SubscriptionId -Scope Process


$SubscriptionId = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
$TenantId = 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx'
# Set the context to the correct subscription
Set-AzContext  -Subscription $SubscriptionId -TenantId $TenantId

# Build the Resource Group
$resourceGroupName = 'TRANSIT-NET-EAST-RG'
$tag = @{ Environment = 'DEV' }
If ($null -eq (Get-AzResourceGroup -Name $resourceGroupName -ea SilentlyContinue)) {
    New-AzResourceGroup -Name $resourceGroupName -Location "eastus" -Tag $tag
}

# Test the Parameters and Template
$resourceGroupName = 'TRANSIT-NET-EAST-RG'
$templateFilePath = 'template.json'
$parametersFilePath = 'parameters.json'
Test-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -Mode Incremental -TemplateFile $templateFilePath -TemplateParameterFile $parametersFilePath -Verbose

# Build the Parameters and Template
$resourceGroupName = 'TRANSIT-NET-EAST-RG'
$templateFilePath = 'template.json'
$parametersFilePath = 'parameters.json'
New-AzResourceGroupDeployment -Name "TRANSIT-NET-EAST-RG.BuildVnet" -ResourceGroupName $resourceGroupName -Mode Incremental -TemplateFile $templateFilePath -TemplateParameterFile $parametersFilePath -Force -Verbose

