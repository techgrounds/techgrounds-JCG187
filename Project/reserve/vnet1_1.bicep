
var virtualnetwork1Name = 'Vnet1'
var Subnet1Name = 'Subnet1'
var NetworkSecurityGroupName = 'nsg1'
var networkInterfaceName = 'Interface1'
var publicIpAddressName = 'PublicIP1'








param location string = resourceGroup().location
resource vnet_1 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualnetwork1Name
  location: location
  properties: {  
    addressSpace: {
       addressPrefixes: [
        '10.10.10.0/24'                        
       ]  
    }           
  }
}  
resource subnet_1 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {  
  parent: vnet_1
  name: Subnet1Name 
  properties: {
     addressPrefix: '10.10.10.0/24'
     privateEndpointNetworkPolicies: 'Enabled'
     privateLinkServiceNetworkPolicies: 'Enabled'
     networkSecurityGroup: {
       id: nsg1sub_1.id
     }
    }
  }
resource nsg1sub_1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {  
  location: location
  properties: {
     securityRules: [
       {
         name: 'RDP'
          properties: {
             priority:1000
              protocol: 'Tcp'
               access: 'Allow'
                direction: 'Inbound' 
                 sourceAddressPrefix: '77.163.53.33'
                  sourcePortRange: '*'
                   destinationAddressPrefix: '*'
                    destinationPortRange: '3389'
          }          
       }
     ]    
  }
  
    name: NetworkSecurityGroupName
 }
resource nic_1 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name:  networkInterfaceName
  location:location
  properties: {
     ipConfigurations: [
       {
         name:'ipconfig1'
          properties: {
             subnet: {
               id:  subnet_1.id
             }
              privateIPAllocationMethod: 'Static'
               privateIPAddress: '10.10.10.50'
               publicIPAddress: {
                 id: publicIp.id
               }
                               
             }
          }       
     ]
  }
}
