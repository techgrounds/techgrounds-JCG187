// gebuikersnaam voor de windows vm
param adminUsername string = 'Jennifer'

// wachtwoord voor de windows vm  ww = JaH00rW33r33n23456
@minLength(12)
@secure()
param adminPassword string

// unieke DMS naam voor het publieke Ip die wordt gebruikt om de virtuele machine te benaderen om in te loggen
param dnsLabelPrefix string = toLower('${vmName}-${uniqueString(resourceGroup().id, vmName)}')

// naam voor de publieke Ip adres wat gebruikt kan worden om toegang tot de vm te krijgen
param publicIpName string = 'myPublicIP'

// de methode waarop het publieke IP adres wordt gegeven. In dit geval dynamisch
@allowed([
  'Dynamic'
  'Static'
])
param publicIPAllocationMethod string = 'Dynamic'

@description('SKU for the Public IP used to access the Virtual Machine.')
@allowed([
  'Basic'
  'Standard'
])
param publicIpSku string = 'Basic'

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
@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'Standard'

var storageAccountName = 'bootdiags${uniqueString(resourceGroup().id)}'
var nicName = 'Man1-Nic1'
var addressPrefix = '10.10.10.0/24'
var subnetName = 'Man1-Subnet1'
var subnetPrefix = '10.10.10.0/24'
var virtualNetworkName = 'Man1-Vnet1'
var networkSecurityGroupName = 'Man1-Nsg1'
var securityProfileJson = {
  uefiSettings: {
    secureBootEnabled: true
    vTpmEnabled: true
  }
  securityType: securityType
}
// var extensionName = 'GuestAttestation'
// var extensionPublisher = 'Microsoft.Azure.Security.WindowsAttestation'
// var extensionVersion = '1.0'
// var maaTenantName = 'GuestAttestation'
// var maaEndpoint = substring('emptyString', 0, 0)

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
    name: publicIpSku
  }
  properties: {
    publicIPAllocationMethod: publicIPAllocationMethod
    dnsSettings: {
      domainNameLabel: dnsLabelPrefix
    }
  }
}

resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2022-05-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: [
      {
        name: 'default-allow-3389'
        properties: {
          priority: 1000
          access: 'Allow'
          direction: 'Inbound'
          destinationPortRange: '3389'
          protocol: 'Tcp'
          sourcePortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
        }
      }
    ]
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2022-05-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        addressPrefix
      ]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetPrefix
          networkSecurityGroup: {
            id: networkSecurityGroup.id
          }
        }
      }
    ]
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
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName)
          }
        }
      }
    ]
  }
  dependsOn: [

    virtualNetwork
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
    securityProfile: ((securityType == 'TrustedLaunch') ? securityProfileJson : null)
  }
}

// resource vmExtension 'Microsoft.Compute/virtualMachines/extensions@2022-03-01' = if ((securityType == 'TrustedLaunch') && ((securityProfileJson.uefiSettings.secureBootEnabled == true) && (securityProfileJson.uefiSettings.vTpmEnabled == true))) {
//   parent: vm
//   name: extensionName
//   location: location
//   properties: {
//     publisher: extensionPublisher
//     type: extensionName
//     typeHandlerVersion: extensionVersion
//     autoUpgradeMinorVersion: true
//     enableAutomaticUpgrade: true
//     settings: {
//       AttestationConfig: {
//         MaaSettings: {
//           maaEndpoint: maaEndpoint
//           maaTenantName: maaTenantName
//         }
//       }
//     }
//   }
// }




// resource peering 'Microsoft.Network/virtualNetworks/virtualNetworkPeerings@2022-11-01' = {
//   name: 
//    parent: virtualNetwork
//     properties: {
//        allowForwardedTraffic:
//         allowGatewayTransit:
//          allowVirtualNetworkAccess:
//           doNotVerifyRemoteGateways:
//            peeringState:
//             peeringSyncLevel:
//              remoteAddressSpace:
//               remoteBgpCommunities:
//                remoteVirtualNetwork:
//                 remoteVirtualNetworkAddressSpace:
//                  useRemoteGateways:
//     }
//      dependsOn: [
       
//      ]
      
// }











output hostname string = publicIp.properties.dnsSettings.fqdn
output windowsVnetName string = virtualNetwork.name
