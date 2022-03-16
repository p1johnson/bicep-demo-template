targetScope = 'resourceGroup'

param location string = resourceGroup().location
param virtualNetworkName string = 'vnet-bicep-demo'
param virtualNetworkAddresses array = [
  '10.0.0.0/16'
]
param virtualNetworkDnsServers array = []
param subnetName string = 'default'
param subnetAddress string = '10.0.1.0/24'

output subnetId string = resourceId('Microsoft.Network/virtualNetworks/subnets', virtualNetworkName, subnetName)

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-05-01' = {
  name: virtualNetworkName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: virtualNetworkAddresses
    }
    dhcpOptions: {
      dnsServers: virtualNetworkDnsServers
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddress
        }
      }
    ]
  }
}
