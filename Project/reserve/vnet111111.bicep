param location string = resourceGroup().location //de locatie die gekoppeld is aan de resourcegroup
param vmName string = 'Mngm-VM'
param adminUsername string = 'admin'
param networkInterfaceName string = 'win-networkinterface'
param computerName string = 'admin-vm'

@secure()
param adminPassword string

//var VnetID = virtualNetworkId
//var subnetRef = '${vnetId}/subnets/${subnetName}'


resource vnet_1 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: 'Vnet1'
  location: location
  properties: {
    addressSpace: {
       addressPrefixes: [
        '10.10.0.0/24'                        
       ]  
    }           
  }
}  


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////



@description('aanmaken van subnet1 voor de webserver')
resource websubnet 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  parent: vnet_1 
  name: 'websubnet1' 
  properties: {
     addressPrefix: '10.10.10.0/25'
     networkSecurityGroup: {
       id: nsg1sub1.id
     }
    }
  }

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 


@description('netwerksecuritygroup voor subnet1')
resource nsg1sub1 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  location: location
    name: 'nsg1'
 }
     




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource vmWindows 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vmName
  location: location
  properties: {
     hardwareProfile: {
       vmSize: 'Standard_B2ms'
       
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
           id: networkInterfaceName
            properties: {
               deleteOption: 'Delete'
            }
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
}

resource publicIp 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: 'Win-ip'
  sku: {
     name: 'Basic'     
  }
  } 




resource networkinterface 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: networkInterfaceName
  properties: {
     ipConfigurations: [
       {
         name:'ipconfig1'
          properties: {
             subnet: {
               id:websubnet.id
             }
              privateIPAllocationMethod: 'Static'
              
          }
       }
     ]
  }
}












output webSubnet string = websubnet.id
output adminUsername string = adminUsername
output ip string = reference(networkInterfaceName).ipconfigurations[0].properties.privateIPAddress
