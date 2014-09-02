#!/usr/bin/env bash

if type git >/dev/null; then
	echo "OK, I'm going to install potter-shell now."
else
	echo "You don't have git installed! Please install git, then try installing potter-shell again."
	exit 1
fi

git clone git://github.com/jacksondc/pottershell.git ~/.pottershell

if [ $? ]; then
	# Cloning succeeded
	
	# Clever installation based on shell detection
	# This works due to the fact that the install snippet pipes to $SHELL, not sh or bash
	if [ $SHELL == bash ]; then
		echo "Ah! I see you're using bash. Lovely shell, bash."
		read -n 1 -p "Shall I automatically install potter-shell to your .bash_profile, or would you prefer to do that yourself? [Ynq?] "
		if [ $REPLY == y || $REPLY == Y ]; then
			AUTOINSTALL = y
		else if [ $REPLY == n || $REPLY == N ]; then
			AUTOINSTALL = n
		else if [ $REPLY == q || $REPLY == Q ]; then
			echo "OK, I'm quitting. You may wish to \`rm -rf ~/.pottershell\`."
			echo "Bye!"
		else if [ $REPLY == ? ]; then
			echo "In order for potter-shell to work, it needs to be referenced in your shell's startup script."
			# Please forgive me for this escaping monstrosity
			echo "potter-shell can do this automatically for you by running \`echo \"\\nsource ~/.pottershell/pottershell.sh\\n\" >> ~/.bash_profile\`."
			echo "Type y to have potter-shell automatically run this for you."
			echo "Type n to have potter-shell do nothing."
			echo "Type q to quit the potter-shell installation."
			echo "Type ? to have potter-shell display this help text."
		fi; fi; fi; fi
	fi
	
	echo "               __________                          ______      ___________"
	echo " ________________  /__  /_____________      __________  /_________  /__  /"
	echo " ___  __ \  __ \  __/  __/  _ \_  ___/________  ___/_  __ \  _ \_  /__  / "
	echo " __  /_/ / /_/ / /_ / /_ /  __/  /   _/_____/(__  )_  / / /  __/  / _  /  "
	echo " _  .___/\____/\__/ \__/ \___//_/           /____/ /_/ /_/\___//_/  /_/   "
	echo " /_/                                         ...has been installed. Enjoy!"
	echo
		
	echo 'Now all you need to do is put `source ~/.pottershell/pottershell.sh` in your shell startup.'
	echo "I can't do this automatically, because I don't know what kind of shell $SHELL is. Perhaps send a pull request?"
else
	# Cloning failed
	echo "Something went wrong! Check the output, fix any errors, and try again."
	echo "If you still have problems, open an issue on GitHub: https://github.com/jacksondc/pottershell/issues"
	echo "Make sure to include the full output of the installer. Good luck!"
	exit 2
fi
