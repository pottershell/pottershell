#!/usr/bin/env bash

if type git >/dev/null; then
	echo "OK, I'm going to install pottershell now."
else
	echo "You don't have git installed! Please install git, then try installing pottershell again."
	exit 1
fi

if git clone git://github.com/jacksondc/pottershell.git ~/.pottershell; then
	# Cloning succeeded
	
	# Clever installation based on shell detection
	# This works due to the fact that the install snippet pipes to $SHELL, not sh or bash
	if [ $SHELL == bash ]; then
		echo "Ah! I see you're using bash. Lovely shell, bash. Solid default."
	        CONTINUE_INSTALL_LOOP=y
		while [ $CONTINUE_INSTALL_LOOP == y ]; do
			read -n 1 -p "Shall I automatically install pottershell to your .bash_profile, or would you prefer to do that yourself? [Ynq?] "
			if ! ([ $REPLY == Y ] || \
			      [ $REPLY == y ] || \
			      [ $REPLY == n ] || \
			      [ $REPLY == N ] || \
			      [ $REPLY == q ] || \
			      [ $REPLY == Q ] || \
			      [ $REPLY == ? ] )
			then
			
				# User just pressed enter or replied with something invalid, so we need to prompt again
				
				if [ -z $REPLY ]; then
					# User pressed enter
					true
				else
					# User gave some other garbage value
					echo
					echo "I didn't understand your reply. Perhaps type ? for help?"
					continue
				fi
			fi
			
			echo
			
			if [ $REPLY == y ] || [ $REPLY == Y ]; then
				AUTOINSTALL=y
				CONTINUE_INSTALL_LOOP=n
			else if [ $REPLY == n ] || [ $REPLY == N ]; then
				AUTOINSTALL=n
				CONTINUE_INSTALL_LOOP=n
			else if [ $REPLY == q ] || [ $REPLY == Q ]; then
				echo "OK, I'm quitting. You may wish to \`rm -rf ~/.pottershell\`."
				echo "Bye!"
				exit 3
			else if [ $REPLY == ? ]; then
				echo "In order for pottershell to work, it needs to be referenced in your shell's startup script."
				# Please forgive me for this escaping monstrosity
				echo "pottershell can do this automatically for you by running \`printf \"source ~/.pottershell/pottershell.sh\\n\" >> ~/.bash_profile\`."
				echo "Type y to have pottershell automatically run this for you."
				echo "Type n to have pottershell do nothing."
				echo "Type q to quit the pottershell installation."
				echo "Type ? to have pottershell display this help text."
			fi; fi; fi; fi
			unset REPLY
		done
	else
		UNKNOWN_SHELL=
	fi

	if [ $AUTOINSTALL == y ]; then
		if [ $SHELL = bash ]; then printf "\nsource ~/.pottershell/pottershell.sh\n" >> ~/.bash_profile; fi
		echo "Successfully autoinstalled pottershell to your initialization file."
	else if [ $AUTOINSTALL == n ]; then
		echo "Refraining from autoinstalling."
	fi; fi
	
	
	echo "               __________                          ______      ___________"
	echo " ________________  /__  /_____________      __________  /_________  /__  /"
	echo " ___  __ \  __ \  __/  __/  _ \_  ___/________  ___/_  __ \  _ \_  /__  / "
	echo " __  /_/ / /_/ / /_ / /_ /  __/  /   _/_____/(__  )_  / / /  __/  / _  /  "
	echo " _  .___/\____/\__/ \__/ \___//_/           /____/ /_/ /_/\___//_/  /_/   "
	echo " /_/                                         ...has been installed. Enjoy!"
	echo

	if [ -n $UNKNOWN_SHELL ]; then
		echo 'Now all you need to do is put `source ~/.pottershell/pottershell.sh` in your shell startup.'
		echo "I can't do this automatically, because I don't know what kind of shell $SHELL is. Perhaps send a pull request?"
	fi
else
	# Cloning failed
	echo "Something went wrong! Check the output, fix any errors, and try again."
	echo "If you still have problems, open an issue on GitHub: https://github.com/jacksondc/pottershell/issues"
	echo "Make sure to include the full output of the installer. Good luck!"
	exit 2
fi
