<#
    .SYNOPSIS 
        Creates new RG and Dev QA enviroment for testing. Enviroment has Ubuntu Linux with needed Docker bits  
    .DESCRIPTION
        This sample runbooks creates fresh, new QA enviroment after Docker build initiates/triggers webhook
        Note: If you do not uncomment the "Select-AzureSubscription" statement (on line 58) and insert
        the name of your Azure subscription, the runbook will use the default subscription.
    .PARAMETER 
       No parameter required for this runbook
    .REQUIREMENTS 
        This runbook requires the Azure Resource Manager PowerShell module has been imported into 
        your Azure Automation instance.
        
    .NOTES
        AUTHOR: Aleksandar Dordevic, @Alex_ZZ_
        LASTEDIT: Nov 11, 2015
#>

workflow docker-geekquiz-acs
{

 #Getting json template for ACS
 $template = (Invoke-WebRequest https://raw.githubusercontent.com/srdjan-bozovic/docker-geekquiz-acs/master/marathon-scripts/geekquiz.json -UseBasicParsing).Content

 #In case there is no previous installation
 try
 {
  #Clearing previous installation
  Invoke-WebRequest -Uri http://acs-cph-cluster.westeurope.cloudapp:8080/v2/groups/geekquiz -Method Delete
 }
 catch
 {
 }
 
 #Deploy template                    
 Invoke-WebRequest -Uri http://acs-cph-cluster.westeurope.cloudapp:8080/v2/groups -Method Post -Headers @{"content-type"="application/json"} -Body $template       
}