#!/bin/bash
PS3="Select Recipe : "
 
# set recipe list
select recipes in 'LAMP - Apache2 With PHP5 And MySQL' 'LEMP - Nginx With PHP5 And MySQL' 'LAMP - Wordpress - Apache2 With PHP5 And MySQL' 'Exit'
do
	case $recipes in
		'LAMP - Apache2 With PHP5 And MySQL')
			echo "--------------"
			echo "Space Shuttle Columbia was the first spaceworthy space shuttle in NASA's orbital fleet."
			echo "--------------"
			;;
		'LEMP - Nginx With PHP5 And MySQL')
			echo "--------------"		
			echo "Space Shuttle Endeavour is one of three currently operational orbiters in the Space Shuttle." 
			echo "--------------"		
			;;
		'LAMP - Wordpress - Apache2 With PHP5 And MySQL') 
			echo "--------------"				
		    echo "Space Shuttle Challenger was NASA's second Space Shuttle orbiter to be put into service."
			echo "--------------"				    
			;;				
		'Exit')
			
			echo "--------------"	

			break						
			;;
		*)		
			echo "Error: Please try again (select 1..4)!"
			;;		
	esac
done