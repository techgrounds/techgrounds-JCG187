param location string = resourceGroup().location //de locatie die gekoppeld is aan de resourcegroup
param peeringName string = 'peeringWinMan'



//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////VnetA WINDOWS WEBSERVER/////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////



@description('aanmaken vnet1')
resource Vnet1Web 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: 'Vnet1-WebServer'
  location: location
  properties: {
    addressSpace: {
       addressPrefixes: [
        '10.10.10.0/24'                        
       ]  
    }           
  }
}  


//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////VnetA WEBSUBNET////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////



@description('aanmaken van subnet1 voor de webserver')
resource Subnet1Win 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  parent: Vnet1Web //hiermee vertel je dat het een subnet is van vnet_1
  name: 'Subnet1-WebServer' //naam van de subnet
  properties: {
     addressPrefix: '10.10.10.0/25'//subnetadres
     networkSecurityGroup: {
       id: nsg1sub1.id
     }
    }
  }


//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////VnetA NSG/////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////


@description('netwerksecuritygroup voor subnet1')
resource nsg1sub1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  location: location
  dependsOn:  [
    Vnet1Web
  ]
    name: 'nsg1'          
 }
     


/////////////////////////////////////////////////////////////////////////////////////
////////////////////////VNET2////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////





 @description('aanmaken van vnet2 voor management server')
 resource Vnet2Man 'Microsoft.Network/virtualNetworks@2022-11-01' = {
   name: 'Vnet2-ManageServer'
   location: location
   properties: {
     addressSpace: {
        addressPrefixes: [
         '10.20.20.0/24'                        
        ]  
     }      
   }
 }  


 /////////////////////////////////////////////////////////////////////////////////////
////////////////////////SUBNET2////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
 
 @description('aanmaken van subnet2 voor de managementserver')
 resource Subnet2Man 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
   parent: Vnet2Man //hiermee vertel je dat het een subnet is van vnet2
   name: 'SubNet2-ManageServer' //naam van de subnet
   properties: {
      addressPrefix: '10.20.20.0/25'//subnetadres
      networkSecurityGroup: {
        id: nsg2sub2.id 
      }
     }
 }
 
 @description('netwerksecuritygroup voor subnet2')
 resource nsg2sub2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
   location: location
   dependsOn: [
      Vnet2Man
   ]
   name: 'nsg2'
  }


///////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////PEERING 1 met 2//////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////




  @description('peering vnet1 met vnet2')
  resource peeringWinwithMan 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {
    name: '${Vnet1Web}-To-${Vnet2Man}'
    parent: Vnet1Web
    properties: {            
      allowVirtualNetworkAccess: true
      allowForwardedTraffic: true
      allowGatewayTransit: true
      useRemoteGateways: false      
      peeringState:'Connected'       
      remoteAddressSpace: {
         addressPrefixes: [
           '10.10.0.0/24'
                      
         ]
      }    
    
      
    remoteVirtualNetwork: {
       id: Vnet2Man.id
     }    
 }  
}
 


resource peeredNetwork 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-07-01' = {
  name: peeringName
  parent: Vnet1Web
  properties: {
    allowForwardedTraffic: true
    allowGatewayTransit: false
    allowVirtualNetworkAccess: true
    doNotVerifyRemoteGateways: false
    peeringState:  'Connected'
    peeringSyncLevel:  'FullyInSync'
    remoteAddressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
    
    remoteVirtualNetwork: {
      id: Vnet2Man.id
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
    useRemoteGateways: false
  }
}

