<#
    .SYNOPSIS 
        Provision Azure Cluster Service on Azure Platform. Enviroment has Marathon, Swarm and Chronos running on top of Mesos cluster  
    .DESCRIPTION
        This sample script provision Azure Cluster Service on Azure Platform. You only need to change few parameters, and you are good to go.
    .PARAMETER 
       Please use azuredeploy.parameters.json file that is included in this repo
    .REQUIREMENTS 
        This script uses Azure CLI, more details #https://azure.microsoft.com/en-us/documentation/articles/xplat-cli-azure-resource-manager/  
        
        
    .NOTES
        AUTHOR: Aleksandar Dordevic, @Alex_ZZ_, Srdjan Bozovic
        LASTEDIT: January 15, 2016
#>


#Set the Azure Resource Manager mode
azure config mode arm

#azure login #Log in to your Azure Tenant
azure login

#selecting subscription
azure account set <Insert-your-subscription-Name-Here> #Please put your subscription name

# Mark the start time of the script execution
$startTime = Get-Date 

#Creates a new resource group & deploy cluster
azure group create -n '<Neme-for-ARM-Group-Goes-Here>' -l '<Location-of-Azure-DataCenter-Goes-Here>' --template-uri `
'https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/mesos-swarm-marathon/azuredeploy.json' `
-e '<link-to-Parameters-file___azuredeploy.parameters.json>' -v #Please replace path to azuredeploy.parameters.json file and edit it to fit your need.

#Show status of Deploymenmt
azure group deployment list <Neme-for-ARM-Group-Goes-Here>
azure group deployment show <Neme-for-ARM-Group-Goes-Here>

# Mark the finish time of the script execution
$finishTime = Get-Date
# Output the time consumed in seconds
$TotalTime = ($finishTime - $startTime).TotalMinutes
Write-Output "The script completed in $TotalTime minutes."





             
             