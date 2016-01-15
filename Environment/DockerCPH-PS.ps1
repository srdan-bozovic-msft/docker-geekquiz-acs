<#
    .SYNOPSIS 
        Provision Azure Cluster Service on Azure Platform. Enviroment has Marathon, Swarm and Chronos running on top of Mesos cluster  
    .DESCRIPTION
        This sample script provision Azure Cluster Service on Azure Platform. You only need to change few parameters, and you are good to go.
    .PARAMETER 
       Please use azuredeploy.parameters.json file that is included in this repo
    .REQUIREMENTS 
        This script uses Azure PowerShell, https://azure.microsoft.com/en-gb/documentation/articles/powershell-install-configure/
        
    .NOTES
        AUTHOR: Aleksandar Dordevic, @Alex_ZZ_, Srdjan Bozovic
        LASTEDIT: January 15, 2016
#>


Select-AzureSubscription -SubscriptionId <Insert-your-subscription-ID-Here> #To Get Azure SubscriptionId run Get-AzureSubscription 

#AzureRM Login
Login-AzureRmAccount -SubscriptionId <Insert-your-subscription-ID-Here>



# Mark the start time of the script execution
$startTime = Get-Date

#Create Parameters Object
$parametersACS = @{newStorageAccountNamePrefix = "youracsstorage"; `
            adminUsername = "acs"; `
            adminPassword = "ACSadmin!"; `
            dnsNameForJumpboxPublicIP = "zxc-acs-jumpbox-xplat-xyz"; `
            dnsNameForContainerServicePublicIP = "zxc-acs-cluster-xplat-xyz"; `
            agentCount = 3; `
            masterCount = 3; `
            jumpboxConfiguration = "windows"; ` #Can be linux or windows
            masterConfiguration = "masters-are-agents"; ` #Masters Are or Not Agents
            agentVMSize = "Standard_D1";`
            masterVMSize = "Standard_D1"; `
            jumpboxVMSize = "Standard_D2";` 
            clusterPrefix = "C1";`
            swarmEnabled = "true";`
            chronosEnabled = "true";`
            sshRSAPublicKey = "disabled"                       
             }

New-AzureRmResourceGroup -Name <Neme-for-ARM-Group-Goes-Here> -Location <Location-of-Azure-DataCenter-Goes-Here> 

New-AzureRmResourceGroupDeployment -ResourceGroupName <Neme-for-ARM-Group-Goes-Here> `
                                   -TemplateUri "https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/mesos-swarm-marathon/azuredeploy.json" `
                                   -Force `
                                   -TemplateParameterObject $parametersACS `
                                   -Verbose

# Mark the finish time of the script execution
$finishTime = Get-Date
# Output the time consumed in seconds
$TotalTime = ($finishTime - $startTime).TotalMinutes
Write-Output "The script completed in $TotalTime minutes."

