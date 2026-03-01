# 💤 Neovim Config

My personal Neovim configuration built with Lua and powered by **lazy.nvim**.

Clean. Fast. Minimal. Productive.

---

## ✨ Features

- 🔌 Plugin management via lazy.nvim
- 🎨 Gruvbox theme
- 🌲 Treesitter for syntax highlighting
- 🔍 Telescope fuzzy finder
- 📂 Neo-tree file explorer
- ⚡ LSP + autocompletion
- 🎯 Which-key keybinding helper
- 📝 Conform formatter
- 🔁 UndoTree
- 🧠 Harpoon
- 💅 Lualine statusline
- 🧩 Modular structure

---

## 📁 Structure

```
.
├── init.lua
├── lazy-lock.json
└── lua/
    ├── config/
    │   ├── lazy.lua
    │   ├── set.lua
    │   ├── keymaps.lua
    │   └── color.lua
    └── plugins/
        ├── lsp.lua
        ├── treesitter.lua
        ├── telescope.lua
        ├── neo-tree.lua
        ├── gruvbox.lua
        ├── lualine.lua
        ├── harpoon.lua
        ├── undo-tree.lua
        ├── conform.lua
        ├── gitstatus.lua
        └── which-key.lua
```

---

## 🚀 Installation

```bash
git clone https://github.com/devkit908/nvim-config.git ~/.config/nvim
```

Then open Neovim:

```bash
nvim
```

lazy.nvim will install plugins automatically.

---

## 🧠 Requirements

- Neovim >= 0.9
- Git
- A Nerd Font (recommended)

---

## 🎨 Theme

Currently using **Gruvbox**.

---

## ⚠️ Missing  Things

some thing are missing like for you need to copy things in clipboard you need ``` "+y ``` or to paste ``` "+p ``` and there is no dashboard or no teminal i am working on theme  

what i am planning 

- dashboard
- terminal
- add this so normal y an dp yan to clipboard and paste form clipboard

---

## 🔥 amazing thing
so these are some keybinding that are best

- in visual mode J and K move the thing and if there is a thing like a if statement it also indent it when you move the Thing with J K 
- <leader>s is the shourct for %s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>
- <leader>x do !chmod +x %
## 🔑 Keybindings

Leader key: `<Space>`

(Use `which-key` to explore available mappings.)

---

## 🛠️ Customization

All settings live inside:

```
lua/config/
```

All plugins live inside:

```
lua/plugins/
```

Add or remove plugins modularly.

---

## 📌 Philosophy

- Minimal but powerful
- Modular structure
- Easy to extend
- No unnecessary bloat

---

## 📄 License

MIT (or change as needed)

---

> Built with ❤️ using Neovim
