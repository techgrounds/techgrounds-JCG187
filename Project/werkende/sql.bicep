
@description('The name of the SQL logical server.')
param serverName string = uniqueString('sql', resourceGroup().id)

@description('Location for all resources.')
param location string = resourceGroup().location

@description('The administrator username of the SQL logical server.')
param administratorLogin string = 'sqladmin'

@description('The administrator password of the SQL logical server.')
@secure()
param administratorLoginPassword string // JaH00rW33r33n23456

@description('Enable Microsoft Defender for SQL, the user deploying the template must have an administrator or owner permissions.')
param enableSqlDefender bool = true

@description('Allow Azure services to access server.')
param allowAzureIPs bool = true

@description('SQL logical server connection type.')
@allowed([
  'Default'
  'Redirect'
  'Proxy'
])
param connectionType string = 'Default'




resource sqlserver 'Microsoft.Sql/servers@2014-04-01' ={  
  name: serverName    
  location: location  
  properties: {
     administratorLogin: administratorLogin
     administratorLoginPassword: administratorLoginPassword
     version:  '12.0'
  }
}


resource firewallRule 'Microsoft.Sql/servers/firewallRules@2022-05-01-preview' = if (allowAzureIPs) {
  parent: sqlserver
  name: 'AllowAllWindowsAzureIps'
  properties: {
    endIpAddress: '0.0.0.0'
    startIpAddress: '0.0.0.0'
  }  
}

resource protectionSetting 'Microsoft.Sql/servers/advancedThreatProtectionSettings@2022-05-01-preview' = if (enableSqlDefender) {
  parent: sqlserver
  name: 'Default'
  properties: {
    state: 'Enabled'
  }
}

resource assessment 'Microsoft.Sql/servers/sqlVulnerabilityAssessments@2022-05-01-preview' = if (enableSqlDefender) {
  parent: sqlserver
  name: 'Default'
  properties: {
    state: 'Enabled'
  }
}

resource connectionPolicy 'Microsoft.Sql/servers/connectionPolicies@2022-05-01-preview' = {
  parent: sqlserver
  name: 'Default'
  properties: {
    connectionType: connectionType
  }
}
// resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2014-04-01' = {  
//   parent: sqlServer  
//   name: sqlServerDatabaseName    
//   location: location      
//   properties: {
//     collation: collation    
//     edition: 'Basic'
//     maxSizeBytes: maxSizeBytes
//     requestedServiceObjectiveName: 'Basic'    
//   }

// }

resource Vnet2Man 'Microsoft.Network/virtualNetworks@2022-11-01' existing = {
  name: 'Vnet2ManServer'
}

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2021-05-01' = {
  name: 'sqlprivateendpoint'
  location: location
  properties: {
    subnet: {
      id: Vnet2Man.properties.subnets[0].id
    }
    privateLinkServiceConnections: [
      {
        name: 'privateEndSql'
        properties: {
          privateLinkServiceId:sqlserver.id
          groupIds: [
            'sqlServer'
          ]
        }
      }
    ]
  }
  dependsOn: [
    Vnet2Man
  ]
}
