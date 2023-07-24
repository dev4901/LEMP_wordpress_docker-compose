#!/bin/bash

domain="abc.io"
dom_dash=$(echo $domain | sed 's/\./-/')
echo $domain
echo $dom_dash
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
