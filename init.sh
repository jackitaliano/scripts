#!/usr/bin/env zsh

commandsDir="$HOME/scripts/commands"

for f in $(find "$commandsDir" -type f -name "*.sh"); do
	if [ $f != "./init.sh" ]; then
		source "$f"
	fi
done

echo ":)\n"
