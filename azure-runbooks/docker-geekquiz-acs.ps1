<#
    .SYNOPSIS 
        Deploys docekrized solution for testing to Mesos cluseter. Enviroment has Marathon and Chronos running on top of Mesos cluster  
    .DESCRIPTION
        This sample runbooks deploys dockerized solution in to Mesos cluster, after Docker build initiates/triggers webhook
    .PARAMETER 
       No parameter required for this runbook
    .REQUIREMENTS 
        This runbook requires the Azure Resource Manager PowerShell module has been imported into 
        your Azure Automation instance.
        
    .NOTES
        AUTHOR: Aleksandar Dordevic, @Alex_ZZ_, Srdjan Bozovic
        LASTEDIT: January 15, 2016
#>

workflow docker-geekquiz-acs
{

 #Getting json template for ACS
 Write-Output 'Getting json template for ACS'                                 
 $template = (Invoke-WebRequest https://raw.githubusercontent.com/srdjan-bozovic/docker-geekquiz-acs/master/marathon-scripts/geekquiz.json -UseBasicParsing).Content

 #In case there is no previous installation
 try
 {
  #Clearing previous installation
  Write-Output 'Clearing previous installation'                                 
  Invoke-WebRequest -Uri http://acs-cph-cluster.westeurope.cloudapp.azure.com:8080/v2/groups/geekquiz -Method Delete -UseBasicParsing
 }
 catch
 {
 }
 
 #Deploying template   
 Write-Output 'Deploying template'                                 
 Invoke-WebRequest -Uri http://acs-cph-cluster.westeurope.cloudapp.azure.com:8080/v2/groups -Method Post -Headers @{"content-type"="application/json"} -Body $template -UseBasicParsing       
}