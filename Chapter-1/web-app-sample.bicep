// snippet: res-app-plan
resource appServicePlan 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'asp-demo912'
  location: resourceGroup().location
  sku: {
    name: 'F1'
    capacity: 1
    tier: 'Free'
  }
}

// snippet: res-webb-app
resource webApplication 'Microsoft.Web/sites@2018-11-01' = {
  name: 'app-name-914'
  location: resourceGroup().location
  tags: {
    'hidden-related:${resourceGroup().id}/providers/Microsoft.Web/serverfarms/appServicePlan': 'Resource'
  }
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
  }
}
