$lzLocalPath = "C:\Users\dylan.graham\OneDrive - Accenture Federal Services\Desktop\ACP4Gov Dev\acpBlueprintsV2\identity"
$assignmentBpPath = "C:\Users\dylan.graham\OneDrive - Accenture Federal Services\Desktop\ACP4Gov Dev\acpBlueprintsV2\identity\blueprintAssignment.json"
$bpName = "IdentityLzBpTest"
$assignmentName = "assignIdentityLzBpTest"
$subscriptionId = "009bdc79-1eee-40cf-a62d-8dd277d1cd26"

Set-AzContext -SubscriptionId $subscriptionId

Import-AzBlueprintWithArtifact -Name $bpName -InputPath $lzLocalPath -Confirm:$false
$bp = Get-AzBlueprint -Name $bpName
Publish-AzBlueprint -Blueprint $bp -Version '1.0'
New-AzBlueprintAssignment -Blueprint $bp -Name $assignmentName -AssignmentFile $assignmentBpPath


#Remove-AzBlueprintAssignment -Name $assignmentName
#Remove-AzResource -ResourceId "/subscriptions/$subscriptionId/providers/Microsoft.Blueprint/blueprints/$bpName" -Force