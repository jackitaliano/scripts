#!/usr/bin/env $SHELL

listDirsPath="$HOME/scripts/common/listDirs.sh"

extensions=("py" "js" "cs" "c" "cpp" "sh" "jave" "json" "csv" "txt" "asm" "ts" "tf" "lua" "md")
exclusions=("*/.git/" ".git" "*/.venv/*" ".DS_Store" "*/Library/*")

fileExclusions=""
extensionInclusions=""

for ext in "${extensions[@]}"; do
	extensionInclusions+=" -o -name '*.$ext'"
done
extensionInclusions="${extensionInclusions# -o }"

for ext in "${exlusions[@]}"; do
	fileExclusions+=" -and \! -path $ext"
done
fileExclusions="${extensionInclusions# -and }"

chd() {
	# Capture the directories as an array, using command substitution and IFS
	IFS=$'\n' dirsToLookIn=($("$listDirsPath"))

	# Use an array expansion with double quotes to pass the directories to the find command
	files=$(eval "find "${dirsToLookIn[@]}" \( -type f \( "$fileExclusions" \) -and \( "$extensionInclusions" \) -print \)")

	selected_file=$(fzf --preview-window up --preview="less {}" --bind shift-up:preview-page-up,shift-down:preview-page-down <<<"$files")

	selected_dir=$(dirname "$selected_file")

	if [ -n "$selected_dir" ] && [ "$selected_dir" != "." ]; then
		cd "$selected_dir"
	fi
}

cpd() {
	# Use an array expansion with double quotes to pass the directories to the find command
	files=$(eval "find . \( -type f \( "$fileExclusions" \) -and \( "$extensionInclusions" \) -print \)")

	selected_file=$(fzf --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' --preview 'bat --color=always {1}' --bind shift-up:preview-page-up,shift-down:preview-page-down <<<"$files")

	selected_dir=$(dirname "$selected_file")

	if [ -n "$selected_dir" ] && [ "$selected_dir" != "." ]; then
		cd "$selected_dir"
	fi
}

ccd() {
	# Capture the directories as an array, using command substitution and IFS
	IFS=$'\n' dirsToLookIn=($("$listDirsPath" "code"))

	# Use an array expansion with double quotes to pass the directories to the find command
	files=$(eval "find "${dirsToLookIn[@]}" \( -type f \( "$fileExclusions" \) -and \( "$extensionInclusions" \) -print \)")

	selected_file=$(fzf --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' --preview 'bat --color=always {1}' --bind shift-up:preview-page-up,shift-down:preview-page-down <<<"$files")

	selected_dir=$(dirname "$selected_file")

	if [ -n "$selected_dir" ] && [ "$selected_dir" != "." ]; then
		cd "$selected_dir"
	fi
}

cnd() {
	# Capture the directories as an array, using command substitution and IFS
	IFS=$'\n' dirsToLookIn=($("$listDirsPath" "notes"))

	# Use an array expansion with double quotes to pass the directories to the find command
	files=$(eval "find "${dirsToLookIn[@]}" \( -type f \( "$fileExclusions" \) -and \( "$extensionInclusions" \) -print \)")

	selected_file=$(fzf --preview-window 'up,60%,border-bottom,+{2}+3/3,~3' --preview 'bat --color=always {1}' --bind shift-up:preview-page-up,shift-down:preview-page-down <<<"$files")

	selected_dir=$(dirname "$selected_file")

	if [ -n "$selected_dir" ] && [ "$selected_dir" != "." ]; then
		cd "$selected_dir"
	fi
}
