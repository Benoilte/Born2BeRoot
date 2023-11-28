#!/bin/bash

arch=$(uname -a)

user=$1

echo -e "
	#Architecture: "$arch"
	#CPU physical:
	#vCPU:
	#Memory Usage:
	#Disk Usage:
	#CPU load:
	#Last boot:
	#LVM use:
	#Connections TCP
	#User log: "$user"
	#Network:
	#Sudo:
	"
