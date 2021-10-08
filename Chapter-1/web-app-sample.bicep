param azureRegion string = resourceGroup().location

resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'asp-demo9124'
  location: azureRegion
  sku: {
    name: 'F1'
    capacity: 1
    tier: 'Free'
  }
}

resource webApplication 'Microsoft.Web/sites@2018-11-01' = {
  name: 'app-name-914'
  location: azureRegion
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}

output webApplicationHostName string = webApplication.properties.defaultHostName
