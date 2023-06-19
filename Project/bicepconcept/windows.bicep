param location string = resourceGroup().location


resource networkInterfaceManagementServer 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: 'nic-2'
  properties: {
     ipConfigurations: [
       {
         name: 'network2'
          id: vnet-2.id
       }
     ]
  }
}

resource ManagementServer 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: 'managementserver'
  location: location
   properties: {
     hardwareProfile: {
       
     }
    proximityPlacementGroup: {
       
    } 
     networkProfile: {
       networkInterfaces: [
        
       ]
     }     
   }
   
}



