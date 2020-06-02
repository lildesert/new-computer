#!/bin/sh

#                    _           _        _ _ 
#  ___  _____  __   (_)_ __  ___| |_ __ _| | |
# / _ \/ __\ \/ /   | | '_ \/ __| __/ _` | | |
#| (_) \__ \>  <    | | | | \__ \ || (_| | | |
# \___/|___/_/\_\   |_|_| |_|___/\__\__,_|_|_|


echo "I  ❤️  🍎"
echo "Mac OS Install Setup Script"
echo "By Julien Bistoquet"

# Colorize

# Set the colours you can use
black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)

# Resets the style
reset=`tput sgr0`

# Color-echo. Improved. [Thanks @joaocunha]
# arg $1 = message
# arg $2 = Color
cecho() {
  echo "${2}${1}${reset}"
  return
}

echo ""
cecho "###############################################" $red
cecho "#        DO NOT RUN THIS SCRIPT BLINDLY       #" $red
cecho "#         YOU'LL PROBABLY REGRET IT...        #" $red
cecho "#                                             #" $red
cecho "#              READ IT THOROUGHLY             #" $red
cecho "#         AND EDIT TO SUIT YOUR NEEDS         #" $red
cecho "###############################################" $red
echo ""

# Set continue to false by default.
CONTINUE=false

echo ""
cecho "Have you read through the script you're about to run and " $red
cecho "understood that it will make changes to your computer? (y/n)" $red
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
  CONTINUE=true
fi

if ! $CONTINUE; then
  # Check if we're continuing and output a message if not
  cecho "Please go read the script, it only takes a few minutes" $red
  exit
fi

# Here we go.. ask for the administrator password upfront and run a
# keep-alive to update existing `sudo` time stamp until script has finished
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &


##############################
# Prerequisite: Install Brew #
##############################

echo "Installing brew..."

if test ! $(which brew)
then
	## Don't prompt for confirmation when installing homebrew
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
fi

# Latest brew, install brew cask
brew upgrade
brew update


#############################################
### Generate ssh keys & add to ssh-agent
### See: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
#############################################

if [ -e ~/.ssh/id_rsa ]
then
    echo "ssh key already exists. Skipping generating new ssh key... "
else
    echo "Generating ssh keys, adding to ssh-agent..."
    read -p 'Input email for ssh key: ' useremail

    echo "Use default ssh file location, enter a passphrase: "
    ssh-keygen -t rsa -b 4096 -C "$useremail"  # will prompt for password
	eval "$(ssh-agent -s)"

	# Now that sshconfig is synced add key to ssh-agent and
	# store passphrase in keychain
	ssh-add -K ~/.ssh/id_rsa

	# If you're using macOS Sierra 10.12.2 or later, you will need to modify your ~/.ssh/config file to automatically load keys into the ssh-agent and store passphrases in your keychain.


	if [ -e ~/.ssh/config ]
	then
		echo "ssh config already exists. Skipping adding osx specific settings... "
	else
		echo "Writing osx specific settings to ssh config... "
		cat <<EOT >> ~/.ssh/config
		Host *
			AddKeysToAgent yes
			UseKeychain yes
			IdentityFile ~/.ssh/id_rsa
	EOT
	fi

	#############################################
	### Add ssh-key to GitHub via api
	#############################################

	echo "Adding ssh-key to GitHub (via api)..."
	echo "Important! For this step, use a github personal token with the admin:public_key permission."
	echo "If you don't have one, create it here: https://github.com/settings/tokens/new"

	retries=3
	SSH_KEY=`cat ~/.ssh/id_rsa.pub`

	for ((i=0; i<retries; i++)); do
		  read -p 'GitHub username: ' ghusername
		  read -p 'Machine name: ' ghtitle
		  read -sp 'GitHub personal token: ' ghtoken

		  gh_status_code=$(curl -o /dev/null -s -w "%{http_code}\n" -u "$ghusername:$ghtoken" -d '{"title":"'$ghtitle'","key":"'"$SSH_KEY"'"}' 'https://api.github.com/user/keys')

		  if (( $gh_status_code -eq == 201))
		  then
			  echo "GitHub ssh key added successfully!"
			  break
		  else
				echo "Something went wrong. Enter your credentials and try again..."
				echo -n "Status code returned: "
				echo $gh_status_code
		  fi
	done

	[[ $retries -eq i ]] && echo "Adding ssh-key to GitHub failed! Try again later."
