#!/bin/bash
while :
do
 clear
 echo "   M A I N - M E N U"
 echo "1. Contents of /etc/passwd"
 echo "2. List of users currently logged"
 echo "3. Prsent handling directory"
 echo "4. Exit"
 echo -n "Please enter option [1 - 4]"
 read opt
 case $opt in
  1) echo "************ Conents of /etc/passwd *************";
     more /etc/passwd;;
  2) echo "*********** List of users currently logged";
     who | more;;
  3) echo "You are in $(pwd) directory";   
     echo "Press [enter] key to continue. . .";
     read enterKey;;
  4) echo "Bye $USER";
     exit 1;;
  *) echo "$opt is an invaild option. Please select option between 1-4 only";
     echo "Press [enter] key to continue. . .";
     read enterKey;;
esac
done