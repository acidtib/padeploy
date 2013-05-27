#!/bin/sh
if [ -f "/etc/redhat-release" ]; then
    rhos="Fedora CentOS Red Hat"
    for i in $rhos; do
            if [ ! -z "`/bin/grep $i /etc/redhat-release`" ]; then
                if [[ $i = "Centos" ]]; then
                	echo "Centos"
                elif [[ $i = "Fedora" ]]; then
                	echo "Fedora"
                elif [[ $i = "Red Hat" ]]; then
                	echo "Red Hat"
                fi
            fi
    done
elif [ -f "/etc/debian_version" ]; then
        echo "debian"
elif [ -f "/etc/arch-release" ]; then
        echo "arch"
elif [ -f "/etc/SuSE-release" ]; then
        echo 'suse'
fi