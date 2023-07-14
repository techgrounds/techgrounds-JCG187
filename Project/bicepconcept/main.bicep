//parameters voor vnet
param vnet1Name string = 'Vnet1-WebServer'
param Vnet2Name string = 'Vnet2-ManServer'



//parameters voor windows vm
@secure()
param adminPassword string
param adminUsername string = 'Jennifer'
param location string = resourceGroup().location
param serviceEndPoints array = [
  {
      locations: [
        'westeurope'                   
               ]
      service: 'Microsoft.Storage'
           }
]



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




//ubuntuvm module
module Ubuntuvm 'Ubuntu.bicep'= {
  name: 'deploymnetubuntuvm'
  params: {
    adminPassword:adminPassword
    adminUsername:adminUsername   
    location: location
  }
}




//windowsvm module
module windowsvm 'Windows.bicep'= {
  name: 'deploymentwindowsvm'
  params: {
    adminPassword: adminPassword
    adminUsername:adminUsername
    location: location
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
