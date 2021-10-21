// bicepdemoapp-refactored.bicep

param sites_bicepdemo_app_name string = 'bicepdemo-app'
param serverfarms_asp_bicepdemoapp_name string = 'asp-bicepdemoapp'
param virtualNetworks_bicepnetwork_name string = 'bicepnetwork'
param storageAccounts_samplestg1010_name string = 'samplestg1010'
param registries_demoacr109_name string = 'demoacr109'
param azureRegion string = 'eastus'

resource registries_demoacr109_name_resource 'Microsoft.ContainerRegistry/registries@2021-06-01-preview' = {
  name: registries_demoacr109_name
  location: azureRegion
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
    policies: {
      quarantinePolicy: {
        status: 'disabled'
      }
      trustPolicy: {
        type: 'Notary'
        status: 'disabled'
      }
      retentionPolicy: {
        days: 7
        status: 'disabled'
      }
      exportPolicy: {
        status: 'enabled'
      }
    }
    encryption: {
      status: 'disabled'
    }
    dataEndpointEnabled: false
    publicNetworkAccess: 'Enabled'
    networkRuleBypassOptions: 'AzureServices'
    zoneRedundancy: 'Disabled'
    anonymousPullEnabled: false
  }
}

resource virtualNetworks_bicepnetwork_name_resource 'Microsoft.Network/virtualNetworks@2020-11-01' = {
  name: virtualNetworks_bicepnetwork_name
  location: azureRegion
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'default'
        properties: {
          addressPrefix: '10.0.0.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: 'app-subnet'
        properties: {
          addressPrefix: '10.0.1.0/24'
          delegations: []
          privateEndpointNetworkPolicies: 'Enabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }
}

resource storageAccounts_samplestg1010_name_resource 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccounts_samplestg1010_name
  location: azureRegion
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    allowCrossTenantReplication: true
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: true
    allowSharedKeyAccess: true
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

resource serverfarms_asp_bicepdemoapp_name_resource 'Microsoft.Web/serverfarms@2021-01-15' = {
  name: serverfarms_asp_bicepdemoapp_name
  location: 'East US 2'
  sku: {
    name: 'D1'
    tier: 'Shared'
    size: 'D1'
    family: 'D'
    capacity: 0
  }
  kind: 'app'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: false
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
  }
}

resource virtualNetworks_bicepnetwork_name_app_subnet 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_bicepnetwork_name_resource
  name: 'app-subnet'
  properties: {
    addressPrefix: '10.0.1.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource virtualNetworks_bicepnetwork_name_default 'Microsoft.Network/virtualNetworks/subnets@2020-11-01' = {
  parent: virtualNetworks_bicepnetwork_name_resource
  name: 'default'
  properties: {
    addressPrefix: '10.0.0.0/24'
    delegations: []
    privateEndpointNetworkPolicies: 'Enabled'
    privateLinkServiceNetworkPolicies: 'Enabled'
  }
}

resource storageAccounts_samplestg1010_name_default 'Microsoft.Storage/storageAccounts/blobServices@2021-04-01' = {
  parent: storageAccounts_samplestg1010_name_resource
  name: 'default'
  properties: {
    changeFeed: {
      enabled: false
    }
    restorePolicy: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    isVersioningEnabled: false
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_samplestg1010_name_default 'Microsoft.Storage/storageAccounts/fileServices@2021-04-01' = {
  parent: storageAccounts_samplestg1010_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_samplestg1010_name_default 'Microsoft.Storage/storageAccounts/queueServices@2021-04-01' = {
  parent: storageAccounts_samplestg1010_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_samplestg1010_name_default 'Microsoft.Storage/storageAccounts/tableServices@2021-04-01' = {
  parent: storageAccounts_samplestg1010_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource sites_bicepdemo_app_name_resource 'Microsoft.Web/sites@2021-01-15' = {
  name: sites_bicepdemo_app_name
  location: 'East US 2'
  kind: 'app'
  properties: {
    enabled: true
    hostNameSslStates: [
      {
        name: '${sites_bicepdemo_app_name}.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Standard'
      }
      {
        name: '${sites_bicepdemo_app_name}.scm.azurewebsites.net'
        sslState: 'Disabled'
        hostType: 'Repository'
      }
    ]
    serverFarmId: serverfarms_asp_bicepdemoapp_name_resource.id
    reserved: false
    isXenon: false
    hyperV: false
    siteConfig: {
      numberOfWorkers: 1
      acrUseManagedIdentityCreds: false
      alwaysOn: false
      http20Enabled: false
      functionAppScaleLimit: 0
      minimumElasticInstanceCount: 1
    }
    scmSiteAlsoStopped: false
    clientAffinityEnabled: true
    clientCertEnabled: false
    clientCertMode: 'Required'
    hostNamesDisabled: false
    customDomainVerificationId: '3C3B0EAC1A5A421EB06C972059F577364CECD8091CEBD453C29F2184D327866B'
    containerSize: 0
    dailyMemoryTimeQuota: 0
    httpsOnly: false
    redundancyMode: 'None'
    storageAccountRequired: false
    keyVaultReferenceIdentity: 'SystemAssigned'
  }
}

resource sites_bicepdemo_app_name_ftp 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2021-01-15' = {
  parent: sites_bicepdemo_app_name_resource
  name: 'ftp'
  location: 'East US 2'
  properties: {
    allow: true
  }
}

resource sites_bicepdemo_app_name_scm 'Microsoft.Web/sites/basicPublishingCredentialsPolicies@2021-01-15' = {
  parent: sites_bicepdemo_app_name_resource
  name: 'scm'
  location: 'East US 2'
  properties: {
    allow: true
  }
}

resource sites_bicepdemo_app_name_web 'Microsoft.Web/sites/config@2021-01-15' = {
  parent: sites_bicepdemo_app_name_resource
  name: 'web'
  location: 'East US 2'
  properties: {
    numberOfWorkers: 1
    defaultDocuments: [
      'Default.htm'
      'Default.html'
      'Default.asp'
      'index.htm'
      'index.html'
      'iisstart.htm'
      'default.aspx'
      'index.php'
      'hostingstart.html'
    ]
    netFrameworkVersion: 'v4.0'
    requestTracingEnabled: false
    remoteDebuggingEnabled: false
    remoteDebuggingVersion: 'VS2019'
    httpLoggingEnabled: false
    acrUseManagedIdentityCreds: false
    logsDirectorySizeLimit: 35
    detailedErrorLoggingEnabled: false
    publishingUsername: '$bicepdemo-app'
    scmType: 'None'
    use32BitWorkerProcess: true
    webSocketsEnabled: false
    alwaysOn: false
    managedPipelineMode: 'Integrated'
    virtualApplications: [
      {
        virtualPath: '/'
        physicalPath: 'site\\wwwroot'
        preloadEnabled: false
      }
    ]
    loadBalancing: 'LeastRequests'
    experiments: {
      rampUpRules: []
    }
    autoHealEnabled: false
    vnetRouteAllEnabled: false
    vnetPrivatePortsCount: 0
    localMySqlEnabled: false
    ipSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictions: [
      {
        ipAddress: 'Any'
        action: 'Allow'
        priority: 1
        name: 'Allow all'
        description: 'Allow all access'
      }
    ]
    scmIpSecurityRestrictionsUseMain: false
    http20Enabled: false
    minTlsVersion: '1.2'
    scmMinTlsVersion: '1.0'
    ftpsState: 'AllAllowed'
    preWarmedInstanceCount: 0
    functionAppScaleLimit: 0
    functionsRuntimeScaleMonitoringEnabled: false
    minimumElasticInstanceCount: 1
    azureStorageAccounts: {}
  }
}

resource sites_bicepdemo_app_name_sites_bicepdemo_app_name_azurewebsites_net 'Microsoft.Web/sites/hostNameBindings@2021-01-15' = {
  parent: sites_bicepdemo_app_name_resource
  name: '${sites_bicepdemo_app_name}.azurewebsites.net'
  location: 'East US 2'
  properties: {
    siteName: 'bicepdemo-app'
    hostNameType: 'Verified'
  }
}

resource storageAccounts_samplestg1010_name_default_testfileshare 'Microsoft.Storage/storageAccounts/fileServices/shares@2021-04-01' = {
  parent: Microsoft_Storage_storageAccounts_fileServices_storageAccounts_samplestg1010_name_default
  name: 'testfileshare'
  properties: {
    accessTier: 'TransactionOptimized'
    shareQuota: 6
    enabledProtocols: 'SMB'
  }
  dependsOn: [
    storageAccounts_samplestg1010_name_resource
  ]
}
