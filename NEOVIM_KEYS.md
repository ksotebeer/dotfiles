# Neovim Keybindings Cheatsheet

**Leader key: `Space`**

## 🔍 Navigation

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover documentation |

## ✏️ Code Actions

| Key | Action |
|-----|--------|
| `<leader>rn` | Rename symbol |
| `<leader>ca` | Code actions |
| `<leader>f` | Format file |

## 📁 File Management

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files (fuzzy) |
| `<leader>fg` | Grep in files |
| `<leader>fb` | Browse buffers |
| `<leader>e` | Toggle file tree |

## 💾 Editor Basics

| Key | Action |
|-----|--------|
| `jk` | Exit insert mode |
| `<leader>w` | Save file |
| `<leader>q` | Quit |

## 🪟 Window Management

| Key | Action |
|-----|--------|
| `Ctrl-h` | Move to left window |
| `Ctrl-j` | Move to window below |
| `Ctrl-k` | Move to window above |
| `Ctrl-l` | Move to right window |

## 💬 Comments

| Key | Action |
|-----|--------|
| `gcc` | Toggle comment line |
| `gc` | Toggle comment (visual selection) |

## 🔤 Completion (Insert Mode)

| Key | Action |
|-----|--------|
| `Tab` | Next suggestion |
| `Shift-Tab` | Previous suggestion |
| `Enter` | Accept suggestion |
| `Ctrl-Space` | Trigger completion |
| `Ctrl-e` | Cancel completion |

## 🎨 Visual Mode

| Key | Action |
|-----|--------|
| `v` | Enter visual mode |
| `V` | Enter visual line mode |
| `Ctrl-v` | Enter visual block mode |

## Quick Tips

- **Leader timeout**: After pressing space, you have ~1 second to press the next key
- **File tree**: Navigate with `hjkl`, press `Enter` to open file
- **Multiple cursors**: Not configured yet (can add later if needed)
- **Undo/Redo**: Standard `u` and `Ctrl-r` work as expected

## Coming from VSCode?

| VSCode | Neovim Equivalent |
|--------|------------------|
| `Cmd-P` | `<leader>ff` |
| `Cmd-Shift-F` | `<leader>fg` |
| `F12` | `gd` |
| `Shift-F12` | `gr` |
| `F2` | `<leader>rn` |
| `Cmd-S` | `<leader>w` |
| File Explorer | `<leader>e` |