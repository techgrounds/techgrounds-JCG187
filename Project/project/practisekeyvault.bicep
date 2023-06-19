param location string = 'westeurope'
param tenantID string = 'de60b253-74bd-4365-b598-b9e55a2b208d'
param objectID string = 'ef936799-e0f3-4ef5-810c-07fd3be0d342'

resource practisekvjg2468 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: 'practiseKeyVaultjg1357'
  location: location
  properties: {
    sku: {
      family:  'A'
      name:  'standard'
    }
    tenantId:  tenantID
     accessPolicies: [
       {
        objectId: objectID
        permissions: {
           certificates: [
             'create'
              'delete'
               'get'
           ]
        }
        tenantId: tenantID         
       }
        {
          objectId: objectID
          permissions: {
             keys: [
               'create'
                'delete'
                 'get'
                  'backup'
             ]
          }
          tenantId: tenantID
        }
         {
          objectId: objectID
          permissions: {
             secrets: [
               'all'
             ]
          }
          tenantId: tenantID
         }
          {
            objectId: objectID
            permissions: {
               storage: [
                 'backup'
                  'delete'
                   'get' 
                    'list'
                     'recover' 
                      'restore'
               ]
            }
            tenantId: tenantID
          }
     ]
  }   
}

