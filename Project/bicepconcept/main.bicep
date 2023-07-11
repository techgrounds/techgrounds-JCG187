
//parameters voor windows vm
@secure()
param adminPassword string
param adminUsername string = 'Jennifer'
param location string = resourceGroup().location





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



//peering module
module peering 'peering.bicep'= {
  name: 'deploymentpeering'
}


//sql module
module sql 'sql.bicep'= {
  name: 'deploymentsql'
  params: {
    adminPassword: adminPassword    
    location: location  
  }
}
