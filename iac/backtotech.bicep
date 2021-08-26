targetScope = 'resourceGroup'

param sql_server_name string = 'avanadebacktotechsummerbiwithgithub'
param sql_server_administrator_login string = 'jesappelleroot'
@secure()
param sql_server_administrator_password string
param analysis_server_name string = 'backtotechsummerbiwithgithubas'
param analysis_server_admins array = [
  'olivier.delmotte_avanade.com#EXT#@olivierdatavanade.onmicrosoft.com'
]

resource analysis_server 'Microsoft.AnalysisServices/servers@2017-08-01' = {
  name: analysis_server_name
  location: 'West Europe'
  sku: {
    name: 'D1'
    tier: 'Development'
    capacity: 1
  }
  properties: {
    managedMode: 1
    asAdministrators: {
      members: analysis_server_admins
    }
    querypoolConnectionMode: 'All'
    serverMonitorMode: 1
  }
}

resource sql_server 'Microsoft.Sql/servers@2021-02-01-preview' = {
  name: sql_server_name
  location: 'westeurope'
  properties: {
    administratorLogin: sql_server_administrator_login
    administratorLoginPassword: sql_server_administrator_password
    version: '12.0'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    administrators: {
      administratorType: 'ActiveDirectory'
      principalType: 'User'
      login: 'olivier.delmotte@avanade.com Delmotte'
      sid: '986969a1-a05a-4301-a886-515573c2aaef'
      tenantId: '38ae7b6f-dca9-4e77-bb28-4767fae1ca4d'
    }
    restrictOutboundNetworkAccess: 'Disabled'
  }
}

resource sql_database_adventureworksdw2017 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  parent: sql_server
  name: 'AdventureWorksDW2017'
  location: 'westeurope'
  sku: {
    name: 'Basic'
    tier: 'Basic'
    capacity: 5
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 2147483648
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
    requestedBackupStorageRedundancy: 'Local'
    isLedgerOn: false
  }
}

resource sql_server_firewall_azure_services 'Microsoft.Sql/servers/firewallRules@2021-02-01-preview' = {
  parent: sql_server
  name: 'AllowAllWindowsAzureIps'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

output sql_server_fqdn string = sql_server.properties.fullyQualifiedDomainName
output analysis_server_fqdn string = analysis_server.properties.serverFullName
output sql_server_administrator_login string = sql_server_administrator_login
