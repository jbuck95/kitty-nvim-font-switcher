#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
KITTY_CONF_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/kitty"
FONT_DIR="${HOME}/.local/share/fonts"

echo "==> Installing Kitty font-switcher configs …"
mkdir -p "$KITTY_CONF_DIR"
cp "$REPO_DIR/kitty/font_default.conf" "$KITTY_CONF_DIR/"
cp "$REPO_DIR/kitty/font_markdown.conf" "$KITTY_CONF_DIR/"
echo "    Copied font_default.conf and font_markdown.conf to $KITTY_CONF_DIR/"

echo ""
echo "==> Installing Garamond Mono fonts …"
mkdir -p "$FONT_DIR/garamond-mono"
cp "$REPO_DIR/fonts/garamond-mono/"*.otf "$FONT_DIR/garamond-mono/"
cp "$REPO_DIR/fonts/garamond-mono/"*.ttf "$FONT_DIR/garamond-mono/" 2>/dev/null || true
echo "    Fonts copied to $FONT_DIR/garamond-mono/"

echo ""
echo "==> Installing Nerd Font patched Garamond Mono …"
mkdir -p "$FONT_DIR/garamond-mono-nerd"
cp "$REPO_DIR/fonts/garamond-mono-nerd/"*.otf "$FONT_DIR/garamond-mono-nerd/"
echo "    Fonts copied to $FONT_DIR/garamond-mono-nerd/"

echo ""
echo "==> Updating font cache …"
fc-cache -fv "$FONT_DIR" 2>/dev/null | grep -i garamond || true

echo ""
echo "==> Done!"
echo ""
echo "Next steps:"
echo "  1. Make sure your kitty.conf has: listen_on unix:/tmp/kitty"
echo "  2. Restart kitty (or reload config with Ctrl+Shift+F5)"
echo "  3. Add to Neovim: require('config.kitty-font-switcher')"
echo "     or copy nvim/lua/config/kitty-font-switcher.lua into your config."
echo "  4. To use JetBrainsMono Nerd Font as coding font, install it via"
echo "     your package manager (e.g. ttf-jetbrains-mono-nerd on Arch)"
