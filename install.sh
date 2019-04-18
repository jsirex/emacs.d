#!/usr/bin/bash

SUDO=${SUDO:-sudo}
EMACS_DIR=$(cd $(dirname $0); pwd)

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

install_emacs_snapshot() {
    ensure_system_package "emacs-snapshot"
}

install_fira_code_font() {
    local font_package="fonts-firacode"
    local font_source="$(realpath $EMACS_DIR/fonts/firacode/FiraCode-Regular-Symbol.otf)"
    local font_local="$(realpath ~/.local)/share/fonts/FiraCode-Regular-Symbol.otf"

    ensure_system_package $font_package

    if [ -f $font_local ]; then
	echo "Patched font 'Fira Code Regular Symbol' has been already installed."
    else
	echo "Copying locally patched 'Fira Code Regular Symbol' to $font_local"
	cp $font_source $font_local
    fi
}

install_editorconfig() {
    ensure_system_package "editorconfig"
}

install_shellcheck() {
    ensure_system_package "shellcheck"
}

install_multimarkdown() {
    echo "multimarkdown provided by libtext-markup-perl package"
    ensure_system_package "libtext-markup-perl"
}

add_emacs_snapshot_repo
install_emacs_snapshot
install_fira_code_font
install_editorconfig
install_shellcheck
install_multimarkdown
