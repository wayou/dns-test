#!/bin/bash

light_red='\e[1;91m%s\e[0m\n'                     
light_green='\e[1;92m%s\e[0m\n' 

echo "set DNS to $1"
sudo networksetup -setdnsservers Wi-Fi $1

echo "clean DNS cache"
sudo dscacheutil -flushcache && \
sudo killall -HUP mDNSResponder

echo "start test the new DNS..."

ping -c 4 google.com                        
if [ "$?" -eq 0 ]; then                           
  printf "$light_green" "[ CONNECTION AVAILABLE ]"
else                                              
  printf "$light_red" "[ HOST DISCONNECTED ]"     
fi
