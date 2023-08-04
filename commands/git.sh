#!/usr/bin/env $SHELL

function gac() {
	git add.
	if [ -n "$1" ]; then
		git commit -m "$1"
	else
		git commit
	fi
}
