grep -i "$1" $2_Dealer_schedule | awk '{print $1,$2,$5,$6}'

