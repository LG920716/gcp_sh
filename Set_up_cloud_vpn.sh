export REGION=asia-east1
export REGION2=asia-east2
export REGION3=asia-east1

# Creating the on-prem VPC
# create a vpc to simulate the on-primises environment
gcloud compute networks create on-prem --subnet-mode custom
gcloud compute firewall-rules create on-prem-fw --network on-prem --allow tcp:22,tcp:5001,udp:5001,icmp
gcloud compute networks subnets create on-prem-asia \
    --network on-prem --range 192.168.1.0/24 --region $REGION

# Creating the cloud VPC
# create a vpc to simulate the cloud environment
gcloud compute networks create cloud --subnet-mode custom
gcloud compute firewall-rules create cloud-fw --network cloud --allow tcp:22,tcp:5001,udp:5001,icmp
gcloud compute networks subnets create cloud-asia --network cloud \
    --range 10.0.1.0/24 --region $REGION2

# Creating the cloud VPC
# create a vpc to simulate the cloud environment
gcloud compute networks create datacenter --subnet-mode custom
gcloud compute firewall-rules create datacenter-fw --network datacenter --allow tcp:22,tcp:5001,udp:5001,icmp
gcloud compute networks subnets create datacenter-asia --network datacenter \
    --range 172.16.1.0/24 --region $REGION3

# Creating VPN gateways
gcloud compute target-vpn-gateways create on-prem-gw1 --network on-prem --region $REGION
gcloud compute target-vpn-gateways create cloud-gw1 --network cloud --region $REGION2
gcloud compute target-vpn-gateways create datacenter-gw1 --network datacenter --region $REGION3

# Creating a route-based VPN tunnel between local and Google Cloud
# create a static ip address to provide to rotuer
gcloud compute addresses create on-prem-gw1 --region $REGION
gcloud compute addresses create cloud-gw1 --region $REGION2
gcloud compute addresses create datacenter-gw1 --region $REGION3
on_prem_gw1_ip=$(gcloud compute addresses describe on-prem-gw1 \
    --region $REGION --format='value(address)')
cloud_gw1_ip=$(gcloud compute addresses describe cloud-gw1 \
    --region $REGION2 --format='value(address)')
datacenter_gw1_ip=$(gcloud compute addresses describe datacenter-gw1 \
    --region $REGION3 --format='value(address)')

# Set up ESP protocol from on-prem-gw1
gcloud compute forwarding-rules create on-prem-fr-esp --ip-protocol ESP \
    --address $on_prem_gw_ip --target-vpn-gateway on-prem-gw1 --region $REGION
gcloud compute forwarding-rules create on-prem-fr-udp500 --ip-protocol UDP --ports 500 \
    --address $on_prem_gw_ip --target-vpn-gateway on-prem-gw1 --region $REGION
gcloud compute forwarding-rules create on-prem-fr-udp4500 --ip-protocol UDP --ports 4500 \
    --address $on_prem_gw_ip --target-vpn-gateway on-prem-gw1 --region $REGION

# Set up ESP protocol from cloud-gw1
gcloud compute forwarding-rules create cloud-fr-esp --ip-protocol ESP \
    --address $cloud_gw1_ip --target-vpn-gateway cloud-gw1 --region $REGION2
gcloud compute forwarding-rules create cloud-fr-udp500 --ip-protocol UDP \
    --ports 500 --address $cloud_gw1_ip --target-vpn-gateway cloud-gw1 --region $REGION2
gcloud compute forwarding-rules create cloud-fr-udp4500 --ip-protocol UDP \
    --ports 4500 --address $cloud_gw1_ip --target-vpn-gateway cloud-gw1 --region $REGION2

# Set up ESP protocol from datacenter-gw1
gcloud compute forwarding-rules create datacenter-fr-esp --ip-protocol ESP \
    --address $datacenter_gw1_ip --target-vpn-gateway datacenter-gw1 --region $REGION3
gcloud compute forwarding-rules create datacenter-fr-udp500 --ip-protocol UDP \
    --ports 500 --address $datacenter_gw1_ip --target-vpn-gateway datacenter-gw1 --region $REGION3
