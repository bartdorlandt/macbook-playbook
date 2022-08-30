# Mac Development Ansible Playbook

Almost all of this comes from oxyc ['oxyc/mac-playbook'](https://github.com/oxyc/mac-playbook).
The playbook contained in this repo does nothing except delegate all functionality to [`geerlingguy/mac-dev-playbook`](https://github.com/geerlingguy/mac-dev-playbook)'s playbook.

*Note: Do NOT install anything you haven't looked through–this is a highly opinionated set of configurations. Running the playbook will affect pretty much every aspect of your environment so for others than me, this is mostly a reference point.*

*See also*:

- [`geerlingguy/mac-dev-playbook`](https://github.com/geerlingguy/mac-dev-playbook) (the actual playbook used to provision)

## Installation

    # Pre tasks
    Log into Mac App Store (App Store in Spotlight)

    # Create git repo dir
    mkdir -p ~/git/
    cd ~/git/

    # Clone this repository to your local drive.
    git clone --recursive https://github.com/bartdorlandt/mac-playbook.git
    cd mac-playbook

    # export path so ansible binaries are going to be on path
    export PATH=~/Library/Python/3.8/bin:$PATH

    # Install dependencies.
    make install

    # Run the playbook (Some casks might need an interactive password during installation).
    make provision

    # Addtional tasks
    Open up the `Mac Playbook - Bootstrap` note and follow it.

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. The tags available are `dotfiles`, `homebrew`, `mas` and `osx`.

    ansible-playbook main.yml -i geerlingguy.mac-dev-playbook/inventory -K --tags "dotfiles,homebrew"

or

    ansible-playbook main.yml -i geerlingguy.mac-dev-playbook/inventory -K --tags "post"
## Future additions

* global gitconfig
* pypi settings (.pypirc)

### Things that still need to be done manually

* **True Tone** Disable True Tone for retina display
* **Finder**: Setup sidebar containing favourites
* **Services**: In System Preferences / Keyboard / Services, enable 'New Terminal at Folder' and 'New Terminal Tab at Folder'
* **Screen Saver**: Set the screen saver to 'Flurry'
* **Notification Centre**: Set the order of items and allow permission
* **Sublime Text**: Sync settings
* **Google Chrome**: Login and sync
* **App Store Login Items**: Start App Store menubar apps and set them to start
  at login (AppCleaner and OneDrive)
* **Keyboard Shortcuts**: Under System Preferences / Keyboard:
  * Mission Control:
    * Mission Control: F11
    * Switch Desktop 1: ctrl+1
    * Switch Desktop 2: ctrl+2
    * Disable all
  * Lanuchpad
    * Disable all
