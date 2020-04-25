#!/bin/bash

SUDO=${SUDO:-sudo}
EMACS_DIR=$(cd $(dirname $0); pwd)
EMACS_CACHE_DIR="$EMACS_DIR/.cache"

if [ "$(whoami)" == "root" ]; then
    SUDO=""
    echo "Installing for user root"
fi

add_emacs_snapshot_repo() {
    local emacs_list="/etc/apt/sources.list.d/emacs-snapshot.list"

    if [ -f $emacs_list ]; then
        echo "Emacs repository has been already added."
    else
        echo "Adding emacs snapshot repo: $emacs_list ..."
        cat << EOF | $SUDO tee $emacs_list > /dev/null
deb     [arch=amd64] http://emacs.secretsauce.net unstable main
deb-src [arch=amd64] http://emacs.secretsauce.net unstable main
EOF
        $SUDO apt-get update
    fi
}

package_installed() {
    dpkg -s $1 2>&1 | grep "Status: install ok installed" > /dev/null
}

ensure_system_package() {
    local package=$1

    if package_installed $package; then
        echo "Package $package has been already installed."
    else
        echo "Installing package $package ..."
        $SUDO apt-get -q -y install $package
    fi
}

install_fira_code_nerd_font() {
    local fira_code_nerd_version="v2.1.0"
    local fira_code_nerd_source="https://github.com/ryanoasis/nerd-fonts/releases/download/${fira_code_nerd_version}/FiraCode.zip"
    local fira_code_nerd_filename="$EMACS_CACHE_DIR/FiraCode-${fira_code_nerd_version}.zip"
    local local_fonts_dir=~/.local/share/fonts/

    if [[ -f "$fira_code_nerd_filename" ]]; then
        echo "Using cached font archive: $fira_code_nerd_filename"
    else
        wget -c "$fira_code_nerd_source" -O "$fira_code_nerd_filename"
    fi

    unzip -o -u -d "$local_fonts_dir" "$fira_code_nerd_filename"
    fc-cache "$local_fonts_dir"
}

mkdir -p "$EMACS_CACHE_DIR"

# Install Fira Code Nerd Font
install_fira_code_nerd_font

add_emacs_snapshot_repo

ensure_system_package "emacs-snapshot"
ensure_system_package "editorconfig"
ensure_system_package "shellcheck"
