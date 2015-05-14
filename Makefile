## DOTFILES MAKEFILE
##
## Gets you set up quickly so you don't have to do work.
##
## Thanks to mitsuhiko on GitHub for the idea.
##

userhome := $${HOME}
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))

.PHONY: default update install

default: install

update:
	@echo "Updating to latest version..."
	-@git pull
	@echo "Updated. You should now do 'make install' to put everything in place."

install: install-bash install-vim
	@echo "Creating symlink to the dotfiles directory: $(current_dir)."
	-@$(RM) $(userhome)/.dotfiles
	-@ln -sf $(current_dir) $(userhome)/.dotfiles

.PHONY: install-bash
install-bash:
	@echo "Installing prefs: bash"
	-@$(RM) $(userhome)/.bashrc
	-@$(RM) $(userhome)/.bash_profile
	-@$(RM) $(userhome)/.bash_aliases
	-@$(RM) $(userhome)/.inputrc
	-@$(RM) $(userhome)/.git_prompt
	-@ln -sf $(current_dir)bash/bashrc.sh $(userhome)/.bashrc
	-@ln -sf $(current_dir)bash/bash_profile.sh $(userhome)/.bash_profile
	-@ln -sf $(current_dir)bash/bash_aliases.sh $(userhome)/.bash_aliases
	-@ln -sf $(current_dir)bash/inputrc.sh $(userhome)/.inputrc
	-@ln -sf $(current_dir)bash/git_prompt.sh $(userhome)/.git_prompt

.PHONY: install-vim
install-vim:
	@echo "Installing prefs: vim"
	-@$(RM) $(userhome)/.vim $(userhome)/.vimrc
	-@ln -sf $(current_dir)vim $(userhome)/.vim
	-@ln -sf $(userhome)/.vim/vimrc $(userhome)/.vimrc

.PHONY: install-tcsh
install-tcsh:
	@echo "Installing prefs: tcsh"
	-@$(RM) $(userhome)/.cshrc
	-@$(RM) $(userhome)/.tcsh_aliases
	-@$(RM) $(userhome)/.tcsh_prompt
	-@ln -sf $(current_dir)tcsh/cshrc.tcsh $(userhome)/.cshrc
	-@ln -sf $(current_dir)tcsh/tcsh_aliases.tcsh $(userhome)/.tcsh_aliases
	-@ln -sf $(current_dir)tcsh/tcsh_prompt.tcsh $(userhome)/.tcsh_prompt

save:
	-@git add --all .
	-@git commit -m "Automatic Update: $$(date)"
	-@git push
	@echo "Changes committed and pushed."
