param location string = resourceGroup().location //de locatie die gekoppeld is aan de resourcegroup


@description('aanmaken van vnet2 voor management server')
resource vnet_2 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: 'Vnet2'
  location: location
  properties: {
    addressSpace: {
       addressPrefixes: [
        '10.20.0.0/16'                        
       ]  
    }      
  }
}  

@description('aanmaken van subnet2 voor de managementserver')
resource managementsubnet2 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  parent: vnet_2 //hiermee vertel je dat het een subnet is van vnet2
  name: 'managementsubnet2' //naam van de subnet
  properties: {
     addressPrefix: '10.20.20.0/24'//subnetadres
     networkSecurityGroup: {
       id: nsg2sub2.id 
     }
    }
}

@description('netwerksecuritygroup voor subnet1')
resource nsg2sub2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  location: location
  dependsOn: [
     vnet_2
  ]
  name: 'nsg2'
 }


