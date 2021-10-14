// storage-parametrized.bicep

@description('Storage account name')
param storageName string

@description('Azure location for all resources')
param azureRegion string

@description('Azure storage SKU')
param storageSku string

@description('Deployment environment name')
param environment string = 'dev'

resource bicepStorage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: '${storageName}${environment}'
  location: azureRegion
  sku: {
    name: storageSku
  }
  kind: 'StorageV2'
}
