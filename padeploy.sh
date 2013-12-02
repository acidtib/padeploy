#!/bin/bash
PS3="Select recipe : "
 
# set shuttle list
select shuttle in LAMP - Apache2 With PHP5 And MySQL endeavour challenger discovery atlantis enterprise pathfinder
do
	case $shuttle in
		LAMP - Apache2 With PHP5 And MySQL)
			echo "--------------"
			echo "Space Shuttle Columbia was the first spaceworthy space shuttle in NASA's orbital fleet."
			echo "--------------"
			;;
		endeavour)
			echo "--------------"		
			echo "Space Shuttle Endeavour is one of three currently operational orbiters in the Space Shuttle." 
			echo "--------------"		
			;;
		challenger) 
			echo "--------------"				
		    echo "Space Shuttle Challenger was NASA's second Space Shuttle orbiter to be put into service."
			echo "--------------"				    
			;;		
		discovery) 
			echo "--------------"		
			echo "Discovery became the third operational orbiter, and is now the oldest one in service."
			echo "--------------"							
			;;		
		atlantis)
			echo "--------------"		
			echo "Atlantis was the fourth operational shuttle built."
			echo "--------------"							
			;;
		enterprise)
			echo "--------------"		
			echo "Space Shuttle Enterprise was the first Space Shuttle orbiter."
			echo "--------------"							
			;;		
		pathfinder)
			echo "--------------"		
			echo "Space Shuttle Orbiter Pathfinder is a Space Shuttle simulator made of steel and wood."
			echo "--------------"							
			;;
		*)		
			echo "Error: Please try again (select 1..7)!"
			;;		
	esac
done