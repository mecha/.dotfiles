#! /bin/env bash

if [ -z "$GIT_NAME" ] || [ -z "$GIT_EMAIL" ]; then
    echo "The \$GIT_NAME or \$GIT_EMAIL environment variables are not set."
    echo
    echo "GIT_NAME = $GIT_NAME"
    echo "GIT_EMAIL = $GIT_EMAIL"
    echo
    echo "Add these vars to ~/.env and re-run the script."
    exit 1
fi

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global core.autocrlf
git config --global pull.rebase false
git config --global remote.origin.receivepack "git receive-pack"

git config --global gpg.format ssh
git config --global commit.gpgsign true
git config --global tag.gpgsign true
git config --global user.signingkey ~/.ssh/id_rsa.pub
