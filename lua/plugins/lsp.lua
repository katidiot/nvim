local M = {
  -- LSP Configuration & Plugins
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    { 'j-hui/fidget.nvim', opts = {} },
  },
}

function M.config()
  -- local on_attach = function(client, bufnr)
  --   -- Mappings
  --   local opts = { noremap = true, silent = true }
  --   local function buf_set_keymap(lhs, rhs)
  --     vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, opts)
  --   end
  --
  --   -- Disable highlighting from LSP as TreeSitter takes care of it
  --   client.server_capabilities.semanticTokensProvider = nil
  --
  --   buf_set_keymap("<leader>vd", "<cmd>lua vim.lsp.buf.definition()<CR>")
  --   buf_set_keymap("<leader>vh", "<cmd>lua vim.lsp.buf.hover()<CR>")
  --   buf_set_keymap("<leader>vi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
  --   buf_set_keymap("<leader>vsh", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
  --   buf_set_keymap("<leader>vrr", "<cmd>lua vim.lsp.buf.references()<CR>")
  --   buf_set_keymap("<leader>vrn", "<cmd>lua vim.lsp.buf.rename()<CR>")
  --   buf_set_keymap("<leader>vca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
  --   buf_set_keymap("<leader>vsd", "<cmd>lua vim.diagnostic.open_float(nil, {})<CR>")
  --   buf_set_keymap("<leader>vp", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
  --   buf_set_keymap("<leader>vn", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
  --   buf_set_keymap("<space>vf", "<cmd>lua vim.lsp.buf.format{ async = true }<CR>")
  -- end

  -- [[ Configure LSP ]]
  --  This function gets run when an LSP connects to a particular buffer.
  local on_attach = function(_, bufnr)
    -- NOTE: Remember that lua is a real programming language, and as such it is possible
    -- to define small helper and utility functions so you don't have to repeat yourself
    -- many times.
    --
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local nmap = function(keys, func, desc)
      if desc then
        desc = 'LSP: ' .. desc
      end

      vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
    end


    nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
    nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
    nmap('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')
    nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
    nmap('<leader>od', require('telescope.builtin').diagnostics, '[O]pen [D]iagnostics')
    nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')
    nmap('<leader>ff', require('telescope.builtin').find_files, '[F]ind [F]iles')
    nmap('<leader>fg', require('telescope.builtin').git_files, '[F]ind [G]it')
    nmap('<leader>fb', require('telescope.builtin').buffers, '[F]ind [B]uffers')
    nmap('<leader>fm', require('telescope.builtin').marks, '[F]ind [M]arks')
    nmap('<leader>fr', require('telescope.builtin').lsp_references, '[F]ind [R]eferences')
    nmap('<leader>gr', require('telescope.builtin').live_grep, '[GR]ep')
    nmap('<leader>en', require('vim.diagnostic').goto_next, '[E]rror [N]ext')
    nmap('<leader>ep', require('vim.diagnostic').goto_prev, '[E]rror [P]revious')
    nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
    nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
    -- See `:help K` for why this keymap
    nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
    nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
    -- Lesser used LSP functionality
    nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
    nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
    nmap('<leader>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, '[W]orkspace [L]ist Folders')

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
      vim.lsp.buf.format()
    end, { desc = 'Format current buffer with LSP' })
  end

  -- mason-lspconfig requires that these setup functions are called in this order
  -- before setting up the servers.
  require('mason').setup()
  require('mason-lspconfig').setup()

  -- Enable the following language servers
  --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
  --
  --  Add any additional override configuration in the following tables. They will be passed to
  --  the `settings` field of the server config. You must look up that documentation yourself.
  --
  --  If you want to override the default filetypes that your language server will attach to you can
  --  define the property 'filetypes' to the map in question.
  local servers = {
    -- clangd = {},
    gopls = {},
    -- pyright = {},
    rust_analyzer = {},
    -- tsserver = {},
    -- html = { filetypes = { 'html', 'twig', 'hbs'} },
    lua_ls = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
        -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        diagnostics = {
          disable = { 'missing-fields' },
          globals = { 'vim', 'use' },
        },
      },
    },
  }

  -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

  -- Ensure the servers above are installed
  local mason_lspconfig = require 'mason-lspconfig'

  mason_lspconfig.setup {
    ensure_installed = vim.tbl_keys(servers),
  }

  mason_lspconfig.setup_handlers {
    function(server_name)
      require('lspconfig')[server_name].setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = servers[server_name],
        filetypes = (servers[server_name] or {}).filetypes,
      }
    end,
  }
end

return M
