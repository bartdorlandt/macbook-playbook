set positional-arguments

TAGS := 'all'

default:
	@just --list --unsorted --justfile {{justfile()}}

[group('ansible')]
all playbook:

[group('ansible')]
list-tags:
	ansible-playbook main.yml --list-tags

[group('ansible')]
playbook *ARGS:
	ansible-playbook main.yml -K '{{ARGS}}'

[group('ansible')]
provision tags=TAGS *ARGS="":
	just playbook --tags={{tags}} '{{ARGS}}'

[group('ansible')]
step *ARGS:
	just playbook --step '{{ARGS}}'

[group('init')]
install install_xcode install_ansible install_repo:

[group('init')]
install_ansible pip_upgrade *ARGS:
	pip3 install ansible --user '{{ARGS}}'

[group('init')]
install_xcode:
	#!/bin/bash
	set -euxo pipefail
	xcode-select -p 2>&1 >/dev/null || xcode-select --install
	if [ "`xcode-select -p`" != "/Library/Developer/CommandLineTools" ]; then sudo xcode-select -switch /Library/Developer/CommandLineTools; fi

[group('init')]
git_submodules:
	@echo "Update the submodule geerlingguy.mac-dev-playbook"
	git submodule update --init --recursive

[group('init')]
pip_upgrade:
	python3 -m pip install --upgrade pip
	python3 -m ensurepip --upgrade

[group('init')]
install_repo ansible_requirements_force git_submodules:

[group('init')]
ansible_requirements *ARGS:
	ansible-galaxy install -r requirements.yml '{{ARGS}}'

[group('init')]
ansible_requirements_force:
	just ansible_requirements --force

[group('clean')]
[confirm]
clean:
	rm -rf ./roles/geerlingguy.*
	rm -rf ./roles/bartdorlandt.*
	rm -rf ./roles/monolithprojects.homebrew
	rm -rf ./roles/elliotweiser.osx-command-line-tools
