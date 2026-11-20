#!/usr/bin/env bash

FQDN=$1
if [ $# -gt 1 ]; then
    ips=$2
else
    ips=$(dig $FQDN +short | grep -v '\.$')
fi
if [ $# -gt 2 ]; then
    PORT=$3
else
    PORT=443
fi
for ip in $ips
do
    openssl_output=$(openssl s_client -connect $ip:$PORT -servername $FQDN -host $FQDN -showcerts -legacy_server_connect < /dev/null 2> /dev/null)
    if [ "$(uname)" == 'Darwin' ]; then
        enddate=$(echo "$openssl_output" | openssl x509 -noout -enddate | cut -d= -f2 | sed 's/Jan/01/;s/Feb/02/;s/Mar/03/;s/Apr/04/;s/May/05/;s/Jun/06/;s/Jul/07/;s/Aug/08/;s/Sep/09/;s/Oct/10/;s/Nov/11/;s/Dec/12/')
        days=$((($(date -j -f '%m %d %H:%M:%S %Y %Z' "$enddate" '+%s') - $(TZ=GMT date '+%s')) / (60 * 60 * 24)))
    else
        enddate=$(echo "$openssl_output" | openssl x509 -noout -enddate | cut -d= -f2)
        days=$((($(date -d "$enddate" '+%s') - $(TZ=GMT date '+%s')) / (60 * 60 * 24)))
    fi
    echo $ip
    echo "$openssl_output" | openssl x509 -noout -subject -dates
    echo "$openssl_output" | grep 'Verify return code:'
    echo "remaining: $days days"
    echo 
done

