SHELL = /bin/sh
HOMEDIR = ${HOME}
UNAME_S = $(shell uname -s)

ifeq ($(UNAME_S),Darwin)
VSCODE_USER_DIR = ${HOMEDIR}/Library/Application Support/Code/User
else
VSCODE_USER_DIR = ${HOMEDIR}/.config/Code/User
endif


.PHONY: help all


.DEFAULT_GOAL := help

# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[1;1;36m%-30s\033[1;0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

all: git-fetch deploy-macos ## Update repo and run deploy-macos

install: git-fetch deploy-base ## Update repor and run deploy-base

deploy-base: deploy-eza deploy-tmux deploy-vim deploy-zsh deploy-ssh deploy-hushlogin deploy-git deploy-htop ## Only deploy basic conf files for shell usage

deploy-workstation: deploy-base deploy-vscode deploy-ghostty ## Deploy workstation specific config files (inherits deploy-shell)

deploy-macos: deploy-workstation deploy-brewfile deploy-aerospace deploy-karabiner ## Deploy macOS specific config files (inherits deploy-workstation)

gen-vscode-extension-list: ## Update the list of VSCode extensions
	@echo "\033[1;32m>>>\033[1;0m Updating the list of VSCode extensions at .config/Code/User/extensions.list"
	@code --list-extensions > .config/Code/User/extensions.list

git-fetch: ## Fetch changes from origin
	@echo "\033[1;32m>>>\033[1;0m Fetching changes from origin."
	@git fetch origin main

git-push: ## Push changes to origin
	@echo "\033[1;32m>>>\033[1;0m Pushing changes to origin."
	@git push origin main

git-update-submodules: ## Update all submodules
	@echo "\033[1;32m>>>\033[1;0m Updating git submodules."
	@git submodule update --init --recursive && \
	git submodule foreach git pull --recurse-submodules origin

brew-bundle: ## Install applications with brew bundle
	@echo "\033[1;32m>>>\033[1;0m\033[1;0m Installing applications from .config/Brewfile" 
	@brew bundle --file .config/Brewfile --force || true

brew-bundle-cleanup: ## Removew all appplications that are not listed in Brewfile
	@echo "\033[1;32m>>>\033[1;0m Removing applications that are not listed in .config/Brewfile"
	@brew bundle cleanup --zap --force --file .config/Brewfile

