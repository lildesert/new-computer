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

#### Alfred

* Set Double Cmd to Alfred hotkey

#### Configure VPN

#### SizeUp

* configure license
* settings -> automatically start at login

#### Karabiner Elements

* Simple Modifications
	* From key caps_lock to key left_control (Remap caps lock to control for emacs)
	* From key right_control to key `b` (custom setting for my ergonomic keyboard)
* Devices
	* For all devices -> Caps Lock LED Check Manipulate LED

#### Arduino IDE (Set up to use with Adafruit boards)

* Preferences -> Additional Boards Manager URLS -> https://adafruit.github.io/arduino-board-index/package_adafruit_index.json
* Tools -> Board -> Board Manager. Install:
	* Arduino SAMD Boards
	* Adafruit AVR Boards
* Sketch -> Include Library -> Manage Libraries. Install:
	* Adafruit NeoPixel
	* FastLED

#### Dash

* Download
* docs for:
	* python2
	* python3
	* django
	* flask
	* arduino
	* processing
	* man pages
* cheatsheets for:
	* emacs
	* git
	* python debugger
	* python unittest assertions

### Limechat

* log into freenode

### Widgets

Useful [shipping status tracker widget](https://junecloud.com/software/dashboard/delivery-status.html)

#### Optional

Apps:

* [Send to kindle for Mac](https://www.amazon.com/gp/sendtokindle/mac)
* [Delivery Status Dashboard Widget](https://www.apple.com/downloads/dashboard/shopping/deliverystatus.html)
* [Flip Clock Screensaver](https://fliqlo.com/#about)
* [FlyCut Clipboard Manager](https://github.com/TermiT/Flycut)
* Visit [this page](http://optout.aboutads.info/) to opt out of ads (turn off adblock first)

#### Todos

- Configure touchbar?
	- See: https://blog.eriknicolasgomez.com/2016/11/28/managing-or-setting-the-mini-touchbar-control-strip/
- Set up wallpaper
	- osascript -e 'tell application "Finder" to set desktop picture to "/Users/wilsonmar/Pictures/wallpapers/macOS-High-Sierra-Wallpaper-2880x1494.jpg" as POSIX file'
- Set up alfred powerpack
