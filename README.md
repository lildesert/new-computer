# Setting up a new computer

My personal installation script for a new computer.

## Install from script:

Open the terminal, then:

```sh
bash -c "`curl -L https://raw.githubusercontent.com/lildesert/new-computer/master/setup.sh`"
```

---

# Manual Configuration

These apps need to be configured manually.

For OSX settings, I'm still looking for the command line way to change this preference.

#### Iterm2

- Iterm2 -> Preferences -> General
  _ Check: Load preferences from custom folder
  _ Check: Save changes to folder when Iterm2 quits

#### System Preferences Configuration

**Touch ID**

**Control strip**

- Customize control strip

**Users & Groups**

- make sure guest account is turned off

**General**

- Recent items: None

**Trackpad**

- Point & Click (MBP 2016) \* Silent clicking -> On

**Security & Privacy**

- Firewall -> on
- Firewall options -> Enable stealth mode
- FileVault -> Turn On FileVault (encrypt harddrive)

**Sharing**

- Ensure everything is unchecked

**Energy Saver**

- Turn off display after: 10mn battery / 30mn power adapter

**Finder Preferences**

- General \* New finder window show: home folder
- Sidebar \* Show home, remove Recents
- Advanced
  _ Show all filename extensions: ON
  _ Show warning before changing an extension: OFF \* Show warning before emptying the trash: OFF

#### Chrome

- Sign into chrome to sync profile & bookmarks
- Chrome -> Warn before quitting: ON
- Extensions
  _ React dev tools -> https://chrome.google.com/webstore/detail/react-developer-tools/fmkadmapgofadopljbjfkapdkoienihi?hl=en
  _ Grammarly -> https://chrome.google.com/webstore/detail/grammarly-for-chrome/kbfnbcaeplbcioakkpcpgfkobkghlhen?hl=en
  _ Show Password -> https://chrome.google.com/webstore/detail/showpassword/bbiclfnbhommljbjcoelobnnnibemabl?hl=en
  _ Dark Reader -> https://chrome.google.com/webstore/detail/dark-reader/eimadpbcbfnmbkopoojfekhnkhdbieeh?hl=en

#### Docker

- System Preferences / Security & Privacy / Privacy / Full Disk Access -> add Docker app

#### Flycut

- Launch on login -> https://github.com/TermiT/Flycut/issues/206

#### Configure VPN
