param storageAccountName string = 'storage1${uniqueString(resourceGroup().id)}'
param location string = resourceGroup().location


resource SAproject 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS' //hiervoor gekozen omdat de storage niet wordt gebruikt voor critieke scenario's.
  }
  kind: 'StorageV2'

  properties:{
    accessTier: 'Hot'
    allowBlobPublicAccess: true
    allowCrossTenantReplication:false //Geeft toestemming voor cross-tenant replicatie. Het zorgt ervoor dat je een object replicatie policy kan maken waarbij de bron van de account in een ander tenant AD zit en de bestemming in een andere.
    allowedCopyScope: 'PrivateLink'//alles wat via een private link verbonden is kan kopieen van of naar deze storage sturen? Het is me nog niet helemaal duidelijk of het van of naar is.
    allowSharedKeyAccess:false //andere gebruikers krijgen alleen toegang als de toegang via permissies in de AD is geactiveerd.
    // azureFilesIdentityBasedAuthentication:{     ////dit gaat over de rechten om toegang tot files shares te krijgen adhv AD.
    //   activeDirectoryProperties:{
    //     accountType:
    //     azureStorageSid:
    //     domainGuid:
    //     domainName:
    //     domainSid:
    //     forestName:
    //     netBiosDomainName:
    //     samAccountName:
    //   }
    //   defaultSharePermission: 
    //   directoryServiceOptions:
    // // }
    // customDomain:{
    //   name:
    //   useSubDomainName:
    // }
    // defaultToOAuthAuthentication: 'false'// een access token is een middel wat door applicaties wordt gebruikt om namesn een gebruiker API's verzoeken te doen.  
    // dnsEndpointType: 'string'
    // encryption: {
    //   identity: {
    //     federatedIdentityClientId: 'string'
    //     userAssignedIdentity: 'string'
    //   }
    //   keySource: 'string'
    //   keyvaultproperties: {
    //     keyname: 'string'
    //     keyvaulturi: 'string'
    //     keyversion: 'string'
    //   }
    //   requireInfrastructureEncryption: 'true'
    //   services: {
    //     blob: {
    //       enabled: 'true'
    //       keyType: 'string'
    //     }
    //     file: {
    //       enabled: 'false'
    //       keyType: 'string'
    //     }
    //     queue: {
    //       enabled: 'false'
    //       keyType: 'string'
    //     }
    //     table: {
    //       enabled: 'false'
    //       keyType: 'string'
    //     }
    //   }
    // }
    // immutableStorageWithVersioning: { //dit zorgt ervoor dat bestanden niet verwijderd of gewijzigd kunnen worden. Met versiebeheer kan je meerdere versies van 1 bestand bewaren. Alle wijzigingen aan een bestand worden als nieuwe versie gezien, oude versies blijven bestaan.
    //   enabled: false  // ik heb dit voor nu uitgezet anders kan je de storage account niet deleten. 
    //   immutabilityPolicy: {
    //     allowProtectedAppendWrites: true                     // uitgezet omdat je anders geen large file share kan doen.
    //     immutabilityPeriodSinceCreationInDays: 7
    //     state: 'Disabled' 
    //   }
    // }
    // isHnsEnabled: true // zorgt ervoor dat je een structuur of mappen voor de bestanden hierarchisch kan aanmaken in de blobstorage. Dit is niet nodig voor het project.
    // isLocalUserEnabled: false
    // isNfsV3Enabled: false
    // isSftpEnabled: false
    // keyPolicy: {
    //   keyExpirationPeriodInDays: ''
    // }
    largeFileSharesState: 'Enable'
    minimumTlsVersion: 'TLS1-2'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: 'Allow'
      ipRules: [
        {
          action: 'Allow'
          value: 
        }
      ]
      resourceAccessRules: [
        {
          resourceId: 'string'
          tenantId: 'string'
        }
      ]
      virtualNetworkRules: [
        {
          action: 'Allow'
          id: 'string'
          state: 'string'
        }
      ]
    }
  } 
 }
}

resource blobservice 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
 parent: SAproject
  name: 'default'
   properties: {
     
   }
}


resource folder 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  parent: blobservice
  name: 'folder1'
   properties: {
    publicAccess:'Blob'
   }   
}












output blobContainerResourceId string = .id
output blobResourceId string = blobservice.id
output folderResourceId string = folder.id






//Azure Storage encryption is enabled for all storage accounts and cannot be disabled.



