
param adminUsername string = 'adminwebserver'
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

//scale set name
param vmScaleSetName string = 'vmssWebApp'


var osType = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '16.04-LTS'
  version: 'latest'
}
var imageReference = osType

//var publicIPAddressID = publicIPAddress.id
var nicName = 'nic'
var ipConfigName = 'ipconfig'
var applicationGateWayName = 'myAppGateway'
var customdata = loadFileAsBase64('install_apache.sh')


resource Vnet1Web 'Microsoft.Network/virtualNetworks@2023-02-01' existing = {
   name: 'Vnet1WebServer'
}


resource nsg1 'Microsoft.Network/networkSecurityGroups@2023-02-01' existing = {
   name:'nsg1web'
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
      domainNameLabel:'webproject1jgo2023'      
    }    
  }
  dependsOn:[
    Vnet1Web
  ]
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
    // automaticRepairsPolicy:{
    //   enabled:true
    // }
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
          
              ipConfigurations:[
                {
                  name:ipConfigName
                  properties:{
                    subnet:{
                       id:Vnet1Web.properties.subnets[1].id
                    }
                    privateIPAddressVersion: 'IPv4'
                     applicationGatewayBackendAddressPools: [
                       {
                         id: applicationGateWay.properties.backendAddressPools[0].id                                   //resourceId('Microsoft.Network/applicationGateways/backendAddressPools', 'myAppGateway','appGatewayBackendAddressPool') 
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
    //  applicationGateWay
    // networkInterface
    nsg1
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
    backendAddressPools: [
      {
        name: 'appGatewayBackendAddressPool'
        properties:{                               
        }     
        }      
    ]        
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: Vnet1Web.properties.subnets[0].id //resourceId('Microsoft.Network/VirtualNetworks/subnets', Vnet1Web.name, 'sub1web')                                 
          }                    
        }        
      }      
    ]        
    frontendIPConfigurations: [
      {
        name: 'appGwPublicFrontendIp'
        properties: {
          privateIPAllocationMethod: 'Dynamic'   
          publicIPAddress:{
            id: publicIPAddress.id    //resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'appGatewayBackendAddressPool')
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
      // {
      //   name:'appGatewayFrontPorthttps'
      //   properties:{
      //     port: 443
      //   }
      // }
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
          requireServerNameIndication:false     
        }
      }
      // {
      //   name: 'myListenerHTTPS'
      //   properties: {
      //     frontendIPConfiguration: {
      //       id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', applicationGateWayName, 'appGwPublicFrontendIp')
      //     }
      //     frontendPort: {
      //       id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', applicationGateWayName, 'appGatewayFrontPorthttps')
      //     }
      //     protocol: 'Https'
      //     requireServerNameIndication: false
      //     sslCertificate: {
      //       id: resourceId('Microsoft.Network/applicationGateways/authenticationCertificates', applicationGateWayName, 'myCertificate')
      //     }
      //   }
      // }
    ]
    requestRoutingRules: [
      {
        name: 'rule1HTTP'
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
      // {
      //   name: 'myRoutingRuleHTTPS'
      //   properties: {
      //     ruleType: 'Basic'
      //     httpListener: {
      //       id: resourceId('Microsoft.Network/applicationGateways/httpListeners', appGatewayName, 'myListenerHTTPS')
      //     }
      //     backendAddressPool: {
      //       id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', appGatewayName, 'myBackendPool')
      //     }
      //     backendHttpSettings: {
      //       id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', appGatewayName, 'myHTTPSSetting')
      //     }
      //   }
      // }
    ]
    enableHttp2: false
    autoscaleConfiguration: {
      minCapacity: 0
      maxCapacity: 3
    }
  }
 dependsOn:[
  Vnet1Web
 ]
}

// resource networkInterface 'Microsoft.Network/networkInterfaces@2021-05-01' =  {
//   name: nicName
//   location: location
//   properties: {
//     ipConfigurations: [
//       {
//         name: ipConfigName
//         properties: {
//           privateIPAllocationMethod: 'Dynamic'
//           // publicIPAddress: {
//           //   id: publicIPAddress.id       ///////resourceId('Microsoft.Network/publicIPAddresses', publicIPAddress, 'gatewaypublicIP')
//           // }
//           subnet: {
//             id:  Vnet1Web.properties.subnets[1].id  //resourceId('Microsoft.Network/VirtualNetworks/subnets', 'Vnet1Web','sub1web')
//           }
//           primary: true
//           privateIPAddressVersion: 'IPv4'
//           // applicationGatewayBackendAddressPools: [
//           //   {
//           //     id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', applicationGateWayName, 'appGatewayBackendAddressPool')
//           //  }
//           //]
//         }
//       }
//     ]
//     enableAcceleratedNetworking: false
//     enableIPForwarding: false
//     networkSecurityGroup: {
//       id:nsg1.id                                   // resourceId('Microsoft.Network/networkSecurityGroup','nsg1') //Vnet1Web.properties.subnets[0].id
//     }
//   }
//   dependsOn: [    
//     applicationGateWay
//     Vnet1Web
//     // nsg1
    
//   ]
// }
