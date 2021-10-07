param storageName string
param azureRegion string
param storageSku string
param environment string = 'dev'

resource bicepStorage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: '${storageName}${environment}'
  location: azureRegion
  sku: {
    name: storageSku
  }
  kind: 'StorageV2'
}
