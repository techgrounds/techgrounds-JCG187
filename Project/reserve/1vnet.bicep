
param location string = resourceGroup().location //de locatie die gekoppeld is aan de resourcegroup


resource vnet_1 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: 'Vnet1'
  location: location
  properties: {
    addressSpace: {
       addressPrefixes: [
        '10.0.0.0/8'        
       ]  
    }          
  }
}  


@description('aanmaken van eerste subnet voor de webserver')
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

@description('aanmaken van tweede subnet voor de managementserver')
resource managementsubnet2 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  parent: vnet_1 //hiermee vertel je dat het een subnet is van vnet
  name: 'managementsubnet2' //naam van de subnet
  properties: {
     addressPrefix: '10.10.20.0/24'//subnetadres
     networkSecurityGroup: {
       id: nsg2sub2.id 
     }
  }
}

@description('netwerksecuritygroup voor websubnet1')
resource nsg1sub1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  location: location
  name: 'nsg1sub1'
 }

@description('netwerksecuritygroup voor managementsubnet1')
resource nsg2sub2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  location: location
  name: 'nsg2sub2'
}


