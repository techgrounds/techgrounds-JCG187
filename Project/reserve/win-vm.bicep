@description('naam voor de managementserver')
param vm string = 'win-web-vm'

@description('locatie waar de vm geinstalleerd wordt')
param location string = resourceGroup().location

@description('wachtwoord voor inlog')
@minLength(8)
@secure()
param adminPassword string

@description('inlognaam admin')
param adminUsername string 

@description('naam van de vm als je gaat inloggen')
param computerName string = 'win-management-server'

@description('vmSize')
param vmSize string = 'Standard_B2s'

@description('naam van de nic')
param networkInterfaceName string = 'man-nic'

@description('naam 2 voor nic')
param nicName string = 'man-server-nic'


//Nog nodig: ip adres. 
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////Public Ip adres//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
resource publicIp 'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: 'WinIP'
   dependsOn:  [
     manNic
   ]
}









//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////Network interface Card////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////




resource manNic 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: networkInterfaceName
  location: location
   properties: {
     ipConfigurations: [
       
     ]
   }
   
}






//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////VIRTUAL MACHINE//////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////

resource winVm 'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: vm
  location: location 
   properties:  {
      hardwareProfile: {
         vmSize: vmSize
      }
     osProfile: {
      adminPassword: adminPassword
      adminUsername: adminUsername
      computerName: computerName      
     } 
     storageProfile: {
       dataDisks: [
         {
          createOption: 'FromImage'
          lun: 1
          deleteOption: 'Delete'
          diskSizeGB: 128         
         
          }
        ]
        imageReference:  {
          publisher: 'MicrosoftWindowsServer'
          offer: 'WindowsServer'
          sku: '2019-datacenter-gensecond'
          version: 'latest'
        }
     }     
    }      
}
