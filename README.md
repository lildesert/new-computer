# Setting up a new computer

My personal installation script for a new computer.

Note, this sets up an extremely opinionated and highly personalized installation, with my preferences and dotfiles. Please adjust as needed!

My dotfile repo is currently private, but I plan on creating a public repo before the end of the year.

Some resources borrowed from:

- https://github.com/ruyadorno/installme-osx/
- https://gist.github.com/millermedeiros/6615994
- https://gist.github.com/brandonb927/3195465/

## Install from script:

Open the terminal, then:

```sh
bash -c "`curl -L https://raw.githubusercontent.com/lildesert/new-computer/master/setup.sh`"
```

----


# Manual Configuration

These apps need to be configured manually.

For OSX settings, I'm still looking for the command line way to change this preference.

#### Set Scroll Reverser preferences

##### Scrolling Section

Checked:

- Reverse Scrolling
- Reverse vertical
- Reverse horizontal
- Reverse Mouse

Unchecked:
- Reverse Trackpad

#### Iterm2

* Iterm2 -> Preferences -> General
	* Check: Load preferences from custom folder /Users/nina/dotfiles/iterm-profiles
	* Check: Save changes to folder when Iterm2 quits

#### System Preferences Configuration

**Users & Groups**

* make sure guest account is turned off

**General**

* Recent items: None
* Appearance: Dark
* Highlight color: Blue

**Trackpad**

* Tap to click: ON
* Secondary click: ON

**Display**

* Night Shift (flux) -> Schedule -> Sunrise to Sunset

**Security & Privacy**

* Firewall -> on
* Firewall options -> Enable stealth mode
* FileVault -> Turn On FileVault (encrypt harddrive)

**Sharing**

* Ensure everything is unchecked

**Finder Preferences**

* General
	* New finder window show: home folder
* Sidebar
	* Show home, remove Recents
* Advanced
	* Show all filename extensions: ON
	* Show warning before changing an extension: OFF
	* Show warning before emptying the trash: OFF

**TrackPad**

* Point & Click
	* Silent clicking -> On

#### Chrome

* Sign into chrome to sync profile & bookmarks
* Chrome -> Warn before quitting: ON
* Extensions
	* React dev tools -> https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en
	* Grammarly -> https://chrome.google.com/webstore/detail/grammarly-for-chrome/kbfnbcaeplbcioakkpcpgfkobkghlhen?hl=en
	* Show Password -> https://chrome.google.com/webstore/detail/showpassword/bbiclfnbhommljbjcoelobnnnibemabl?hl=en
	* Dark Reader -> https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh?hl=en

#### Alfred

#### Configure VPN
