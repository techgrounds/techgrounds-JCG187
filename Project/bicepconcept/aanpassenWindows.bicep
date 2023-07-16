// gebuikersnaam voor de windows vm
param adminUsername string = 'managementserver1'

// wachtwoord voor de windows vm  ww = JaH00rW33r33n23456
@minLength(12)
@secure()
param adminPassword string

// unieke DMS naam voor het publieke Ip die wordt gebruikt om de virtuele machine te benaderen om in te loggen
// param dnsLabelPrefix string = toLower('${vmName}-${uniqueString(resourceGroup().id, vmName)}')

// naam voor de publieke Ip adres wat gebruikt kan worden om toegang tot de vm te krijgen
param publicIpName string = 'manPIP'


// de windows server versies die gebruikt mogen worden. Dit zal een volledig gepatchte image kiezen van de opgegeven Windows-versie.')
@allowed([
  '2022-datacenter-azure-edition'
  '2022-datacenter-azure-edition-core'
  '2022-datacenter-azure-edition-core-smalldisk'
  '2022-datacenter-azure-edition-smalldisk'
  '2022-datacenter-core-g2'
  '2022-datacenter-core-smalldisk-g2'
  '2022-datacenter-g2'
  '2022-datacenter-smalldisk-g2'
])
param OSVersion string = '2022-datacenter-azure-edition'

// de grote van de virtuele machine
param vmSize string = 'Standard_B2s'

// locatie voor alle resources
param location string = resourceGroup().location

// de naam van de v machine
param vmName string = 'Man1-vm'

// het soort beveiliging wat gebruikt kan worden voor de virtuele Machine
// @allowed([
//   'Standard'
//   'TrustedLaunch'
// ])
// param securityType string = 'Standard'

var storageAccountName = 'bootdiags${uniqueString(resourceGroup().id)}'
var nicName = 'Man1-Nic1'
// var securityProfileJson = {
//   uefiSettings: {
//     secureBootEnabled: true
//     vTpmEnabled: true
//   }
//   securityType: securityType
// }

resource Vnet2Man 'Microsoft.Network/virtualNetworks@2023-02-01' existing = {
   name: 'existingvnet2'
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2022-05-01' = {
  name: publicIpName
  location: location
  sku: {
    name: 'Standard' //basic zal per 30-9-2025 niet meer bestaan.
  }
  properties: {
    publicIPAllocationMethod: 'Dynamic'
   
  }
}


resource nic 'Microsoft.Network/networkInterfaces@2022-05-01' = {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIp.id
          }
          subnet: {
            id: Vnet2Man.properties.subnets[0].id
          }
        }
      }
    ]
  }
  dependsOn: [

    Vnet2Man
  ]
}

resource vm 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: vmSize
    }
    osProfile: {
      computerName: vmName
      adminUsername: adminUsername
      adminPassword: adminPassword
    }
    storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: OSVersion
        version: 'latest'
      }
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'Standard_LRS'
        }
      }
      dataDisks: [
        {
          diskSizeGB: 1023
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: nic.id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: storageAccount.properties.primaryEndpoints.blob
      }
    }
    // securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)    
  }
  zones:[
    '2'
  ]
}













output hostnamefqdn string = publicIp.properties.dnsSettings.fqdn

