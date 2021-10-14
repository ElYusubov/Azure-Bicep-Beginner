// storage-w-variables.bicep

@description('Azure storage account name')
param storageName string

@description('Azure location for all resources')
param azureRegion string

@description('Deployment environment name')
param environment string = 'dev'

var accountName = '${storageName}${environment}'
var storageAccountSkuName = (environment == 'prod') ? 'Standard_GRS' : 'Standard_LRS'

resource bicepStorage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: accountName
  location: azureRegion
  sku: {
    name: storageAccountSkuName
  }
  kind: 'StorageV2'
}

output storageId string = bicepStorage.id
output blobEndpoint string = bicepStorage.properties.primaryEndpoints.blob
