#Usage: ./aws-grp-users.sh 
#Description: This script generates a list of IAM groups and the IAM Users in each group
#Output Fields: GroupName:
#               Users:
#Author: Swati Sannidhi 

#!/usr/bin/env bash

grp=$(aws iam list-groups --profile paloit-sg --query 'Groups[*].{GroupName:GroupName}' --output text)

for i in $grp ;
do
echo -e "GroupName:" $i
echo -e "Users:"
aws iam get-group --profile paloit-sg --group-name $i --query 'Users[*].{Users:UserName}' --output table | tail -n +5
done
