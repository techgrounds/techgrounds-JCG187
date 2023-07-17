param location string = resourceGroup().location
// param addressPrefixesVnet1 string = '10.10.10.0/24'
param addressPrefixesVnet2 string = '10.20.20.0/24'



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

resource nsg1vnet2 'Microsoft.Network/networkSecurityGroups@2023-02-01' = {
  location:location
  name: 'nsg1vnet2'
  properties:{
    securityRules:[
      {
        name:
      }
    ]
  }
}
