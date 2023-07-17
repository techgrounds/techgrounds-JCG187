//parameters peered vnet
param location string = resourceGroup().location
param vnet1Name string = 'Vnet1WebServer'
param Vnet2Name string = 'Vnet2ManServer'
param vnet1Prefix string = '10.10.10.0/24'
param vnet2Prefix string = '10.20.20.0/24'
param subnet1prefix string = '10.10.10.0/25'
param subnet2prefix string = '10.10.10.128/25'
param subnet3prefix string = '10.20.20.0/25'

//parameters vmss and application gateway
param adminUsername string = 'adminwebserver'
@secure()
param adminPassword string





module vnet 'werkt-peeringvnets.bicep'= {
   name: 'deployvnet'
   params: {
    location:location
    subnet1prefix:subnet1prefix
    subnet2prefix:subnet2prefix
    subnet3prefix:subnet3prefix
    vnet1Name:vnet1Name
    Vnet2Name:Vnet2Name
    vnet1Prefix:vnet1Prefix
    vnet2Prefix:vnet2Prefix
   } 
}


module vmmsgateway '1.vmss-met-appgate.bicep'= {
  name: 'deployvmssgateway'
  params: {
    location:location
    adminPassword: adminPassword
    adminUsername: adminUsername
  }
}

