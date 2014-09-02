#!/usr/bin/env bash

if type git >/dev/null; then
	echo "OK, I'm going to install potter-shell now."
else
	echo "You don't have git installed! Please install git, then try installing potter-shell again."
	exit 1
fi

git clone git://github.com/jacksondc/pottershell.git ~/.pottershell

if [ $? ]; then
	echo "               __________                          ______      ___________"
	echo " ________________  /__  /_____________      __________  /_________  /__  /"
	echo " ___  __ \  __ \  __/  __/  _ \_  ___/________  ___/_  __ \  _ \_  /__  / "
	echo " __  /_/ / /_/ / /_ / /_ /  __/  /   _/_____/(__  )_  / / /  __/  / _  /  "
	echo " _  .___/\____/\__/ \__/ \___//_/           /____/ /_/ /_/\___//_/  /_/   "
	echo " /_/                                         ...has been installed. Enjoy!"
	echo ""
	echo 'Now all you need to do is put `source ~/.pottershell/pottershell.sh` in your shell startup.'
else
	echo "Something went wrong! Check the output, fix any errors, and try again."
	echo "If you still have problems, open an issue on GitHub: https://github.com/jacksondc/pottershell/issues"
	echo "Make sure to include the full output of the installer. Good luck!"
	exit 1
fi
