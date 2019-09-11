#!/usr/bin/env bash

grp=$(aws iam list-groups --profile paloit-sg --query 'Groups[*].{GroupName:GroupName}' --output text)

for i in $grp ;
do
users=$(aws iam get-group --profile paloit-sg --group-name $i --query 'Users[*].{UserName:UserName}' --output text)
echo -e "\nGroupName:" $i
echo -e "\t Users:" $users
done
