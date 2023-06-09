ALACRITTY_SOURCE_PATH?="$$HOME/opt/alacritty"

.PHONY: all
all: dotenvs_link bin_link

.PHONY: dotenvs_link
dotenvs_link:
	ln -sf $$PWD/dotfiles/xinitrc $$HOME/.xinitrc
	ln -sf $$PWD/dotfiles/inputrc $$HOME/.inputrc
	ln -sf $$PWD/dotfiles/vimrc $$HOME/.vimrc
	ln -sf $$PWD/dotfiles/tigrc $$HOME/.tigrc
	ln -sf $$PWD/dotfiles/alacritty.yml $$HOME/.alacritty.yml
	ln -sf $$PWD/dotfiles/tmux.conf $$HOME/.tmux.conf

.PHONY: bin_link
bin_link:
	ln -sf $$PWD/bin/deploy $$HOME/bin/deploy
	ln -sf $$PWD/bin/tag-deploy $$HOME/bin/tag-deploy
	ln -sf $$PWD/bin/wmbarshow $$HOME/bin/wmbarshow
	ln -sf $$PWD/bin/wmbarupdate $$HOME/bin/wmbarupdate
	ln -sf $$PWD/bin/wmmenu $$HOME/bin/wmmenu
	ln -sf $$PWD/bin/wmreload $$HOME/bin/wmreload
	ln -sf $$PWD/bin/wmscreenshot $$HOME/bin/wmscreenshot

.PHONY: update_alacritty
update_alacritty:
	cd $(ALACRITTY_SOURCE_PATH) && \
	git fetch --all && \
	git checkout $$(git tag | grep -v v9 | grep -E "^v[0-9]+\.[0-9]+\.[0-9]+$$" | sort --version-sort | tail -n 1) && \
	make binary
	cp "$(ALACRITTY_SOURCE_PATH)/target/release/alacritty" "$$HOME/bin"
