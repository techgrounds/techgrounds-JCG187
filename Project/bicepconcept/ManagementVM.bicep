
param location string = resourceGroup().location
@secure()
param adminUsername string 
param computerName string = 'Man-vm'
@secure()
param adminPassword string


var virtualnetwork1Name = 'Vnet1'
var Subnet1Name = 'Subnet1'
var NetworkSecurityGroupName = 'nsg1'
var networkInterfaceName = 'Interface1'
var publicIpAddressName = 'PublicIP1'
var virtualmachineName = 'Virtualmachine1'


resource vnet_1 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualnetwork1Name
  location: location
  properties: {  
    addressSpace: {
       addressPrefixes: [
        '10.10.10.0/24'                        
       ]  
    }           
  }
}  
resource subnet_1 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {  
  parent: vnet_1
  name: Subnet1Name 
  properties: {
     addressPrefix: '10.10.10.0/24'
     privateEndpointNetworkPolicies: 'Enabled'
     privateLinkServiceNetworkPolicies: 'Enabled'
     networkSecurityGroup: {
       id: nsg1sub_1.id
     }
    }
  }
resource nsg1sub_1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {  
  location: location
  properties: {
     securityRules: [
       {
         name: 'RDP'
          properties: {
             priority:1000
              protocol: 'Tcp'
               access: 'Allow'
                direction: 'Inbound' 
                 sourceAddressPrefix: ''
                  sourcePortRange: '*'
                   destinationAddressPrefix: '*'
                    destinationPortRange: '3389'
          }          
       }
     ]    
  }
  
    name: NetworkSecurityGroupName
 }
resource nic_1 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name:  networkInterfaceName
  location:location
  properties: {
     ipConfigurations: [
       {
         name:'ipconfig1'
          properties: {
             subnet: {
               id:  subnet_1.id
             }
              privateIPAllocationMethod: 'Static'
               privateIPAddress: '10.10.10.50'
               publicIPAddress: {
                 id: publicIp.id
               }
                               
             }
          }       
     ]
  }
}

   resource publicIp 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIpAddressName
  location:location    
  sku: {
     name:   'Standard'
     tier: 'Regional'          
  }  
   properties: {
    publicIPAddressVersion: 'IPv4'    
    publicIPAllocationMethod: 'Static'        
    deleteOption: 'Delete'  
      }      
    } 
  
    
 resource ManagementVM 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: virtualmachineName
  location: location
  properties: {
     hardwareProfile: {
       vmSize:  'Standard_B2s'       
     }
     storageProfile: {
       osDisk: {
         name: 'OS-Disk'
        createOption:  'FromImage'
         managedDisk: {
           storageAccountType: 'Standard_LRS'
         }
          deleteOption: 'Delete'
       }
        imageReference: {
           publisher: 'MicrosoftWindowsServer'
            offer: 'WindowsServer'
             sku: '2019-datacenter-gensecond'
             version: 'latest' 
        }
     }
     networkProfile: {
       networkInterfaces: [
         {
           id:  nic_1.id
           
         }
       ]
     }
      osProfile: {
         computerName: computerName
          adminUsername:  adminUsername
           adminPassword: adminPassword
            windowsConfiguration: {
               enableAutomaticUpdates: true
                provisionVMAgent: true
            }
      }
   }
   zones: [
    '2'
   ]
  }



output nic1Id string = nic_1.id
output nic1Name string = nic_1.name
output subnet1ID string = subnet_1.id
output subnet1Name string = subnet_1.name
output publicIP string = publicIp.properties.ipAddress

