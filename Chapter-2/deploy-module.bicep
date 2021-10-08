// deploy-module.bicep

module appService '../Chapter-1/web-app-sample.bicep' = {
  name: 'myNewBicepAppDeployment'
  params: {
   azureRegion: resourceGroup().location     
  }
}

output appServiceHostName string = appService.outputs.webApplicationHostName
