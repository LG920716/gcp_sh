export REGION1=asia-east1
export REGION2=asia-east2

# Set up a simulated on-premises environment
gcloud compute networks create on-prem --subnet-mode custom
gcloud compute networks subnets create on-prem-subnet \
    --network on-prem --range 10.0.0.0/24 --region asia-east1

# Set up a cloud environment
gcloud compute networks create cloud --subnet-mode custom
gcloud compute networks subnets create cloud-subnet \
    --network cloud --range 10.0.1.0/24 --region asia-east2

# Set up a cloud environment
gcloud compute networks create datacenter --subnet-mode custom
gcloud compute networks subnets create cloud-subnet \
    --network datacenter --range 10.0.2.0/24 --region asia-east1

# Set up an HA VPN gateway
gcloud compute vpn-gateways create on-prem-vpn-gw1 --network on-prem --region $REGION1
gcloud compute vpn-gateways create cloud-vpn-gw1 --network cloud --region $REGION2
# Create cloud routers
gcloud compute routers create on-prem-router1 \
    --region $REGION1 \
    --network on-prem \
    --asn 65001
gcloud compute routers create cloud-router1 \
    --region $REGION2 \
    --network cloud \
    --asn 65002

# Create two VPN tunnels
gcloud compute vpn-tunnels create on-prem-tunnel0 \
    --peer-gcp-gateway cloud-vpn-gw1 \
    --region $REGION1 \
    --ike-version 2 \
    --shared-secret ShareSecret \
    --router on-prem-router1 \
    --vpn-gateway on-prem-vpn-gw1 \
    --vpn-gateway-region $REGION2 \
    --interface 0
gcloud compute vpn-tunnels create on-prem-tunnel1 \
    --peer-gcp-gateway cloud-vpn-gw1 \
    --peer-gcp-gateway-region $REGION2 \
    --region $REGION1 \
    --ike-version 2 \
    --shared-secret ShareSecret \
    --router on-prem-router1 \
    --vpn-gateway on-prem-vpn-gw1 \
    --interface 1
gcloud compute vpn-tunnels create cloud-tunnel0 \
    --peer-gcp-gateway on-prem-vpn-gw1 \
    --peer-gcp-gateway-region $REGION1 \
    --region $REGION2 \
    --ike-version 2 \
    --shared-secret ShareSecret \
    --router cloud-router1 \
    --vpn-gateway cloud-vpn-gw1 \
    --interface 0
gcloud compute vpn-tunnels create cloud-tunnel1 \
    --peer-gcp-gateway on-prem-vpn-gw1 \
    --peer-gcp-gateway-region $REGION1 \
    --region $REGION2 \
    --ike-version 2 \
    --shared-secret ShareSecret \
    --router cloud-router1 \
    --vpn-gateway cloud-vpn-gw1 \
    --interface 1

# Create Border Gateway Protocol (BGP) peering for each tunnel
gcloud compute routers add-interface cloud-router1 \
    --interface-name if-tunnel0-to-on-prem \
    --ip-address 169.254.0.2 \
    --mask-length 30 \
    --vpn-tunnel cloud-tunnel0 \
    --region $REGION1
gcloud compute routers add-bgp-peer cloud-router1 \
    --peer-name bgp-on-prem-tunnel0 \
    --interface if-tunnel0-to-on-prem \
    --peer-ip-address 169.254.0.1 \
    --peer-asn 65001 \
    --region $REGION1

gcloud compute routers add-interface cloud-router1 \
    --interface-name if-tunnel1-to-on-prem \
    --ip-address 169.254.1.2 \
    --mask-length 30 \
    --vpn-tunnel cloud-tunnel1 \
    --region $REGION1
gcloud compute routers add-bgp-peer cloud-router1 \
    --peer-name bgp-on-prem-tunnel1 \
    --interface if-tunnel1-to-on-prem \
    --peer-ip-address 169.254.1.1 \
    --peer-asn 65001 \
    --region $REGION1

gcloud compute routers add-interface on-prem-router1 \
    --interface-name if-tunnel0-to-cloud \
    --ip-address 169.254.0.1 \
    --mask-length 30 \
    --vpn-tunnel on-prem-tunnel0 \
    --region $REGION2
gcloud compute routers add-bgp-peer on-prem-router1 \
    --peer-name bgp-cloud-tunnel0 \
    --interface if-tunnel0-to-cloud \
    --peer-ip-address 169.254.0.2 \
    --peer-asn 65002 \
    --region $REGION2

gcloud compute routers add-interface on-prem-router1 \
    --interface-name if-tunnel1-to-cloud \
    --ip-address 169.254.1.1 \
    --mask-length 30 \
    --vpn-tunnel on-prem-tunnel1 \
    --region $REGION2
gcloud compute routers add-bgp-peer on-prem-router1 \
    --peer-name bgp-cloud-tunnel1 \
    --interface if-tunnel1-to-cloud \
    --peer-ip-address 169.254.1.2 \
    --peer-asn 65002 \
    --region $REGION2

# Configure firewall rules to allow traffic from the remote VPC
# You can use vpn-tunnels command to check the status of each tunnel
gcloud compute firewall-rules create allow-prem-and-datacenter-to-cloud --network cloud --allow tcp,udp,icmp --source-ranges 10.0.0.0/24,10.0.2.0/24
gcloud compute firewall-rules create allow-cloud-and-datacenter-to-prem --network on-prem --allow tcp,udp,icmp --source-ranges 10.0.1.0/24,10.0.2.0/24
gcloud compute firewall-rules create allow-prem-and-cloud-to-datacenter --network datacenter --allow tcp,udp,icmp --source-ranges 10.0.0.0/24,10.0.1.0/24
gcloud compute firewall-rules create on-prem-allow-ssh-icmp --network on-prem --allow tcp:22,icmp
gcloud compute firewall-rules create cloud-allow-ssh-icmp --network cloud --allow tcp:22,icmp
gcloud compute firewall-rules create datacenter-allow-ssh-icmp --network datacenter --allow tcp:22,icmp

# You need to delete vpn tunnel, BGP peering, router, vpn gateway, instance, firewall rule, VPC to clean up your environment

gcloud compute routers create on-prem-router \
    --region asia-east1 \
    --network on-prem \
    --asn 65001
gcloud compute routers create cloud-router \
    --region asia-east2 \
    --network cloud 
    --asn 65002
gcloud compute routers create datacenter-router \
    --region asia-east1 \
    --network datacenter \
    --asn 65003

gcloud compute vpn-gateways create on-prem-vpn-gw1 --network on-prem --region asia-east1
gcloud compute vpn-gateways create cloud-vpn-gw1 --network cloud --region asia-east2
gcloud compute vpn-gateways create datacenter-vpn-gw1 --network datacenter --region asia-east1