## DOTFILES MAKEFILE
##
## Gets you set up quickly so you don't have to do work.
##
## Thanks to mitsuhiko on GitHub for the idea.
##

USERHOME := $${HOME}

.PHONY: default update install

default: update install

update:
	@echo "Updating to latest version..."
	-@git pull
	@echo "Updated. You should now `make install` to put everything in place."

install: install-bash install-vim

.PHONY: install-bash
install-bash:
	@echo "Installing prefs: bash"
	-@$(RM) $(USERHOME)/.bashrc
	-@$(RM) $(USERHOME)/.bash_profile
	-@$(RM) $(USERHOME)/.bash_aliases
	-@$(RM) $(USERHOME)/.inputrc
	-@ln -sf `pwd`/bash/bashrc $(USERHOME)/.bashrc
	-@ln -sf `pwd`/bash/bash_profile $(USERHOME)/.bash_profile
	-@ln -sf `pwd`/bash/bash_aliases $(USERHOME)/.bash_aliases
	-@ln -sf `pwd`/bash/inputrc $(USERHOME)/.inputrc

.PHONY: install-vim
install-vim:
	@echo "Installing prefs: vim"
	-@$(RM) $(USERHOME)/.vim $(USERHOME)/.vimrc
	-@ln -sf `pwd`/vim $(USERHOME)/.vim
	-@ln -sf $(USERHOME)/vimrc $(USERHOME)/.vimrc

save:
	-@git add --all .
	-@git commit -m "Automatic Update: $$(date)"
	-@git push -u origin master
	@echo "Changes committed and pushed."
