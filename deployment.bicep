targetScope = 'resourceGroup'

@description('Existing Log Analytics Workspace Name')
param workspaceName string

@description('Deployment location')
param location string = resourceGroup().location

resource workspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  name: workspaceName
}

module dce './modules/dce.bicep' = {
  name: 'Deploy-DCE'
  params: {
    location: location
  }
}

var tables = [
  'Test1'
  'Test2'
  'Test3'
]

module table './modules/table.bicep' = [for tableName in tables: {
  name: 'Table-${tableName}'
  params: {
    workspaceName: workspace.name
    tableName: tableName
  }
}]

module dcr './modules/dcr.bicep' = [for tableName in tables: {
  name: 'DCR-${tableName}'
  params: {
    location: location
    workspaceId: workspace.id
    dceId: dce.outputs.dceId
    tableName: tableName
  }
}]
