//LET OP key vault heeft een namingconvention voor de secret name. Je moet in de param dus @minLength en @maxLenght toevoegen
// Ik heb de key vault ID nodig voor andere templates zodat wachtwoorden niet zichtbaar worden. 
// 2 SKU standard en premium. Standard gebruiken.
// Te gebruiken voor storage account. Output voor ID maken?
// Tijdens installatie kan je toegang geven aan VM, 
// dependsOn maken

@description('een key vault heeft een unieke naam nodig')
param keyVaultName string = 'testKV${uniqueString(resourceGroup().id)}'

param location string = resourceGroup().location

@description('dit is het id van de tenant')
param tenantID string = '2927c370-1129-495e-8c20-77eddca0ae1e' // let op dit is tenant ID van mijn abonnement. Die vindt je in Azure AD


@description('objectID voor de access policy')
param objectID string = '4f2adfaf-47b9-4edb-8c25-2f98c626f490'










resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family:  'A'
      name:  'standard'
    }
    tenantId: tenantID
    enabledForDiskEncryption: true
    enabledForTemplateDeployment: true 
    enabledForDeployment: true 
    enableRbacAuthorization: true 
    softDeleteRetentionInDays: 30



     
  }
}
resource keyVaultsKeys 'Microsoft.KeyVault/vaults/accessPolicies@2023-02-01' = {
  parent:keyVault
  name:  'add'
  properties: {
    accessPolicies:  [
       {
        objectId: objectID
        permissions: {
          storage: [
             'all'
          ]
          secrets: [
             'all'
          ]
          keys: [
             'all'
          ]
          certificates: [
             'all'           
              
          ]
        }
        tenantId: tenantID
       }
    ]
  }
}

output keyVaultId string = keyVault.id
