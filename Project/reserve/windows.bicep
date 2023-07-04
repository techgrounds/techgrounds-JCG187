@description('resource deployment region')
param location string = resourceGroup().location

@description('naam van de NIC')
param NICname string = 'win-man-NIC'

@description('name of NSG')
param networkSecurityGroupName string = 'win-man-nsg'

@description('network security group rules')
param networkSecurityGroupRules array 

@description('naam van virtuele network')
param virtualNetworkName string = 'win-man-network'

@description('prefix van de vnet')
param addressPrefixes array = ['10.20.0.0/16']

@description('prefix van subnet?')
param subnets array = [  '10.20.20.0/24']

@description('naam van de subnet')
param subnetName string = 'win-man-subnet2'

@description('naam van de public IP adres')
param publicIpAddressName string = 'win-man-public-ip'

@description('public address type')
param publicIpAddressType string = 'Dynamic'

@description('public IP address SKU')
param publicIpAddressSku string = 'Basic'

@description('naam van VM')
param VMName string = 'win-man-vm'

//@description('naam van datadisk')
//param dataDiskName string = 'win-man-datadisk'

@description('Admin user name')
param adminUsername string 

@description('password for VM')
@minLength(8)
@secure()
param adminPassword string  

//@description('enable acceleratednetworking')
//param enableAcceleratedNetworking bool = true

var nsgId = resourceId(resourceGroup().name, 'Microsoft.Network/networkSecurityGroups', networkSecurityGroupName)
var vnetId = resourceId(resourceGroup().name, 'Microsoft.Network/virtualNetworks', networkSecurityGroupName)
var subnetRef = '${vnetId}/subnets/${subnetName}'


///////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////NETWORKINTERFACE//////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////


resource WindowsAdminNic 'Microsoft.Network/networkInterfaces@2022-11-01' = {
  name: NICname
  location:location
  properties: {
     ipConfigurations: [
       {
         name:'vnet_2'
         properties: {
           subnet: {
             id: 'subnetRef'
           }
           privateIPAllocationMethod: 'Dynamic'
           publicIPAddress: {
             id: resourceId(resourceGroup().name, 'Microsoft.Network/publicIpAddresses', publicIpAddressName)
           }
         }
       }
      ]   
  }   
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////VNET///////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////

@description('aanmaken van vnet2 voor management server')
resource vnet_2 'Microsoft.Network/virtualNetworks@2022-11-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
       addressPrefixes: [
        '10.20.0.0/16'                        
       ]      
    }          
  }
}  


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////SUBNET/////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////



@description('aanmaken van subnet2 voor de managementserver')
resource managementsubnet2 'Microsoft.Network/virtualNetworks/subnets@2022-11-01' = {
  parent: vnet_2 //hiermee vertel je dat het een subnet is van het vnet
  name: subnetName //naam van de subnet
  properties: {
     addressPrefix: '10.20.20.0/24'//subnetadres
     networkSecurityGroup: {
       id: nsgId
     }
    }
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////NETWORKSECURITYGROUP////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////



@description('netwerksecuritygroup voor subnet1')
resource nsg 'Microsoft.Network/networkSecurityGroups@2022-11-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
     securityRules: networkSecurityGroupRules
  } 
 }



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////PUBLIC-IP-ADDRESS////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////


resource publicIpAddress  'Microsoft.Network/publicIPAddresses@2022-11-01' = {
  name: publicIpAddressName
  location: location
  properties: {
    publicIPAllocationMethod: publicIpAddressType
  }
  sku: {
    name: publicIpAddressSku
  }
  zones: [
    
  ]
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////VIRTUAL-MACHINE-DATA-DISK////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//resource winManDataDisk 'Microsoft.Compute/disks@2022-07-02' = {
//  name: dataDiskName
//  location: location
//  properties:  {
//    creationData: {
//      createOption: 'FromImage'
//    }
//  }
//  sku: {
//    name:'Standard_LRS'   
//  }
//  zones: 
//}













//////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////WINDOWS VM////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////





resource WindowsManVM  'Microsoft.Compute/virtualMachines@2023-03-01' = {
  name: VMName
  location: location
 properties: {
  hardwareProfile: {
     vmSize:  'Standard_B2s'    
  }
  osProfile: {
    adminPassword: adminPassword
    adminUsername: adminUsername 
    computerName:'adminVM'
    
    windowsConfiguration: { 
       additionalUnattendContent: [
         {
           
         }
       ]
    }
  }
  storageProfile: {
     osDisk: {
      createOption: 'FromImage'
      managedDisk: {
        storageAccountType: 'Standard_LRS'
      }
      deleteOption: 'Delete'
     }
     imageReference:  {
       publisher: 'MicrosoftWindowsServer'
       offer: 'WindowsServer'
       sku: '2019-datacenter-gensecond'
       version: 'latest'
     }
    }
  }
}
