param vnet1Name string = 'bicep-test-vnet-jgo'
param vnetAddressPrefix string = '10.0.0.0/8'
param location string = 'WestEurope'
param subnet1Prefix string = '10.10.10.0/24'
param subnet1Name string= 'subnet1'
param subnet2prefix string = '10.10.20.0/24'
param subnet2Name string = 'subnet2'
param resourceGroupName string = 'project1'


resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: vnet1Name
   location:location
    properties: {
       addressSpace: {
         addressPrefixes: [vnetAddressPrefix
           
         ]
       }
        subnets: [
           {
             name: subnet1Name
              properties: {
                 addressPrefix: subnet1Prefix
                  networkSecurityGroup:   
                  
              
           }
         {
            name: subnet2Name
             properties: {
               addressPrefix: subnet2prefix 
              
             } 

         }
          ]          
    }
}

    ]
  }
}


