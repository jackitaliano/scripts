#!/usr/bin/env zsh

year="2023"
notesDir=$HOME"/notes/"$year
notesTestDir=$HOME"/notes/testDir"
projectsDir=$HOME"/projects"
reposDir=$HOME"/repos"
scriptsDir=$HOME"/scripts"
osuOneDriveDir=$HOME"'/OneDrive - The Ohio State University'"
personalOneDriveDir=$HOME"/OneDrive"
configDir=$HOME"/.config"
dotfilesDir=$HOME"/.dotfiles"

# Store the directories as an array
codeDirs=("${projectsDir}" "${scriptsDir}" "${configDir}" "${dotfilesDir}" "${reposDir}")
noteDirs=("${notesDir}")
allDirs=("${codeDirs[@]}" "${noteDirs[@]}" "${personalOneDriveDir}")

if [ "$1" = "code" ]; then
    printf '%s\n' "${codeDirs[@]}"
elif [ "$1" = "notes" ]; then
    printf '%s\n' "${noteDirs[@]}"
else
    printf '%s\n' "${allDirs[@]}"
fi

