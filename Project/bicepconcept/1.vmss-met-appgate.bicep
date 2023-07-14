
param adminUsername string = 'Jennifer'
@secure()
param adminPassword string // JGO89HNG9Hiyn
param location string = resourceGroup().location

param backendIpAddress string = '10.10.10.128/25'

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

param vmScaleSetName string = 'vmssWebApp'


var osType = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '16.04-LTS'
  version: 'latest'
}
var imageReference = osType

//var vNetName = 'vnet'

//var publicIPAddressID = publicIPAddress.id
var nicName = 'nic'
var ipConfigName = 'ipconfig'
// var nsgName = 'vm-nsg'
// var nsg1Name = 'vm-nsg1'
var applicationGateWayName = 'myAppGateway'
// var virtualNetworkPrefix = '10.10.10.0/24'
// var FrontsubnetPrefix = '10.10.10.0/25'
// var backendSubnetPrefix = '10.10.10.128/25'
var customdata = loadFileAsBase64('install_apache.sh')


resource Vnet1Web 'Microsoft.Network/virtualNetworks@2023-02-01' existing = {
   name:'existingVnet1'
}






resource publicIPAddress 'Microsoft.Network/publicIPAddresses@2021-05-01' =  {
  name: 'gatewaypublicIP'
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
                id:nsg
              }
              ipConfigurations:[
                {
                  name:ipConfigName
                  properties:{
                    subnet:{
                       id:resourceId('Microsoft.Network/VirtualNetworks/subnets', 'Vnet1Web','sub2web')
                    }
                    privateIPAddressVersion: 'IPv4'
                     applicationGatewayBackendAddressPools: [
                       {
                         id:resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName,'appGatewayBackendAddressPool')
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
    networkInterface
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
            id: resourceId('Microsoft.Network/VirtualNetworks/subnets', 'Vnet1Web', 'sub1web')                                 
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
        name: 'appGatewayFrontporthttp'
        properties: {
          port: 80
        }        
      }
      {
        name:'appGatewayFrontPorthttps'
        properties:{
          port: 443
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'appGatewayBackendAddressPool'
        properties:{
                            
        }     
        }      
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGatewayBackendHttpSettings'
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
        name: 'appgatewayHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', applicationGateWayName, 'appGwPublicFrontendIp')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGateWayName,'appGatewayFrontporthttp')
          }
          protocol: 'Http'      
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          ruleType: 'Basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', applicationGateWayName, 'appgatewayHttpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'appGatewayBackendAddressPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', applicationGateWayName, 'appGatewayBackendHttpSettings')
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
          // privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: publicIPAddress.id       ///////resourceId('Microsoft.Network/publicIPAddresses', publicIPAddress, 'gatewaypublicIP')
          }
          subnet: {
            id: resourceId('Microsoft.Network/VirtualNetworks/subnets', 'Vnet1Web','sub2web')
          }
          primary: true
          privateIPAddressVersion: 'IPv4'
          applicationGatewayBackendAddressPools: [
            {
              id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'appGatewayBackendAddressPool')
            }
          ]
        }
      }
    ]
    enableAcceleratedNetworking: false
    enableIPForwarding: false
    networkSecurityGroup: {
      id: resourceId('Microsoft.Network/networkSecurityGroup', 'Vnet1Web', 'sub1web')
    }
  }
  dependsOn: [
   
    applicationGateWay
    Vnet1Web
    
  ]
}
