#!/bin/bash

# Environments
cat >> ~/.bashrc << EOF
export PS1="\[$(tput setaf 1)\]\u@\h:\[$(tput setaf 7)\]\W\\$ \[$(tput sgr0)\]"
alias gr='grep -Hirn'
alias grw='grep -Hirnw'
export TERM="xterm-256color"
source ~/.git-completion.bash
EOF

# Packages
install_deps=(
	bash-completion
	cmake
	git
	htop
	net-tools
	clang
	clang-format
	tree
	vim
	universal-ctags
	cscope
)
sudo apt update
sudo apt install ${install_deps[*]}

# Download jellybeans color scheme
if [ ! -f "${HOME}/.vim/colors/jellybeans.vim" ]; then
  mkdir -p ~/.vim/colors
  curl https://raw.githubusercontent.com/nanotech/jellybeans.vim/master/colors/jellybeans.vim \
    -o ~/.vim/colors/jellybeans.vim
fi

# Git command autocompletion
if [ ! -f "${HOME}/.git-completion.bash" ]; then
  curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.bash \
    -o ~/.git-completion.bash
fi

# Install configuration files
cp vimrc ~/.vimrc
cp tmux.conf ~/.tmux.conf
cp gitconfig ~/.gitconfig
sudo chmod 775 mkcscope && sudo cp mkcscope /usr/local/bin
if [ ! -d "${HOME}/.vim/plugin" ]; then
  mkdir -p ~/.vim/plugin
fi
cp cscope_maps.vim ~/.vim/plugin

if [ ! -d "${HOME}/.vim/bundle" ]; then
  mkdir -p ~/.vim/bundle
fi

if [ ! -d "${HOME}/.vim/bundle/Vundle.vim" ]; then
  git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

vim -c PluginInstall -c q -c q

source ~/.bashrc
