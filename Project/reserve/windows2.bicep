
param location string = resourceGroup().location
param adminUsername string // Jennifer
param computerName string = 'Man-vm'
@secure()
param adminPassword string // JaH00rW33r33n23456


var storageAccountName = 'bootdiags${uniqueString(resourceGroup().id)}'
var virtualnetwork1Name = 'Vnet1'
var Subnet1Name = 'Subnet1'
var NetworkSecurityGroupName = 'nsg1'
var networkInterfaceName = 'Interface1'
var publicIpAddressName = 'PublicIP1'
var vmname = 'Virtualmachine1'
var addressprefix = '10.10.10.0/24'
var subnetprefix = '10.10.10.0/24'

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-05-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'Storage'
}


resource publicIp 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIpAddressName
  location:location    
  sku: {
     name:   'Standard'
      tier: 'Regional'           
  }  
   properties: {    
    publicIPAllocationMethod: 'Static'   
             }              
    } 
  

    resource nsg1sub_1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {  
      name: NetworkSecurityGroupName
      location: location
      properties: {
         securityRules: [
           {
             name: 'AllowAnyCustomAnyInbound'
             properties: {
             priority:1000
             protocol: '*'
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
     }
    


resource vnet_1 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualnetwork1Name
  location: location
  properties: {  
    addressSpace: {
       addressPrefixes: [
        addressprefix                        
       ]  
    }     
     subnets: [
       {
         name: Subnet1Name 
          properties: {
             addressPrefix: subnetprefix 
              networkSecurityGroup: {
                 id: nsg1sub_1.id
              }
          }
       }
     ]      
  }
}  



resource nic_1 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name:  networkInterfaceName
  location:location
  properties: {
     ipConfigurations: [
       {
         name:'ipconfig1'
          properties: {
             privateIPAllocationMethod: 'Dynamic'
              publicIPAddress: {
                 id: publicIp.id
              }
              subnet: {
                 id: resourceId('Microsoft.Network/virtualNetworks/subnets', virtualnetwork1Name, Subnet1Name)
                  
              }
          }               
       }       
     ]     
  }
  dependsOn: [
     vnet_1
  ]
}


    
 resource ManagementVM 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vmname
  location: location
  properties: {
     hardwareProfile: {
       vmSize:  'Standard_B2s'       
     }
     osProfile: {
      computerName: computerName
      adminUsername:  adminUsername
      adminPassword: adminPassword
         
   }
     storageProfile: {
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
         offer: 'WindowsServer'
          sku: '2019-datacenter-gensecond'
          version: 'latest' 
     }
       osDisk: {
         name: 'OSWIN-Disk'
        createOption:  'FromImage'
         managedDisk: {
           storageAccountType: 'Standard_LRS'
         }
          deleteOption: 'Delete'
       }        
        dataDisks: [
           {
            createOption: 'Empty' 
            lun: 0
            diskSizeGB: 1023
           }
        ]
     }
     networkProfile: {
       networkInterfaces: [
         {
           id:  nic_1.id           
         }
       ]
     }  
     diagnosticsProfile: {
       bootDiagnostics: {
         enabled: true
          storageUri:storageAccount.properties.primaryEndpoints.blob
       }
     }    
   }
   zones: [
    '2'
   ]   
  }



output nic1Id string = nic_1.id
output nic1Name string = nic_1.name
output publicIP string = publicIp.properties.ipAddress

