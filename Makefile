TAGS ?= all
UNAME := $(shell uname)
.PHONY: all install install-ansible install-xcode install-repo provision ./roles ./geerlingguy.mac-dev-playbook/main.yml clean

ifeq ($(FORCE),1)
FORCE_FLAG := --force
endif
all: provision

install: install-xcode install-ansible install-repo

install-ansible: upgrade-pip pip-install-ansible

install-xcode:
ifeq ($(UNAME),Darwin)
	xcode-select -p 2>&1 >/dev/null || xcode-select --install
	if [ "`xcode-select -p`" != "/Library/Developer/CommandLineTools" ]; then sudo xcode-select -switch /Library/Developer/CommandLineTools; fi
endif

install-repo: ./roles ./geerlingguy.mac-dev-playbook/main.yml

clean:
	rm -rf ./roles/elliotweiser.osx-command-line-tools
	rm -rf ./roles/geerlingguy.dotfiles

provision:
	ansible-playbook main.yml -K --tags="$(TAGS)"

./geerlingguy.mac-dev-playbook/main.yml:
	git submodule update --init --recursive

upgrade-pip:
	python3 -m pip install --upgrade pip
	python3 -m ensurepip --upgrade

pip-install-ansible: upgrade-pip
	pip3 install ansible --user

./roles:
	ansible-galaxy install -r requirements.yml $(FORCE_FLAG)
