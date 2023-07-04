@description('locatie die gekoppeld is aan de resourcegroup')
param location string = resourceGroup().location 


@description('naam van de virtuele machine')
param vmName string = 'web-vm'

@description('naam van de gebruiker die in mag loggen op de linux web vm')
param adminUserName string = 'admin'

@secure()
param password string

@description('Naam van de virtuele netwerk')
param virtualNetworkName string = 'Vnet2'

@description('Naam van de subnet')
param subnetName string = 'subnet2'

@description('naam van de network security group')
param networkSecurityGroupName string = 'nsg2'


@description('naam van de NIC')
param networkInterfaceName string = 'web-interfacecard'

@description('naam van het publieke IP adres')
param publicIpAddressName string = 'web-public-IP'

@description('website dnsnaam')
param dnslabelPrefix string = ('${vmName}-${uniqueString(resourceGroup().id)}')





//aanmaken van vnet2 voor linux webserver
resource vnet_2 'Microsoft.Network/virtualNetworks@2022-11-01' = {  
  name: virtualNetworkName
  location: location
    properties: { 
  
  
      addressSpace: {
       addressPrefixes: [
        '10.20.20.0/24'                        
       ]         
    }     
  }
}  
//aanmaken van subnet2 voor de linux webserver
resource webSubnet2 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  parent: vnet_2
  name: subnetName
  properties: {
     addressPrefix: '10.20.20.0/25'
      privateEndpointNetworkPolicies: 'Enabled'
       privateLinkServiceNetworkPolicies: 'Enabled'
     networkSecurityGroup: {
       id: nsg2sub2.id 
     }
    }
}

@description('netwerksecuritygroup voor subnet2')
resource nsg2sub2 'Microsoft.Network/networkSecurityGroups@2022-11-01' = { 
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
                    destinationPortRange: '22'
          }
       }
     ]
   }
  dependsOn: [
     vnet_2
  ]
  name: networkSecurityGroupName
 }



//aanmaken network interface
resource networkInterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: networkInterfaceName
   location: location
    properties: {
       ipConfigurations: [
         {
           name: 'ipconfig1'
            properties: {
               subnet: {
                 id:webSubnet2.id
               }
                privateIPAllocationMethod: 'Dynamic'
                 publicIPAddress: {
                   id: publicIpAddress.id
                 }
            }
         }
       ]
       networkSecurityGroup: {
         id:nsg2sub2.id
       }
    }
}



//aanmaken public IP adres
resource publicIpAddress 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIpAddressName
  location:location
   sku: {
     name:  'Standard'
   }
    properties: {
       publicIPAllocationMethod:  'Static'
        publicIPAddressVersion: 'IPv4'
         dnsSettings: {
           domainNameLabel: dnslabelPrefix
         }
    }
}






  

//aanmaken linux vm voor de website
resource WebVm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: 'Web-vm'
  location: location
   properties: {
      hardwareProfile: {
         vmSize:  'Standard_B2s'
      }
       storageProfile: {
         osDisk: {
           createOption: 'FromImage' 
            managedDisk: {
               storageAccountType:  'Standard_LRS'
            }
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
               disablePasswordAuthentication: false
            }
       }
   }
}





output vnName string = publicIpAddress.properties.dnsSettings.fqdn