deploy-eza: ## Deploy eza config
	@echo "\033[1;32m>>>\033[1;0m Deploy eza config to ${HOMEDIR}/.config/eza"
	@mkdir -p ${HOMEDIR}/.config/eza
	@cp .config/eza/* ${HOMEDIR}/.config/eza

deploy-htop: ## Deploy htop config
	@echo "\033[1;32m>>>\033[1;0m Deploy htop config to ${HOMEDIR}/.config/htop"
	@mkdir -p ${HOMEDIR}/.config/htop
	@cp .config/htop/htoprc ${HOMEDIR}/.config/htop/htoprc

deploy-tmux: ## Deploy tmux config
	@echo "\033[1;32m>>>\033[1;0m Deploy tmux config to ${HOMEDIR}/.config/tmux"
	@mkdir -p ${HOMEDIR}/.config/tmux
	@cp .config/tmux/*.conf ${HOMEDIR}/.config/tmux
	@cp .config/tmux/*.sh ${HOMEDIR}/.config/tmux
	@chmod +x ${HOMEDIR}/.config/tmux/*.sh

deploy-vim: ## Deploy vim config
	@echo "\033[1;32m>>>\033[1;0m Deploy vim config to ${HOMEDIR}/.config/vim"
	@mkdir -p ${HOMEDIR}/.config/vim
	@mkdir -p ${HOMEDIR}/.config/vim/autoload
	@mkdir -p ${HOMEDIR}/.config/vim/backup
	@mkdir -p ${HOMEDIR}/.config/vim/colors
	@mkdir -p ${HOMEDIR}/.config/vim/plugged
	@mkdir -p ${HOMEDIR}/.config/vim/swap
	@mkdir -p ${HOMEDIR}/.config/vim/undo
	@cp .config/vim/vimrc ${HOMEDIR}/.config/vim

deploy-vscode: ## Deploy VSCode config
	@echo "\033[1;32m>>>\033[1;0m Deploy VSCode config to ${VSCODE_USER_DIR}"
	@mkdir -p "${VSCODE_USER_DIR}"
	@cp .config/Code/User/*.json "${VSCODE_USER_DIR}"
	
	@echo "\033[1;32m>>>\033[1;0m Install VSCode extensions from .config/Code/User/extensions.list"
	@cat .config/Code/User/extensions.list | xargs -L 1 code --install-extension

deploy-aerospace: ## Deploy Aerospace config
	@echo "\033[1;32m>>>\033[1;0m Deploy Aerospace config to ${HOMEDIR}/.config/aerospace"
	@mkdir -p ${HOMEDIR}/.config/aerospace
	@cp .config/aerospace/aerospace.toml ${HOMEDIR}/.config/aerospace

deploy-ghostty: ## Deploy Ghostty config
	@echo "\033[1;32m>>>\033[1;0m Deploy Ghostty config to ${HOMEDIR}/.config/ghostty"
	@mkdir -p ${HOMEDIR}/.config/ghostty
	@cp .config/ghostty/config ${HOMEDIR}/.config/ghostty

deploy-git: ## Deploy Git config
	@echo "\033[1;32m>>>\033[1;0m Deploy Git config to ${HOMEDIR}/.config/git"
	@mkdir -p ${HOMEDIR}/.config/git
	@cp .config/git/config ${HOMEDIR}/.config/git

deploy-karabiner: ## Deploy Karabiner config
	@echo "\033[1;32m>>>\033[1;0m Deploy Karabiner config to ${HOMEDIR}/.config/karabiner"
	@mkdir -p ${HOMEDIR}/.config/karabiner/scripts
	@cp .config/karabiner/karabiner.json ${HOMEDIR}/.config/karabiner
	@cp .config/karabiner/scripts/*.scpt ${HOMEDIR}/.config/karabiner/scripts

deploy-zsh: ## Deploy zsh config
	@echo "\033[1;32m>>>\033[1;0m Deploy zsh config to ${HOMEDIR}/.config/zsh"
	@mkdir -p ${HOMEDIR}/.config/zsh
	@mkdir -p ${HOMEDIR}/.config/zsh/autoload
	@mkdir -p ${HOMEDIR}/.config/zsh/conf.d
	@cp .zshenv ${HOMEDIR}/
	@cp .config/zsh/.z* ${HOMEDIR}/.config/zsh
	@cp .config/zsh/autoload/* ${HOMEDIR}/.config/zsh/autoload
	@cp .config/zsh/conf.d/*.zsh ${HOMEDIR}/.config/zsh/conf.d

deploy-brewfile: ## Deploy Brewfile
	@echo "\033[1;32m>>>\033[1;0m Deploy Brewfile to ${HOMEDIR}/.config/"
	@mkdir -p ${HOMEDIR}/.config
	@cp .config/Brewfile ${HOMEDIR}/.config/

deploy-ssh: ## Deploy SSH config
	@echo "\033[1;32m>>>\033[1;0m Deploy SSH config to ${HOMEDIR}/.ssh"
	@mkdir -p ${HOMEDIR}/.ssh/master
	@mkdir -p ${HOMEDIR}/.ssh/conf.d
	@cp .ssh/config ${HOMEDIR}/.ssh/
	-@cp .ssh/conf.d/* ${HOMEDIR}/.ssh/conf.d

deploy-hushlogin: ## Deploy .hushlogin
	@echo "\033[1;32m>>>\033[1;0m Deploy .hushlogin to ${HOMEDIR}"
	@cp .hushlogin ${HOMEDIR}/
