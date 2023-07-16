param location string = resourceGroup().location
param addressPrefixesVnet1 string = '10.10.10.0/24'
param addressPrefixesVnet2 string = '10.20.20.0/24'


resource vnet1web 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  name: 'vnet1website'
  location:location
  properties:{
    addressSpace:{
      addressPrefixes:[
        addressPrefixesVnet1        
      ]      
    }
    subnets:[
      {
        name: 'sub1web'
        properties:{
          addressPrefix:'10.10.10.0/25'
          networkSecurityGroup:{
            id:nsg1vnet1.id
          }          
        }
      }
      {
        name:'sub2web'
        properties:{
          addressPrefix:'10.10.10.128/25'
          networkSecurityGroup:{
            id:nsg2vnet1.id
          }
        }
      }
    ]
  }
}



resource vnet2man 'Microsoft.Network/virtualNetworks@2023-02-01' = {
  name: 'vnet2manage'
  location:location
  properties:{
    addressSpace:{
      addressPrefixes:[
        addressPrefixesVnet2
      ]      
    }
    subnets:[
      {
        name:'sub1man'
        properties:{
          addressPrefix:'10.20.20.0/25'
          networkSecurityGroup:{
            id:nsg1vnet2.id
          }
        }
      }
    ]
  }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 





resource nsg1vnet1 'Microsoft.Network/networkSecurityGroups@2023-02-01' = {
  name: 'nsg1'
  location:location
  properties:{
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
      }
    ] 
  }
}  
          
      
resource nsg2vnet1 'Microsoft.Network/networkSecurityGroups@2023-02-01' = {
  location:location
  name: 'nsg2'
  properties:{
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
      }
      // {
      //   properties:{
      //   description: 'HTTPS'
      //     access: 'Allow'
      //     direction: 'Inbound'
      //     priority: 501
      //     protocol: 'Tcp'
      //     destinationAddressPrefix:'*'
      //     destinationPortRange:'443'
      //     sourceAddressPrefix:'*'
      //     sourcePortRange:'*'
      //   }
      // }
    ] 
  }
}  

resource nsg1vnet2 'Microsoft.Network/networkSecurityGroups@2023-02-01' = {
  location:location
  name: 'nsg3'
  properties:{
    securityRules:[
      {
        properties:{  
          description: 'RDP'
          access: 'Allow'
          direction: 'Inbound'
          priority: 2000
          protocol: 'Tcp'
          destinationAddressPrefix:'*'
          destinationPortRange:'3389'
          sourceAddressPrefix:'*'
          sourcePortRange:'*'          
        }
      }
      // {
      //   properties:{
      //     description: 'HTTP'
      //     access: 'Allow'
      //     direction: 'Inbound'
      //     priority: 500
      //     protocol: 'Tcp'
      //     destinationAddressPrefix:'*'
      //     destinationPortRange:'80'
      //     sourceAddressPrefix:'*'
      //     sourcePortRange:'*'
      //   }
      // }
      // {
      //   properties:{
      //   description: 'HTTPS'
      //     access: 'Allow'
      //     direction: 'Inbound'
      //     priority: 501
      //     protocol: 'Tcp'
      //     destinationAddressPrefix:'*'
      //     destinationPortRange:'443'
      //     sourceAddressPrefix:'*'
      //     sourcePortRange:'*'
      //   }
      // }
    ] 
  }
}  
