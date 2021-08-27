$lzLocalPath = "D:\a\az-blueprint-lz\az-blueprint-lz\network"
$assignmentBpPath = "D:\a\az-blueprint-lz\az-blueprint-lz\network\blueprintAssignment.json"
$bpName = "NetworkLzBpTest"
$assignmentName = "assignNetworkLzBpTest"
$subscriptionId = "009bdc79-1eee-40cf-a62d-8dd277d1cd26"

Set-AzContext -SubscriptionId $subscriptionId

Import-AzBlueprintWithArtifact -Name $bpName -InputPath $lzLocalPath -Confirm:$false
$bp = Get-AzBlueprint -Name $bpName
Publish-AzBlueprint -Blueprint $bp -Version '1.0'
New-AzBlueprintAssignment -Blueprint $bp -Name $assignmentName -AssignmentFile $assignmentBpPath


#Remove-AzBlueprintAssignment -Name $assignmentName
#Remove-AzResource -ResourceId "/subscriptions/$subscriptionId/providers/Microsoft.Blueprint/blueprints/$bpName" -Force