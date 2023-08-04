#!/usr/bin/env $SHELL

fileExtension=".md"
quickNotePrefix="qn_"
year=$(date +"%Y")
notesFp="$HOME/notes/$year"
quickNoteFp="$notesFp/quickNotes"

nn() {
	dirsToLookIn=("$notesFp")

	files=$(eval "find "${dirsToLookIn[@]}" \( -type d -print \)")
	echo $files

	selected_dir=$(fzf --preview="less {}" --bind shift-up:preview-page-up,shift-down:preview-page-down <<<"$files")

	if [ -n "$selected_dir" ] && [ "$selected_dir" != "." ]; then
		cd "$selected_dir"

		if [ -n "$1" ]; then
			touch "$1$fileExtension"
			nvim "$1$fileExtension"
		else
			touch "untitled.md"
			nvim "untitled.md"
		fi
	fi
}

qn() {
	fName="$quickNotePrefix"$(date +'%m-%d-%y-%R')"$fileExtension"
	fPath="$quickNoteFp"

	while getopts ":f:d:" option; do
		case $option in
		f)
			fName="$OPTARG.md"
			;;
		d)
			if [ -n "$notesFp/$OPTARG" ]; then
				fPath="$notesFp/$OPTARG"
			else
				echo "Directory doesn't exist: $fPath"
			fi
			;;
		*)
			# code to execute when an unknown flag is provided
			echo "Invalid argument: $OPTARG"
			;;
		esac
	done

	file="$fPath/$fName"

	touch $file
	nvim $file
}
