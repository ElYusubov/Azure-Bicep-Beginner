// bicep-storage-starter.bicep

param storageAccounts_mycloudshell0324_name string = 'mycloudshell0324'

resource storageAccounts_mycloudshell0324_name_resource 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccounts_mycloudshell0324_name
  location: 'eastus2'
  tags: {
    'ms-resource-usage': 'azure-cloud-shell'
  }
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    networkAcls: {
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource storageAccounts_mycloudshell0324_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' = {
  parent: storageAccounts_mycloudshell0324_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: false
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_mycloudshell0324_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-04-01' = {
  parent: storageAccounts_mycloudshell0324_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {}
    }
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_mycloudshell0324_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-04-01' = {
  parent: storageAccounts_mycloudshell0324_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_mycloudshell0324_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-04-01' = {
  parent: storageAccounts_mycloudshell0324_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource storageAccounts_mycloudshell0324_name_default_myfileshare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-04-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_mycloudshell0324_name_default
  name: 'myfileshare'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 6
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_mycloudshell0324_name_resource
  ]
}
