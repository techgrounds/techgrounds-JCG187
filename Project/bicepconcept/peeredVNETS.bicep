param location string = resourceGroup().location //de locatie die gekoppeld is aan de resourcegroup
param vnet1Name string = 'Vnet1-WebServer'
param subnet1Name string = 'Subnet1-WebServer'
param subnet2Name string = 'Subnet2-WebServer'
param subnet3Name string = 'Subnet3-WebServer'
param nsg1Sub1Name string = 'nsg1-sub1'
param nsg2Sub2Name string = 'nsg1-sub2'
param nsg3Sub3Name string = 'nsg1-sub3'

var Vnet1AddressPrefix = '10.10.10.0/24'
var Subnet1AddressPrefix = '10.10.10.0/26'
var Subnet2AddressPrefix = '10.10.10.64/26'
var Subnet3AddresPrefix = '10.10.10.128/26'


param Vnet2Name string = 'Vnet2-ManServer'
param subnet1ManName string = 'Subnet1-ManServer'

var Vnet2AddressPrefix = '10.20.20.0/24'


//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////VnetA WINDOWS WEBSERVER/////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////



@description('aanmaken vnet1')
resource Vnet1Web 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: vnet1Name
  location: location
  properties: {
    addressSpace: {
       addressPrefixes: [
        Vnet1AddressPrefix                        
       ]  
    }           
  }
}  


//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////Vnet1 SUBNET1////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////



@description('aanmaken van subnet1 voor de webserver')
resource Subnet1Web 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  parent: Vnet1Web //hiermee vertel je dat het een subnet is van vnet_1
  name: subnet1Name //naam van de subnet
  properties: {
     addressPrefix: Subnet1AddressPrefix//subnetadres
     networkSecurityGroup: {
       id: nsg1sub1.id
     }
    }
  }




  @description('aanmaken van subnet2 voor de webserver')
  resource Subnet2Web 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
    parent: Vnet1Web //hiermee vertel je dat het een subnet is van vnet_1
    name: subnet2Name //naam van de subnet
    properties: {
       addressPrefix:Subnet2AddressPrefix //subnetadres
       networkSecurityGroup: {
         id: nsg1sub2.id
       }
      }
    }


    @description('aanmaken van subnet3 voor de webserver')
    resource Subnet3Web 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
      parent: Vnet1Web //hiermee vertel je dat het een subnet is van vnet_1
      name: subnet3Name //naam van de subnet
      properties: {
         addressPrefix: Subnet3AddresPrefix//CIDR block
         networkSecurityGroup: {
           id: nsg1sub3.id
         }
        }
      }
  



//////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////Vnet1 NSG's voor alle subnets gelijk/////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////


@description('netwerksecuritygroup voor subnet1')
resource nsg1sub1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {  
  location: location
  name: nsg1Sub1Name    
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
      }
    ]    
  }
dependsOn: [
    Vnet1Web
]
 }
     

 @description('netwerksecuritygroup voor subnet1')
 resource nsg1sub2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {  
   location: location
   name: nsg2Sub2Name       
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
       }
     ]    
   }
 dependsOn: [
     Vnet1Web
 ]
  }
     
  @description('netwerksecuritygroup voor subnet1')
  resource nsg1sub3 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {  
    location: location
    name:  nsg3Sub3Name      
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
        }
      ]    
    }
  dependsOn: [
      Vnet1Web
  ]
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
        addressPrefixes: [
          Vnet2AddressPrefix                    
        ]  
     }      
   }
 }  


 /////////////////////////////////////////////////////////////////////////////////////
////////////////////////SUBNET2////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
 
 @description('aanmaken van subnet2 voor de managementserver')
 resource Subnet1Man 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
   parent: Vnet2Man //hiermee vertel je dat het een subnet is van vnet2
   name: subnet1ManName //naam van de subnet
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
   name: 'nsg2'
   dependsOn: [
      Vnet2Man
   ]   
  }


///////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////PEERING 1 met 2//////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////




  @description('peering vnet1 met vnet2')
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




