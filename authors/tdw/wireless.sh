#!/bin/bash
# troydwill@gmail.com, October 2009

WIRELESS_DEVICE='wlan0'
ESSID='JM'
KEY='D21B5074EA'
MY_IP_ADDRESS='192.168.1.39'
GATEWAY_IP_ADDRESS='192.168.1.1'

down () {
    /sbin/ip link set eth1 down
    /sbin/ip link set ${WIRELESS_DEVICE} down
    /sbin/ip route del default via ${GATEWAY_IP_ADDRESS} dev ${WIRELESS_DEVICE}
    /sbin/ip addr del ${MY_IP_ADDRESS}/24 broadcast 192.168.1.255 dev ${WIRELESS_DEVICE}
}

up () {
    /sbin/ip link set ${WIRELESS_DEVICE} up
    /usr/sbin/iwconfig ${WIRELESS_DEVICE} essid ${ESSID}
    /usr/sbin/iwconfig ${WIRELESS_DEVICE} key ${KEY}
    /sbin/ip addr add ${MY_IP_ADDRESS}/24 broadcast 192.168.1.255 dev ${WIRELESS_DEVICE}
    /sbin/ip route add default via ${GATEWAY_IP_ADDRESS} dev ${WIRELESS_DEVICE}
}

down
up
