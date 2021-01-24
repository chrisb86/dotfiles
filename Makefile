SHELL = /bin/sh
HOMEDIR = ${HOME}


.PHONY: help all


.DEFAULT_GOAL := help

# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
help: ## This help
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[1;1;36m%-30s\033[1;0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

all: git-fetch git-secrets-reveal deploy-macos ## Update repo, decrypt secrets and run deploy-macos

install: git-fetch deploy-base ## Update repor and run deploy-base

deploy-base: deploy-htop deploy-tmux deploy-vim deploy-zsh deploy-ssh deploy-hushlogin ## Only deploy basic conf files for shell usage

deploy-workstation: deploy-base deploy-alacritty deploy-espanso deploy-vscodium deploy-youtubedl ## Deploy workstation specific config files (inherits deploy-shell)

deploy-macos: deploy-workstation deploy-bitbar deploy-duti deploy-skhd deploy-yabai deploy-brewfile ## Deploy macOS specific config files (inherits deploy-workstation)

gen-vscodium-plugin-list: ## Update the list of VSCodium plugins
	@echo "\033[1;32m>>>\033[1;0m Updating the list of VSCodium plugins at .config/VSCodium/UserUser/extensions.list"
	@code --list-extensions > .config/VSCodium/UserUser/extensions.list

git-secrets-hide: ## Hide secrets with git-secret
	@echo "\033[1;32m>>>\033[1;0m Encrypting secrets."
	@git secret hide
	@echo "\033[1;32m>>>\033[1;0m Creating commit."
	@git add -A && git commit -m "Updated secrets."

git-secrets-reveal: ## Reveal secrets with git-secret
	@echo "\033[1;32m>>>\033[1;0m Decrypting secrets."
	@git secret reveal
	@echo "\033[1;32m>>>\033[1;0m Remove encrypted files."
	@git secret clean

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
	@brew bundle --file .config/Brewfile || true

brew-bundle-cleanup: ## Removew all appplications that are not listed in Brewfile
	@echo "\033[1;32m>>>\033[1;0m Removing applications that are not listed in .config/Brewfile"
	@brew bundle cleanup --zap --force --file .config/Brewfile

deploy-alacritty: ## Deploy alacritty config
	@echo "\033[1;32m>>>\033[1;0m Deploy alacritty config to ${HOMEDIR}/.config/alacritty"
	@mkdir -p ~/.config/alacritty
	@cp .config/alacritty/* ${HOMEDIR}/.config/alacritty

deploy-bitbar: ## Deploy BitBar config
	@echo "\033[1;32m>>>\033[1;0m Deploy BitBar config to ${HOMEDIR}/.config/BitBar"
	@mkdir -p ${HOMEDIR}/.config/BitBar
	@cp .config/BitBar/* ${HOMEDIR}/.config/BitBar
	@echo "\033[1;32m>>>\033[1;0m Setting BitBar plugin directory to ${HOMEDIR}/.config/BitBar/Enabled"
	@defaults write com.matryer.BitBar pluginsDirectory "${HOMEDIR}/.config/BitBar/Enabled"
	@echo "\033[1;32m>>>\033[1;0m Enabeling BitBar plugins"
	@mkdir -p ${HOMEDIR}/.config/BitBar/Enabled
	@ln -sf ${HOMEDIR}/.config/BitBar/*.sh ${HOMEDIR}/.config/BitBar/Enabled

deploy-duti: ## Deploy duti config
	@echo "\033[1;32m>>>\033[1;0m Deploy duti config to ${HOMEDIR}/.config/duti"
	@mkdir -p ${HOMEDIR}/.config/duti
	@cp .config/duti/* ${HOMEDIR}/.config/duti
	@echo "\033[1;32m>>>\033[1;0m Processing duti config from ${HOMEDIR}/.config/duti"
	@duti ${HOMEDIR}/.config/duti

deploy-espanso: ## Deploy espanso config
	@echo "\033[1;32m>>>\033[1;0m Deploy espanso config to ${HOMEDIR}/.config/espanso"
	@mkdir -p ${HOMEDIR}/.config/espanso/user
	@cp .config/espanso/*.yml ${HOMEDIR}/.config/espanso
	-@cp .config/espanso/user/*.yml ${HOMEDIR}/.config/espanso/user
	@echo "\033[1;32m>>>\033[1;0m Enabeling espanso daemon"
	@espanso register

deploy-htop: ## Deploy htop config
	@echo "\033[1;32m>>>\033[1;0m Deploy htop config to ${HOMEDIR}/.config/htop"
	@mkdir -p ${HOMEDIR}/.config/htop
	@cp .config/htop/htoprc ${HOMEDIR}/.config/htop

deploy-skhd: ## Deploy skhd config
	@echo "\033[1;32m>>>\033[1;0m Deploy skhd config to ${HOMEDIR}/.config/skhd"
	@mkdir -p ${HOMEDIR}/.config/skhd
	@cp .config/skhd/skhdrc ${HOMEDIR}/.config/skhd
	@echo "\033[1;32m>>>\033[1;0m Enabeling skhd daemon"
	@brew services start skhd

deploy-tmux: ## Deploy tmux config
	@echo "\033[1;32m>>>\033[1;0m Deploy tmux config to ${HOMEDIR}/.config/tmux"
	@mkdir -p ${HOMEDIR}/.config/tmux
	@cp .config/tmux/*.conf ${HOMEDIR}/.config/tmux

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

deploy-vscodium: ## Deploy VSCodium config
	@echo "\033[1;32m>>>\033[1;0m Deploy VSCodium config to ${HOMEDIR}/.config/VSCodium/User"
	@mkdir -p ${HOMEDIR}/.config/VSCodium/User
	@cp .config/VSCodium/User/*.json ${HOMEDIR}/.config/VSCodium/User
	
	@echo "\033[1;32m>>>\033[1;0m Install VSCodium extensions from ${HOMEDIR}/.config/VSCodium/User/extensions.list"
	@cat .config/VSCodium/User/extensions.list | xargs -L 1 code --install-extension

deploy-yabai: ## Deploy yabai config
	@echo "\033[1;32m>>>\033[1;0m Deploy yabai config to ${HOMEDIR}/.config/yabai"
	@mkdir -p ${HOMEDIR}/.config/yabai
	@cp .config/yabai/yabairc ${HOMEDIR}/.config/yabai
	@echo "\033[1;32m>>>\033[1;0m Enabeling yabai daemon"
	@brew services start yabai

deploy-youtubedl: ## Deploy youtube-dl config
	@echo "\033[1;32m>>>\033[1;0m Deploy youtube-dl config to ${HOMEDIR}/.config/youtube-dl"
	@mkdir -p ${HOMEDIR}/.config/youtube-dl
	@cp .config/youtube-dl/config ${HOMEDIR}/.config/youtube-dl

deploy-zsh: ## Deploy zsh config
	@echo "\033[1;32m>>>\033[1;0m Deploy zsh config to ${HOMEDIR}/.config/zsh"
	@mkdir -p ${HOMEDIR}/.config/zsh
	@mkdir -p ${HOMEDIR}/.config/zsh/functions
	@mkdir -p ${HOMEDIR}/.config/zsh/lib
	@cp .zshenv ${HOMEDIR}/
	@cp .config/zsh/.z* ${HOMEDIR}/.config/zsh
	@cp .config/zsh/functions/* ${HOMEDIR}/.config/zsh/functions
	@cp .config/zsh/lib/*.zsh ${HOMEDIR}/.config/zsh/lib

deploy-brewfile: ## Deploy Brewfile
	@echo "\033[1;32m>>>\033[1;0m Deploy Brewfile to ${HOMEDIR}/.config/"
	@mkdir -p ${HOMEDIR}/.config
	@cp .config/Brewfile ${HOMEDIR}/.config/

deploy-ssh: ## Deploy SSH config
	@echo "\033[1;32m>>>\033[1;0m Deploy SSH config to ${HOMEDIR}/.ssh"
	@mkdir -p ${HOMEDIR}/.ssh/master
	@mkdir -p ${HOMEDIR}/.ssh/conf.d
	@cp .ssh/config ${HOMEDIR}/.ssh/
	-@cp .ssh/conf.d/*.conf ${HOMEDIR}/.ssh/conf.d

deploy-hushlogin: ## Deploy .hushlogin
	@echo "\033[1;32m>>>\033[1;0m Deploy .hushlogin to ${HOMEDIR}"
	@cp .hushlogin ${HOMEDIR}/