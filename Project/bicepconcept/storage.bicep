param location string = resourceGroup().location //gives the location name of the resourcegroup
param storageAccountName string = 'storage${uniqueString(resourceGroup().id)}'//gives a unique string at the end of test123

@description('creates the storage account')
resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name:'Standard_LRS' 
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    allowBlobPublicAccess: false
    encryption: {
       identity: {
         
       }
    }
     networkAcls: {
      defaultAction:  'Deny'
      bypass:'None'
      ipRules: [
         {          
          value: '77.163.53.33'
          action:'Allow'
         }
      ]
        
       
     }

  }
}



