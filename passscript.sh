#!/bin/bash
file1=/tmp/users

#request sudo perms
echo Please enter sudo password
sudo echo sudo password accepted
echo -------------------------------------------------------
echo "Password reset script By Justin taught by Brandon S. "
echo -------------------------------------------------------

#Read and find REAL users in the user file
cat /etc/passwd | grep /bin/bash | cut -d: -f1 > $file1

#print out users on sys
echo Here are the users on the system:
cat $file1

#Begin to reset password via imput
	echo "Whose password do I reset:"
	echo "type "'"all"'" to change all users passwords simultaneously"
	echo "type "'"random"'" to enter the random password generator"

#user input
read usr

#Check if user is on the system
grep -Fx $usr $file1

if [ $? -eq 0 ]
	then
echo "Resetting password for" '"'$usr'"'
		#reset the pass
		sudo passwd $usr
		#if user types all
elif [[ $usr = "random" ]]; then
	cat $file1 | grep /bin/bash | cut -d: -f1 > $file2

	#cleanup
	mv $file2 $file1

	#print out users on sys
	echo Here are the users on the system:
	cat $file1

	#Begin to reset password via imput
		echo "Please enter the user randomize:"
	read usr



	#Check if user is on the system
	grep -Fx $usr $file1 > /dev/null

	if [ $? -eq 0 ]
		then
			echo "Ok lets reset" '"'$usr'"'
			#Random number gen
	password=$RANDOM

	 	#random password var

				#pipe random number into passwd

	#workin
		sudo yes $password | sudo passwd $usr


			echo "The new password for" '"'"$usr"'"' "is :"
			echo $password

		else
			#fail condition
			echo No matching user found
			echo "Ok reseting" '"'$usr'"'
			#Random number gen
	password=$RANDOM

	 	#random password var

				#pipe random number into passwd

	#workin
		sudo yes $password | sudo passwd $usr


			echo "The new password for" '"'"$usr"'"' "is :"
			echo $password


	fi

elif [[ $usr = "all" ]]; then
	#Make sure of choice
		echo You have elected to change all of the users passwords are you sure? [yes/no]
		read makesure
			if [ $makesure = "yes" ]
			then
					echo "ok what do you want EVERYONE's password to be?"
					read passwordall
					echo Now changing passwords...

#Every user changer loop

					for i in `cat $file1`; do
							sudo yes $passwordall | sudo passwd $i
					done
							echo "Changed all passwords to" $passwordall
			else
							echo "Passwords unchanged."
		 fi
	else
		#fail condition
		echo No matching user found, attempting anyway.

		echo "Resetting password for" '"'$usr'"'
		#reset the pass
		sudo passwd $usr
fi

#clean up
rm -rf $file1
