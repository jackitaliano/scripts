#!/usr/bin/env bash

listDirsPath="$HOME/scripts/common/listDirs.sh"

rpf() {
	RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
	INITIAL_QUERY="${*:-}"
	selected_file=$(fzf --ansi --disabled --query "$INITIAL_QUERY" \
		--bind "start:reload($RG_PREFIX {q})+unbind(ctrl-r)" \
		--bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
		--bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
		--bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
		--color "hl:-1:underline,hl+:-1:underline:reverse" \
		--prompt '1. ripgrep> ' \
		--delimiter : \
		--header '╱ CTRL-R (ripgrep mode) ╱ CTRL-F (fzf mode) ╱' \
		--preview 'bat --color=always {1} --highlight-line {2}' \
		--preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
		--with-nth 1 \
		--query "$INITIAL_QUERY" \
		--exit-0)

	if [ -n "$selected_file" ]; then
		file_path=$(echo "$selected_file" | cut -d: -f1)
		line_number=$(echo "$selected_file" | cut -d: -f2)
		absolute_path=$(realpath "$file_path")
		cd "$(dirname "$file_path")"
		nvim "+$line_number" "$absolute_path"
	fi
}
# rpf() {
# 	QUERY=$1
#
# 	cwd=$(pwd)
# 	files=$(fd -H $QUERY .)
# 	file=$(fzf $files)
# 	echo $file
# }

rhf() {
	RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
	INITIAL_QUERY="${1:-}"

	IFS=$'\n' dirsToLookIn=($HOME)
	search_dirs=""
	for dir in "${dirsToLookIn[@]}"; do
		search_dirs+="-g" "$dir"
	done

	selected_file=$(fzf --ansi --disabled --query "$INITIAL_QUERY" \
		--bind "start:reload($RG_PREFIX {q})+unbind(ctrl-r)" \
		--bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
		--bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
		--bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
		--color "hl:-1:underline,hl+:-1:underline:reverse" \
		--prompt '1. ripgrep> ' \
		--delimiter : \
		--header '╱ CTRL-R (ripgrep mode) ╱ CTRL-F (fzf mode) ╱' \
		--preview 'bat --color=always {1} --highlight-line {2}' \
		--preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
		--with-nth 1 \
		--query "$INITIAL_QUERY" \
		--print0 \
		--exit-0 \
		$search_dirs)

	file_path=$(echo "$selected_file" | cut -d: -f1)
	line_number=$(echo "$selected_file" | cut -d: -f2)

	if [ -n "$selected_file" ] && [ "$selected_file" != "$search_dirs" ] && [ "$file_path" != "." ]; then
		absolute_path=$(realpath "$file_path")
		cd "$(dirname "$absolute_path")"
		nvim "+$line_number" "$absolute_path"
	fi
}

rcf() {
	RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
	INITIAL_QUERY="${1:-}"

	IFS=$'\n' dirsToLookIn=("$HOME/Projects")
	search_dirs=""
	for dir in "${dirsToLookIn[@]}"; do
		search_dirs+="-g" "$dir"
	done

	selected_file=$(fzf --ansi --disabled --query "$INITIAL_QUERY" \
		--bind "start:reload($RG_PREFIX {q})+unbind(ctrl-r)" \
		--bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
		--bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
		--bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
		--color "hl:-1:underline,hl+:-1:underline:reverse" \
		--prompt '1. ripgrep> ' \
		--delimiter : \
		--header '╱ CTRL-R (ripgrep mode) ╱ CTRL-F (fzf mode) ╱' \
		--preview 'bat --color=always {1} --highlight-line {2}' \
		--preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
		--with-nth 1 \
		--query "$INITIAL_QUERY" \
		--print0 \
		--exit-0 \
		$search_dirs)

	file_path=$(echo "$selected_file" | cut -d: -f1)
	line_number=$(echo "$selected_file" | cut -d: -f2)

	if [ -n "$selected_file" ] && [ "$selected_file" != "$search_dirs" ] && [ "$file_path" != "." ]; then
		absolute_path=$(realpath "$file_path")
		cd "$(dirname "$absolute_path")"
		nvim "+$line_number" "$absolute_path"
	fi
}

rnf() {
	RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
	INITIAL_QUERY="${1:-}"

	IFS=$'\n' dirsToLookIn=($HOME/notes)
	search_dirs=""
	for dir in "${dirsToLookIn[@]}"; do
		search_dirs+="-g" "$dir"
	done

	selected_file=$(fzf --ansi --disabled --query "$INITIAL_QUERY" \
		--bind "start:reload($RG_PREFIX {q})+unbind(ctrl-r)" \
		--bind "change:reload:sleep 0.1; $RG_PREFIX {q} || true" \
		--bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
		--bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
		--color "hl:-1:underline,hl+:-1:underline:reverse" \
		--prompt '1. ripgrep> ' \
		--delimiter : \
		--header '╱ CTRL-R (ripgrep mode) ╱ CTRL-F (fzf mode) ╱' \
		--preview 'bat --color=always {1} --highlight-line {2}' \
		--preview-window 'up,60%,border-bottom,+{2}+3/3,~3' \
		--with-nth 1 \
		--query "$INITIAL_QUERY" \
		--print0 \
		--exit-0 \
		<<<"$files")

	file_path=$(echo "$selected_file" | cut -d: -f1)
	line_number=$(echo "$selected_file" | cut -d: -f2)

	if [ -n "$selected_file" ] && [ "$selected_file" != "$search_dirs" ] && [ "$file_path" != "." ]; then
		absolute_path=$(realpath "$file_path")
		cd "$(dirname "$absolute_path")"
		nvim "+$line_number" "$absolute_path"
	fi
}
