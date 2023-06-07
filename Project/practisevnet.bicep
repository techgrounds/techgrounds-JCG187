param location string = resourceGroup().location
param subnet1Vnet1 string = '10.10.10.0/24'
param subnet2Vnet1 string = '10.10.20.0/24'
param resourceGroup string = BicepTestEnvironment
param storageAccountName string = 'biceptesting${uniqueString(resourceGroup().id)}'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'BicepTestEnvironment'
  location: 'westeurope'

}

resource vnet1 'Microsoft.Network/virtualNetworks@2022-11-01'= {
  name: 'biceptestvnet'
  location:location
   properties: {
     addressSpace:'10.0.0.0/8' 
   }

}

