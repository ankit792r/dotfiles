#!/usr/bin/env bash
set -e

DOTS_DIR="$HOME/.dotfiles"
CONFIG_DIR="$HOME/.config"

# ===============================
# 🔧 PACKAGE INSTALL HELPER
# ===============================

install_pkg() {
	local pkg="$1"
	echo "📦 Installing $pkg..."
	if command -v apt &>/dev/null; then
		sudo apt update -y && sudo apt install -y "$pkg"
	elif command -v dnf &>/dev/null; then
		sudo dnf install -y "$pkg"
	elif command -v pacman &>/dev/null; then
		sudo pacman -S --noconfirm "$pkg"
	elif command -v brew &>/dev/null; then
		brew install "$pkg"
	else
		echo "⚠️  No supported package manager found. Please install $pkg manually."
	fi
}

# ===============================
# 🔗 SAFE SYMLINK CREATOR
# ===============================

link() {
	local src="$1"
	local dest="$2"
	mkdir -p "$(dirname "$dest")"
	if [ -e "$dest" ] || [ -L "$dest" ]; then
		echo "⚠️  Backing up existing $dest → ${dest}.bak"
		mv "$dest" "${dest}.bak"
	fi
	ln -sf "$src" "$dest"
	echo "🔗 Linked $dest → $src"
}

# ===============================
# 🪶 FONT INSTALL
# ===============================

install_nerd_font() {
	FONT_NAME="JetBrainsMono Nerd Font"
	FONT_DIR="$HOME/.local/share/fonts"

	if fc-list | grep -qi "JetBrainsMono Nerd Font"; then
		echo "✅ $FONT_NAME already installed."
		return
	fi

	echo "📥 Installing $FONT_NAME..."
	mkdir -p "$FONT_DIR"
	cd "$FONT_DIR" || exit 1
	ZIP_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"
	wget -q "$ZIP_URL" -O JetBrainsMono.zip
	unzip -o JetBrainsMono.zip >/dev/null
	rm JetBrainsMono.zip
	fc-cache -fv >/dev/null
	echo "✅ $FONT_NAME installed."
}

# ===============================
# ⚙️ INSTALLER FUNCTIONS
# ===============================

install_fzf() {
	if ! command -v fzf &>/dev/null; then
		install_pkg "fzf"
	else
		echo "✅ fzf already installed."
	fi
}

install_nvim() {
	if ! command -v nvim &>/dev/null; then
		install_pkg "neovim"
	else
		echo "✅ Neovim already installed."
	fi
	link "$DOTS_DIR/nvim" "$CONFIG_DIR/nvim"
}

install_tmux() {
	if ! command -v tmux &>/dev/null; then
		install_pkg "tmux"
	else
		echo "✅ Tmux already installed."
	fi
	link "$DOTS_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
}

install_lazygit() {
	if ! command -v lazygit &>/dev/null; then
		install_pkg "lazygit"
	else
		echo "✅ Lazygit already installed."
	fi
	link "$DOTS_DIR/lazygit/config.yml" "$CONFIG_DIR/lazygit/config.yml"
}

install_lazydocker() {
	if ! command -v lazydocker &>/dev/null; then
		install_pkg "lazydocker"
	else
		echo "✅ Lazydocker already installed."
	fi
	link "$DOTS_DIR/lazydocker/config.yml" "$CONFIG_DIR/lazydocker/config.yml"
}

# ===============================
# 🌀 MAIN MENU
# ===============================

main() {
	# Detect package manager
	if command -v apt &>/dev/null; then
		echo "💻 Detected package manager: apt (Ubuntu/Debian)"
	elif command -v dnf &>/dev/null; then
		echo "💻 Detected package manager: dnf (Fedora)"
	elif command -v pacman &>/dev/null; then
		echo "💻 Detected package manager: pacman (Arch)"
	elif command -v brew &>/dev/null; then
		echo "💻 Detected package manager: brew (macOS)"
	else
		echo "⚠️  Could not detect package manager."
	fi

	install_fzf

	echo "🧩 Use arrow keys / space to select what to install. Press Enter when done."
	selected=$(printf "Neovim\nTmux\nLazygit\nLazydocker\nFont\nAll" | fzf -m --prompt="Select items to install: ")

	for item in $selected; do
		case "$item" in
		Neovim) echo "test" ;;     # install_nvim ;;
		Tmux) echo "test" ;;       #   install_tmux ;;
		Lazygit) echo "test" ;;    #  install_lazygit ;;
		Lazydocker) echo "test" ;; #  install_lazydocker ;;
		Font) echo "test" ;;       #  install_nerd_font ;;
		All) echo "test" ;;        #
			# install_nvim
			# install_tmux
			# install_lazygit
			# install_lazydocker
			# install_nerd_font
			# break
			# ;;
		esac
	done

	echo "🎉 Setup complete!"
}

main
