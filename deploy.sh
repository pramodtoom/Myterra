#!/bin/bash


DB_HOST=$1
DB_USERNAME=$2
DB_PASSWORD=$3
STACK_NAME=$4
LB_URL=$5
DB_NAME=$6

parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
#ls $parent_path
#cat $parent_path/kubernetes.yml
# read the yml template from a file and substitute the string
template=`cat "$parent_path/magento-deployment.yaml" | sed "s/{{STACK_NAME}}/$STACK_NAME/g" | sed "s/{{DB_HOST}}/$DB_HOST/g" | sed "s/{{DB_USERNAME}}/$DB_USERNAME/g" | sed "s/{{DB_PASSWORD}}/$DB_PASSWORD/g" | sed "s~{{LB_URL}}~http://$LB_URL~g" |sed "s/{{DB_NAME}}/$DB_NAME/g"`

# apply the yml with the substituted value
echo "$template" | kubectl apply -f -

