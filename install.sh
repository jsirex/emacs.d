#!/bin/bash

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

if [ -z $EMACS_SNAPSHOT ]; then
    echo "note: export EMACS_SNAPSHOT=t to install emacs-snapshot"
else
    echo add_emacs_snapshot_repo
    echo ensure_system_package "emacs-snapshot"
fi

ensure_system_package "fonts-firacode"
ensure_system_package "editorconfig"
ensure_system_package "shellcheck"
