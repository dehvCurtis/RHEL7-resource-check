
#! /bin/bash

# clear the screen
clear
# unset any variable which system may be using
unset dlpcheck os architecture kernelrelease internalip externalip nameserver loadaverage

# Define Variable dlpcheck
dlpcheck=$(tput sgr0)

# Check if connected to Internet or not
ping -c 1 google.com &> /dev/null && echo -e '\E[32m'"Internet: $dlpcheck Connected" || echo -e '\E[32m'"Internet: $dlpcheck Disconnected"
ipadd=$(ip add | grep inet)
echo -e '\E[32m'"IP Address :"  $dlpcheck $ipadd

# Check OS Type
os=$(uname -o)
echo -e '\E[32m'"Operating System Type :" $dlpcheck $os

# Check OS Release Version and Name
cat /etc/os-release | grep 'NAME\|VERSION' | grep -v 'VERSION_ID' | grep -v 'PRETTY_NAME' > /tmp/osrelease
echo -n -e '\E[32m'"OS Name :" $dlpcheck  && cat /tmp/osrelease | grep -v "VERSION" | cut -f2 -d\"
echo -n -e '\E[32m'"OS Version :" $dlpcheck && cat /tmp/osrelease | grep -v "NAME" | cut -f2 -d\"

# Check Architecture
architecture=$(uname -m)
echo -e '\E[32m'"Architecture :" $dlpcheck $architecture

# Check Kernel Release
kernelrelease=$(uname -r)
echo -e '\E[32m'"Kernel Release :" $dlpcheck $kernelrelease

# Check hostname
echo -e '\E[32m'"Hostname :" $dlpcheck $HOSTNAME

# Check Internal IP
internalip=$(hostname -I)
echo -e '\E[32m'"Internal IP :" $dlpcheck $internalip

# Check External IP
externalip=$(curl -s ipecho.net/plain;echo)
echo -e '\E[32m'"External IP : $dlpcheck "$externalip

# Check DNS
nameservers=$(cat /etc/resolv.conf | sed '1 d' | awk '{print $2}')
echo -e '\E[32m'"Name Servers :" $dlpcheck $nameservers

# Check Logged In Users
who>/tmp/who
echo -e '\E[32m'"Logged In users :" $dlpcheck && cat /tmp/who

# Check RAM and SWAP Usages
free -h | grep -v + > /tmp/ramcache
echo -e '\E[32m'"Ram Usages :" $dlpcheck
cat /tmp/ramcache | grep -v "Swap"
echo -e '\E[32m'"Swap Usages :" $dlpcheck
cat /tmp/ramcache | grep -v "Mem"

# Check Disk Usages
df -h| grep 'Filesystem\|/dev/sda*' > /tmp/diskusage
echo -e '\E[32m'"Disk Usages :" $dlpcheck
cat /tmp/diskusage

# Check Load Average
loadaverage=$(top -n 1 -b | grep "load average:" | awk '{print $10 $11 $12}')
echo -e '\E[32m'"Load Average :" $dlpcheck $loadaverage

# Check System Uptime
tecuptime=$(uptime | awk '{print $3,$4}' | cut -f1 -d,)
echo -e '\E[32m'"System Uptime Days/(HH:MM) :" $dlpcheck $tecuptime

# Unset Variables
unset dlpcheck os architecture kernelrelease internalip externalip nameserver loadaverage

# Remove Temporary Files
rm /tmp/osrelease /tmp/who /tmp/ramcache /tmp/diskusage

shift $(($OPTIND -1))
