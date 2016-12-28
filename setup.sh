#!/bin/sh

current_path=$(pwd)
REPLACE_FILES=true

command_exists() {
  type "$1" &>/dev/null
}

#-----------------------------------------------------
# Basic requirements check
#-----------------------------------------------------

brew update

if ! command_exists brew; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

if ! command_exists curl; then
  brew install curl
fi

if ! command_exists git; then
  brew install git
fi

if ! command_exists python3; then
  brew install python3
fi

if ! command_exists neovim; then
  pip3 install neovim
fi

if ! command_exists reattach-to-user-namespace; then
  brew install reattach-to-user-namespace
fi

if ! command_exists gitsh; then
  brew tap thoughtbot/formulae
  brew install gitsh
fi

#-----------------------------------------------------
# ZSH installation
#-----------------------------------------------------
echo "[ zshrc ]"

if [ ! -f ~/.zshrc ]; then
  echo "    Creating zshrc"
  ln -sf $current_path/zsh/zshrc ~/.zshrc
elif $REPLACE_FILES; then
  echo "    Deleting old zshrc"
  rm ~/.zshrc
  ln -sf $current_path/zsh/zshrc ~/.zshrc
else
  echo "    Keeping existing zshrc"
fi

echo "[ oh-my-zsh ]"

if command_exists zsh; then
  if [ ! -d ~/.oh-my-zsh ]; then
    echo "    Installing Oh my zsh"
    install_oh_my_zsh
  else
    echo "    Using existing Oh my zsh"
  fi
else
  echo "    Installing ZSH."
  brew install zsh
  install_oh_my_zsh
fi

#-----------------------------------------------------
# Git (config, ignore)
#-----------------------------------------------------
echo "[ gitconfig ]"

if [ ! -f ~/.gitconfig ]; then
  echo "    Creating gitconfig"
  ln -sf $current_path/git/config ~/.gitconfig
elif $REPLACE_FILES; then
  echo "    Deleting old gitconfig"
  rm ~/.gitconfig
  ln -sf $current_path/git/config ~/.gitconfig
else
  echo "    Keeping existing gitconfig"
fi

echo "[ gitignore global ]"

if [ ! -f ~/.gitignore_global ]; then
  echo "    Creating gitignore global"
  ln -sf $current_path/git/gitignore_global ~/.gitignore_global
elif $REPLACE_FILES; then
  echo "    Deleting old gitignore global"
  rm ~/.gitignore_global
  ln -sf $current_path/git/gitignore_global ~/.gitignore_global
else
  echo "    Keeping existing gitignore global"
fi

#-----------------------------------------------------
# Neovim
#-----------------------------------------------------
echo "[ Neovim ]"

if ! command_exists nvim; then
  echo "    Installing Neovim"
  brew install neovim/neovim/neovim
else
  echo "    Installed"
fi

if [ ! -d ~/.config/nvim ]; then
  echo "    Creating nvim config"

  if [ ! -d ~/.config ]; then
    mkdir -p ~/.config
  fi

  ln -sf $current_path/nvim ~/.config/nvim
elif $REPLACE_FILES; then
  echo "    Replace existing nvim config"
  rm -rf ~/.config/nvim
  ln -sf $current_path/nvim ~/.config/nvim
else
  echo "    Using existing nvim config"
fi

#-----------------------------------------------------
# Installing tmux
#-----------------------------------------------------
echo "[ tmux ]"

if ! command_exists tmux; then
  echo "    Installing tmux"
  brew install tmux
else
  echo "    Installed"
fi

if [ ! -f ~/.tmux.conf ]; then
  echo "    Creating tmux.conf"
  ln -sf $current_path/tmux/config ~/.tmux.conf
elif $REPLACE_FILES; then
  echo "    Deleting old tmux.conf"
  rm ~/.tmux.conf
  ln -sf $current_path/tmux/config ~/.tmux.conf
else
  echo "    Keeping existing tmux.conf"
fi

#-----------------------------------------------------
# Installing linters
#-----------------------------------------------------
echo "[ Rubocop ]"

if command_exists rubocop; then
  echo "   Rubocop Installed"
  ln -sf $current_path/codestyles/ruby-style.yml ~/.rubocop.yml
else
  echo "   Installing rubocop"
  gem install rubocop
  ln -sf $current_path/codestyles/ruby-style.yml ~/.rubocop.yml
fi

echo "[ JSHint ]"

if command_exists jshint; then
  echo "   JSHint Installed"
  ln -sf $current_path/codestyles/javascript-style.json ~/.jshintrc
else
  echo "   Installing JSHint"
	sudo npm -g install jshint
  ln -sf $current_path/codestyles/javascript-style.json ~/.jshintrc
fi

echo "[ SCSS Lint ]"

if command_exists scss-lint; then
  echo "   SCSS Lint Installed"
  ln -sf $current_path/codestyles/scss-style.json ~/.scss-lint.yml
else
  echo "   Installing SCSS Lint"
  gem install scss-lint
  ln -sf $current_path/codestyles/scss-style.json ~/.scss-lint.yml
fi

echo "[ ES Lint ]"

if command_exists eslint; then
  echo "   ES Lint Installed"
  ln -sf $current_path/codestyles/eslintrc ~/.eslintrc
else
  echo "   Installing ES Lint"
  npm install -g eslint
  npm install -g babel-eslint
  npm install -g eslint-plugin-react

  # If you're using older Node version
  # To handle `SyntaxError: Use of const in strict mode.` error

  # sudo npm cache clean -f
  # sudo npm install -g n
  # sudo n stable

  ln -sf $current_path/codestyles/eslintrc ~/.eslintrc
fi
#-----------------------------------------------------
# Installing FZF
#-----------------------------------------------------
echo "[ FZF ]"

if command_exists fzf; then
  echo "   FZF Installed"
else
  echo "   Installing FZF"
  brew install fzf
  /usr/local/opt/fzf/install
fi

echo ""
echo "Setup Completed"
