// maat van de vmscale set
param vmSku string = 'Standard_B2s'

// naam van de vmss
@maxLength(61)
param vmssName string = 'web2-vmss2'

//gebruikersnaam administrator
param admin2UserName string = 'Jennifer'

// hoeveelheid vm instances die minimaal en maximaal aangemaakt mogen worden
@minValue(1)
@maxValue(3)
param instanceCount int

// wachtwoord om min te loggen
@secure()
@minLength(12)
param password2 string // JGO1234**JGO1234 wachtwoord voor vm

param dnsLabelPrefix string = toLower('${vmName}-${uniqueString(resourceGroup().id, vmName)}')


var osType = {
  publisher: 'Canonical'
  offer: 'UbuntuServer'
  sku: '16.04-LTS'
  version: 'latest'
}
var imageReference = osType


//@allowed([
//  'sshPublicKey'
//  'password'
//])
//@description('Type of authentication to use on the Virtual Machine. SSH key is recommended.')
//param authenticationType string = 'password'

//@description('SSH Key or password for the Virtual Machine. SSH key is recommended.')
//@secure()
//param adminPasswordOrKey string


param location string = resourceGroup().location 
param vmName string = 'Web2-vm2'
param sshPrefix string = '10.10.10.0/24'





var newStorageAccountName = 'web2storage${uniqueString(resourceGroup().id)}'
var virtualnetwork2Name = 'Web-Vnet2'
var subnet2Name = 'Web-Subnet2'
var networkSecurityGroupName2 = 'Web-nsg2'
var networkInterface2Name = 'Web-Nic2'
var publiceIpAddress2Name = 'web-PublicIp2'
var virtualMachine2Name = 'web2-vm2'
var customdatascript =   loadFileAsBase64('install_apache.sh')  
var addressPrefix = '10.20.20.0/24'     
var subnetPrefix = '10.20.20.0/24'





resource newStorageAccountName_resource 'Microsoft.Storage/storageAccounts@2021-01-01' = {
  name: newStorageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}



resource publicIpAddress 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publiceIpAddress2Name
  location:location
   sku: {
     name:  'Standard'
     tier: 'Regional'
   }
    properties: {
       publicIPAllocationMethod: 'Static'
       dnsSettings: {
           domainNameLabel: dnsLabelPrefix
       }              
       deleteOption: 'Delete'   
        }     
        
  }

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
          computerNamePrefix: virtualMachine2Name
          adminUsername: admin2UserName
          adminPassword: password2
          customData: customdatascript
        }
        networkProfile: {
          networkInterfaceConfigurations: [
            {
              name: networkInterface2Name
              properties: {
                primary: true
                ipConfigurations: [
                  {
                    name:  networkInterface2Name
                    properties: {
                      subnet: {
                        id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnet_2.name, subnet2Name)
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
      automaticRepairsPolicy: {
         enabled: true
         gracePeriod: 'PT30M' 
      }
       
    }
  }
  
  resource autoScaleSettings 'microsoft.insights/autoscalesettings@2015-04-01' = {
    name: 'cpuautoscale'
    location: location
    properties: {
      name: 'cpuautoscale'
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
  

resource nsg2sub_2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = { 
  name: networkSecurityGroupName2
  location: location
  properties: {
    securityRules: [
        {        
        name: 'SSH'
        properties: {
        priority:1000
        protocol: 'Tcp' 
        access: 'Allow'
        direction: 'Inbound'
        sourceAddressPrefix: sshPrefix
        sourcePortRange: '*'
        destinationAddressPrefix: '*'
        destinationPortRange: '22'
         }
      }    
      {
        name: 'HTTPS'
       properties:{
         access: 'Allow'
         direction: 'Inbound'
         priority: 1002
         protocol: 'Tcp'
         sourceAddressPrefix:'*'
         sourcePortRange:'*'
         destinationAddressPrefix:'*'
         destinationPortRange: '443'
      }   
    }
    ]
  } 
}


resource vnet_2 'Microsoft.Network/virtualNetworks@2022-11-01' = {  
  name: virtualnetwork2Name
  location: location
    properties: {   
      addressSpace: {
       addressPrefixes: [
         addressPrefix                        
       ]         
    }    
    subnets: [
       {
         name: subnet2Name
          properties: {
             addressPrefix: subnetPrefix  
              networkSecurityGroup: {
                 id: nsg2sub_2.id
              }
          }
       }
    ] 
  }
}  

 resource networkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {  
  name: networkInterface2Name
   location: location
    properties: {
       ipConfigurations: [
         {
           name: 'ipconfig1'
            properties: {               
                privateIPAllocationMethod: 'Dynamic'                              
                 publicIPAddress: {
                   id: publicIpAddress.id                   
                 } 
                 subnet: {
                  id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualnetwork2Name, subnet2Name)
                 }                    
              }
          }         
       ]       
    }
     dependsOn: [
       vnet_2
     ]
}


resource WebVm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachine2Name
  location: location
   properties: {
    userData: customdatascript
      hardwareProfile: {
         vmSize:  'Standard_B2s'
      }
       storageProfile: {
         osDisk: {
           name: 'OSubuntu-Disk'
           caching: 'ReadWrite'
           createOption: 'FromImage' 
            managedDisk: {
               storageAccountType:  'Standard_LRS'
            }
             deleteOption: 'Delete'
         }
           imageReference:  {
             publisher: 'Canonical'
              offer: 'UbuntuServer'
              sku: '16.04-LTS'
               version: 'latest'

           }           
       }
       networkProfile: {
         networkInterfaces: [
           {
             id: networkInterface.id
           }
         ]
       }
       osProfile: {
         computerName:vmName
          adminUsername:admin2UserName
           adminPassword:password2          
            customData: customdatascript
            }
            diagnosticsProfile: {
               bootDiagnostics: {
                 enabled: true 
                  storageUri: newStorageAccountName_resource.properties.primaryEndpoints.blob
               }
            }

       }
       zones:[
        '2'
       ]
   }

   


   output hostname string = publicIpAddress.properties.dnsSettings.fqdn
   output nic2Id string = networkInterface.id
   output nic2Name string = networkInterface.name
   output publicIP string = publicIpAddress.properties.ipAddress
   output virtualNetworkName string = vnet_2.id
