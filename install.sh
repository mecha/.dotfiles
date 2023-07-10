#! /bin/env bash

STOW_DIR=$HOME

dirs=$(find . -mindepth 1 -maxdepth 1 -type d -not -path '*/.git' -exec basename {} \;)

# usage function
usage() {
    echo "Usage: ./install.sh [-u]"
    echo "  Run with no arguments to stow all directories"
    echo ""
    echo "Arguments:"
    echo "  -u: uninstall"
    exit 1
}

# See => https://github.com/aspiers/stow/issues/65#issuecomment-1465060710
stow_quietly() {
	stow "$@" 2> >(grep -v 'BUG in find_stowed_path? Absolute/relative mismatch' 1>&2)
}

# check if help arg given
if [[ $# -eq 1 && $1 == "-h" ]]; then
    usage
fi

if [[ $# -eq 0 ]]; then
    for dir in $dirs
    do
        echo "Stowing $dir"
        stow_quietly -R $dir
    done
    exit 0
fi

# check if uninstall arg given
if [[ $# -eq 1 && $1 == "-u" ]]; then
    for dir in $dirs
    do
        echo "Unstowing $dir"
        stow_quietly -D $dir
    done
    exit 0
fi

echo "Invalid arguments given"
usage
