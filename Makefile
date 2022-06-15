## DOTFILES MAKEFILE
##
## Gets you set up quickly so you don't have to do work.
##
## Thanks to mitsuhiko on GitHub for the idea.
##

userhome    := $${HOME}
mkfile_path := $(abspath $(lastword $(MAKEFILE_LIST)))
current_dir := $(dir $(mkfile_path))

.PHONY: default update install

default: install

update:
	@echo "Updating to latest version..."
	-@git pull
	@echo "Updated. You should now do 'make install' to put everything in place."

install: install-bash install-tcsh install-zsh install-vim install-git
	@echo "Creating symlink to the dotfiles directory: $(current_dir)."
	-@$(RM) $(userhome)/.dotfiles
	-@ln -sf $(current_dir) $(userhome)/.dotfiles

.PHONY: install-bash
install-bash:
	@echo "Installing prefs: bash"
	-@$(RM) $(userhome)/.bashrc
	-@$(RM) $(userhome)/.bash_profile
	-@$(RM) $(userhome)/.bash_aliases
	-@$(RM) $(userhome)/.bash_extras
	-@$(RM) $(userhome)/.inputrc
	-@$(RM) $(userhome)/.git_prompt
	-@$(RM) $(userhome)/.man_colors
	-@$(RM) $(userhome)/.dircolors
	-@ln -sf $(current_dir)bash/bashrc.sh $(userhome)/.bashrc
	-@ln -sf $(current_dir)bash/bash_profile.sh $(userhome)/.bash_profile
	-@ln -sf $(current_dir)bash/bash_aliases.sh $(userhome)/.bash_aliases
	-@ln -sf $(current_dir)bash/bash_extras.sh $(userhome)/.bash_extras
	-@ln -sf $(current_dir)bash/inputrc.sh $(userhome)/.inputrc
	-@ln -sf $(current_dir)bash/git_prompt.sh $(userhome)/.git_prompt
	-@ln -sf $(current_dir)bash/man_colors.sh $(userhome)/.man_colors
	-@ln -sf $(current_dir)bash/dircolors.custom $(userhome)/.dircolors

.PHONY: install-vim
install-vim:
	@echo "Installing prefs: vim"
	-@$(RM) $(userhome)/.vim $(userhome)/.vimrc
	-@ln -sf $(current_dir)vim $(userhome)/.vim
	-@ln -sf $(userhome)/.vim/vimrc $(userhome)/.vimrc

.PHONY: install-tcsh
install-tcsh:
	@echo "Installing prefs: tcsh"
	-@$(RM) $(userhome)/.tcshrc
	-@$(RM) $(userhome)/.tcsh_aliases
	-@$(RM) $(userhome)/.tcsh_prompt
	-@ln -sf $(current_dir)tcsh/tcshrc.tcsh $(userhome)/.tcshrc
	-@ln -sf $(current_dir)tcsh/tcsh_aliases.tcsh $(userhome)/.tcsh_aliases
	-@ln -sf $(current_dir)tcsh/tcsh_prompt.tcsh $(userhome)/.tcsh_prompt

install-zsh: export INSTALL_OMZ := true
install-zsh: OMZ_DIR ?= $(userhome)/.oh-my-zsh
install-zsh: omz_extras_dir := $(current_dir)/zsh/extras

.PHONY: install-zsh
install-zsh:
	@echo "Installing prefs: zsh"
	-@$(RM) $(userhome)/.zshrc
	-@$(RM) $(userhome)/.zprofile
	-@$(RM) $(userhome)/.zshenv
	-@ln -sf $(current_dir)/zsh/zshrc.zsh $(userhome)/.zshrc
	-@ln -sf $(current_dir)/zsh/zprofile.zsh $(userhome)/.zprofile
	-@ln -sf $(current_dir)/zsh/zshenv.zsh $(userhome)/.zshenv
	@if [ ! -d "$(OMZ_DIR)" ]; then \
		echo "No Oh My Zsh directory found at $(OMZ_DIR)."; \
		/bin/echo -n "Would you like to install Oh My Zsh? [Y/n] "; \
		read RESPONSE; \
		if [[ "$$RESPONSE" == [nN]* ]]; then \
			export INSTALL_OMZ=false; \
		elif [[ "$$RESPONSE" == [yY]* || -z "$$RESPONSE" ]]; then \
			echo "Installing Oh My Zsh..."; \
			sh -c "$$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"; \
		else \
			echo "Invalid response: \"$$RESPONSE\""; \
			exit 1; \
		fi; \
	fi; \
	if [ -d $(omz_extras_dir) ] && $$INSTALL_OMZ; then \
		ln -sf $(omz_extras_dir) $(OMZ_DIR)/custom/from-dotfiles; \
	fi

.PHONY: install-git
install-git:
	@echo "Installing prefs: git"
	-@$(RM) $(userhome)/.global-gitignore
	-@ln -sf $(current_dir)/git/global-gitignore $(userhome)/.global-gitignore
	-@git config --global core.excludesfile $(userhome)/.global-gitignore

save:
	-@git add --all .
	-@git commit -m "Automatic Update: $$(date)"
	-@git push
	@echo "Changes committed and pushed."
