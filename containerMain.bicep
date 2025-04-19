param resourceName string
param location string = resourceGroup().location

resource containerInstance 'Microsoft.ContainerInstance/containerGroups@2024-11-01-preview' = {
  name: resourceName
  location: location
  properties: {
    containers: [
      {
        name: resourceName
        properties: {
          image: 'mcr.microsfot.com/azuredocs/aci-hellworld'
          ports: [{ port: 80, protocol: 'TCP' }]
          resources: { requests: { cpu: 1, memoryInGB: 2 } }
        }
      }
    ]
    osType: 'Linux'
    restartPolicy: 'Always'
    ipAddress: {
      type: 'Public'
      ports: [
        { port: 80, protocol: 'TCP' }
      ]
    }
  }
}

output containerIP string = containerInstance.properties.ipAddress.ip
