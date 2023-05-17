.PHONY: dotenvs_link
dotenvs_link:
	ln -sf $$PWD/dotfiles/xinitrc $$HOME/.xinitrc
	ln -sf $$PWD/dotfiles/vimrc $$HOME/.vimrc
