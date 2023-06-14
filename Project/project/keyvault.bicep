param location string = 'westeurope'

resource keyVault 'Microsoft.KeyVault/vaults@2019-09-01' = {
  name: 'project1keyvault2468'
  location: location
   
   
  properties: {
    enabledForDeployment: true
    enabledForTemplateDeployment: true
    enabledForDiskEncryption: true
    tenantId: 'tenantId'
    accessPolicies: [
      {
        tenantId: 'tenantId'
        objectId: 'objectId'
        permissions: {
          keys: [
            'get'
          ]
          secrets: [
            'list'
            'get'
          ]
        }
      }
    ]
    sku: {
      name: 'standard'
      family: 'A'
    }
  }
}

