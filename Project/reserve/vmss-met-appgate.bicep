
param adminUsername string = 'adminproject1'
@secure()
param adminPassword string // JGO89HNG9Hiyn
param location string = resourceGroup().location

// @description('Size of the virtual machine.')
// param vmSize string = 'Standard_B2ms'

@description('Size of VMs in the VM Scale Set.')
param vmSku string = 'Standard_B2ms'

@description('Number of VM instances (100 or less).')
@minValue(1)
@maxValue(100)
param instanceCount int = 2

// param computerNamePrefix string = 'webServer${uniqueString(resourceGroup().id)}'
@description('When true this limits the scale set to a single placement group, of max size 100 virtual machines. NOTE: If singlePlacementGroup is true, it may be modified to false. However, if singlePlacementGroup is false, it may not be modified to true.')
param singlePlacementGroup bool = true

@description('Fault Domain count for each placement group.')
param platformFaultDomainCount int = 1

var osType = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '16.04-LTS'
  version: 'latest'
}
var imageReference = osType



var vmScaleSetName = 'scalesetwebserver'
var vNetName = 'vnet'
var publicIPAddressName = 'pip'
var subnetName = 'subnet'
//var publicIPAddressID = publicIPAddress.id
var nicName = 'nic'
var ipConfigName = 'ipconfig'
var nsgName = 'vm-nsg'
var applicationGateWayName = 'myAppGateway'
var virtualNetworkPrefix = '10.10.10.0/24'
var subnetPrefix = '10.10.10.0/25'
var backendSubnetPrefix = '10.10.10.128/25'
var customdata = loadFileAsBase64('install_apache.sh')

resource nsg 'Microsoft.Network/networkSecurityGroups@2021-05-01' = {
  name: nsgName
  location: location
  properties: {
    securityRules: [
      {
        name: 'HTTP'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '80'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 300
          direction: 'Inbound'
        }        
      }      
    ]    
  }  
}

resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-05-01' =  {
  name: publicIPAddressName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'
    idleTimeoutInMinutes: 4
  }
}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: vNetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        virtualNetworkPrefix
      ]
    }
    subnets: [
      {
        name: 'myfrontendAGSubnet'
        properties: {
          addressPrefix: subnetPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'myBackendwebSubnet'
        properties: {
          addressPrefix: backendSubnetPrefix
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    enableDdosProtection: false
    enableVmProtection: false    
  }
}

// resource virtualMachine 'Microsoft.Compute/virtualMachines@2021-11-01' = {
//   name: 
//   location: location
//   properties: {
//     hardwareProfile: {
//       vmSize: vmSize
//     }
//     storageProfile: {
//       imageReference: {
//         publisher: 'MicrosoftWindowsServer'
//         offer: 'WindowsServer'
//         sku: '2016-Datacenter'
//         version: 'latest'
//       }
//       osDisk: {
//         osType: 'Windows'
//         createOption: 'FromImage'
//         caching: 'ReadWrite'
//         managedDisk: {
//           storageAccountType: 'StandardSSD_LRS'
//         }
//         diskSizeGB: 127
//       }
//     }
//     osProfile: {
//       computerName: '${virtualMachineName}${i + 1}'
//       adminUsername: adminUsername
//       adminPassword: adminPassword
//       windowsConfiguration: {
//         provisionVMAgent: true
//         enableAutomaticUpdates: true
//       }
//       allowExtensionOperations: true
//     }
//     networkProfile: {
//       networkInterfaces: [
//         {
//           id: resourceId('Microsoft.Network/networkInterfaces', '${networkInterfaceName}${i + 1}')
//         }
//       ]
//     }
//   }
//   dependsOn: [
//     networkInterface
//   ]
// }]

// resource virtualMachine_IIS 'Microsoft.Compute/virtualMachines/extensions@2021-11-01' = {
//   name: '${virtualMachineName}${(i + 1)}/IIS'
//   location: location
//   properties: {
//     autoUpgradeMinorVersion: true
//     publisher: 'Microsoft.Compute'
//     type: 'CustomScriptExtension'
//     typeHandlerVersion: '1.4'
//     settings: {
//       commandToExecute: 'powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path "C:\\inetpub\\wwwroot\\Default.htm" -Value $($env:computername)'
//     }
//   }
//   dependsOn: [
//     virtualMachine
//   ]
// }]

resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01'= {
  name: vmScaleSetName
  location: location  
  zones:[
   '2' 
  ]
  sku: {
    name: vmSku
    tier: 'Standard'
    capacity: instanceCount
  }
  properties:{
    overprovision: true
    upgradePolicy:{
      mode:'Automatic'
    }      

    singlePlacementGroup:singlePlacementGroup
    platformFaultDomainCount: platformFaultDomainCount
    virtualMachineProfile:{
      osProfile:{
        computerNamePrefix:vmScaleSetName
        adminUsername:adminUsername
        adminPassword:adminPassword
        customData:customdata
            
      }          
      storageProfile:{
        osDisk:{
          createOption: 'FromImage'
          caching:'ReadWrite'
        }
        imageReference:imageReference
      }
      networkProfile:{
        networkInterfaceConfigurations:[
          {
            name: nicName
            properties:{
              primary:true
              ipConfigurations:[
                {
                  name:ipConfigName
                  properties:{
                    subnet:{
                      id:virtualNetwork.properties.subnets[1].id
                    }
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

resource autoscalehost 'Microsoft.Insights/autoscalesettings@2022-10-01' = {  
  name: 'autoscalehost1'
  location: location
  properties: {
    name: 'autoscalehost1'
    targetResourceUri: vmss.id
    enabled: true
    profiles: [
      {
        name: 'Profile2'
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
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 50
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
              metricResourceUri:  vmss.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: 30
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


resource applicationGateWay 'Microsoft.Network/applicationGateways@2021-05-01' = {
  name: applicationGateWayName
  location: location
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id:   virtualNetwork.properties.subnets[0].id    // resourceId('Microsoft.Network/virtualNetworks/subnets', vNetName, subnetName)                             
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIp'
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: resourceId('Microsoft.Network/publicIPAddresses', '${publicIPAddressName}0')
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'port_80'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'myBackendPool'
        properties: {
          backendAddresses:[
            {
              ipAddress:backendSubnetPrefix //////kijken of dit goed is
            }
          ]
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'myHTTPSetting'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          pickHostNameFromBackendAddress: false
          requestTimeout: 20
        }
      }
    ]
    httpListeners: [
      {
        name: 'myListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', applicationGateWayName, 'appGwPublicFrontendIp')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGateWayName, 'port_80')
          }
          protocol: 'Http'
          requireServerNameIndication: false
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'myRoutingRule'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateWayName, 'myListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'myBackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', applicationGateWayName, 'myHTTPSetting')
          }
        }
      }
    ]
    enableHttp2: false
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 3
    }
  }
  dependsOn: [
      publicIPAddress      
  ]
}

resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' =  {
  name: nicName
  location: location
  properties: {
    ipConfigurations: [
      {
        name: ipConfigName
        properties: {
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: resourceId('Microsoft.Network/publicIPAddresses', '${publicIPAddressName}')
          }
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vNetName, 'myBackendSubnet')
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          applicationGatewayBackendAddressPools: [
            {
              id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'myBackendPool')
            }
          ]
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    networkSecurityGroup: {
      id: resourceId('Microsoft.Network/networkSecurityGroups', '${nsgName}')
    }
  }
  dependsOn: [
    publicIPAddress
    applicationGateWay
    nsg
  ]
}




output vmssName string = vmss.name
output vmssID string = vmss.id
output vnetName string = virtualNetwork.name
output vnetID string = virtualNetwork.id
output subnet1Name string = virtualNetwork.name
output subnet1ID string = virtualNetwork.id

