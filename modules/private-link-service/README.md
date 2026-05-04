
## Provider side

VMSS-> 
    Internal Load Balaner (Internal Load balancer does have SNAT so we have created NAT gateway in provider vent to allow access to internet outside since VMSS needs to connect docker registry for images pull and push and package downloads)
     -> Private Link Servie (Private Link IP -> Load balancer private IP)

  ## Consumer Side

     Private Endpoint in consumner vent which is different network/region/subscription

     -> private endpoint IP points -> Private link service in provider network

  * Enter network flow will be communicate Azure blackbone network (Azure private fiber network cables connects to all global services , data centers, regions in privately)