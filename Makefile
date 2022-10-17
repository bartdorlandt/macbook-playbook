TAGS ?= all
.PHONY: all install install-ansible install-xcode install-repo provision ./roles ./geerlingguy.mac-dev-playbook/main.yml clean

all: provision

install: install-xcode install-ansible install-repo

install-ansible: upgrade-pip pip-install-ansible

install-xcode:
	xcode-select -p 2>&1 >/dev/null || xcode-select --install
	if [ "`xcode-select -p`" != "/Library/Developer/CommandLineTools" ]; then sudo xcode-select -switch /Library/Developer/CommandLineTools; fi

install-repo: ./roles ./geerlingguy.mac-dev-playbook/main.yml

clean:
	rm -rf ./roles/elliotweiser.osx-command-line-tools
	rm -rf ./roles/geerlingguy.dotfiles

provision:
	ansible-playbook main.yml -K --tags="$(TAGS)"

./geerlingguy.mac-dev-playbook/main.yml:
	git submodule update --init --recursive

upgrade-pip:
	python3 -m pip install --upgrade pip --user
	python3 -m ensurepip --upgrade

pip-install-ansible: upgrade-pip
	pip3 install ansible --user

./roles:
	ansible-galaxy install -r requirements.yml
