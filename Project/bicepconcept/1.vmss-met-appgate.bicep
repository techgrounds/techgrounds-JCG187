
param adminUsername string = 'Jennifer'
@secure()
param adminPassword string // JGO89HNG9Hiyn
param location string = resourceGroup().location

// @description('Size of the virtual machine.')
// param vmSize string = 'Standard_B2ms'

//Size of VMs in the VM Scale Set
param vmSku string = 'Standard_B2s'

//Number of VM instances (100 or less)
@minValue(1)
@maxValue(100)
param instanceCount int = 2

// param computerNamePrefix string = 'webServer${uniqueString(resourceGroup().id)}'
@description('When true this limits the scale set to a single placement group, of max size 100 virtual machines. NOTE: If singlePlacementGroup is true, it may be modified to false. However, if singlePlacementGroup is false, it may not be modified to true.')
param singlePlacementGroup bool = true

//Fault Domain count for each placement group
param platformFaultDomainCount int = 1

var osType = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '16.04-LTS'
  version: 'latest'
}
var imageReference = osType



param vmScaleSetName string = 'vmssWebApp'
var vNetName = 'vnet'
var publicIPAddressName = 'pip'
//var publicIPAddressID = publicIPAddress.id
var nicName = 'nic'
var ipConfigName = 'ipconfig'
var nsgName = 'vm-nsg'
var applicationGateWayName = 'myAppGateway'
var virtualNetworkPrefix = '10.10.10.0/24'
var FrontsubnetPrefix = '10.10.10.0/25'
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
    dnsSettings:{
      domainNameLabel:'webproject1'
    }
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
        name: '${vNetName}-frontsubnet'
        properties: {
          addressPrefix: FrontsubnetPrefix
          // privateEndpointNetworkPolicies: 'Enabled'
          // privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: '${vNetName}-backsubnet'
        properties: {
          addressPrefix: backendSubnetPrefix
          // privateEndpointNetworkPolicies: 'Enabled'
          // privateLinkServiceNetworkPolicies: 'Enabled'
          networkSecurityGroup: {
            id:nsg.id
          }
        }
      }
    ]
    enableDdosProtection: false
    enableVmProtection: false    
  }
}

resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2023-03-01'= {
  name: vmScaleSetName
  location: location  
  // zones:[
  //  '2' 
  // ]
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
          managedDisk:{
           storageAccountType:'StandardSSD_ZRS' 
          }
        }
        imageReference:imageReference
      }
      networkProfile:{
        networkInterfaceConfigurations:[
          {
            name: nicName
            properties:{
              primary:true
              networkSecurityGroup:{
                id:nsg.id
              }
              ipConfigurations:[
                {
                  name:ipConfigName
                  properties:{
                    subnet:{
                       id:virtualNetwork.properties.subnets[1].id
                    }
                    privateIPAddressVersion: 'IPv4'
                     applicationGatewayBackendAddressPools: [
                       {
                         id:resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'appGatewayBackendPool')
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
  dependsOn:[
    applicationGateWay
  ]
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
              metricNamespace:''
              metricResourceUri: vmss.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 80
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
    predictiveAutoscalePolicy:{
      scaleMode: 'Disabled'     
    }
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
            id: virtualNetwork.properties.subnets[0].id                             
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
            id: publicIPAddress.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'frontendport1'
        properties: {
          port: 80
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'myBackendPool'        
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
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGateWayName,'frontendport1')
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
