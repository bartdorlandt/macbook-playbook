# Macbook Ansible Playbook

Almost all of this comes from oxyc ['oxyc/mac-playbook'](https://github.com/oxyc/mac-playbook).
The playbook contained in this repo delegates some functionality to [`geerlingguy/mac-dev-playbook`](https://github.com/geerlingguy/mac-dev-playbook)'s playbook and does some other things.

*Note: Do NOT install anything you haven't looked through–this is a highly opinionated set of configurations. Running the playbook will affect pretty much every aspect of your environment so for others than me, this is mostly a reference point.*

*See also*:

- [`geerlingguy/mac-dev-playbook`](https://github.com/geerlingguy/mac-dev-playbook) (the actual playbook used to provision)

## What you get
By default, it will install an environment that is suited for my personal needs. Including but not limited to the tools and programs I use along with several configuration setups and dotfiles.

Along with that it will set most of the settings, including the dock layout.

# Installation

## Pre tasks
Log into Mac App Store (App Store in Spotlight)
From a terminal:

    xcode-select --install

## Create git repo dir

    mkdir -p ~/git/
    git clone --recursive https://github.com/bartdorlandt/macbook-playbook.git ~/git/macbook-playbook
    cd ~/git/macbook-playbook

    # install uv
    curl -LsSf https://astral.sh/uv/install.sh | sh

    uv venv
    uv sync
    source .venv/bin/activate

## copy and edit the .env.yml file
    cp env.yml-template .env.yml
    vi .env.yml

## Install dependencies for MAC

    ansible-galaxy install -r requirements.yml
    git submodule update --init --recursive

## Run the playbook
(Some casks might need an interactive password during installation).

    ansible-playbook main.yml -K

# Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `TAGS="<tag1>,<tag2>"` flag. The tags can be retrieved using:

    task list-tags

example:

    task TAGS=dotfiles,homebrew all

using playbook steps:

    task step

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

- **Fish**:
  - Run the function `fish_add_own_paths`

## iTerm2

Snippets need to be exported and inported manually. They are save as json file. [iterm2_snippets.json](tasks/files/iterm2_snippets.json).

Changes made to the dynamic profile, needs to be exported, [Profiles.json](tasks/files/Profiles.json). On its turn, this file needs to be copied back to DynamicProfiles dir, `$HOME/Library/Application Support/iTerm2/DynamicProfiles`.

    TAGS=iterm2 ./run all
