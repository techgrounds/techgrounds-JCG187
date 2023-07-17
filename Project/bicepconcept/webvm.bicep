param location string = resourceGroup().location 
param vmName string = 'web-vm'
@secure()
param adminUserName string 
@secure()
param password string

//@description('website dnsnaam')
//param dnslabelPrefix string = ('${vmName}-${uniqueString(resourceGroup().id)}')

var virtualnetwork2Name = 'VirtualNetwork2'
var subnet2Name = 'Subnet2'
var networkSecurityGroupName2 = 'nsg2'
var networkInterface2Name = 'Interface2'
var publiceIpAddress2Name = 'PublicIp2'
var virtualMachine2Name = 'vm2'


resource vnet_2 'Microsoft.Network/virtualNetworks@2022-11-01' = {  
  name: virtualnetwork2Name
  location: location
    properties: {   
      addressSpace: {
       addressPrefixes: [
        '10.20.20.0/24'                        
       ]         
    }     
  }
}  
resource Subnet_2 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  parent: vnet_2
  name: subnet2Name
  properties: {
     addressPrefix: '10.20.20.0/24'
      privateEndpointNetworkPolicies: 'Enabled'
       privateLinkServiceNetworkPolicies: 'Enabled'
     networkSecurityGroup: {
       id: nsg2sub_2.id 
     }
    }
}
resource nsg2sub_2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = { 
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
                 sourceAddressPrefix: '*'
                  sourcePortRange: '*'
                   destinationAddressPrefix: '*'
                    destinationPortRange: '*'
          }
       }
     ]
   }
 
  name: networkSecurityGroupName2
 }
resource networkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {  
  name: networkInterface2Name
   location: location
    properties: {
       ipConfigurations: [
         {
           name: 'ipconfig1'
            properties: {
               subnet: {
                 id: Subnet_2.id
               }
                privateIPAllocationMethod: 'Static'
                privateIPAddressVersion: 'IPv4'
                 privateIPAddress: '10.20.20.50'  
                 publicIPAddress: {
                   id: publicIpAddress.id
                 }               
                 
              }
          }         
       ]       
    }
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
       publicIPAddressVersion: 'IPv4'              
       deleteOption: 'Delete'   
        }     

    }
resource WebVm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualMachine2Name
  location: location
   properties: {
      hardwareProfile: {
         vmSize:  'Standard_B2s'
      }
       storageProfile: {
         osDisk: {
           name: 'OSubuntu-Disk'
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
             id:networkInterface.id
           }
         ]
       }
       osProfile: {
         computerName:vmName
          adminUsername:adminUserName
           adminPassword:password
            linuxConfiguration: {
               
                 
                }
            }
       }
       zones:[
        '2'
       ]
   }






output vnNamefgdn string = publicIpAddress.properties.dnsSettings.fqdn
