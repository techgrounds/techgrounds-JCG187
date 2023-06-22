param location string = resourceGroup().location //de locatie die gekoppeld is aan de resourcegroup
param peeringName1 string = 'peeringvnet1'



//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////VNET1///////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////



@description('aanmaken vnet1')
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
  dependsOn:  [
    vnet_1
  ]
    name: 'nsg1'
 }
     


/////////////////////////////////////////////////////////////////////////////////////
////////////////////////VNET2////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////





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
 
 @description('netwerksecuritygroup voor subnet2')
 resource nsg2sub2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
   location: location
   dependsOn: [
      vnet_2
   ]
   name: 'nsg2'
  }


///////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////PEERING 1 met 2//////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////




  @description('peering vnet1 met vnet2')
  resource peering1met2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
    name: peeringName1
    parent: vnet_1
    properties: {
      allowVirtualNetworkAccess: true
      allowForwardedTraffic: true
      allowGatewayTransit: false
      useRemoteGateways: false
      remoteVirtualNetwork: {
        id: vnet_2.id
      }
      peeringState:'Connected'
      remoteAddressSpace: {
         addressPrefixes: [
           '10.20.0.0/16'
           
         ]
      }
  }
}
 


