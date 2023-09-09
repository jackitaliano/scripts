tma() {

	sessions=$(tmux ls | awk '{ print substr($1, 1, length($1)-1) }')

	selected_session=$(fzf <<<"$sessions")

	if [ $selected_session ]; then
		tmux a -t $selected_session
	fi
}
