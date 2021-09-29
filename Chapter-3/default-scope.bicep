// default-scope.bicep

targetScope = 'resourceGroup'

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2019-05-01' = {
  name: 'myacr0928'
  location: resourceGroup().location
  sku: {
    name: 'Standard'
  }
  properties: {
    adminUserEnabled: true
  }
}

output acrLoginServer string = containerRegistry.properties.loginServer
