using './key-vault.bicep'
using './rsg.bicep'

param location = 'westeurope'
param ResourceGroupName = 'test123'

param keyVaultName = 'test123project${uniqueString(resourceGroup().id)}'
param location = resourceGroup().location
param tenantID = '2927c370-1129-495e-8c20-77eddca0ae1e' // let op dit is tenant ID van mijn abonnement. Die vindt je in Azure AD

