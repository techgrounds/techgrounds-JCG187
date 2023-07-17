param location string = resourceGroup().location
param addressPrefixesVnet1 string = '10.10.10.0/24'
// param addressPrefixesVnet2 string = '10.20.20.0/24'


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
          // networkSecurityGroup:{
          //   id:nsg1vnet1.id
          // }          
        }
      }
      {
        name:'sub2web'
        properties:{
          addressPrefix:'10.10.10.128/25'
          // networkSecurityGroup:{
          //   id:nsg2vnet1.id
          // }
        }
      }
    ]
  }
}
