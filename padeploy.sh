#!/bin/sh
if [ -f "/etc/redhat-release" ]; then
    
    rhos="Fedora CentOS Red Hat"
    for i in $rhos; do
        
        if [ ! -z "`/bin/grep $i /etc/redhat-release`" ]; then
            
            if [[ $i = "CentOS" ]]; then
            	
            	PS3='Please enter your choice: '
				options=("LAMP - Apache2 With PHP5 And MySQL" "LEMP - Nginx With PHP5 And MySQL" "Quit")
				select opt in "${options[@]}"
				do
				    case $opt in
				        "LAMP - Apache2 With PHP5 And MySQL")
				            clear

				            echo 'Going to install the LAMP stack on your box, here we go...'
							echo '------------------------'
							read -p "MySQL Password: " mysqlPassword
							read -p "Retype password: " mysqlPasswordRetype




							while [[ "$mysqlPassword" = "" && "$mysqlPassword" != "$mysqlPasswordRetype" ]]; do
							  	echo -n "Please enter the desired mysql root password: "
							  	stty -echo
							  	read -r mysqlPassword
							  	echo
							  	echo -n "Retype password: "
							  	read -r mysqlPasswordRetype
							  	stty echo
							  	echo
							  	if [ "$mysqlPassword" != "$mysqlPasswordRetype" ]; then
							    	echo "Passwords do not match!"
							  	fi
							done

				            ;;
				        "LEMP - Nginx With PHP5 And MySQL")
				            echo "you chose choice 2"
				            ;;
				        "Quit")
				            break
				            ;;
				        *) echo invalid option;;
				    esac
				done

            elif [[ $i = "Fedora" ]]; then
            	
            	echo "Fedora"

            elif [[ $i = "Red Hat" ]]; then
            	
            	echo "Red Hat"

            fi

        fi

    done

elif [ -f "/etc/lsb-release" ]; then
        
        echo "ubuntu"

elif [ -f "/etc/debian_version" ]; then
        
        echo "debian"

elif [ -f "/etc/arch-release" ]; then
        
        echo "arch"

elif [ -f "/etc/SuSE-release" ]; then
        
        echo 'suse'

fi