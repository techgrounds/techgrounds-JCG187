param location string = 'westeurope'

resource storageaccount 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'project1StorageAccount2468'
  location: location
  kind: 'StorageV2'
  sku: {
    name:'Standard_LRS' 
  }
   properties: {
     encryption: {
      keySource:  
     }
   }
}

