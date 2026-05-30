# Provider Resource Group and Location
resource_group_name="rg-pls-provider-dev"
location="eastus"

# Virtual Network and Subnet
vnet_name="vnet-pls-provider-dev"
vnet_address_space=["10.0.0.0/16"]
subnet_address_prefixes=["10.0.1.0/24"]
subnet_name="subnet-pls-provider-dev"

# Virtual Machine Scale Set
vmss_size = "Standard_B16ps_v2"
admin_password="Jadapeta@909"
admin_username="az700admin"
docker_image="devopsdeveloper909/azure-private-link-service:latest"
docker_password="Jadapeta@909"
docker_username="devopsdeveloper909"
vmss_name="vmss-pls-provider-dev"
application_name="azure-private-link-service-provider-app"

# load balancer
load_balancer_name="lb-pls-provider-dev"

# Network Security Group and Rule
nsg_name="nsg-pls-provider-dev"
rule_name="AllowHTTP"

# Storage Account for Terraform state
storage_account_name="storageacttfstateplsdev"
storage_container_name="tfstate-container-pls-dev"
tfstate_key="dev-pls.tfstate"
nat_gateway_name = "natgw-pls-provider-dev"

# Provider Private Link Service
provider_private_link_service_name="pls-provider-dev"

# Consumer Resource Group and Location
consumer_resource_group_name="rg-pls-consumer-dev"
consumer_location="eastus"

# Consumer virtual network and subnet
consumer_vnet_name="vnet-pls-consumer-dev"
consumer_vnet_address_space=["10.2.0.0/16"]
consumer_subnet_name="subnet-pls-consumer-dev"
consumer_subnet_address_prefixes=["10.2.1.0/27"]

# Consumer virtual machine
consumer_vm_size="Standard_B16ps_v2"
consumer_vm_name="vm-pls-consumer-dev"

# Link between consumer and provider
consumer_private_endpoint_name="pe-pls-consumer-dev"
private_service_connection_name="psc-pls-consumer-dev"

