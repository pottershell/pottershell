#!/usr/bin/env bash

# See also PORTABILITY.md

# ENVIRONMENT VARIABLES

# POTTER-SHELL_INSTALL_DIR: path value, sets the path to install potter-shell to. Currently ignored.
# POTTER-SHELL_ECHO_COMMAND: any value, turns on command echoing. Currently ignored.
# POTTER-SHELL_NO_ECHO_COMMAND: any value, turns off command echoing. This is the default. Currently ignored.
# POTTER-SHELL_SET_GIT: any value, turns on support for setting git aliases, overrides POTTER-SHELL_NO_SET_GIT. This is the default. Currently ignored.
# POTTER-SHELL_NO_SET_GIT: any value, turns off support for setting git aliases. Currently ignored.

# GLOBAL VARIABLES



# UTILITY FUNCTION DECLARATIONS

function throw_warn() {
	echo "$0: WARNING: $1"
}

function throw_info() {
	if [ $# = 0 ]; then
		throw_warn "Attempted to call throw_info with no arguments!"
		return -1
	fi
	echo "$0: INFO: $1"
}

function throw_fatal() {
	if [ $# = 0 ]; then
		throw_warn "Attempted to call throw_fatal with no arguments!"
		throw_fatal "throw_fatal called, but no reason given. Aborting anyway."
	fi
	echo -n "$0: FATAL: "
	echo $1
	throw_info "Aborting script due to fatal error."
	if [ -v 2 ]; then exit $2; fi
	exit -1
}

# FUNCTION DECLARATIONS

function add_shell_alias() {
	# TODO: add argument validation
	throw_info "Adding a shell alias to accept $1 as $2..."
	COMMAND="alias $2=$1"
	$COMMAND
}

function add_git_alias() {
	# TODO: add argument validation
	COMMAND="git config --global alias.$2 $1"
	$COMMAND
}

# MAIN SCRIPT BODY

# evaluate shell aliases

for i in $(cat shell.aliases); do
	echo $i
	if [ -z $_POTTERSHELL_FIRST_ALIAS ]; then
		_POTTERSHELL_FIRST_ALIAS=$i
		throw_info "Setting _POTTERSHELL_FIRST_ALIAS to $_POTTERSHELL_FIRST_ALIAS"
	else
		throw_info "Setting alias. _POTTERSHELL_FIRST_ALIAS is set to $_POTTERSHELL_FIRST_ALIAS"
		add_shell_alias $_POTTERSHELL_FIRST_ALIAS $i
		unset _POTTERSHELL_FIRST_ALIAS
	fi
done

# just in case

if [ -n $_POTTERSHELL_FIRST_ALIAS ]; then
	throw_warn "Something has gone wrong. Either there is a bug or a malformed .aliases file."
	throw_warn "Continuing anyway."
fi

# evaluate git aliases

for i in $(cat git.aliases); do
	if [ -z $_POTTERSHELL_FIRST_ALIAS ]; then
		_POTTERSHELL_FIRST_ALIAS=$i
	else
		add_git_alias $_POTTERSHELL_FIRST_ALIAS $i
		unset _POTTERSHELL_FIRST_ALIAS
	fi
done

# just in case

if [ -n $_POTTERSHELL_FIRST_ALIAS ]; then
	echo $_POTTERSHELL_FIRST_ALIAS
	throw_warn "Something has gone wrong. Either there is a bug or a malformed .aliases file."
	throw_warn "Continuing anyway."
fi
