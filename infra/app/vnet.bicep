@description('Specifies the name of the virtual network.')
param vNetName string

@description('Specifies the location.')
param location string = resourceGroup().location

@description('Specifies the name of the subnet for the Service Bus private endpoint.')
param peSubnetName string = 'private-endpoints-subnet'

@description('Specifies the name of the subnet for Function App virtual network integration.')
param appSubnetName string = 'app'

param tags object = {}

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2023-11-01' = {
  name: vNetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    encryption: {
      enabled: false
      enforcement: 'AllowUnencrypted'
    }
    subnets: [
      {
        name: peSubnetName
        properties: {
          addressPrefixes: [
            '10.0.1.0/28' // allows for 11 usable IP addresses
          ]
          delegations: []
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: appSubnetName
        properties: {
          addressPrefixes: [
            '10.0.2.0/26' // allows for 59 usable IP addresses
          ]
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
            }
            {
              service: 'Microsoft.KeyVault'
            }
          ]
          delegations: [
            {
              name: 'delegation'
              id: resourceId('Microsoft.Network/virtualNetworks/subnets/delegations', vNetName, 'app', 'delegation')
              properties: {
                //Microsoft.App/environments is the correct delegation for Flex Consumption VNet integration
                serviceName: 'Microsoft.App/environments'
              }
            }
          ]
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
    ]
    virtualNetworkPeerings: []
    enableDdosProtection: false
  }

  resource appSubnet 'subnets' existing = {
    name: appSubnetName
  }
}

output peSubnetName string = virtualNetwork.properties.subnets[0].name
output peSubnetID string = virtualNetwork.properties.subnets[0].id
output appSubnetName string = virtualNetwork.properties.subnets[1].name
output appSubnetID string = virtualNetwork::appSubnet.id
