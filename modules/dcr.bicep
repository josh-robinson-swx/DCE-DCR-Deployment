param location string
param workspaceId string
param dceId string
param tableName string

resource dcr 'Microsoft.Insights/dataCollectionRules@2023-03-11' = {
  name: '${tableName}-DCR'
  location: location

  properties: {

    dataCollectionEndpointId: dceId

    streamDeclarations: {
      'Custom-${tableName}': {
        columns: [
          {
            name: 'TimeGenerated'
            type: 'datetime'
          }
          {
            name: 'Message'
            type: 'string'
          }
        ]
      }
    }

    destinations: {
      logAnalytics: [
        {
          name: 'Destination'
          workspaceResourceId: workspaceId
        }
      ]
    }

    dataFlows: [
      {
        streams: [
          'Custom-${tableName}'
        ]

        destinations: [
          'Destination'
        ]

        outputStream: 'Custom-${tableName}_CL'

        transformKql: 'source'
      }
    ]
  }
}
