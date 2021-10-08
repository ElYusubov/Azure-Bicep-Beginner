// storage-w-variables.bicep

param storageName string
param azureRegion string
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
