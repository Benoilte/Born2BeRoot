#!/bin/bash

arch=$(uname -a)
pcpu=$(grep "physical id" /proc/cpuinfo | sort | uniq | wc -l)
vcpu=$(grep ^processor /proc/cpuinfo | sort | uniq | wc -l)
fram=$(free --mega | awk '$1 == "Mem:" {print $2}')
uram=$(free --mega | awk '$1 == "Mem:" {print $3}')
pram=$(echo "($uram / $fram) * 100" | bc -l | awk '{printf "%.2f", $1}')
fdisk=$(df -BG | grep '^/dev/' | grep -v '/boot$' | awk '{fd += $2; print fd}')
udisk=$(df -BG | grep '^/dev/' | grep -v '/boot$' | awk '{ud += $3; print ud}')
pdisk=$(echo "($udisk / $fdisk) * 100;" | bc -l | awk '{printf "%.2f", $1}')
cpul=$(top -bn1 | grep '^%Cpu' | cut -c 9- | xargs | awk '{printf "%.1f%%", $1 + $3}')
lboot=$(uptime -s | cut -d':' -f 1-2)
lvmu=$(if [ $(lsblk | grep "lvm" | wc -l) -eq 0 ]; then echo no; else echo yes; fi)
ulog=$(users | wc -w)
ip=$(ip addr show eth0 | grep 'inet\b' | awk '{print $2}' | cut -d "/" -f 1)
mac=$(ip addr show eth0 | grep ether | awk '{print $2}')
sudocmd=$(cat /home/$USER/.bash_history | grep ^sudo | wc -l)


echo -e "
	#Architecture: $arch
	#CPU physical: $pcpu
	#vCPU: $vcpu
	#Memory Usage: $uram/${fram}MB ($pram%) ($tpram%)
	#Disk Usage: $udisk/${fdisk}Gb ($pdisk%)
	#CPU load: $cpul
	#Last boot: $lboot
	#LVM use: $lvmu
	#Connections TCP:
	#User log: $ulog
	#Network: IP $ip ($mac)
	#Sudo: $sudocmd cmd
	"
