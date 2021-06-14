#!/usr/bin/env bash

if [[ -f /etc/os-release ]]; then
	### Get variables for OS name and stuff ###
	source /etc/os-release
else
	exit 0
fi

install_vim () {
  ### Install Vim ###
	if ! [[ -x "$(command -v vim)" ]]; then
		### Check to see if vim is installed ###
		if [[ -x "$(command -v apt)" ]]; then
			sudo apt install vim
		elif [[ -x "$(command -v pacman)" ]]; then
			sudo pacman -Syu vim
		fi
	fi
	# Install Pathogen
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	if [[ -f /home/$USER/.vimrc ]]; then
		rm ~/.vimrc
	fi
	# Link file
	ln -s ~/.dotfiles/vimrc ~/.vimrc
}

install_flake8_config () {
	### flake8 .config file ###
	if [[ -f /home/$USER/.config/flake8 ]]; then
		rm ~/.config/flake8
	fi
	# Link file
	ln -s ~/.dotfiles/flake8 ~/.config/flake8
}

install_vscodium_config () {
	### VSCodium settings ###
	if [[ -f /home/$USER/.config/VSCodium/User/settings.json ]]; then
		rm ~/.config/VSCodium/User/settings.json
	fi
	ln -s ~/.dotfiles/config/VSCodium/User/settings.json ~/.config/VSCodium/User/settings.json
}

install_all () {
	install_vim
	install_flake8_config
	install_vscodium_config
}

display_help () {
	### Display Help ###
	echo "#################################"
	echo "# RillonDodgers dotfiles script #"
	echo "# install.sh                    #"
	echo "#################################"
	echo "Options:"
	echo "  -a	all"
	echo "  -v	Install vim"
}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
	### If __name__ == '__main__' equivelant ###
	if ! [[ -d $HOME/.dotfiles ]]; then
		echo "directory $HOME/.dotfiles does not exist"
		exit 0
	fi
	while getopts "avh" opt; do
		case $opt in
			a)
				install_all;;
			v)
				install_vim ;;
			h)
				display_help;;
		esac
	done
	shift $(expr $OPTIND - 1)
fi

