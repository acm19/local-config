ALACRITTY_SOURCE_PATH?="$$HOME/opt/alacritty"
TMUX_SOURCE_PATH?="$$HOME/opt/tmux"

.PHONY: all
all: dotenvs-link bin-link

.PHONY: dotenvs-link
dotenvs-link:
	ln -sf $$PWD/dotfiles/xinitrc $$HOME/.xinitrc
	ln -sf $$PWD/dotfiles/inputrc $$HOME/.inputrc
	ln -sf $$PWD/dotfiles/vimrc $$HOME/.vimrc
	ln -sf $$PWD/dotfiles/tigrc $$HOME/.tigrc
	ln -sf $$PWD/dotfiles/alacritty.toml $$HOME/.alacritty.toml
	ln -sf $$PWD/dotfiles/tmux.conf $$HOME/.tmux.conf

.PHONY: bin-link
bin-link:
	ln -sf $$PWD/bin/deploy $$HOME/bin/deploy
	ln -sf $$PWD/bin/tag-deploy $$HOME/bin/tag-deploy
	ln -sf $$PWD/bin/wmbarshow $$HOME/bin/wmbarshow
	ln -sf $$PWD/bin/wmbarupdate $$HOME/bin/wmbarupdate
	ln -sf $$PWD/bin/wmmenu $$HOME/bin/wmmenu
	ln -sf $$PWD/bin/wmreload $$HOME/bin/wmreload
	ln -sf $$PWD/bin/wmscreenshot $$HOME/bin/wmscreenshot

.PHONY: nvim
nvim:
	ln -sf $$PWD/nvim $$HOME/.config/nvim

.PHONY: update-alacritty
update-alacritty:
	cd $(ALACRITTY_SOURCE_PATH) && \
	git fetch --all && \
	git checkout $$(git tag | grep -v v9 | grep -E "^v[0-9]+\.[0-9]+\.[0-9]+$$" | sort --version-sort | tail -n 1) && \
	make binary
	cp $(ALACRITTY_SOURCE_PATH)/target/release/alacritty "$$HOME/bin"
	chmod +x "$$HOME/bin/alacritty"

# @todo: add an update for nvim
.PHONY: update-tmux
update-tmux:
	cd $(TMUX_SOURCE_PATH) && \
	git fetch --all && \
	git checkout $$(git tag | grep -E "^[0-9]+\.[0-9]+[a-z]*$$" | sort --version-sort | tail -n 1) && \
	sh autogen.sh && ./configure && make
	cp $(TMUX_SOURCE_PATH)/tmux "$$HOME/bin"
	chmod +x "$$HOME/bin/tmux"

.PHONY: update-tenv
update-tenv: export LATEST_VERSION := "$(shell curl --silent https://api.github.com/repos/tofuutils/tenv/releases/latest | jq -r .tag_name)"
update-tenv:
	curl -L "https://github.com/tofuutils/tenv/releases/latest/download/tenv_${LATEST_VERSION}_amd64.deb" -o "/tmp/tenv_${LATEST_VERSION}_amd64.deb"
	sudo dpkg -i "/tmp/tenv_${LATEST_VERSION}_amd64.deb"
	tenv completion bash | sudo tee /usr/share/bash-completion/completions/tenv > /dev/null