fi

##############################
# Install via Brew           #
##############################

echo "Starting brew app install..."

### Window Management
brew cask install spectacle  # window manager

# Don’t show the preferences window on next start
defaults write com.irradiatedsoftware.SizeUp ShowPrefsOnNextStart -bool false

# Download .gitconfig
curl -o ~/.gitconfig 'https://raw.githubusercontent.com/lildesert/new-computer/master/dotfiles/.gitconfig'


### Developer Tools
brew cask install iterm2
brew cask install dbeaver-community


### Development
brew cask install java
brew cask install docker
brew cask install kitematic
brew cask install sourcetree
brew cask install diffmerge
brew install nvm
nvm install node
brew install fzf
brew install yarn


### Command line tools - install new ones, update others to latest version
brew install git  # upgrade to latest
brew install git-lfs # track large files in git https://github.com/git-lfs/git-lfs
brew install git-recent
brew install hub
brew install tree
brew link curl --force
brew install grep --with-default-names
brew install trash  # move to osx trash instead of rm
brew install lnav  # log files navigation


### zsh
brew install zsh
chsh -s /usr/local/bin/zsh
# sudo echo /usr/local/bin/zsh >> /etc/shells

# oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
upgrade_oh_my_zsh

# zsh-docker plugin
git clone https://github.com/zsh-users/zsh-docker.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-docker

# powerline fonts
git clone https://github.com/powerline/fonts.git --depth=1
./fonts/install.sh
rm -rf fonts

# powerlevel9k theme
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k

brew install zsh-syntax-highlighting

# Download .zshrc
curl -o ~/.zshrc 'https://raw.githubusercontent.com/lildesert/new-computer/master/dotfiles/.zshrc'


### Dev Editors
brew cask install visual-studio-code


### VM
brew cask install virtualbox

### Productivity
brew cask install the-unarchiver
brew cask install caffeine  # keep computer from sleeping
brew cask install skitch  # app to annotate screenshots
brew cask install muzzle
brew cask install flux
brew cask install flycut
brew cask install alfred

### Security
brew cask install authy


### Chat / Video Conference
brew cask install slack


### Music and Video
brew cask install vlc


### Run Brew Cleanup
brew cleanup


#############################################
### Set OSX Preferences - Borrowed from https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#############################################

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'


##################
### Finder, Dock, & Menu Items
##################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Expand save panel by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Save to disk (not to iCloud) by default
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Finder: show all filename extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Use list view in all Finder windows by default
# Four-letter codes for the other view modes: `icnv`, `clmv`, `Flwv`
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true



###############################################################################
# Screenshots / Screen                                                        #
###############################################################################

# Require password immediately after sleep or screen saver begins"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to the desktop
defaults write com.apple.screencapture location -string "$HOME/Desktop"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Address Book, Dashboard, iCal, TextEdit, and Disk Utility                   #
###############################################################################

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0


###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################


# Trackpad: enable tap to click for this user and for the login screen
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

# Disable force click and haptic feedback
defaults write ~/Library/Preferences/com.apple.AppleMultitouchTrackpad.plist ForceSuppressed -bool true


###############################################################################
# Mac App Store                                                               #
###############################################################################

# Enable the automatic update check
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true


echo ""
cecho "Done!" $cyan
echo ""
echo ""
cecho "################################################################################" $white
echo ""
echo ""
cecho "Note that some of these changes require a logout/restart to take effect." $red
echo ""
echo ""
echo -n "Check for and install available OSX updates, install, and automatically restart? (y/n)? "
read response
if [ "$response" != "${response#[Yy]}" ] ;then
    softwareupdate -i -a --restart
fi
