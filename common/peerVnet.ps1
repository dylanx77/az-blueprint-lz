$vnetSubscriptionId = '009bdc79-1eee-40cf-a62d-8dd277d1cd26'
$vwanSubscriptionId = '009bdc79-1eee-40cf-a62d-8dd277d1cd26'
$vnetName = 'dev-common-vnet-test'
$vnetResourceGroup = 'rg-network-common-dev-eastus'
$vhubName = 'hub-dev-network-usgovva'
$vhubResourceGroup = 'rg-network-dev-usgovva'
$connectionName = $vhubName + '_to_' + $vnetName


Select-AzSubscription -SubscriptionId $vnetSubscriptionId
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $vnetResourceGroup

Select-AzSubscription -SubscriptionId $vwanSubscriptionId
New-AzVirtualHubVnetConnection -ResourceGroupName $vhubResourceGroup -VirtualHubName $vhubName -Name $connectionName -RemoteVirtualNetwork $vnet

