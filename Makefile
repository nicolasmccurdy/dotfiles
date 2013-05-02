SHELL     = /bin/bash
HOMESHICK = $(HOME)/.homesick/repos/homeshick/home/.homeshick

update_all: pull symlink update_vim_plugins

check_wget:
	#if ! command -v wget > /dev/null; then
		#echo "Installation failed. Please install wget."
		#popd > /dev/null
		#exit 1
	#fi

uninstall:
	echo "Uninstalling thenickperson/castle..."
	rm -rf ~/.homesick
	rm ~/.homeshick
	echo "Done. You may need to manually delete leftover symlinks."

clone:
	echo "Cloning repository..."
	$(HOMESHICK) clone https://github.com/thenickperson/castle.git

pull:
	echo "Pulling repository..."
	$(HOMESHICK) pull castle

symlink:
	echo "Symlinking config files..."
	$(HOMESHICK) symlink castle

set_up_repos_directory:
	echo "Setting up ~/Repos..."
	if [ ! -d "$(HOME)/Repos" ]; \
	then \
		mkdir $(HOME)/Repos; \
	fi
	ln -s $(HOME)/.homesick/repos/castle $(HOME)/Repos/castle

clean:
	pushd ~/.homesick/repos/castle > /dev/null
	echo "Cleaning repository..."
	git clean -dfx
	pushd > /dev/null

install_homeshick:
	echo "Installing homeshick..."
	git clone git://github.com/andsens/homeshick.git $(HOME)/.homesick/repos/homeshick

use_zsh:
	echo "Switching shell to zsh..."
	sudo chsh --shell /bin/zsh `whoami`

install_vundle:
	echo "Installing vundle..."
	if [ ! -d "$(HOME)/.vim/bundle" ]; \
	then \
		mkdir $(HOME)/.vim/bundle; \
	fi
	if [ ! -d "$(HOME)/.vim/bundle/vundle" ]; \
	then \
		git clone -q https://github.com/gmarik/vundle.git $(HOME)/.vim/bundle/vundle; \
	fi

install_vim_plugins:
	echo "Installing vim plugins..."
	vim +BundleInstall +qall

update_vim_plugins:
	echo "Updating vim plugins..."
	vim +BundleInstall! +qall

install: check_wget install_homeshick clone use_zsh symlink set_up_repos_directory install_vundle install_vim_plugins
	echo "Open a new terminal to start your proper shell."