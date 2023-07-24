#!/bin/bash

domain="pqr.io"
pub_ip="127.0.0.1" 
hosts_string="${pub_ip} ${domain}"
sed -e "2s/^/${hosts_string}\n/" hosts-copy

# loc="db-sds"
# if [ -d "../databases/${loc}" ]; then
#     echo "dir is present"
# else
#     echo "dir absent"
# fi

# if [ -d "${value}-data" ]; then
#     echo "directory is present"
# else
#     echo "directory absent"

# fi

# ls -la &> /dev/null
# value="$?"
# echo "$value"
# if [ "$value" -ne 0 ]; then
#         echo "value is not 0"
#     else
#         echo "value is 0 " 
# fi

# ls -la sdhjsgskh &> /dev/null
# #value="$?"
# echo $?
# if (( $? )); then
#         echo "value is not 0"
#     else
#         echo "value is 0 " 
# fi
