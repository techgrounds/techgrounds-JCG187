@description('Size of VMs in the VM Scale Set.')
param vmSku string ='Standard_A1_v2'

@description('String used as a base for naming resources. Must be 3-57 characters in length and globally unique across Azure. A hash is prepended to this string for some resources, and resource-specific information is appended.')
@maxLength(57)
param vmssName string = 'vmss'

@description('Number of VM instances (1000 or less).')
@minValue(1)
@maxValue(3)
param instanceCount int

@description('Admin username on all VMs.')
param adminUsername string = 'Jennifer'

@description('Default location')
param location string = resourceGroup().location



// @description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
// @allowed([
//   'sshPublicKey'
//   'password'
// ])
// param authenticationType string = 'sshPublicKey'

@description('SSH Key or password for the Virtual Machine. SSH key is recommended.')
@secure()
param adminPasswordOrKey string // JaH00rW33r33n23456

// var namingInfix_var = toLower(substring(concat(vmssName, uniqueString(resourceGroup().id)), 0, 9))
var customdatascript = loadFileAsBase64('install_apache.sh')
var addressPrefix = '10.0.0.0/16'
var subnetPrefix = '10.0.8.0/21'
var virtualNetworkName = 'vmssvnet'
var subnetName = 'vmsssubnet'
var nicName = 'vmssnic'
var ipConfigName = 'vmssipconfig'
var imageReference = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '16.04-LTS'
  version: 'latest'
}
var appGwPublicIPAddressName = 'vmssappGwPip'
var appGwName = 'vmssappGw'
var appGwPublicIPAddressID = appGwPublicIPAddress.id
var appGwSubnetName = 'wmssappGwSubnet'
var appGwSubnetPrefix = '10.0.1.0/24'
var appGwSubnetID = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, appGwSubnetName)
var appGwFrontendPort = 80
var appGwBackendPort = 80
var appGwBePoolName = 'vmssappGwBepool'
// var linuxConfiguration = {
//   disablePasswordAuthentication: true
//   ssh: {
//     publicKeys: [
//       {
//         path: '/home/${adminUsername}/.ssh/authorized_keys'
//         keyData: adminPasswordOrKey
//       }
//     ]
//   }
// }

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2020-08-01' = {
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
      {
        name: appGwSubnetName
        properties: {
          addressPrefix: appGwSubnetPrefix
        }
      }
    ]
  }
}

resource appGwPublicIPAddress 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
    name: appGwPublicIPAddressName
  location: location
  properties: {
    publicIPAllocationMethod: 'Dynamic'
  }
}

resource appGw  'Microsoft.Network/applicationGateways@2022-11-01' = {  
  name: appGwName
  location: location  
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard'     
      capacity:3

      
    }
    gatewayIPConfigurations: [
      {
        name: 'appGwIpConfig'
        properties: {
          subnet: {
            id: appGwSubnetID
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGwFrontendIP'
        properties: {
        privateIPAllocationMethod: 'Dynamic'
        publicIPAddress: {
           id: resourceId('Microsoft.Network/publicIPAddresses', '${appGwPublicIPAddressID}0')
        }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'appGwFrontendPort'
        properties: {
          port:appGwFrontendPort
        }
      }
    ]
    backendAddressPools: [
      {
        name: appGwBePoolName
        properties: {
          backendAddresses:[
            {
              ipAddress:subnetPrefix
            }
          ]
        }
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGwBackendHttpSettings'
        properties: {
          port: appGwBackendPort
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGwHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations/', appGwName, 'appGwFrontendIP')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts/', appGwName, 'appGwFrontendPort')
          }
          protocol: 'Http'
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'rule1'
        properties: {
          ruleType: 'basic'
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners/', appGwName, 'appGwHttpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools/', appGwName, appGwBePoolName)
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection/', appGwName, 'appGwBackendHttpSettings')
          }          
        }
      }
    ]   
  }
  dependsOn: [
    virtualNetwork

  ]
}

resource scaleset 'Microsoft.Compute/virtualMachineScaleSets@2017-03-30' = {
  name: vmssName
  location: location
  sku: {
    name: vmSku
    tier: 'Standard'
    capacity: instanceCount
  }
  properties: {
    overprovision: true
    singlePlacementGroup: false
    upgradePolicy: {
      mode: 'Automatic'
    }
    virtualMachineProfile: {
      storageProfile: {
        osDisk: {
          caching: 'ReadWrite'
          createOption: 'FromImage'
        }
        imageReference: imageReference
      }
      osProfile: {
        computerNamePrefix: vmssName
        adminUsername: adminUsername
        adminPassword: adminPasswordOrKey
        // linuxConfiguration: ((authenticationType == 'password') ? json('null') : linuxConfiguration)
        customData:customdatascript
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
                      id: resourceId('Microsoft.Network/virtualNetworks/subnets/', virtualNetworkName, subnetName)
                    }
                    applicationGatewayBackendAddressPools: [
                      {
                        id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools/', appGwName, appGwBePoolName)
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
  dependsOn: [
    virtualNetwork
    appGw
  ]
}

// Application Gateway uses a rule to specify how to direct the messages that it receives on its incoming port to the servers in the back-end pool. If the servers are using TLS/SSL, you must configure the rule to indicate:

//     That the servers expect traffic through the HTTPS protocol.
//     Which certificate to use to encrypt traffic and authenticate the connection to a server.



// Application Gateway routing

// When the gateway routes a client request to a web server in the back-end pool, it uses a set of rules configured for the gateway to determine where the request should go. 
// There are two primary methods of routing this client request traffic: path-based routing and multiple-site routing.

// Path-based routing

// Path-based routing sends requests with different URL paths to different pools of back-end servers. For example, you could direct requests with the 
// path /video/* to a back-end pool containing servers that are optimized to handle video streaming, and direct /images/* requests to a pool of servers that handle image retrieval.

// Multiple-site routing

// Multiple-site routing configures more than one web application on the same Application Gateway instance. In a multi-site configuration, you register multiple DNS names (CNAMEs) for 
// the IP address of the application gateway, specifying the name of each site. Application Gateway uses separate listeners to wait for requests for each site. 
// Each listener passes the request to a different rule, which can route the requests to servers in a different back-end pool. For example, you could direct all requests 
// for http://contoso.com to servers in one back-end pool, and requests for http://fabrikam.com to another back-end pool. The following diagram shows this configuration:

// TLS/SSL termination

// When you terminate the TLS/SSL connection at the application gateway, it offloads the CPU-intensive TLS/SSL termination workload from your servers. Also, you don’t need to 
// install certificates and configure TLS/SSL on your servers.

// If you need end-to-end encryption, Application Gateway can decrypt the traffic on the gateway by using your private key, then re-encrypt again with the public key of the 
// service running in the back-end pool.

// Traffic enters the gateway through a front-end port. You can open many ports, and Application Gateway can receive messages on any of these ports. A listener is the first 
// thing that your traffic meets when entering the gateway through a port. It's set up to listen for a specific host name, and a specific port on a specific IP address. 
// The listener can use an TLS/SSL certificate to decrypt the traffic that enters the gateway. The listener then uses a rule that you define to direct the 
// incoming requests to a back-end pool.

// Health probes

// Health probes determine which servers are available for load-balancing in a back-end pool. The Application Gateway uses a health probe to send a request to a server. 
// When the server returns an HTTP response with a status code between 200 and 399, the server is considered healthy. If you don't configure a health probe, 
// Application Gateway creates a default probe that waits for 30 seconds before deciding that a server is unavailable. Health probes ensure that traffic isn't 
// being directed to a back-end pool web endpoint that is non-responsive for has failed.
