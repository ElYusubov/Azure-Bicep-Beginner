resource globalazuredemostg21 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'globalazuredemostg21'
  location: 'eastus2'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
  }
  tags: {
    Environment: 'Demo'
    Project: 'First Look into Azure Bicep'
  }
}
