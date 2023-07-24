#!/bin/bash

if command -v docker &> /dev/null; then
        echo "Docker Compose is installed on the system."
    else
        echo "Docker Compose is not installed on the system."
	    echo "this will install docker-compose"
        curl https://get.docker.com/ > install_docker.sh
        chmod u+x install_docker.sh
        sudo sh install_docker.sh
        sudo usermod -aG docker ${USER}
        newgrp docker
fi

if [ "$1" == "domain" ]; then

    read -p "enter the name of your website - " domain

    echo "name of your website is $domain"
    dom_dash=$(echo $domain | sed 's/\./-/g')
    pub_ip="localhost" 
    hosts_string="${pub_ip} ${domain}"    
    dom_dc_file="docker-compose-${dom_dash}.yml"

    #if the website was previously called, it'll directly run
    if [ -d $dom_dash ]; then
        echo "website with this name already exists, hence firing it up!!"
        cd $dom_dash
        docker compose -f $dom_dc_file up -d 
        exit 1
    fi



    # 1. Setting up website folder for new domain
    #creating the website dir and adding the template files/directories 
    mkdir $dom_dash
    cp -r nginx/ $dom_dash/ 
    cd $dom_dash
    mkdir wordpress
    cp ../docker-compose.yml ./$dom_dc_file

    # creating new database location for the new domain
    echo -e "\ncreating new database directory for $domain"
    db_loc="db-data-$dom_dash"
    mkdir $db_loc
    sed -i "s/db-data/${db_loc}/ ; s/website_db/${dom_dash}_db/" $dom_dc_file


    if [ -d "${db_loc}" ]; then
        echo "website database location is $db_loc"
    else
        mkdir ./db-data/${db_loc}
        echo "website database location is $db_loc"
    fi

    #creating new nginx config file for the new domain
    config_file="${dom_dash}-site.conf"
    mv nginx/config/wp-site2.conf "nginx/config/${config_file}"
    
    sed -i "s/DOMAIN_NAME/${domain}/ ; s/DOMDASH/${dom_dash}/" nginx/config/$config_file
    value="$?"
    # echo "$value"
    if [[ "$value" -ne 0 ]]; then
            echo "couldn't add domain to nginx conf, hence exiting with code ${value}"
            # echo "value not 0"
        else
            echo "domain is successfully added to the nginx conf file" 
    fi
    
    # editing the new docker-compose file for the new website
    


    #adding domain to the /etc/hosts file
    sudo sed -i "2s/^/${hosts_string}\n/" /etc/hosts 2> errors.txt
    value="$?"
    # echo "$value"
    if [[ "$value" -ne 0 ]]; then
            echo "couldn't add domain to /etc/hosts"
            # echo "value not 0"
        else
            echo "domain is successfully added to the /etc/hosts file" 
    fi
    
    #creating new docker-compose file for all new domains
    #dom_dc_file="docker-compose-$(dom_dash).yml"


    echo "Firing up the LAMP stack docker compose file for ${domain} ........ !!"

    docker compose -f $dom_dc_file up -d 


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
    domain=$2
    dom_dash=$(echo $domain | sed 's/\./-/g')
    if [ -d $dom_dash ]; then
        echo "${dom_dash} directory exists"
        cd $dom_dash
        dom_dc_file="docker-compose-${dom_dash}.yml"
        docker compose -f ${dom_dc_file} up -d
    else
        echo "the website doesn't exist, create it using 'domain' as an argument while running this script"
    fi

    
elif [ "$1" == "disable" ]; then
    domain=$2
    dom_dash=$(echo $domain | sed 's/\./-/g')
    if [ -d $dom_dash ]; then
        echo "${dom_dash} directory exists"
        cd $dom_dash
        dom_dc_file="docker-compose-${dom_dash}.yml"
        docker compose -f ${dom_dc_file} down
    else
        echo "the website doesn't exist, create it using 'domain' as an argument while running this script"
    fi
fi

if [ "$1" == "delete" ]; then
    domain=$2
    dom_dash=$(echo $domain | sed 's/\./-/g')
    dom_dc_file="docker-compose-${dom_dash}.yml"
    if [ -d $dom_dash ]; then
        echo "${dom_dash} directory exists"
        cd ${dom_dash} && docker compose -f ${dom_dc_file} down && cd ../   
        docker stop $(docker ps -q) 2> /dev/null
        docker rm $(docker ps -aq) 2> /dev/null
        sudo rm -rf $dom_dash/ ; echo "deleted the $dom_dash directory"
    else
        echo "the website doesn't exist, create it using 'domain' as an argument while running this script"
    fi
fi




