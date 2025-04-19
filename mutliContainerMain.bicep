param testRresourceName string
param location string = resourceGroup().id

resource mutliContainer 'Microsoft.ContainerInstance/containerGroups@2024-11-01-preview' = {
  name: testRresourceName
  location: location
  properties: {
    containers: [
      {
        name: 'Hello World'
        properties: {
          image: 'mcr.microsoft.com/azuredocs/aci-helloworld'
          ports: [
            {
              port: 80
              protocol: 'TCP'
            }
            {
              port: 8080
              protocol: 'TCP'
            }
          ]
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 2
            }
          }
        }
      }
      {
        name: 'Side-car'
        properties: {
          image: 'mcr.microsoft.com/azuredocs/aci-tutorial-sidecar'
          resources: {
            requests: {
              cpu: 1
              memoryInGB: 2
            }
          }
        }
      }
    ]
    osType: 'Linux'
    ipAddress: {
      ports: [
        {
          port: 80
          protocol: 'TCP'
        }
        {
          port: 8080
          protocol: 'TCP'
        }
      ]
      type: 'Public'
    }
  }
}

output containerIp string = mutliContainer.properties.ipAddress.ip
