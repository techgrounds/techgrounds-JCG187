// de applicatie kan inforamtie uit the Key Vault ophalen met Uri's. De Uri's geven de mogelijkheid om een specifieke versie van een geheim op te halen. 

// Voordat de sleutel verkregen wordt moet de aanvrager geauthenticeerd en geauthoriseerd worden. In ons geval gaat de authorisatie via de key vault
// access policy. Niet via RBAC. Dat zit niet in het abonnement. 

// Key vault access policy kan alleen gebruikt worden om informatie die in de key vault is opgeslagen op te halen. 

// De software-protected keys, secrets en certificaten gebruiken industry standard algorithmes en sleutellengtes. (HSM is de dure variant)

// Te gebruiken voor Disk Encryptie - storage account - azure SQL database

// De sleutels worden opgeslagen en gemanaged in Azure Key Vault

// Software-protected keys die standaard zijn is een RSA 2048-bit sleutel kosten €0.029/10,000  voor transactions 




//LET OP key vault heeft een namingconvention voor de secret name. Je moet in de param dus @minLength en @maxLenght toevoegen
// Ik heb de key vault ID nodig voor andere templates zodat wachtwoorden niet zichtbaar worden. 
// 2 SKU standard en premium. Standard gebruiken.
// Te gebruiken voor storage account. Output voor ID maken?



//BELANGRIJK. DE KEYVAULT MOET EERST GEINSTALLEERD ZIJN VOORDAT ANDERE RESOURCES ER GEBRUIK VAN KUNNEN MAKEN. DEZE MOET DUS BOVENAAN 
// IN DE MAIN FILE STAAN!!!!!


//een key vault heeft een unieke naam nodig
param keyVaultName string = 'testKV${uniqueString(resourceGroup().id)}'

//locatie
param location string = resourceGroup().location

// dit is het id van de tenant
param tenantID string = '2927c370-1129-495e-8c20-77eddca0ae1e' // let op dit is tenant ID van mijn abonnement. Die vindt je in Azure AD


@description('objectID voor de access policy')
param objectID string = '4f2adfaf-47b9-4edb-8c25-2f98c626f490'


@description('Geeft aan of Azure Virt. machines toestemming hebben om certificaten op te halen die als geheimen zijn opgeslagen in de key vault.')
param enabledForDeployment bool = false

@description('Geeft aan of Azure disk encruption toestemming heeft om geheimen op te halen uit de kluis en of het sleutels uit mag pakken.')
param enabledForDiskEncryption bool = false

@description('Geeft aan of Azure Resource manager toestemming heeft om geheimen op te halen die opgeslagen zijn in de key vault.')
param enabledForTemplateDeployment bool = false

@description('Geeft aan welke Azure Active Directory tenant ID gebruikt moet worden om verzoeken naar de key vault te authentiseren.')
param tenantId string = subscription().tenantId

@description('Specificeert het object-ID van een gebruiker, service principal of beveiligingsgroep in de Azure Active Directory-tenant voor de kluis. Het object-ID moet uniek zijn binnen de lijst met toegangspolicies.')
param objectId string

@description('Specificeert de machtigingen voor sleutels in de vault. Geldige waarden zijn: all, encrypt, decrypt, wrapKey, unwrapKey, sign, verify, get, list, create, update, import, delete, backup, restore, recover en purge.')
param keysPermissions array = [
  'list'
]

@description('Specificeert de machtigingen voor geheimen de vault. geldige waarden zijn: all, get, list, set, delete, backup, restore, recover, and purge.')
param secretsPermissions array = [
  'list'
]

@description('De SKU van de key vault.')
@allowed([
  'standard'
  'premium'
])
param skuName string = 'standard'

@description('Specificeert de namen of de geheimen van die je wilt maken.')
param secretName string

@description('Specificeert de waarde van de geheimen die je wilt maken.')
@secure()
param secretValue string


resource kv 'Microsoft.KeyVault/vaults@2021-11-01-preview' = {
  name: keyVaultName
  location: location
  properties: {
    enabledForDeployment: enabledForDeployment
    enabledForDiskEncryption: enabledForDiskEncryption
    enabledForTemplateDeployment: enabledForTemplateDeployment
    enablePurgeProtection: true
    enableSoftDelete: true
      
    tenantId: tenantId
    accessPolicies: [
      {
        objectId: objectId
        tenantId: tenantId
        permissions: {
          keys: keysPermissions
          secrets: secretsPermissions
        }
      }
    ]
    sku: {
      name: skuName
      family: 'A'
    }
    networkAcls: {
      defaultAction: 'Allow'
      bypass: 'AzureServices'
    }
  }
}

resource secret 'Microsoft.KeyVault/vaults/secrets@2021-11-01-preview' = {
  parent: kv
  name: secretName
  properties: {
    value: secretValue
  }
}




resource keyVault 'Microsoft.KeyVault/vaults@2023-02-01' = {
  name: keyVaultName
  location: location
  properties: {
    sku: {
      family:  'A'
      name:  'standard'
    }
  }
}
resource keyVaultsKeys  





output keyVaultId string = keyVault.id
