// back ups voor RPO (Recover point objective) is 1 week van dat akwijt max. Liefst 1 dag.
// RTO (recover time objectieve) is 1 uur max. 


//parameters voor storage vault

@description('Name of the Vault')
param vaultName string = 'recover'

@description('Location for all resources.')
param location string = resourceGroup().location

@description('Change Vault Storage Type (Works if vault has not registered any backup instance)')
@allowed([
  'LocallyRedundant'
  'GeoRedundant'
])
param vaultStorageType string = 'GeoRedundant'

var skuName = 'RS0'
var skuTier = 'Standard'



//parameters en variabelen voor backup policies

@description('Resource group where the virtual machines are located. This can be different than resource group of the vault. ')
param existingVirtualMachinesResourceGroup string

@description('Array of Azure virtual machines. e.g. ["vm1","vm2","vm3"]')
param existingVirtualMachines array

@description('Conditional parameter for New or Existing Vault')
param isNewVault bool = false

@description('Backup policy to be used to backup VMs. Backup POlicy defines the schedule of the backup and how long to retain backup copies. By default every vault comes with a \'DefaultPolicy\' which canbe used here.')
param policyName string = 'DefaultPolicy'

@description('Conditional parameter for New or Existing Backup Policy')
param isNewPolicy bool = false

var backupFabric = 'Azure'
var scheduleRunTimes = [
  '2017-01-26T05:30:00Z'
]
var v2VmType = 'Microsoft.Compute/virtualMachines'
var v2VmContainer = 'iaasvmcontainer;iaasvmcontainerv2;'
var v2Vm = 'vm;iaasvmcontainerv2;'



//                                                                                                                              //
//                                               recovery service vault                                                         //
//                                                                                                                              //








resource recoveryServicesVault 'Microsoft.RecoveryServices/vaults@2020-10-01' = {
  name: vaultName
  location: location
  properties: {
    encryption: {
       
    }
  }
  sku: {
    name: skuName
    tier: skuTier
  }
}

//                                                                                                                              //
//                                                      backup policies                                                         //
//                                                                                                                              //




resource backupPolicy 'Microsoft.RecoveryServices/vaults/backupPolicies@2021-03-01' = if (isNewPolicy) {
  parent: recoveryServicesVault
  name: policyName
  location: location
  properties: {
    backupManagementType: 'AzureIaasVM'
    instantRpRetentionRangeInDays: 5
    schedulePolicy: {
      scheduleRunFrequency: 'Daily'
      scheduleRunTimes: scheduleRunTimes
      schedulePolicyType: 'SimpleSchedulePolicy'
    }
    retentionPolicy: {
      dailySchedule: {
        retentionTimes: scheduleRunTimes
        retentionDuration: {
          count: 104
          durationType: 'Days'
        }
      }
      weeklySchedule: {
        daysOfTheWeek: [
          'Sunday'
          'Tuesday'
          'Thursday'
        ]
        retentionTimes: scheduleRunTimes
        retentionDuration: {
          count: 104
          durationType: 'Weeks'
        }
      }
      monthlySchedule: {
        retentionScheduleFormatType: 'Daily'
        retentionScheduleDaily: {
          daysOfTheMonth: [
            {
              date: 1
              isLast: false
            }
          ]
        }
        retentionTimes: scheduleRunTimes
        retentionDuration: {
          count: 60
          durationType: 'Months'
        }
      }
      yearlySchedule: {
        retentionScheduleFormatType: 'Daily'
        monthsOfYear: [
          'January'
          'March'
          'August'
        ]
        retentionScheduleDaily: {
          daysOfTheMonth: [
            {
              date: 1
              isLast: false
            }
          ]
        }
        retentionTimes: scheduleRunTimes
        retentionDuration: {
          count: 10
          durationType: 'Years'
        }
      }
      retentionPolicyType: 'LongTermRetentionPolicy'
    }
    timeZone: 'UTC'
  }
}

resource protectedItems 'Microsoft.RecoveryServices/vaults/backupFabrics/protectionContainers/protectedItems@2021-03-01' = [for item in existingVirtualMachines: {
  name: '${vaultName}/${backupFabric}/${v2VmContainer}${existingVirtualMachinesResourceGroup};${item}/${v2Vm}${existingVirtualMachinesResourceGroup};${item}'
  location: location
  properties: {
    protectedItemType: v2VmType
    policyId: backupPolicy.id
    sourceResourceId: resourceId(subscription().subscriptionId, existingVirtualMachinesResourceGroup, 'Microsoft.Compute/virtualMachines', item)
  }
  dependsOn: [
    recoveryServicesVault
  ]
}]
