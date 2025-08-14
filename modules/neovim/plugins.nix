{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # Themes (multiple options)
      catppuccin-nvim
      tokyonight-nvim
      onedark-nvim
      nord-nvim
      
      # Simple theme configuration - no fancy setup
      {
        plugin = onedark-nvim;
        type = "lua";
        config = ''
          -- Simple catppuccin setup
          vim.cmd.colorscheme("onedark")
        '';
      }
      
      # Treesitter (syntax highlighting)
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = ''
          require'nvim-treesitter.configs'.setup {
            highlight = { enable = true },
            indent = { enable = true },
          }
        '';
      }
      
      # Telescope (fuzzy finder)
      {
        plugin = telescope-nvim;
        type = "lua";
        config = ''
          local builtin = require('telescope.builtin')
          
          require('telescope').setup{
            defaults = {
              file_ignore_patterns = { "node_modules", ".git/" },
            }
          }
          
          -- Essential keymaps only
          vim.keymap.set('n', '<leader>ff', builtin.find_files)
          vim.keymap.set('n', '<leader>fg', builtin.live_grep)
          vim.keymap.set('n', '<leader>fb', builtin.buffers)
        '';
      }
      plenary-nvim  # Required for telescope
      
      # File explorer
      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = ''
          require("nvim-tree").setup({
            renderer = {
              icons = {
                show = {
                  file = false,
                  folder = false,
                  folder_arrow = false,
                  git = false
                }
              }
            }
          })
          vim.keymap.set('n', '<leader>e', ':NvimTreeToggle<CR>')
        '';
      }
      
      # Status line (minimal config)
      {
        plugin = lualine-nvim;
        type = "lua";
        config = ''
          require('lualine').setup {
            options = { theme = 'catppuccin' }
          }
        '';
      }
      
      # Git signs in gutter
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = ''
          require('gitsigns').setup()
        '';
      }
      
      # Comments (gcc to comment line, gc in visual mode)
      {
        plugin = comment-nvim;
        type = "lua";
        config = ''
          require('Comment').setup()
        '';
      }
      
      # Auto pairs
      {
        plugin = nvim-autopairs;
        type = "lua";
        config = ''
          require('nvim-autopairs').setup()
        '';
      }
    ];
  };
}
