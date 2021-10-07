resource bicepStorage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: 'bicepstgdemo'
  location: 'eastus2'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
