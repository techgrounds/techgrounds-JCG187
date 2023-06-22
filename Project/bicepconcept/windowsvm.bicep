param location string = 'westeurope'
param nicname string = 'windows-adm-nic'
param networkSecurityGroupName string = 'window-nsg'
param networkSecurityGroupRules array 
param subnetName string
param virtualNetworkName string
param addressPrefixes array
param subnets array
param publicIpAddressName2 string
param publicIpAddressType string
param publicIpAddressSku string
param pipDeleteOption string
param virtualMachineName string = 'windows-man-server'
param virtualMachineName2 string
param virtualMachineComputerName2 string
param virtualMachineRG string
param osDiskType string
param osDiskDeleteOption string
param dataDisks2 array
param dataDiskResources2 array
param virtualMachineSize string
param nicDeleteOption string
param adminUsername string

@secure()
param adminPassword string
param patchMode string
param enableHotpatching bool
param virtualMachine2Zone string

var nsgId = resourceId(resourceGroup().name, 'Microsoft.Network/networkSecurityGroups', networkSecurityGroupName)
var vnetName = virtualNetworkName
var vnetId = resourceId(resourceGroup().name, 'Microsoft.Network/virtualNetworks', virtualNetworkName)
var subnetRef = '${vnetId}/subnets/${subnetName}'



///////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////NETWORKINTERFACE//////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////






resource NicWindowsAdmServ 'Microsoft.Network/networkInterfaces@2021-08-01' = {
  name: nicname
  location: location
  properties: {
    ipConfigurations: [
      {
        name: 'ipconfig1'
        properties: {
          subnet: {
            id: 'subnetRef'
          }
          privateIPAllocationMethod: 'Dynamic'
          publicIPAddress: {
            id: resourceId(resourceGroup().name, 'Microsoft.Network/publicIpAddresses', publicIpAddressName2)
            properties: {
              deleteOption: pipDeleteOption
            }            
          }
        }
      }
    ]
    networkSecurityGroup: {
      id: nsgId
    }
  }
  dependsOn: [
    networkSecurityGroup
    virtualNetwork
    publicIpAddress2
  ]
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////NETWORKSECURITYGROUP///////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////







resource networkSecurityGroup 'Microsoft.Network/networkSecurityGroups@2019-02-01' = {
  name: networkSecurityGroupName
  location: location
  properties: {
    securityRules: networkSecurityGroupRules
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////VNET////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////





resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-01-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: addressPrefixes
    }
    subnets: subnets
  }
}


////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////PUBLIC-IP-ADRESS///////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////







resource publicIpAddress2 'Microsoft.Network/publicIpAddresses@2020-08-01' = {
  name: publicIpAddressName2
  location: location
  properties: {
    publicIPAllocationMethod: publicIpAddressType
  }
  sku: {
    name: publicIpAddressSku
  }
  zones: [
    virtualMachine2Zone
  ]
}



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////VIRTUAL-MACHINE-DATA-DISK////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////




resource dataDiskResources2_name 'Microsoft.Compute/disks@2022-03-02' = [for item in dataDiskResources2: {
  name: item
  location: location
  properties: 
  sku: {
    name: 'StandardSSD_ZRS'
  }
  zones: (contains(item.sku, '_ZRS') ? json('null') : array(virtualMachine2Zone))
}]



////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////VIRTUAL MACHINE2//////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////







resource virtualMachine2 'Microsoft.Compute/virtualMachines@2022-03-01' = {
  name: virtualMachineName2
  location: location
  properties: {
    hardwareProfile: {
      vmSize: virtualMachineSize
    }
    storageProfile: {
      osDisk: {
        createOption: 'fromImage'
        managedDisk: {
          storageAccountType: osDiskType
        }
        deleteOption: osDiskDeleteOption
      }
      imageReference: {
        publisher: 'MicrosoftWindowsServer'
        offer: 'WindowsServer'
        sku: '2019-datacenter-gensecond'
        version: 'latest'
      }
      dataDisks: [for item in dataDisks2: {
        lun: item.lun
        createOption: item.createOption
        caching: item.caching
        diskSizeGB: item.diskSizeGB
        managedDisk: {
          id: (item.id ?? ((item.name == json('null')) ? json('null') : resourceId('Microsoft.Compute/disks', item.name)))
          storageAccountType: item.storageAccountType
        }
        deleteOption: item.deleteOption
        writeAcceleratorEnabled: item.writeAcceleratorEnabled
      }]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: .id
          properties: {
            deleteOption: nicDeleteOption
          }
        }
      ]
    }
    osProfile: {
      computerName: virtualMachineComputerName2
      adminUsername: adminUsername
      adminPassword: adminPassword
      windowsConfiguration: {
        enableAutomaticUpdates: true
        provisionVMAgent: true
        patchSettings: {
          enableHotpatching: enableHotpatching
          patchMode: patchMode
        }
      }
    }
  }
  zones: [
    virtualMachine2Zone
  ]
  dependsOn: [
    dataDiskResources2_name

  ]
}

output adminUsername string = adminUsername
