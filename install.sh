#!/usr/bin/env bash

set -e


DOTFILES="$(pwd)"
EXCLUDE_FILES=("install.sh" "install.local.sh" "README" ".git" ".gitignore" "Brewfile")


files() { entries "$1" "-type f"; }
directories() { entries "$1" "-type d"; }

entries() {
    EXCLUDE_FILES+=("$(basename $1)")
    local exclude=$(printf " ! -name %s" "${EXCLUDE_FILES[@]}")
    find "$1" -maxdepth 1 $2 $exclude
}



backup() {
    echo -e "\n\nBACKUP EXISTING FILES\n"
    local BACKUP_DIR=$HOME/.dotfiles_backup

    echo "Creating backup directory at $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"

    echo "Backing up files..."
    for file in $(files "$DOTFILES"); do
        backup_entry "$file"
    done

    echo -e "\nBacking up directories..."
    for directory in $(directories "$DOTFILES"); do
        local directoryname="$(basename "$directory")"

        for entry in $(entries "$directory"); do
            backup_entry "$entry" "$directoryname"
        done
    done
}

backup_entry() {
    filename="$(basename "$1")"
    target="$HOME/$2/$filename"

    if [ -L "$target" ]; then
        return 
    elif [ -f "$target" ]; then
        cp "$target" "$BACKUP_DIR/$2"
    elif [ -d "$target" ]; then
        cp -r "$target" "$BACKUP_DIR/$2"
    fi
}


link() {
    echo -e "\n\nCREATE SYMLINKS\n"

    echo "Creating symlinks for files..."
    for file in $(files "$DOTFILES"); do
        link_entry "$file"
    done

    echo -e "\nCreating symlinks for first-level entries in directories..."
    for directory in $(directories "$DOTFILES"); do
        local directoryname="$(basename "$directory")"
        mkdir -p "$HOME/$directoryname"

        for entry in $(entries "$directory"); do
            link_entry "$entry" "$directoryname"
        done
    done
}

link_entry() {
    filename="$(basename "$1")"
    target="$HOME/$2/$filename"

    rm -f "$target"
    echo "$2/$filename"
    ln -s "$1" "$target"
}


dependencies() {
    echo -e "\n\nINSTALL DEPENDENCIES\n"
    return
    if test ! "$(command -v brew)"; then
        echo "Homebrew not installed. Installing..."

        # Run as a login shell (non-interactive) so that the script doesn't pause for user input
        sudo apt-get install build-essential
        NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
        echo "eval \"\$($(brew --prefix)/bin/brew shellenv)\"" >> ~/.bashrc
    fi

    brew bundle
}


install_local() {
    echo -e "\n\nEXECUTE LOCAL SCRIPT\n"
    [ -f "./install.local.sh" ] && bash ./install.local.sh
}



case "$1" in
    backup) backup;;
    link) link;;
    deps) dependencies;;
    local) install_local;;
    *) backup && link && dependencies && install_local;;
esac

echo -e "\nDone!\n"
