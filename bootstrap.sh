#!/bin/bash

command=$1;

if [ "$command" == "" ]; then
	echo "Usage: ./bootstrap [link|changes|sublime]"
	exit 1
fi

if [ "$2" == "--force" -o "$2" == "-f" ]; then
	rsyncflags="-q"
else
	rsyncflags="-v"
fi

case $command in
	link)
		cd "$(dirname "$0")"

		function doIt() {
			rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" --exclude "README.md" --exclude "sublime" -a $rsyncflags . ~
		}

		if [ "$2" == "--force" -o "$2" == "-f" ]; then
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
	sublime)
		# configure sublime 3
		packages="$HOME/Library/Application Support/Sublime Text 3/Installed Packages";
		user="$HOME/Library/Application Support/Sublime Text 3/Packages/User"

		if [ -d "$packages" ]; then
			rsync --exclude ".DS_Store" $rsyncflags -a "sublime/Installed Packages/" "$packages"
		fi

		if [ -d "$user" ]; then
			rsync --exclude ".DS_Store" $rsyncflags -a "sublime/Packages/User/" "$user"
		fi

		# configure sublime 2
		# if [ -d "$HOME/Library/Application Support/Sublime Text 2/Packages" ]; then
		#		rsync --exclude ".DS_Store" -av "sublime/" "$HOME/Library/Application Support/Sublime Text 2/Packages"
		# fi

		;;
	*)
		echo "Unknown command $command provided."
esac
