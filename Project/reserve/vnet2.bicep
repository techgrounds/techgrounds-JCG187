param location string = resourceGroup().location //de locatie die gekoppeld is aan de resourcegroup
param networkName2 string = 'Vnet2-Mngm'
param subnetName2 string = 'Subnet2-Mngm'
param networkSecurityGroupName2 string = 'nsg2-Mngm'
param vnetAddressPrefix2 string = '10.20.20.0/24'
param subnetAddressPrefix2 string = '10.20.20.0/25'




//vnet 2
resource vnet_2 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: networkName2
  location: location
  properties: {
    addressSpace: {
       addressPrefixes: [
        vnetAddressPrefix2                        
       ]  
    }      
  }
}  

//subnet2 van vnet2
resource subnet_2 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  parent: vnet_2 
  name: subnetName2 
  properties: {
     addressPrefix: subnetAddressPrefix2
     networkSecurityGroup: {
       id: nsg_2.id 
     }
    }
}

//nsg2 voor subnet2
resource nsg_2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  location: location
  name: networkSecurityGroupName2
 }






output vnet2ResourceName string = vnet_2.name
output subnet2ResourceId string = subnet_2.id