gcloud compute forwarding-rules create datacenter-fr-udp4500 --ip-protocol UDP \
    --ports 4500 --address $datacenter_gw1_ip --target-vpn-gateway datacenter-gw1 --region $REGION3

# Create the VPN tunnel from on-prem to cloud
gcloud compute vpn-tunnels create on-prem-tunnel1 --peer-address $cloud_gw1_ip \
    --target-vpn-gateway on-prem-gw1 --ike-version 2 --local-traffic-selector 0.0.0.0/0 \
    --remote-traffic-selector 0.0.0.0/0 --shared-secret=sharedsecret --region $REGION
# Create the VPN tunnel from cloud to on-prem
gcloud compute vpn-tunnels create cloud-tunnel1 --peer-address $on_prem_gw1_ip \
    --target-vpn-gateway cloud-gw1 --ike-version 2 --local-traffic-selector 0.0.0.0/0 \
    --remote-traffic-selector 0.0.0.0/0 --shared-secret=sharedsecret --region $REGION2
# Create the VPN tunnel from cloud to datacenter
gcloud compute vpn-tunnels create cloud-tunnel2 --peer-address $datacenter_gw1_ip \
    --target-vpn-gateway cloud-gw1 --ike-version 2 --local-traffic-selector 0.0.0.0/0 \
    --remote-traffic-selector 0.0.0.0/0 --shared-secret=sharedsecret --region $REGION2
# Create the VPN tunnel from datacenter to cloud
gcloud compute vpn-tunnels create datacenter-tunnel1 --peer-address $cloud_gw1_ip \
    --target-vpn-gateway datacenter-gw1 --ike-version 2 --local-traffic-selector 0.0.0.0/0 \
    --remote-traffic-selector 0.0.0.0/0 --shared-secret=sharedsecret --region $REGION3

# Route traffic from the on-prem VPC to the cloud 10.0.1.0/24 range into the tunnel
gcloud compute routes create on-prem-route1 --destination-range 10.0.1.0/24 \
    --network on-prem --next-hop-vpn-tunnel on-prem-tunnel1 \
    --next-hop-vpn-tunnel-region $REGION
# Route traffic from the cloud VPC to the on-prem 192.168.1.0/24 range into the tunnel
gcloud compute routes create cloud-route1 --destination-range 192.168.1.0/24 \
    --network cloud --next-hop-vpn-tunnel cloud-tunnel1 --next-hop-vpn-tunnel-region $REGION2
# Route traffic from the datacenter VPC to the cloud 10.0.1.0/24 range into the tunnel
gcloud compute routes create datacenter-route1 --destination-range 10.0.1.0/24 \
    --network datacenter --next-hop-vpn-tunnel datacenter-tunnel1 \
    --next-hop-vpn-tunnel-region $REGION3
# Route traffic from the cloud VPC to the datacenter 172.16.1.0/24 range into the tunnel
gcloud compute routes create cloud-route2 --destination-range 172.16.1.0/24 \
    --network cloud --next-hop-vpn-tunnel cloud-tunnel2 --next-hop-vpn-tunnel-region $REGION2

# Set the routes to let the traffic that on-prem to datacenter or datacenter to on-prem can be work
# let the traffic that on-prem go to datacenter use on-prem-tunnel1 not internet
gcloud beta compute routes create route-from-prem-to-datacenter --network=on-prem --priority=1000 --destination-range=172.16.1.0/24 --next-hop-vpn-tunnel=on-prem-tunnel1 --next-hop-vpn-tunnel-region=asia-east1
# let the traffic that datacenter go to on-prem use datacenter-tunnel1 not internet
gcloud beta compute routes create route-from-datacenter-to-prem --network=datacenter --priority=1000 --destination-range=192.168.1.0/24 --next-hop-vpn-tunnel=datacenter-tunnel1 --next-hop-vpn-tunnel-region=asia-east1
# Add firewall rules to allow the traffic between on-prem and datacenter
gcloud compute firewall-rules create allow-prem-to-datacenter \
    --network on-prem \
    --allow tcp,udp,icmp \
    --source-ranges 172.16.1.0/24
gcloud compute firewall-rules create allow-datacenter-to-prem \
    --network datacenter \
    --allow tcp,udp,icmp \
    --source-ranges 192.168.1.0/24