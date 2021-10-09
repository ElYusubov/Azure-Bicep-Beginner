// container-registry.bicep

targetScope = 'resourceGroup'

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2019-05-01' = {
  name: 'demoacr109'
  location: resourceGroup().location
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

output containerRegistryLoginServer string = containerRegistry.properties.loginServer
