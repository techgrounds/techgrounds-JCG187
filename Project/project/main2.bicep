@description('dit is de locatie waar de resources gedeployed worden')
param location string = 'westeurope'
@description('dit is de naam van subnet 1')
param subNet1 string = 'subNet1'
@description('dit is het netwerk adres van subnet 1')
param subNet1Prefix string = '10.10.10.0/24'
@description('dit is de naam van subnet2')
param subNet2 string = 'subNet2'
@description('dit is het hetwerkadres van subnet 2')
param subNet2Prefix string = '10.10.20.0/24'

@description('dit is de resource van het netwerk')
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
            {
               name: subNet2 
                properties: {
                   addressPrefix: subNet2Prefix
                }
            }              
        ]
    }
 }

resource NSGsub1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: 'nsgsub1'
   properties: {
     
   }
}

