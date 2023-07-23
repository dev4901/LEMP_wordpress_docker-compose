#!/bin/bash

if command -v docker compose &> /dev/null; then
        echo "Docker Compose is installed on the system."
    else
        echo "Docker Compose is not installed on the system."
	    echo "this will install docker-compose"
#	apt update
#	apt install docker-compose -y
fi

if [ "$1" == "domain" ]; then

    read -p "enter the name of your website - " domain

    #read $domain
    pub_ip="localhost" 

    echo "name of your website is $domain"

    sed -i "2s/^/${domain} ${pub_ip}\n/" hosts-copy 2> errors.txt
    value="$?"
    # echo "$value"
    if [[ "$value" -ne 0 ]]; then
            echo "couldn't add domain to /etc/hosts"
            # echo "value not 0"
        else
            echo "domain is successfully added to the /etc/hosts file" 
    fi

    cp nginx-conf-copy "$domain-site-conf"
    sed -i "s/DOMAIN_NAME/${domain}/" $domain-site-conf
    value="$?"
    # echo "$value"
    if [[ "$value" -ne 0 ]]; then
            echo "couldn't add domain to nginx conf"
            # echo "value not 0"
        else
            echo "domain is successfully added to the nginx conf file" 
    fi
    
    echo "starting your lemp stack docker compose file"

    docker compose up

    value="$?"
    # echo "$value"
    if [[ "$value" -ne 0 ]]; then
            echo "couldn't start docker compose properly"
            # echo "value not 0"
            exit 1
        else
            echo "have successfully started docker compose and you can access your website at $domain!!" 
    fi

fi

if [ "$1" == "enable" ]; then
    docker compose up -d
elif [ "$1" == "disable" ]; then
    docker compose down
fi

echo "enter correct argument"



