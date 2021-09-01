$vnetSubscriptionId = '009bdc79-1eee-40cf-a62d-8dd277d1cd26'
$vwanSubscriptionId = '009bdc79-1eee-40cf-a62d-8dd277d1cd26'
$vnetName = 'vnet-192.168.6.0_24-dev-management-usgovva'
$vnetResourceGroup = 'rg-network-dev-management-usgovva-arm'
$vhubName = 'hub-dev-network-usgovva'
$vhubResourceGroup = 'rg-network-dev-usgovva'
$connectionName = $vhubName + '_to_' + $vnetName


Select-AzSubscription -SubscriptionId $vnetSubscriptionId
$vnet = Get-AzVirtualNetwork -Name $vnetName -ResourceGroupName $vnetResourceGroup

Select-AzSubscription -SubscriptionId $vwanSubscriptionId
New-AzVirtualHubVnetConnection -ResourceGroupName $vhubResourceGroup -VirtualHubName $vhubName -Name $connectionName -RemoteVirtualNetwork $vnet

