//parameters voor vnet
param vnet1Name string = 'Vnet1-WebServer'
param Vnet2Name string = 'Vnet2-ManServer'
param location string = resourceGroup().location
param serviceEndPoints array = [
  {
      locations: [
        'westeurope'                   
               ]
      service: 'Microsoft.Storage'
           }
]


//parameters vmssgateway
param adminUsername string = 'Jennifer'
@secure()
param adminPassword string // JGO89HNG9Hiyn



//module vnet
module virtualnetwork 'peeredVNETS.bicep'={
  name: 'deploymentvnet'
  params:{
    location:location
    vnet1Name:vnet1Name
    Vnet2Name:Vnet2Name
    serviceEndPoints:serviceEndPoints
  }
}



module vmssgateway '1.vmss-met-appgate.bicep'= {
  name: 'deployvmssgateway'
  params: {
    location:location
    adminPassword: adminPassword
    adminUsername: adminUsername
    
  }
}







// //peering module
// module peering 'peering.bicep'= {
//   name: 'deploymentpeering'
// }


// //sql module
// module sql 'sql.bicep'= {
//   name: 'deploymentsql'
//   params: {
//     adminPassword: adminPassword    
//     location: location  
//   }
// }
