param location string = 'westeurope'
param tenantID string = 'de60b253-74bd-4365-b598-b9e55a2b208d'
param objectID string = 'ef936799-e0f3-4ef5-810c-07fd3be0d342'

resource testKeyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'testKVJGO2468'
  location: location
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: tenantID
    accessPolicies: [
       {
        objectId: objectID
        tenantId: tenantID
        permissions: {
           certificates: [
             'create' 
              'delete'
               
           ]
        }
        
       }
        {
          objectId: objectID
          permissions: {
             secrets: [
               'get'
               'list'
                'set'

             ]
          }
          tenantId:  tenantID
        }
         {
          objectId: objectID
          permissions: {
             storage: [
               'all'
             ]
             
          }
          tenantId: tenantID
         }
    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

