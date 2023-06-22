param location string = resourceGroup().location //de locatie die gekoppeld is aan de resourcegroup



resource vnet_1 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: 'Vnet1'
  location: location
  properties: {
    addressSpace: {
       addressPrefixes: [
        '10.10.0.0/16'                        
       ]  
    }           
  }
}  

@description('aanmaken van subnet1 voor de webserver')
resource websubnet 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  parent: vnet_1 //hiermee vertel je dat het een subnet is van vnet1
  name: 'websubnet1' //naam van de subnet
  properties: {
     addressPrefix: '10.10.10.0/24'//subnetadres
     networkSecurityGroup: {
       id: nsg1sub1.id
     }
    }
  }
@description('netwerksecuritygroup voor subnet1')
resource nsg1sub1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  location: location
    name: 'nsg1'
 }
     


// voor de ubuntu webvm nodig: 1 nic, een public ipadres, een subnet, een os disk, een datadisk, script om apache te 
//installeren 



resource network






resource vm1 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: 'webvm'
  location: location


}
