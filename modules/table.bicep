param workspaceName string
param tableName string

resource table 'Microsoft.OperationalInsights/workspaces/tables@2023-09-01' = {
  name: '${workspaceName}/${tableName}_CL'

  properties: {
    schema: {
      name: '${tableName}_CL'

      columns: [
        {
          name: 'TimeGenerated'
          type: 'DateTime'
        }
        {
          name: 'Message'
          type: 'String'
        }
      ]
    }

    retentionInDays: 30
    totalRetentionInDays: 30
  }
}
