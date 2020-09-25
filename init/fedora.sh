#!/bin/sh

# Hostname that should be set
HOST="martha"

# dnf packages that should be installed
FEDORA_PKG="zsh rsync tmux mosh htop hugo gnome-tweaks firefox thunderbird elementary-planner codium newsflash calibre adobe-source-code-pro-fonts fira-code-fonts zeal sequeler gitg deja-dup deja-dup-nautilus vim-enhanced marker ImageMagick nodejs npm util-linux-user nextcloud-client nextcloud-client-nautilus gnome-extensions-app papirus-icon-theme libreoffice-icon-theme-papirus vlc libappindicator libappindicator-gtk3 broadcom-wl portfolio-performance"

FEDORA_FLAT="com.spotify.client girens noson"

FEDORA_PIP="gnome-extensions-cli"

FEDORA_COPR="lray/PortfolioPerformance"

GNOME_SHELL_EXTENSIONS="appindicatorsupport@rgcjonas.gmail.com auto-move-windows@gnome-shell-extensions.gcampax.github.com blyr@yozoon.dev.gmail.com caffeine@patapon.info dash-to-dock@micxgx.gmail.com Hide_Activities@shay.shayel.org Move_Clock@rmy.pobox.com native-window-placement@gnome-shell-extensions.gcampax.github.com netspeed@hedayaty.gmail.com nightthemeswitcher@romainvigier.fr panel-osd@berend.de.schouwer.gmail.com remove-dropdown-arrows@mpdeimos.com status-area-horizontal-spacing@mathematical.coffee.gmail.com steal-my-focus@kagesenshi.org user-theme@gnome-shell-extensions.gcampax.github.com"

# NPM packes that should be installed
NPM_PKG="nativefier typescript"

# Which App to use at default etxt editor (instead of gEdit)
DEFAULT_EDITOR="codium.desktop"
DEFAULT_EDITOR_FILETYPES="public.plain-text public.unix-executable public.data .zsh)"

## Get username
USER=`whoami`

## Ask for the administrator password upfront
sudo -v

## Set hostname
echo ">>> Setting hostname"
sudo hostnamectl set-hostname ${HOST}

echo ">>> Adding repos"
## Add  RPM Fusion repos
sudo dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

## Add VSCodium repo
sudo rpm --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg 
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=gitlab.com_paulcarroty_vscodium_repo\nbaseurl=https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg" |sudo tee -a /etc/yum.repos.d/vscodium.repo

## Add copr repos
echo ">>> Adding copr repos"
if [ ! -z "${FEDORA_COPR}" ]; then
  for copr in ${FEDORA_COPR}; do
    sudo dnf copr enable ${copr} -y
  done
fi

## Add flatpak repos
echo ">>> Adding flatpak repos"
sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

## Update repos
echo ">>> Updating repos"
sudo dnf upgrade -y

## Update installed flatpaks
echo ">>> Updating flatpaks"
flatpak update

## Install packages
if [ ! -z "${FEDORA_PKG}" ]; then
  echo ">>> Installing packages"
  sudo dnf install ${FEDORA_PKG} -y
fi

## Install flatpaks
if [ ! -z "${FEDORA_FLAT}" ]; then
  echo ">>> Installing flatpaks"
  flatpak install ${FEDORA_FLAT} -y
fi

## Install npm packages
if [ ! -z "${NPM_PKG}" ]; then

  echo ">>> Setting up npm"
  mkdir "${HOME}/.npm-packages"
  npm config set prefix "${HOME}/.npm-packages"

  echo ">>> Installing NPM packages"
  npm install -g ${NPM_PKG}
  PATH="${PATH}:${HOME}/.npm-packages/bin"
fi

## Install pip packages
if [ ! -z "${FEDORA_PIP}" ]; then
  echo ">>> Installing PIP packages"
  pip install --user ${FEDORA_PIP}
fi

## Apply GNOME settings
if [ -f "gsettings.lst" ]; then
  echo ">>> Applying GNOME settings"
  cat gsettings.lst | while read line; do
    schema=$(echo $line | cut -f1 -d' ')
    key=$(echo $line | cut -f2 -d' ')
    value=$(echo $line | cut -f3- -d' ')
    echo $schema "$key => $value"
    # commented out for dry-run:
    gsettings set ${schema} ${key} "${value}"
  done
fi

## Install Nord theme for gnome-terminal
echo ">>> Installing Nord theme for gnome-terminal"
git clone https://github.com/arcticicestudio/nord-gnome-terminal.git /tmp/gnome-terminal
cd /tmp/gnome-terminal/src
./nord.sh

## Install pop_shell
echo ">>> Installing pop_shell"
git clone https://github.com/pop-os/shell.git /tmp/pop_shell
cd /tmp/pop_shell
touch .confirm_shortcut_change

## No need to restart gnome-shell at this point
sed -e '/^make restart-shell/s/^/#/' -i ./rebuild.sh
sed -e '/^make listen/s/^/#/' -i ./rebuild.sh
./rebuild.sh

## Install workspace-switcher
echo ">>> Installing workspace-switcher"
git clone https://github.com/tomha/gnome-shell-extension-workspace-switcher ${HOME}/.local/share/gnome-shell/extensions/workspace-switcher@tomha.github.com
gnome-extensions enable workspace-switcher@tomha.github.com

# Install gnome-shell extensions
echo ">>> Installing gnome-shell extensions"
${HOME}/.local/bin/gnome-extensions-cli install ${GNOME_SHELL_EXTENSIONS}

## Install VSCodium extensions
echo ">>> Install VSCodium extensions"
cat ${HOME}/.config/VSCodium/User/extensions.list | xargs -L 1 codium --install-extension

echo ">>> Setting VSCodium as default text editor"
xdg-mime default ${DEFAULT_EDITOR} text/plain

for EXT in ${EDITOR_FILETYPES}; do
  xdg-mime default ${DEFAULT_EDITOR} ${EXT}
done

## Set zsh as shell
echo ">>> Setting zsh as shell for ${USER}"
sudo chsh -s $(which zsh) ${USER}

## Rebuild kernel extensions
echo ">>> Rebuilding kernel extensions"
sudo akmods

echo ">>> Everything is done. You should reboot now."
