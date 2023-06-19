param location string = resourceGroup().location
param storageAccountName string = 'develop${uniqueString(resourceGroup().id)}'

resource symbolicname 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: storageAccountName
  location: location 
  tags: {
    tagName1: 'development'
    tagName2: 'test'
  }
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  
  identity: {
    type: 'SystemAssigned'
    userAssignedIdentities: {    
    }
  }
  properties: {
    accessTier: 'Hot' 
    allowBlobPublicAccess: false
    allowCrossTenantReplication: true
    allowedCopyScope: 'AAD'
    allowSharedKeyAccess: false
    
      defaultSharePermission: 'string'
      directoryServiceOptions: 'string'
    }
    
    defaultToOAuthAuthentication: true
    dnsEndpointType: 'string'
    encryption: {
      identity: {
        federatedIdentityClientId: 'string'
        userAssignedIdentity: 'string'
      }
      keySource: 'string'
      keyvaultproperties: {
        keyname: 'string'
        keyvaulturi: 'string'
        keyversion: 'string'
      }
      requireInfrastructureEncryption: true
      services: {
        blob: {
          enabled: true
          keyType:'Account' 
        }
        file: {
          enabled: true
          keyType:  'Account'
        }
        queue: {
          enabled:  true
          keyType:  'Account'
        }
        table: {
          enabled:  true
          keyType:  'Account'
        }
      }
    }
    immutableStorageWithVersioning: {
      enabled: true
      immutabilityPolicy: {
        allowProtectedAppendWrites:  true
        immutabilityPeriodSinceCreationInDays: int
        state: 'string'
      }
    }
    isHnsEnabled: bool
    isLocalUserEnabled: bool
    isNfsV3Enabled: bool
    isSftpEnabled: bool
    keyPolicy: {
      keyExpirationPeriodInDays: int
    }
    largeFileSharesState: 'string'
    minimumTlsVersion: 'string'
    networkAcls: {
      bypass: 'string'
      defaultAction: 'string'
      ipRules: [
        {
          action: 'Allow'
          value: 'string'
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
    publicNetworkAccess: 'string'
    routingPreference: {
      publishInternetEndpoints: bool
      publishMicrosoftEndpoints: bool
      routingChoice: 'string'
    }
    sasPolicy: {
      expirationAction: 'Log'
      sasExpirationPeriod: 'string'
    }
    supportsHttpsTrafficOnly: bool
  }
}

