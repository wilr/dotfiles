#!/bin/bash

command=$1;

if [ "$command" == "" ]; then
	echo "Usage: ./bootstrap [link|changes|subl]"
	exit 1
fi

case $command in
	link)
		cd "$(dirname "$0")"
		git pull

		function doIt() {
			rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" --exclude ".subl" -av . ~
		}

		if [ "$1" == "--force" -o "$1" == "-f" ]; then
			doIt
		else
			read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
			echo
			if [[ $REPLY =~ ^[Yy]$ ]]; then
				doIt
			fi
		fi

		unset doIt
		source ~/.bash_profile
		;;
	changes)
		for f in `ls -a | grep -P ".{1}[\w][^.]+[\w]$" | grep "[^.git]$" | grep "[^.DS_Store]$"`; do
			if [ -f ~/$f ]; then
				result=`diff ~/$f $f`
				
				if [ "$result" ]; then
					# It's time for us as a people to start makin' some changes. 
					# Let's change the way we eat, let's change the way we live 
					# And let's change the way we treat each other. 
					# You see the old way wasn't working so it's on us to do 
					# What we gotta do, to survive.
					echo "$(tput setaf 1)$f has changes$(tput sgr0)"
					echo "$result"
				else
					# And still I see no changes can't a brother get a little peace 
					# It's war on the streets & the war in the Middle East 
					# Instead of war on poverty they got a war on drugs
					echo "$(tput setaf 2)$f has no no changes$(tput sgr0)"
				fi
			else
				echo "$(tput setaf 1)$f is not linked to ~/$(tput sgr0)"
			fi
		done
		;;
	subl)
		rsync --exclude ".DS_Store" -av ".subl/" "$HOME/Library/Application Support/Sublime Text 2/Packages/User"
		
		;;
esac