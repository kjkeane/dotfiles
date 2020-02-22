#!/usr/bin/env bash

# Create new folder in ~/.vim/pack that contains a start folder and cd into it
#
# Arugments:
#   package_group, a string folder name to create and change into.
#
# Examples:
#   set_group synta-highlighting
#
function create_plugin_dir() {
  path="$HOME/.vim/pack/plugins/start"
  mkdir -p "$path"
}

# Clone or update a git repo in the current directory
#
# Arguments:
#   repo_url, a URL to the git repo.
#
# Examples:
#   package https://github.com/saltstack/salt-vim.git
#
function install_plugin() {
  repo_url=$1
  plugin_name=$(basename "$repo_url" .git)
  if [ -d "$plugin_name" ];
  then
    cd "$HOME/.vim/pack/$plugin_name" || exit
    results=$(git pull --force)
    echo "$plugin_name: $result"
  else
    echo "$plugin_name: Installing..."
    git clone -q "$repo_url" $HOME/.vim/pack/plugins/start/$plugin_name
  fi
}

(
create_plugin_dir
install_plugin https://github.com/saltstack/salt-vim.git
)
