// maat van de vmscale set
param vmSku string = 'Standard_B2s'

// // naam van de vmss
// @maxLength(61)
// param vmssName string = 'webservers-project1'

//@description('Number of VM instances (100 or less).')
@minValue(1)
@maxValue(3)
param instanceCount int = 2

@description('Admin username on all VMs.')
param adminUsername string = 'vmssadmin'

@description('Admin password on all VMs.')
@secure()
param adminPassword string // JGO123488J1fi456

@description('Location for all resources.')
param location string = resourceGroup().location

var vmScaleSetName = 'webvmssproject1'
var addressPrefix = '10.20.20.0/24'
var subnet1Prefix = '10.20.20.0/25'
var subnet2Prefix = '10.20.20.128/25'

var virtualNetworkName = 'webvmssvnet'
var publicIPAddressName = 'webvmsspip'
var subnetName = 'webvmsssubnet'
var subnet1Name = 'webvmsssubnet1'
var loadBalancerName = 'webvmsslb'
var natPoolName = 'webvmssnatpool'
var bePoolName = 'webvmssbepool'

var natStartPort = 50000
var natEndPort = 50119
var natBackendPort = 3389
var nicName = 'webvmssnic'
var ipConfigName = 'webvmssipconfig'


var customdatascript = loadFileAsBase64('install_apache.sh')

var osType = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '16.04-LTS'
  version: 'latest'
}
var imageReference = osType


resource nsg 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: 'nsgweb'
  location: location
  properties:{
    securityRules:[
      {
        name:'Allow-HTTP-InboundRule'
        properties:{
          access:'Allow'
          priority: 500
          direction: 'Inbound'
          protocol:'tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix:'*'
          destinationAddressPrefix: subnet1Prefix
          description: 'Inbound access to vmss website'

        }
      }
    ]
  }
}

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
        name: 'subnet1'
        properties: {
          addressPrefix: subnet1Prefix
          networkSecurityGroup:{
            id:nsg.id
          }
        }                
      }                 
    ]    
  }
}


resource subnet2 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  parent: virtualNetwork
  name: subnet1Name
  properties:{
    addressPrefixes:[
      subnet2Prefix
    ]
  }
}


resource publicIP 'Microsoft.Network/publicIPAddresses@2021-02-01' = {
  name: publicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
    dnsSettings: {
      domainNameLabel: vmScaleSetName
    }
  }
}

resource loadBalancer 'Microsoft.Network/loadBalancers@2021-02-01' = {
  name: loadBalancerName
  location: location
  properties: {
    frontendIPConfigurations: [
      {
        name: 'LoadBalancerFrontEnd'
        properties: {
          publicIPAddress: {
            id: publicIP.id
          }
        }
      }
    ]
    backendAddressPools: [
      {
        name: bePoolName
      }
    ]
    inboundNatPools: [
      {
        name: natPoolName
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/loadBalancers/frontendIPConfigurations', loadBalancerName, 'loadBalancerFrontEnd')
          }
          protocol: 'Tcp'
          frontendPortRangeStart: natStartPort
          frontendPortRangeEnd: natEndPort
          backendPort: natBackendPort
        }
      }
    ]
  }
}

resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2021-03-01' = {
  name: vmScaleSetName
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
    singlePlacementGroup: true
    virtualMachineProfile: {
      storageProfile: {
        osDisk: {
          createOption: 'FromImage'
          caching: 'ReadWrite'
        }
        imageReference: imageReference
      }
      osProfile: {
        computerNamePrefix: vmScaleSetName
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
