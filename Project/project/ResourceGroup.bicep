param location string = 'westeurope'
targetScope = 'subscription'

resource resourcegroup 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'biceprsg'
  location: location 
}

