//azurewebapp.bicep

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'aspLinkedDemo104'
  location: resourceGroup().location
  sku: {
    name: 'F1'
    capacity: 1
  }
}

resource webAppResource 'Microsoft.Web/sites@2018-11-01' = {
  name: 'my-demo-linkedapp104'
  location: resourceGroup().location
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  }
  properties: {
    serverFarmId: appServicePlan.id
  }
}

resource myNewStorage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'storagedemo362872'
  location: resourceGroup().location
  sku: {
    name: 'Standard_GRS'
  }
  kind: 'StorageV2'
}
