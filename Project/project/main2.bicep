@description('dit is de locatie van de resources voor project1')
param location string = 'westeurope'
param subNet1 string = 'subNet1'
param subNet1Prefix string = '10.10.10.0/24'
param subNet2 string = 'subNet2'
param subNet2Prefix string = '10.10.20.0/24'

resource vnetProject1 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: 'vnetProject1'
   location: location
    properties: {
       addressSpace: {
         addressPrefixes: [
          '10.0.0.0/8' 
         ]                   
       }
        subnets: [
           {
             name: subNet1
              properties: { 
                  addressPrefix: subNet1Prefix
              }
           }
          
        ]
    }
}



