#!/bin/sh

git pull origin master
git submodule update --init
cp init/Smyck-Color-Scheme/smyck.vim .vim/colors/smyck.vim

rsync --exclude ".git/" --exclude ".DS_Store" --exclude "bootstrap.sh" \
 --exclude "README.md" --exclude "init/" -avh --no-perms . ~