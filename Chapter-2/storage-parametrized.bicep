param storageName string
param azureRegion string
param storageSku string

resource bicepStorage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageName
  location: azureRegion
  sku: {
    name: storageSku
  }
  kind: 'StorageV2'
}
