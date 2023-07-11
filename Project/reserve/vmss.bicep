// maat van de vmscale set
param vmSku string = 'Standard_B2s'

// @description('The Windows version for the VM. This will pick a fully patched image of this given Windows version.')
// @allowed([
//   '2019-Datacenter'
//   '2016-Datacenter'
//   '2012-R2-Datacenter'
//   '2012-Datacenter'
// ])
// param windowsOSVersion string = '2019-Datacenter'

// naam van de vmss
@maxLength(61)
param vmssName string = 'web2-vmss2'

//@description('Number of VM instances (100 or less).')
@minValue(1)
@maxValue(3)
param instanceCount int

@description('Admin username on all VMs.')
param adminUsername string = 'Jennifer'

@description('Admin password on all VMs.')
@secure()
param adminPassword string // JGO123488J1fi456

@description('Location for all resources.')
param location string = resourceGroup().location

var namingInfix = toLower(substring('${vmssName}${uniqueString(resourceGroup().id)}', 0, 9))
var longNamingInfix = toLower(vmssName)
var addressPrefix = '10.20.20.0/24'
var subnetPrefix = '10.20.20.0/24'

var virtualNetworkName = '${namingInfix}vnet'
var publicIPAddressName = '${namingInfix}pip'
var subnetName = '${namingInfix}subnet'
var loadBalancerName = '${namingInfix}lb'
var natPoolName = '${namingInfix}natpool'
var bePoolName = '${namingInfix}bepool'

var natStartPort = 50000
var natEndPort = 50119
var natBackendPort = 3389
var nicName = '${namingInfix}nic'
var ipConfigName = '${namingInfix}ipconfig'


var customdatascript = loadFileAsBase64('install_apache.sh')

var osType = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '16.04-LTS'
  version: 'latest'
}
var imageReference = osType

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-02-01' = {
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
        }
      }
    ]
  }
}

resource publicIP 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: publicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: longNamingInfix
    }
  }
}



resource nsg




// resource loadBalancer 'Microsoft.Network/loadBalancers@2021-02-01' = {
//   name: loadBalancerName
//   location: location
//   properties: {
//     frontendIPConfigurations: [
//       {
//         name: 'LoadBalancerFrontEnd'
//         properties: {
//           publicIPAddress: {
//             id: publicIP.id
//           }
//         }
//       }
//     ]
//     backendAddressPools: [
//       {
//         name: bePoolName
//       }
//     ]
//     inboundNatPools: [
//       {
//         name: natPoolName
//         properties: {
//           frontendIPConfiguration: {
//             id: resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations', loadBalancerName, 'loadBalancerFrontEnd')
//           }
//           protocol: 'Tcp'
//           frontendPortRangeStart: natStartPort
//           frontendPortRangeEnd: natEndPort
//           backendPort: natBackendPort
//         }
//       }
//     ]
//   }
// }

resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2021-03-01' = {
  name: vmssName
  location: location
  sku: {
    name: vmSku
    tier: 'Standard'
    capacity: instanceCount
  }
  properties: {
    overprovision: true
    upgradePolicy: {
      mode: 'Manual'
    }
    virtualMachineProfile: {
      storageProfile: {
        osDisk: {
          createOption: 'FromImage'
          caching: 'ReadWrite'
        }
        imageReference: imageReference
      }
      osProfile: {
        computerNamePrefix: namingInfix
        adminUsername: adminUsername
        adminPassword: adminPassword
        customData: customdatascript
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: nicName
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: ipConfigName
                  properties: {
                    subnet: {
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetwork.name, subnetName)
                    }
                    loadBalancerBackendAddressPools: [
                      {
                        id: resourceId('Microsoft.Network/loadBalancers/backendAddressPools', loadBalancer.name, bePoolName)
                      }
                    ]
                    loadBalancerInboundNatPools: [
                      {
                        id: resourceId('Microsoft.Network/loadBalancers/inboundNatPools', loadBalancer.name, natPoolName)
                      }
                    ]
                  }
                }
              ]
            }
          }
        ]
      }
    }
  }
}

resource autoScaleSettings 'microsoft.insights/autoscalesettings@2015-04-01' = {
  name: 'cpuautoscale1'
  location: location
  properties: {
    name: 'cpuautoscale1'
    targetResourceUri: vmss.id
    enabled: true
    profiles: [
      {
        name: 'Profile1'
        capacity: {
          minimum: '1'
          maximum: '3'
          default: '1'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: vmss.id
              timeGrain: 'PT1M'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 50
              statistic: 'Average'
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: vmss.id
              timeGrain: 'PT1M'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: 30
              statistic: 'Average'
            }
            scaleAction: {
              direction: 'Decrease'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
        ]
      }
    ]
  }
}
