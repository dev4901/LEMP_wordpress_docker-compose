#!/bin/bash

if command -v docker compose &> /dev/null; then
        echo "Docker Compose is installed on the system."
    else
        echo "Docker Compose is not installed on the system."
	    echo "this will install docker-compose"
        curl https://get.docker.com/ > install_docker.sh
        chmod u+x install_docker.sh
        sh install_docker.sh
fi

if [ "$1" == "domain" ]; then

    read -p "enter the name of your website - " domain

    dom_dash=$(echo $domain | sed 's/\./-/')
    pub_ip="localhost" 

    echo "name of your website is $domain"

    #adding domain to the /etc/hosts file
    sudo sed -i "2s/^/${pub_ip} ${domain}\n/" /etc/hosts 2> errors.txt
    value="$?"
    # echo "$value"
    if [[ "$value" -ne 0 ]]; then
            echo "couldn't add domain to /etc/hosts"
            # echo "value not 0"
        else
            echo "domain is successfully added to the /etc/hosts file" 
    fi

    #creating new nginx config file for the new domain
    config_file="$domain-site.conf"
    cp nginx/config/wp-site2.conf "nginx/config/$config_file"
    
    sed -i "s/DOMAIN_NAME/${domain}/" nginx/config/$config_file
    value="$?"
    # echo "$value"
    if [[ "$value" -ne 0 ]]; then
            echo "couldn't add domain to nginx conf, hence exiting with code 1"
            exit 1
            # echo "value not 0"
        else
            echo "domain is successfully added to the nginx conf file" 
    fi
    
    # creating new database location for the new domain
    echo -e "\ncreating new database folder for $domain"
    db_loc="$dom_dash-db-data"
    mkdir $db_loc

    if [ -d ./databases/"${db_loc}" ]; then
        echo "website database location is $db_loc"
    else
        mkdir ./db-data/${db_loc}
    fi

    #creating new docker-compose file for all new domains
    dom_dc_file="docker-compose-$(dom_dash).yml"
    cp docker-compose.yml 
    cp docker-compose.yml $dom_dc_file
    sed -i "s/db-data/${db_loc}/" $dom_dc_file

    echo "starting your lemp stack docker compose file"

    docker compose up -d

    value="$?"
    # echo "$value"
    if [[ "$value" -ne 0 ]]; then
            echo "couldn't start docker compose properly"
            # echo "value not 0"
            exit 1
        else
            echo "have successfully started docker compose and you can access your website at $domain !!" 
    fi

fi

if [ "$1" == "enable" ]; then
    docker compose up -d
elif [ "$1" == "disable" ]; then
    docker compose stop
fi

if [ "$1" == "delete" ]; then
    docker compose down
    docker rm $(docker ps -aq)
fi




