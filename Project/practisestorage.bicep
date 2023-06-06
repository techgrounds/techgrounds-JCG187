
resource storage 'Microsoft.Storage/storageAccounts@2022-09-01'= {
  name:'myfirstbicepstorageaccount'
    sku: {
    name:'Standard_LRS'
  }
  kind:'StorageV2'
  location:'westeurope'
   
}
