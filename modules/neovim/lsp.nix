{ config, pkgs, lib, ... }:

{
  programs.neovim = {
    plugins = with pkgs.vimPlugins; [
      # LSP
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = ''
          local lspconfig = require('lspconfig')
          
          -- Configure diagnostics to show automatically
          vim.diagnostic.config({
            virtual_text = false,  -- Show diagnostics inline (like VSCode)
            signs = true,         -- Show signs in gutter (E, W, H, I)
            underline = true,     -- Underline errors
            update_in_insert = false,  -- Don't update while typing
            severity_sort = true,      -- Sort by severity
            float = {
              focusable = false,
              style = "minimal", 
              border = "rounded",
              source = "always",
            },
          })
          
          -- Minimal LSP keymaps (only essentials)
          vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('UserLspConfig', {}),
            callback = function(ev)
              local opts = { buffer = ev.buf }
              
              -- Essential navigation
              vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
              vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
              vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
              
              -- Essential actions
              vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
              vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
              vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, opts)
              vim.keymap.set('n', '<leader>d', function()
                vim.diagnostic.open_float(0, { scope = 'line' })
              end, { desc = "Open diagnostic float" })
            end,
          })
          
          -- Setup completion capabilities
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
          
          -- Configure servers with minimal config
          local servers = {
            'nil_ls',
            'ts_ls', 
            'pyright',
            'rust_analyzer',
            'lua_ls',
            'jsonls',
            'yamlls',
            'bashls',
          }
          
          for _, server in ipairs(servers) do
            local config = { capabilities = capabilities }
            
            -- Special config for lua_ls to recognize vim global
            if server == 'lua_ls' then
              config.settings = {
                Lua = {
                  diagnostics = { globals = { 'vim' } },
                  workspace = { checkThirdParty = false },
                  telemetry = { enable = false },
                }
              }
            end
            
            -- Match VSCode rust settings
            if server == 'rust_analyzer' then
              config.settings = {
                ['rust-analyzer'] = {
                  cargo = { features = "all" },
                }
              }
            end
            
            lspconfig[server].setup(config)
          end
        '';
      }
      
      # Minimal completion
      {
        plugin = nvim-cmp;
        type = "lua";
        config = ''
          local cmp = require('cmp')
          local luasnip = require('luasnip')
          
          cmp.setup({
            snippet = {
              expand = function(args)
                require('luasnip').lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ['<Tab>'] = cmp.mapping.select_next_item(),
              ['<S-Tab>'] = cmp.mapping.select_prev_item(),
              ['C-u>'] = cmp.mapping.scroll_docs(-4),
              ['C-d>'] = cmp.mapping.scroll_docs(4),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<C-f>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(1) then
                  luasnip.jump(1)
                else
                  fallback()
                end
              end, {'i', 's'}),
              ['<C-b>'] = cmp.mapping(function(fallback)
                if luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end, {'i', 's'}),
            }),
            sources = {
              { name = 'nvim_lsp' },
              { name = 'buffer' },
              { name = 'path' },
            },
          })
        '';
      }
      cmp-nvim-lsp
      cmp-buffer
      cmp-path
      luasnip
    ];
    
    # LSP servers installed globally as fallbacks
    extraPackages = with pkgs; [
      # Language servers
      nil
      nodePackages.typescript-language-server
      pyright
      rust-analyzer
      lua-language-server
      
      # Config language servers
      nodePackages.vscode-langservers-extracted
      nodePackages.yaml-language-server
      nodePackages.bash-language-server
      
      # Essential formatters
      nixpkgs-fmt
      nodePackages.prettier
      black
      rustfmt
    ];
  };
}
