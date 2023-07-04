
param peeringName string = 'vnetpeering'

param peeringName2 string = 'vnetpeering2'

resource virtualNetwork1 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: 'Man1-Vnet1'
}


resource virtualNetwork2 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: 'Web-Vnet2' //dit is de naam van de vnet die je ook in azure ziet na deploycen van de vnet. Het is de naam die je geeft aan de resource. 
}



resource peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-07-01' = {
  name: peeringName
  parent: virtualNetwork1
  properties: {
    allowForwardedTraffic: true
    allowGatewayTransit: false
    allowVirtualNetworkAccess: true
    doNotVerifyRemoteGateways:true
    peeringState: 'Connected'
    peeringSyncLevel:  'FullyInSync'
    remoteVirtualNetwork: {
      id:  virtualNetwork2.id
    }
    remoteVirtualNetworkAddressSpace: {
      addressPrefixes: [
        '10.20.20.0/24'
      ]
    }
  }
}

// //toevoegen van vnet 2 aan de peeringtemplate
// resource vnet2 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
//   scope: resourceGroup('test123')
//   name: 'VirtualNetwork2'
// }




//koppelen van vnet 2 aan vnet 1
resource peering2 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {  
  parent: virtualNetwork2
  name: peeringName2
  properties: {
   allowVirtualNetworkAccess: true
    allowForwardedTraffic: true
    allowGatewayTransit: false
    useRemoteGateways: false 
    peeringState: 'Connected'            
    remoteVirtualNetwork: {
      id: virtualNetwork1.id
    }   
      remoteAddressSpace: {
       addressPrefixes: [
        '10.10.10.0/24'
       ]
    }    
  }
}
