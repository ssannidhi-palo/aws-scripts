#Usage: ./aws-ec2-instances-all.sh - No input parameters needed
#Description: This script generate a list of all ec2 instances from all regions
#Output: Redirects the output to ec2info.txt file in the current folder
#Output Fields: Region:
#                   InstanceID | Instance Name | Security Group | Status | Instance Type
#Author: Swati Sannidhi 

#!/usr/bin/env bash

regions=$(aws ec2 describe-regions --query 'Regions[*].{r:RegionName}' --output text | sort)

>ec2info.txt

for region in $regions ;
do
echo -e $region | tee -a ec2info.txt
aws ec2 describe-instances --region $region \
--query 'Reservations[].Instances[].{ID:InstanceId,Type:InstanceType,Name:Tags[?Key==`Name`].Value | [0],Status:State.Name,SG:SecurityGroups[].GroupName| [0] }' \
--output table | tr -s "[:blank:]" " " | tail -n +5 | tee -a ec2info.txt
done

