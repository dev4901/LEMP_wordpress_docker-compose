#!/bin/bash

if command -v docker compose &> /dev/null; then
        echo "Docker Compose is installed on the system."
    else
        echo "Docker Compose is not installed on the system."
	echo "this will install docker-compose"
#	apt update
#	apt install docker-compose -y
fi

read -p "enter the name of your website - " domain

#read $domain

echo "name of your website is $domain"


