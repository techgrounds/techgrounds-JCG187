//parameters voor de resourcegroup
param location string = 'westeurope'
param ResourceGroupName string = 'test123'

//parameters voor de storage account
param storageAccountName string = 'storage1${uniqueString(resourceGroup().id)}'


//parameters voor de windows server
// gebuikersnaam voor de windows vm
param adminUsername string = 'Jennifer'

// wachtwoord voor de windows vm  ww = JaH00rW33r33n23456
@minLength(12)
@secure()
param adminPassword string

// unieke DMS naam voor het publieke Ip die wordt gebruikt om de virtuele machine te benaderen om in te loggen
param dnsLabelPrefix string = toLower('${vmName}-${uniqueString(resourceGroup().id, vmName)}')

// naam voor de publieke Ip adres wat gebruikt kan worden om toegang tot de vm te krijgen
param publicIpName string = 'myPublicIP'

// de methode waarop het publieke IP adres wordt gegeven. In dit geval dynamisch
@allowed([
  'Dynamic'
  'Static'
])
param publicIPAllocationMethod string = 'Dynamic'

@description('SKU for the Public IP used to access the Virtual Machine.')
@allowed([
  'Basic'
  'Standard'
])
param publicIpSku string = 'Basic'

// de windows server versies die gebruikt mogen worden. Dit zal een volledig gepatchte image kiezen van de opgegeven Windows-versie.')
@allowed([
  '2022-datacenter-azure-edition'
  '2022-datacenter-azure-edition-core'
  '2022-datacenter-azure-edition-core-smalldisk'
  '2022-datacenter-azure-edition-smalldisk'
  '2022-datacenter-core-g2'
  '2022-datacenter-core-smalldisk-g2'
  '2022-datacenter-g2'
  '2022-datacenter-smalldisk-g2'
])
param OSVersion string = '2022-datacenter-azure-edition'

// de grote van de virtuele machine
param vmSize string = 'Standard_B2s'


// het soort beveiliging wat gebruikt kan worden voor de virtuele Machine
@allowed([
  'Standard'
  'TrustedLaunch'
])
param securityType string = 'Standard'

//parameters voor de ubuntu server
param admin2UserName string
@secure()
@minLength(12)
param password2 string
param vmName string = 'web-vm'
param dnsLabelPrefix string = toLower('${vmName}-${uniqueString(resourceGroup().id, vmName)}')

//parameters voor de netwerk peering
param peeringName1 string = 'peer1with2'
param peeringName2 string = 'peer2with1'


//parm voor recovery-vault


module rgroup 'rsg.bicep' = {
  scope:  subscription()
  name: 'moduleResourceGroup'
  params: {
     location:location 
      ResourceGroupName:ResourceGroupName
  }
}



module storageAcc 'storage.bicep' = {
  name: 'moduleStorageAcc'
   params: {
     location:location 
      storageAccountName:storageAccountName
   }
}




module win1vnet  'Windows.bicep' = {
  name: 'managementserver'
  params: {
    adminPassword: adminPassword
    adminUsername: adminUsername
    location: location
    dnsLabelPrefix: dnsLabelPrefix 
    OSVersion: OSVersion 
    publicIPAllocationMethod: publicIPAllocationMethod
    publicIpName: publicIpName 
    publicIpSku:  publicIpSku 
    securityType: securityType 
    vmName: vmName 
    vmSize: vmSize

  }
}
 

module ubu2vnet 'Ubuntu.bicep' = {
  name: 'moduleVnet2'
  params: {
    location:location 
    vmName:vmName
    admin2UserName:admin2UserName
    password2:password2 
    dnsLabelPrefix:dnsLabelPrefix
  }
}


module peer 'peering.bicep' = {
  name: 'modulePeering'
  params:{
    peeringName1:peeringName1
    peeringName2:peeringName2
  }
}



module recoverVault 'recovery-vault.bicep' = {
  name: 
  params: {
    existingVirtualMachines: 
    existingVirtualMachinesResourceGroup: 
  }
}



