targetScope = 'subscription'
param location string = 'westeurope'
param ResourceGroupName string = 'test123'


resource ResourceGroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: ResourceGroupName
  location: location 
}


