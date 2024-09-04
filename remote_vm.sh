#!/bin/bash
read -p "Enter Your Password:" passwd
HOME_DIR=`pwd`
username=`whoami`
for host in `cat vm_sbl.new`
do
nc -z $host 22 > /dev/null
if [ $? -ne 0 ]
then
	echo "$host is not responding. Please check the server status. "
	else
		#/$HOME_DIR/check_vm_ovs.exp $host $passwd $username |egrep -v 'password|Last|Warning|might|@|ssh'
		/$HOME_DIR/check_vm_ovs.exp $host $passwd $username
fi
done
