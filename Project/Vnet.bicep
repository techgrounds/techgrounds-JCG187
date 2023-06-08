param vnet1Name string = 'bice-test-vnet-jgo'
param vnetAddressPrefix string = '10.0.0.0/8'
param locationForProject string = 'WestEurope'
param subnet1Prefix string = 'subnet1Vnet1'
param subnet1Vnet1 string= '10.10.10.0/24'
param subnet2prefix string = 'subnet2Vnet1'
param subnet2Vnet1 string = '10.10.20.0/24'
param virtualMachine string = 


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: vnet1Name
   location:locationForProject
    properties: {
       addressSpace: {
         addressPrefixes: [vnetAddressPrefix
           
         ]
       }
        subnets: [
           {
             name: subnet1Vnet1
              properties: {
                 addressPrefix: subnet1Prefix
              }
           }
         {
            name: subnet2Vnet1
             properties: {
               addressPrefix: subnet2prefix
             } 
         }
          ]          
    }
}
