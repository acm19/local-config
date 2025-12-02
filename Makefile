ALACRITTY_SOURCE_PATH?="$$HOME/opt/alacritty"
TMUX_SOURCE_PATH?="$$HOME/opt/tmux"

.PHONY: all
all: dotenvs-link bin-link gitconfig-install bashrc-install

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
	mkdir -p $$HOME/bin
	ln -sf $$PWD/bin/deploy $$HOME/bin/deploy
	ln -sf $$PWD/bin/tag-deploy $$HOME/bin/tag-deploy
	ln -sf $$PWD/bin/wmbarshow $$HOME/bin/wmbarshow
	ln -sf $$PWD/bin/wmbarupdate $$HOME/bin/wmbarupdate
	ln -sf $$PWD/bin/wmmenu $$HOME/bin/wmmenu
	ln -sf $$PWD/bin/wmreload $$HOME/bin/wmreload
	ln -sf $$PWD/bin/wmscreenshot $$HOME/bin/wmscreenshot

.PHONY: gitconfig-install
gitconfig-install:
	@if [ ! -f $$HOME/.gitconfig ]; then \
		touch $$HOME/.gitconfig; \
	fi
	@if ! grep -q "path = $$PWD/dotfiles/gitconfig" $$HOME/.gitconfig 2>/dev/null; then \
		echo "" >> $$HOME/.gitconfig; \
		echo "[include]" >> $$HOME/.gitconfig; \
		echo "	path = $$PWD/dotfiles/gitconfig" >> $$HOME/.gitconfig; \
		echo "Gitconfig included in $$HOME/.gitconfig"; \
	else \
		echo "Gitconfig already included in $$HOME/.gitconfig"; \
	fi

.PHONY: bashrc-install
bashrc-install:
	@mkdir -p $$PWD/dotfiles/bashrc.d
	@ln -sfn $$PWD/dotfiles/bashrc.d $$HOME/.bashrc.d
	@if [ ! -f $$HOME/.bashrc ]; then \
		touch $$HOME/.bashrc; \
	fi
	@if ! grep -q "if \[ -d ~/.bashrc.d \]; then" $$HOME/.bashrc 2>/dev/null; then \
		cat $$PWD/templates/bashrc.d-loader.sh >> $$HOME/.bashrc; \
		echo "Bashrc.d configuration added to $$HOME/.bashrc"; \
	else \
		echo "Bashrc.d configuration already exists in $$HOME/.bashrc"; \
	fi

.PHONY: nvim
nvim:
	ln -sf $$PWD/nvim $$HOME/.config/nvim

.PHONY: update-liquidprompt
update-liquidprompt:
	mkdir -p $$HOME/opt
	@if [ ! -d $$HOME/opt/liquidprompt ]; then \
		git clone https://github.com/nojhan/liquidprompt.git $$HOME/opt/liquidprompt; \
	fi
	cd $$HOME/opt/liquidprompt && \
	git pull

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
