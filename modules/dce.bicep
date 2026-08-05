targetScope = 'resourceGroup'

param location string

resource dce 'Microsoft.Insights/dataCollectionEndpoints@2023-03-11' = {
  name: 'TestDCE'
  location: location

  properties: {
    networkAcls: {
      publicNetworkAccess: 'Enabled'
    }
  }
}

output dceId string = dce.id
