@description('Location for all resources')
param location string = resourceGroup().location

@description('Virtual Machine size')
param vmSize string = 'Standard_B1s'

@description('SSH public key for secure access')
@secure()
param adminPublicKey string

@description('Base name for virtual machines')
param vmBaseName string = 'nginxvm'

@description('Number of virtual machines to deploy')
param vmCount int = 2

// Deploy network infrastructure: VNet, Subnet, NSG
module network './modules/network.bicep' = {
  name: 'networkModule'
  params: {
    location: location
  }
}

// Deploy load balancer with health probe and rule
module lb './modules/loadbalancer.bicep' = {
  name: 'loadBalancerModule'
  params: {
    location: location
  }
}

// Deploy multiple VMs connected to the load balancer
module vmMulti './modules/vm-multi.bicep' = {
  name: 'multiVmModule'
  params: {
    location: location
    vmSize: vmSize
    adminPublicKey: adminPublicKey
    vmBaseName: vmBaseName
    vmCount: vmCount
    subnetId: network.outputs.subnetId
    backendPoolId: lb.outputs.backendPoolId
  }
}

// Outputs public IP address of the load balancer
output loadBalancerIp string = lb.outputs.publicIp
