#!/bin/bash

lan1="docker exec -it clab-mod2-bgp-lan1"
lan2="docker exec -it clab-mod2-bgp-lan2"
rtrA="docker exec -it clab-mod2-bgp-rtrA"
rtrB="docker exec -it clab-mod2-bgp-rtrB"
rtrC="docker exec -it clab-mod2-bgp-rtrC"
rtrD="docker exec -it clab-mod2-bgp-rtrD"

create_setup () {

echo 'creating setup'

$lan1 ip addr add 10.10.0.2/24 dev eth1
$lan1 ip addr add 1.1.1.1 dev eth1
$lan1 ip addr add 3.3.3.3 dev eth1
$lan1 ip route add 2.2.2.0/24 dev eth1 via 10.10.0.1
$lan1 ip route add 4.4.4.0/24 dev eth1 via 10.10.0.1

$lan2 ip addr add 10.10.5.2/24 dev eth1
$lan2 ip addr add 2.2.2.2 dev eth1
$lan2 ip addr add 4.4.4.4 dev eth1
$lan2 ip route add 1.1.1.0/24 dev eth1 via 10.10.5.1
$lan2 ip route add 3.3.3.0/24 dev eth1 via 10.10.5.1

$rtrA ip addr add 10.10.0.1/30 dev eth1
$rtrA ip addr add 10.10.1.1/30 dev eth2
$rtrA ip addr add 10.10.2.1/30 dev eth3

$rtrB ip addr add 10.10.1.2/30 dev eth1
$rtrB ip addr add 10.10.3.1/30 dev eth2
$rtrB ip addr add 10.10.6.2/30 dev eth3   # New line for rtrB eth3

$rtrC ip addr add 10.10.2.2/30 dev eth1
$rtrC ip addr add 10.10.4.1/30 dev eth2
$rtrC ip addr add 10.10.6.1/30 dev eth3   # New line for rtrC eth3

$rtrD ip addr add 10.10.5.1/30 dev eth1
$rtrD ip addr add 10.10.3.2/30 dev eth2
$rtrD ip addr add 10.10.4.2/30 dev eth3

}

delete_setup() {
echo 'delete setup'

$lan1 ip addr del 10.10.0.2/24 dev eth1
$lan1 ip addr del 1.1.1.1 dev eth1
$lan1 ip addr del 3.3.3.3 dev eth1
#$lan1 ip route del 2.2.2.0/24 dev eth1 via 10.10.0.1
#$lan1 ip route del 4.4.4.0/24 dev eth1 via 10.10.0.1

$lan2 ip addr del 10.10.5.2/24 dev eth1
$lan2 ip addr del 2.2.2.2 dev eth1
$lan2 ip addr del 4.4.4.4 dev eth1
#$lan2 ip route del 1.1.1.0/24 dev eth1 via 10.10.5.1
#$lan2 ip route del 3.3.3.0/24 dev eth1 via 10.10.5.1

$rtrA ip addr del 10.10.0.1/30 dev eth1
$rtrA ip addr del 10.10.1.1/30 dev eth2
$rtrA ip addr del 10.10.2.1/30 dev eth3

$rtrB ip addr del 10.10.1.2/30 dev eth1
$rtrB ip addr del 10.10.3.1/30 dev eth2
$rtrB ip addr del 10.10.6.2/30 dev eth3   # New line for rtrB eth3

$rtrC ip addr del 10.10.2.2/30 dev eth1
$rtrC ip addr del 10.10.4.1/30 dev eth2
$rtrC ip addr del 10.10.6.1/30 dev eth3   # New line for rtrC eth3

$rtrD ip addr del 10.10.5.1/30 dev eth1
$rtrD ip addr del 10.10.3.2/30 dev eth2
$rtrD ip addr del 10.10.4.2/30 dev eth3

}

if [ $# != 1 ]
then
   echo "specify delete or create"
elif [ $1 == "delete" ]
then 
   delete_setup
elif [ $1 == "create" ]
then
   create_setup
else
   echo "specify delete or create"
fi
