# dotfiles

These are my dotfiles. They are awesome.

This repo contains my dotfiles which I use at macOS, FreeBSD and Linux systems. This set features a nice and fast zsh config, a neat vim environment and a tmux config.

The workstation realted stuff is mostly tested on macOS. Especially the key bindings may be not portable at the moment.

![Alacritty window using the dotfiles by chrisb86](https://raw.githubusercontent.com/chrisb86/dotfiles/main/screenshot.png)

The zsh prompt is handcrafted to look neat and provide some extra info. When you are root the user- and hostname color changes from blue to red. If you are connected via ssh, the prompt will show some green arrows behind the working path and when you are in a git repository, it will show some git infos at the right side.

The tmux config contains some nice settings to make my work a bit easier and look nice.

My color scheme is the awesome [Nord Color scheme](https://www.nordtheme.com) by Arctic Ice Studio and my font is [~~FiraCode~~](https://github.com/tonsky/FiraCode) [Source Code Pro](https://adobe-fonts.github.io/source-code-pro/).

The repo ships with a Makefile that you can use to deploy and update the dotfiles.

```shell
# make help
help                           This help
all                            Update repo, decrypt secrets and run deploy-macos
install                        Update repor and run deploy-base
deploy-base                    Only deploy basic conf files for shell usage
deploy-workstation             Deploy workstation specific config files (inherits deploy-shell)
deploy-macos                   Deploy macOS specific config files (inherits deploy-workstation)
gen-vscodium-plugin-list       Update the list of VSCodium plugins
git-secrets-hide               Hide secrets with git-secret
git-secrets-reveal             Reveal secrets with git-secret
git-fetch                      Fetch changes from origin
git-push                       Push changes to origin
git-update-submodules          Update all submodules
brew-bundle                    Install applications with brew bundle
brew-bundle-cleanup            Removew all appplications that are not listed in Brewfile
deploy-duti                    Deploy duti config
deploy-htop                    Deploy htop config
deploy-htop-zfs                Deploy htop config with zfs
deploy-tmux                    Deploy tmux config
deploy-vim                     Deploy vim config
deploy-vscodium                Deploy VSCodium config
deploy-youtubedl               Deploy youtube-dl config
deploy-zsh                     Deploy zsh config
deploy-brewfile                Deploy Brewfile
deploy-ssh                     Deploy SSH config
deploy-hushlogin               Deploy .hushlogin
```

The dotfiles will be copied to your **~**.

The repo is initialized for beeing used with git-secret. My own personal secrets are pushed to the repo as well and can be decrypted with my GPG key.

## ZSH with bells and whistles

The ZSH config doesn’t use any frameworks and is tuned for speed.

The config delivers some nice extra functions.

### extract()

_extract_ can be run with _extract <filename>_ to extract archives in any given formats.

It utilizes [zsh_unplugged(]https://github.com/mattmc3/zsh_unplugged) for downloading plugins and the small amount of plugins is carefully picked.

## tmux config

The tmux config rebinds the prefix key to C-a. It features different shortcuts to make my life easier (e.g. "C-a -„ for splitting the window horizontally.)

It also supports nested sessions with a modified color scheme. That’s nice when using tmix.

![Alacritty window using the dotfiles by chrisb86 in a tmix session](https://raw.githubusercontent.com/chrisb86/dotfiles/main/screenshot-tmix.png)

## Installation

## ### Getting the dotfiles.

```shell
git clone https://github.com/chrisb86/dotfiles.git
```

### Deploying the dotfiles

For installing the base set for shell usage run
```shell
make install
```
For the fullfl edged setup with decrypting of the secrets use
```shell
make install
```

To list all avaliable commands run:
```shell
make help
```

## Credits

- [Git prompt by Josh Dick](https://gist.github.com/joshdick/4415470)
