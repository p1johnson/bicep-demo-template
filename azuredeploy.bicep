targetScope = 'subscription'

param location string = 'uksouth'
param resourceGroupName string = 'rg-bicep-demo'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

module virtualNetwork 'modules/virtualNetwork/azuredeploy.bicep' = {
  name: 'virtualNetwork'
  scope: resourceGroup
  params: {
    location: location
  }
}

module jumpServer 'modules/jumpServer/azuredeploy.bicep' = {
  name: 'jumpServer'
  scope: resourceGroup
  params: {
    location: location
    subnetId: virtualNetwork.outputs.subnetId
  }
}
