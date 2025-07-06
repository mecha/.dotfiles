#! /bin/env bash

git config --global user.name "Miguel Muscat"
git config --global user.email "mail@miguelmuscat.me"
git config --global core.autocrlf
git config --global pull.rebase false
git config --global remote.origin.receivepack "git receive-pack"

git config --global gpg.format ssh
git config --global commit.gpgsign true
git config --global tag.gpgsign true
git config --global user.signingkey ~/.ssh/id_rsa.pub
