## DOTFILES MAKEFILE
##
## Gets you set up quickly so you don't have to do work.
##
## Thanks to mitsuhiko on GitHub for the idea.
##

USRHOME   := $${HOME}
BACKUPDIR := $(USRHOME)/.old_dotfiles

.PHONY: default update install

default: update install save

update:
	@echo "Updating to latest version..."
	git pull

install: install-bash

install-bash:
	-$(RM) $(USRHOME)/.bashrc
	-$(RM) $(USRHOME)/.bash_profile
	-$(RM) $(USRHOME)/.bash_aliases
	ln -sf `pwd`/bash/bashrc $(USRHOME)/.bashrc
	ln -sf `pwd`/bash/bash_profile $(USRHOME)/.bash_profile
	ln -sf `pwd`/bash/bash_aliases $(USRHOME)/.bash_aliases

install-vim:
	-$(RM) $(USRHOME)/.vim $(USRHOME)/.vimrc
	ln -sf `pwd`/vim $(USRHOME)/.vim
	ln -sf $(USRHOME)/vimrc $(USRHOME)/.vimrc

save:
	git add --all .
	git commit -m "Automatic Update: $(date)"
	git push -u origin master
