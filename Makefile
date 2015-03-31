## DOTFILES MAKEFILE
##
## Gets you set up quickly so you don't have to do work.
##
## Thanks to mitsuhiko on GitHub for the idea.
##

USRHOME   := $${HOME}

.PHONY: default update install

default: update install

update:
	@echo "Updating to latest version..."
	git pull
	@echo "Updated. You should now `make install` to put everything in place."

install: install-bash install-vim

.PHONY: install-bash
install-bash:
	@echo "Installing prefs: bash"
	-$(RM) $(USRHOME)/.bashrc
	-$(RM) $(USRHOME)/.bash_profile
	-$(RM) $(USRHOME)/.bash_aliases
	-$(RM) $(USRHOME)/.inputrc
	ln -sf `pwd`/bash/bashrc $(USRHOME)/.bashrc
	ln -sf `pwd`/bash/bash_profile $(USRHOME)/.bash_profile
	ln -sf `pwd`/bash/bash_aliases $(USRHOME)/.bash_aliases
	ln -sf `pwd`/bash/inputrc $(USRHOME)/.inputrc

.PHONY: install-vim
install-vim:
	@echo "Installing prefs: vim"
	-$(RM) $(USRHOME)/.vim $(USRHOME)/.vimrc
	ln -sf `pwd`/vim $(USRHOME)/.vim
	ln -sf $(USRHOME)/vimrc $(USRHOME)/.vimrc

save:
	git add --all .
	git commit -m "Automatic Update: $$(date)"
	git push -u origin master
