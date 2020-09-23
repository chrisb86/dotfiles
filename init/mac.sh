#!/usr/bin/env sh
# Inspired by https://github.com/mathiasbynens/dotfiles/blob/master/.macos from Mathias Bynens

MAC_HOSTNAME="leia"

# URLs that should be created as singlesite browsers
MAC_NATIVEFIERSITES="https://web.threema.ch/ https://app.youneedabudget.com/"

# Options for nativefier
MAC_NATIVEFIEROPTS="--darwin-dark-mode-support"

# URLs of additional apps that should be downloaded as zip, dmg, pkg or app
MAC_INSTALLDOWNLOADS="https://dl.exactcode.de/tmp/3bb50ff8eeb7ad116724b56a820139fa/ExactScanPro-19.10.10.dmg https://downloads.skylum.com/luminar4/installer/mac/Luminar4Installer.zip https://downloads.binaryage.com/TotalFinder-1.13.0.dmg https://github.com/cbreak-black/ZetaWatch/releases/download/r46/ZetaWatch-r46-0-g573606.zip"

# tmp dirs
MAC_DOWNLOAD="/tmp/macinstall"
MAC_NATIVEFIERTMP="/tmp/nativefier"

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password upfront
sudo -v

echo ">>> Updating macOS..."
sudo softwareupdate -i -a

echo ">>> Applying settings..."

# Keep-alive: update existing `sudo` time stamp until `.macos` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Set hostname
sudo scutil --set ComputerName "$MAC_HOSTNAME"
sudo scutil --set HostName "$MAC_HOSTNAME"
sudo scutil --set LocalHostName "$MAC_HOSTNAME"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "$MAC_HOSTNAME"

# disable automatic update downloads
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticDownload -bool FALSE

# enable network time
sudo systemsetup -setusingnetworktime on

# Enable DSDontWrite - By default, the Finder collects labels, tags, and other
# metadata related to files on mounted SMB volumes before determining how
# to display the files. macOS High Sierra 10.13 introduces the option for the
# Finder to fetch only the basic information about files on a mounted SMB
# volume, and to display them immediately in alphabetical order. This can
# increase performance in certain environments.

defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool TRUE

# Always show scrollbars
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Disable automatic capitalization as it’s annoying when typing code
defaults write NSGlobalDomain NSAutomaticCapitalizationEnabled -bool false

# Set a custom wallpaper image. `DefaultDesktop.jpg` is already a symlink, and
# all wallpapers are in `/Library/Desktop Pictures/`. The default is `Wave.jpg`.
#rm -rf ~/Library/Application Support/Dock/desktoppicture.db
#sudo rm -rf /System/Library/CoreServices/DefaultDesktop.jpg
#sudo ln -s /path/to/your/image /System/Library/CoreServices/DefaultDesktop.jpg

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

# Enable subpixel font rendering on non-Apple LCDs
# Reference: https://github.com/kevinSuttle/macOS-Defaults/issues/17#issuecomment-266633501
defaults write NSGlobalDomain AppleFontSmoothing -int 1

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Set $HOME as the default location for new Finder windows
# For other paths, use `PfLo` and `file:///full/path/here/`
defaults write com.apple.finder NewWindowTarget -string "PfLO"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# When performing a search, search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `glyv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Enable AirDrop over Ethernet and on unsupported Macs running Lion
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Show the /Volumes folder
sudo chflags nohidden /Volumes

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

# Don’t group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false

# Don’t automatically rearrange Spaces based on most recent use
defaults write com.apple.dock mru-spaces -bool false

# Hot corners
# Bottom left screen corner → Desktop
defaults write com.apple.dock wvous-bl-corner -int 4
defaults write com.apple.dock wvous-bl-modifier -int 0

# Check for software updates daily, not just once per week
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

echo ">>> Killing apps..."
# Kill affected apps
for app in "Activity Monitor" \
	"cfprefsd" \
	"Finder" \
	"SystemUIServer"; do
	killall "${app}" &> /dev/null
done

echo ">>> Installing Homebrew..."
# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo ">>> Processing Brewfile..."
# Install apps from Brewfile
brew bundle cleanup -f
brew bundle install

echo ">>> Installing apps that are not avaliable in brew or AppStore..."
MAC_INSTALLMOUNT="$MAC_DOWNLOAD/mount"
mkdir -p ${MAC_INSTALLMOUNT}

cd $MAC_DOWNLOAD

# Download all packages
for d in ${MAC_INSTALLDOWNLOADS}; do
  echo ">>> Downloading ${d}"
  curl -O ${d}
done

# Extracting *.zip
find $MAC_DOWNLOAD -name "*.zip" -print0 | while IFS= read -r -d '' f; do
  echo ">>> Extracting ${f}"
  unzip -q ${f}
  rm ${f}
done

# Install *.pkg
find $MAC_DOWNLOAD -name "*.pkg" -print0 | while IFS= read -r -d '' f; do
  echo ">>> Processing ${f}"
  sudo installer -pkg "$f" -target /
done

# Install *.dmg
find $MAC_DOWNLOAD -name "*.dmg" -print0 | while IFS= read -r -d '' f; do
  echo ">>> Processing ${f}"
  hdiutil attach $f -quiet -mountpoint ${MAC_INSTALLMOUNT}
  cp -rf ${MAC_INSTALLMOUNT}/*.app /Applications
  hdiutil detach ${MAC_INSTALLMOUNT} -quiet
done

# Install *.app
find $MAC_DOWNLOAD -name "*.app" -print0 | while IFS= read -r -d '' f; do
  echo ">>> Processing ${f}"
  open -a "${f}"
done

#rm -rf $MAC_DOWNLOAD

echo ">>> Creating single site browsers"

mkdir -p $MAC_NATIVEFIERTMP

for s in ${MAC_NATIVEFIERSITES}; do
  nativefier ${MAC_NATIVEFIEROPTS} ${s} ${MAC_NATIVEFIERTMP}
done

find $MAC_NATIVEFIERTMP -depth 2 -name "*.app" -exec cp -rf {} /Applications \;

rm -rf $MAC_NATIVEFIERTMP

echo ">>> Setting up Atom"
apm install --packages-file ${HOME}/.atom/pkg.list

echo ">>> Setting up VSCodium"
mkdir -p "${HOME}/Library/Application Support/VSCodium/User"

# Link config files from ~/.config to ~/Library
ln -sf "${HOME}/.config/VSCodium/User/settings.json" "${HOME}/Library/Application Support/VSCodium/User/settings.json"
ln -sf "${HOME}/.config/VSCodium/User/keybindings.json" "${HOME}/Library/Application Support/VSCodium/User/keybindings.json"

# Install extensions
cat ${HOME}/.config/VSCodium/User/vscode-extensions.list | xargs -L 1 code --install-extension

echo ">>> Setting up Pandoc environment"
eval "$(/usr/libexec/path_helper)"
cabal install pandoc-include pandoc-include-code pandoc-plantuml-diagrams

## Set up BitBar
defaults write com.matryer.BitBar pluginsDirectory "${HOME}/.config/BitBar/"

## Set zsh from brew as default shell
echo ">>> Setting /usr/local/bin/zsh as default shell for ${USER}"
sudo chsh -s /usr/local/bin/zsh ${USER}
