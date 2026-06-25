# kitty-nvim-font-switcher

Dynamically switch Kitty fonts based on Neovim filetype.

- **Coding** → `JetBrainsMono Nerd Font Mono`
- **Markdown** → `GaramondMono Nerd Font Mono`

```
kitty/              # Kitty configs (font_default.conf, font_markdown.conf)
nvim/               # Neovim autocommand (kitty-font-switcher.lua)
fonts/              # Garamond Mono (OFL) + Nerd Font patched variant (OFL)
install.sh          # Copy fonts + configs
```

## Install

```bash
git clone https://github.com/jbuck95/kitty-nvim-font-switcher.git && cd kitty-nvim-font-switcher && ./install.sh
```

- Add `listen_on unix:/tmp/kitty` to your kitty.conf
- Run `require('config.kitty-font-switcher')` in Neovim
- Install `ttf-jetbrains-mono-nerd` (Arch) or equivalent

## License

- Fonts: SIL OFL 1.1
- Scripts/configs: MIT
