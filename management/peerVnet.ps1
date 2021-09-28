$vnetSubscriptionId = '009bdc79-1eee-40cf-a62d-8dd277d1cd26'
$vwanSubscriptionId = '009bdc79-1eee-40cf-a62d-8dd277d1cd26'
$vnetName = 'vnet-192.168.6.0_24-dev-management-usgovva'
$vnetResourceGroup = 'rg-network-dev-management-usgovva-arm'
$vhubName = 'hub-dev-network-usgovva'
$vhubResourceGroup = 'rg-network-dev-usgovva'
$connectionName = $vhubName + '_to_' + $vnetName


##Check to validate VHUB is fully provisioned

Set-AzContext -Subscription $vwanSubscriptionId
Get-AzContext
$vhub = Get-AzVirtualHub -ResourceGroupName $vhubResourceGroup -Name $vhubName -ErrorAction SilentlyContinue
Write-Host $vhub.ProvisioningState
while($vhub.ProvisioningState -ne 'Succeeded')
{
    $vhub = Get-AzVirtualHub -ResourceGroupName $vhubResourceGroup -Name $vhubName -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 15
    Write-Host $vhub.ProvisioningState
} 
Write-Host "final vhub provisioning state:" + $vhub.ProvisioningState

##Check to validate rg and virtual network is deployed with a provisioning status of "Succeeded"

Set-AzContext -Subscription $vnetSubscriptionId
$vnetRgCheck = Get-AzResourceGroup -Name $vnetResourceGroup -ErrorAction SilentlyContinue

while ($vnetRgCheck.ProvisioningState -ne "Succeeded") {
    $vnetRgCheck = Get-AzResourceGroup -Name $vnetResourceGroup -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 15
}

Write-Host "final vnet rg provisioning state:" + $vnetRgCheck.ProvisioningState

$vnet = Get-AzVirtualNetwork -ResourceGroupName $vnetResourceGroup -Name $vnetName -ErrorAction SilentlyContinue
while($vnet.ProvisioningState -ne 'Succeeded')
{
    $vnet = Get-AzVirtualNetwork -ResourceGroupName $vnetResourceGroup -Name $vnetName
    Start-Sleep -Seconds 15
}

Write-Host "final vnet provisioning state:" + $vnet.ProvisioningState

##Creating Vhub-Vnet peering

Select-AzSubscription -SubscriptionId $vnetSubscriptionId
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $vnetResourceGroup

Select-AzSubscription -SubscriptionId $vwanSubscriptionId
$defaultRt = Get-AzVHubRouteTable -ResourceGroupName $vhubResourceGroup -VirtualHubName $vhubName -Name "defaultRouteTable"
$hubRt = Get-AzVHubRouteTable -ResourceGroupName $vhubResourceGroup -VirtualHubName $vhubName -Name "hubRouteTable"
$routingConfig = New-AzRoutingConfiguration -AssociatedRouteTable $hubRt.Id -Id @($defaultRt.Id, $hubRt.Id)
New-AzVirtualHubVnetConnection -ResourceGroupName $vhubResourceGroup -VirtualHubName $vhubName -Name $connectionName -RemoteVirtualNetwork $vnet -RoutingConfiguration $routingConfig