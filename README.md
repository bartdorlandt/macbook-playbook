# Macbook Ansible Playbook

Almost all of this comes from oxyc ['oxyc/mac-playbook'](https://github.com/oxyc/mac-playbook).
The playbook contained in this repo delegates some functionality to [`geerlingguy/mac-dev-playbook`](https://github.com/geerlingguy/mac-dev-playbook)'s playbook and does some other things.

*Note: Do NOT install anything you haven't looked through–this is a highly opinionated set of configurations. Running the playbook will affect pretty much every aspect of your environment so for others than me, this is mostly a reference point.*

*See also*:

- [`geerlingguy/mac-dev-playbook`](https://github.com/geerlingguy/mac-dev-playbook) (the actual playbook used to provision)

## Installation

    # Pre tasks
    Log into Mac App Store (App Store in Spotlight)
    From a terminal:
        xcode-select --install

    # Create git repo dir
    mkdir -p ~/git/

    # Clone this repository to your local drive.
    git clone --recursive https://github.com/bartdorlandt/macbook-playbook.git ~/git/macbook-playbook

    # copy and edit the .env.yml file
    cp env.yml-template .env.yml
    vi .env.yml

    # export path so ansible binaries are going to be on path. (use the correct version, `python -V`)
    export PATH=~/Library/Python/3.9/bin:/opt/homebrew/bin:$PATH

    # Install dependencies for MAC
    ./run install

    # Run the playbook (Some casks might need an interactive password during installation).
    ./run provision


### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `TAGS="<tag1>,<tag2>"` flag. The tags can be retrieved using:

    ./run list-tags

example:

    TAGS=dotfiles,homebrew ./run all

using playbook steps:

    ./run step

## Future additions

### Things that still need to be done manually

- **True Tone** Disable True Tone for retina display
- **Finder**: Setup sidebar containing favourites
- **Screen Saver**: Set the screen saver to 'Flurry'
- **Mission Control**:
  - Disable: Automatically rearrange Spaces based on most recent use
- **Mission Control Hot Corners**:
  - Left top: Mission Control
  - Right top: Notification Center
  - Left bottom: Desktop
  - Right bottom: -
- **Notification Centre**: Set the order of items and allow permission
- **VScode**: Install VScode [MAC](https://code.visualstudio.com/docs?dv=osx) and sync with github
- **Sublime Text**: Install "Sync settings" package and sync via github gist
- **Google Chrome**: Login and sync
- **App Store Login Items**: Start App Store menubar apps and set them to start
  at login (AppCleaner and OneDrive)
- **Keyboard Shortcuts**: Under System Preferences / Keyboard:
  - Lanuchpad: Disable all
  - Input Sources: Disable all (needed in PyCharm)
  - Mission Control:
    - Mission Control: F11
    - Switch Desktop 1: ctrl+1
    - Switch Desktop 2: ctrl+2
    - Switch Desktop 3: ctrl+3
    - Disable all
  - Services: 
    - Files and Folders:
      - remove "Send File to Bluetooth Device" shortcut (needed in iTerm2)
    - Disable:
      - Internet
      - Messaging
      - Pictures
      - Searching
      - Text:
        - Open man Page in Terminal
        - Search man Page Index in Terminal
- **Dock & Menu Bar**:
  - Automatically hide and show the dock: on
  - Show recent applications in Dock: off
- **Services**:
  - Text > Convert text to Simplified Chinese: off
  - Text > Convert text to Traditional Chinese: off
- **Music**:
  - Disable loading Music in certain cases:

        launchctl unload -w /System/Library/LaunchAgents/com.apple.rcd.plist
