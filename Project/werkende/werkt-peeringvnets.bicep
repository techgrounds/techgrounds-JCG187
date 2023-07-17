param location string = resourceGroup().location //de locatie die gekoppeld is aan de resourcegroup

param vnet1Name string = 'Vnet1WebServer'
param Vnet2Name string = 'Vnet2ManServer'
param vnet1Prefix string = '10.10.10.0/24'
param vnet2Prefix string = '10.20.20.0/24'
param subnet1prefix string = '10.10.10.0/25'
param subnet2prefix string = '10.10.10.128/25'
param subnet3prefix string = '10.20.20.0/25'


//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////Vnet1 WINDOWS WEBSERVER/////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////



//vnet1 voor webserver
resource Vnet1Web 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: 'Vnet1WebServer'
  location: location
  properties: {
    addressSpace: {
       addressPrefixes: [
        vnet1Prefix                      
       ]  
    }    
    subnets:[
      {
        name:'sub1web'
        properties:{
          addressPrefix:subnet1prefix
          networkSecurityGroup:{
            id:nsg1.id
          
          }
        }      
      }
      {
        name:'sub2web'
        properties:{
          addressPrefix:subnet2prefix
          networkSecurityGroup:{
            id:nsg2.id              
            }
          }
        }
      ]
     }           
  }
 


  // @description('peering vnet1 met vnet2')
resource peeringWebwithMan 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2020-07-01' = {  
  name: 'vnet1-to-vnet2'
  parent: Vnet1Web
  properties: {            
    allowForwardedTraffic: true
    allowGatewayTransit: true     
    remoteVirtualNetwork: {
       id: Vnet2Man.id
    }        
  }  
  }

//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////Vnet1 NSG's Subnet 1 voor alle subnets gelijk/////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////


resource nsg1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {    
  location: location  
  name: 'nsg1web'      
  properties: {
    securityRules:[
      {
        properties:{
          description: 'SSH'
          access: 'Allow'
          direction: 'Inbound'
          priority: 1000
          protocol: 'Tcp'
          destinationAddressPrefix:'*'
          destinationPortRange:'22'
          sourceAddressPrefix:'*'
          sourcePortRange:'*'          
        }    
        name: 'SSH-inbound'    
      }
      {
        properties:{
          description: 'HTTP'
          access: 'Allow'
          direction: 'Inbound'
          priority: 500
          protocol: 'Tcp'
          destinationAddressPrefix:'*'
          destinationPortRange:'80'
          sourceAddressPrefix:'*'
          sourcePortRange:'*'
        }
        name: 'HTTP-inbound' 
      }      
      {
        properties:{
        description: 'HTTPS'
          access: 'Allow'
          direction: 'Inbound'
          priority: 501
          protocol: 'Tcp'
          destinationAddressPrefix:'*'
          destinationPortRange:'443'
          sourceAddressPrefix:'*'
          sourcePortRange:'*'
        }
        name: 'HTTPS-inbound'
      }
      {
        name: 'allowport'
        properties:{
          access: 'Allow'
          direction: 'Inbound'
          priority: 300
          protocol: 'Tcp'
          sourceAddressPrefix:'GatewayManager'
          sourcePortRange:'*'
          destinationPortRange:'65200-65535'
          destinationAddressPrefix:'*'          
        }
      }
    ]    
  }
 }
     
resource nsg2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {  
  location: location
  name: 'nsg2web'      
  properties: {
    securityRules:[
      {
        properties:{
          description: 'SSH'
          access: 'Allow'
          direction: 'Inbound'
          priority: 1000
          protocol: 'Tcp'
          destinationAddressPrefix:'*'
          destinationPortRange:'22'
          sourceAddressPrefix:'*'
          sourcePortRange:'*'          
        }
        name: 'SSH-inbound'
      }
    ]    
  }
}
     
        
/////////////////////////////////////////////////////////////////////////////////////
////////////////////////VNET2////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////





@description('aanmaken van vnet2 voor management server')
resource Vnet2Man 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: Vnet2Name
  location: location
  properties: {
    addressSpace: {
     addressPrefixes:[
      vnet2Prefix
     ]     
    }
    subnets:[
      {
        name:'Sub1Man'
        properties:{
          addressPrefix:subnet3prefix
          networkSecurityGroup:{
            id:nsg3.id
          }
        }
      }
    ]
  }   
}  

 

//nsg vnet2 sub1
resource nsg3 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {  
  location: location
  name: 'nsg1man'
  properties: {
   securityRules:[
     {
       properties:{
         description: 'SSH'
         access: 'Allow'
         direction: 'Inbound'
         priority: 1000
         protocol: 'Tcp'
         destinationAddressPrefix:'*'
         destinationPortRange:'22'
         sourceAddressPrefix:'*'
         sourcePortRange:'*'          
       }
       name:'SSH-Inbound'
     }
     {
       properties:{
       description: 'RDP'
         access: 'Allow'
         direction: 'Inbound'
         priority: 600
         protocol: 'Tcp'
         destinationAddressPrefix:'*'
         destinationPortRange:'3389'
         sourceAddressPrefix:'*'
         sourcePortRange:'*'  
       }   
       name:'RDP-Inbound' 
     }
   ]        
 }
}


///////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////PEERING 1 met 2//////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////





 


resource peeringManwithWeb 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-07-01' = {
  name: 'vnet2-to-vnet1'
  parent: Vnet2Man
  properties: {
    allowForwardedTraffic: true
    allowGatewayTransit: true   
    remoteVirtualNetwork: {
      id: Vnet1Web.id
    }
  }
}



output vnet1IDwebserverID string = Vnet1Web.id
output vnet2IDmanserverID string = Vnet2Man.id

output vnet1IDwebserverName string = Vnet1Web.name
output vnet2IDmanserverName string = Vnet2Man.name



output Subnet1webID string = resourceId('Microsoft.Network/VirtualNetworks/subnets', vnet1Name, 'sub1web')
output Subnet2webID string = resourceId('Microsoft.Network/VirtualNetworks/subnets', vnet1Name,'sub2web')
output Subnet1manID string = resourceId('Microsoft.Network/VirtualNetworks/subnets', Vnet2Name,'sub1man')

output subnet1webID string = Vnet1Web.properties.subnets[0].id
output subnet2webID string = Vnet1Web.properties.subnets[1].id
output subnet1manID string = Vnet2Man.properties.subnets[0].id

output subnet1webName string = Vnet1Web.properties.subnets[0].name
output subnet2webName string = Vnet1Web.properties.subnets[1].name
output subnet1manName string = Vnet2Man.properties.subnets[0].name

output nsg1ID string = nsg1.id
output nsg2ID string = nsg2.id
output nsg3ID string = nsg3.id
output nsg1Name string = nsg1.name
output nsg2Name string = nsg2.name
output nsg3Name string = nsg3.name

output Namevnet1 string = vnet1Name
output Namevnet2 string = Vnet2Name




