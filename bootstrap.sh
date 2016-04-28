#!/usr/bin/env sh

# bootstrap.sh
# Copyright 2016 Christian Busch
# http://github.com/chrisb86/dotfiles

# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:

# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTI

exclude="README.md|init|Makefile|screenshot.png|.git|.gitignore|.gitmodules|.DS_Store|bootstrap.sh"

bootstrap=`basename -- $0`

# Show help screen
# Usage: help exitcode
help () {
  echo "Usage: $bootstrap command {params}"
  echo
  echo "list 			List all files that will be copied"
  echo "update 			Update the git repo and the included submodules"
  echo "deploy 			Copy the files to ~"
  echo "install 		Update and deploy these dotfiles"
  echo "help 			Show this screen"

  exit $1
}

# Update git repo and submodules
# Usage: df_update
df_update () {
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master
}

# Deploy files to ~
# Usage: df_deploy
df_deploy () {
	# poor man's rsync
	df_list | cpio -pdmB --quiet ~
}

# List files that will be copied
# Usage: df_list
df_list () {
	find . -print | grep -vE "$exclude"
}

case "$1" in
######################## bootstrap.sh HELP ########################
help)
	help 0
  ;;
######################## bootstrap.sh LIST ########################
list)
	## Lists all files in repo, except those specified in $exclude"
	df_list
  ;;
######################## bootstrap.sh DEPLOY ########################
deploy)
	echo "#### Copying files to ~"

	# Copy color vim scheme from init folder to .vim/colors
	cp init/Smyck-Color-Scheme/smyck.vim .vim/colors/smyck.vim
	
	df_deploy
  ;;
######################## bootstrap.sh UPDATE ########################
update)
	echo "#### Updating git repos and submodules"
	df_update
  ;;
######################## bootstrap.sh INSTALL ########################
install)
	echo "#### Updating git repos and submodules"
	df_update
	
	echo "#### Copying files to ~"
	df_deploy
  ;;
 *)
	help 1
  ;;
esac