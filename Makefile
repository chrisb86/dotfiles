EXCLUDE		:= .DS_Store .git .gitmodules .gitignore
DOTFILES 	:= $(filter-out $(EXCLUDE), $(wildcard .??*))

all: install

help:
	@echo "make list           #=> Show dot files in this repo"
	@echo "make deploy         #=> Create symlink to home directory"
	@echo "make update         #=> Fetch changes for this repo"
	@echo "make install        #=> Run make update, deploy, init"

list:
	@$(foreach val, $(DOTFILES), /bin/ls -dF $(val);)

deploy:
	@echo '==> Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

update:
	git pull origin master
	git submodule init
	git submodule update
	git submodule foreach git pull origin master

install: update deploy
	@exec $$SHELL