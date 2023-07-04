resource sql 'Microsoft.Sql/managedInstances@2022-11-01-preview' = {
  name: 
  location: 
  properties: {
     administratorLogin:
      administratorLoginPassword:
       administrators: 
        collation:
         dnsZonePartner:
          instancePoolId:
           keyId:
            licenseType:
             maintenanceConfigurationId:
              managedInstanceCreateMode:
               minimalTlsVersion:
                primaryUserAssignedIdentityId:
                 proxyOverride:
                  publicDataEndpointEnabled:
                   requestedBackupStorageRedundancy:
                    restorePointInTime:
                     servicePrincipal: 
                      sourceManagedInstanceId:
                       storageSizeInGB:
                        subnetId:
                         timezoneId:
                          vCores:
                           zoneRedundant:
  }
}


resource sqldatabase 'Microsoft.Sql/managedInstances/databases@2022-11-01-preview' = {
  name: 
  location: 
   properties:
    parent:
}
