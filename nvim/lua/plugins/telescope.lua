return {
  {
    'nvim-telescope/telescope.nvim',
    event = 'VimEnter',
    dependencies = {
      'nvim-lua/plenary.nvim',

      { -- If encountering errors, see telescope-fzf-native README for installation instructions
        'nvim-telescope/telescope-fzf-native.nvim',

        -- `build` is used to run some command when the plugin is installed/updated.
        -- This is only run then, not every time Neovim starts up.
        build = 'make',

        -- `cond` is a condition used to determine whether this plugin should be
        -- installed and loaded.
        cond = function()
          return vim.fn.executable('make') == 1
        end,
      },
      { 'nvim-telescope/telescope-ui-select.nvim' },

      -- Useful for getting pretty icons, but requires a Nerd Font.
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
      { 'nvim-telescope/telescope-file-browser.nvim' },
    },
    config = function()
      require('telescope').setup({
        -- You can put your default mappings / updates / etc. in here
        --  All the info you're looking for is in `:help telescope.setup()`
        --
        defaults = {
          file_ignore_patterns = { '.git/', '.cache', '%.o', '%.a', '%.out', '%.class', '%.pdf', '%.mkv', '%.mp4', '%.zip' },
        },
        -- pickers = {}
        extensions = {
          ['ui-select'] = {
            require('telescope.themes').get_dropdown(),
          },
        },
      })

      -- Enable Telescope extensions if they are installed
      pcall(require('telescope').load_extension, 'fzf')
      pcall(require('telescope').load_extension, 'ui-select')
    end,
    keys = {
      { '<leader>/', false },
      {
        '<leader>fP',
        function()
          require('telescope.builtin').find_files({
            cwd = require('lazy.core.config').options.root,
          })
        end,
        desc = 'Find Plugin File',
      },
      {
        ';f',
        function()
          local builtin = require('telescope.builtin')
          local actions = require('telescope.actions')
          local action_state = require('telescope.actions.state')

          builtin.find_files({
            no_ignore = false,
            hidden = true,
            attach_mappings = function(prompt_bufnr, map)
              local open_in_tab = function()
                local entry = action_state.get_selected_entry()
                actions.close(prompt_bufnr)
                -- entry.path is common; fall back to filename/value
                local path = entry.path or entry.filename or entry.value
                if path then
                  -- create a new tab and edit the file safely (escape name)
                  vim.cmd('tabnew ' .. vim.fn.fnameescape(path))
                end
              end

              -- map Enter to our new-tab opener in both insert and normal modes
              map('i', '<CR>', open_in_tab)
              map('n', '<CR>', open_in_tab)
              return true
            end,
          })
        end,
        desc = 'Lists files in your current working directory, respects .gitignore',
      },
      {
        ';r',
        function()
          local builtin = require('telescope.builtin')
          builtin.live_grep()
        end,
        desc = 'Search for a string in your current working directory and get results live as you type, respects .gitignore',
      },
      {
        '\\\\',
        function()
          local builtin = require('telescope.builtin')
          builtin.buffers()
        end,
        desc = 'Lists open buffers',
      },
      {
        ';t',
        function()
          local builtin = require('telescope.builtin')
          builtin.help_tags()
        end,
        desc = 'Lists available help tags and opens a new window with the relevant help info on <cr>',
      },
      {
        ';;',
        function()
          local builtin = require('telescope.builtin')
          builtin.resume()
        end,
        desc = 'Resume the previous telescope picker',
      },
      {
        ';e',
        function()
          local builtin = require('telescope.builtin')
          builtin.diagnostics({
            wrap_results = true,
            line_width = 'full',
          })
        end,
        desc = 'Lists Diagnostics for all open buffers or a specific buffer',
      },
      {
        ';s',
        function()
          local builtin = require('telescope.builtin')
          builtin.treesitter()
        end,
        desc = 'Lists Function names, variables, from Treesitter',
      },
      {
        '<leader>sk',
        function()
          local builtin = require('telescope.builtin')
          builtin.keymaps()
        end,
        desc = '[S]earch [K]eymaps',
      },
      {
        '<leader>sw',
        function()
          local builtin = require('telescope.builtin')
          builtin.grep_string()
        end,
        desc = '[S]earch current [W]ord',
      },
      {
        '<leader>s.',
        function()
          local builtin = require('telescope.builtin')
          builtin.oldfiles()
        end,
        desc = '[S]earch recent files ("." for repeat)',
      },
      {
        '<leader>sn',
        function()
          local builtin = require('telescope.builtin')
          builtin.find_files({ cwd = vim.fn.stdpath('config') })
        end,
        desc = '[S]earch [N]eovim files)',
      },
      {
        ';c',
        function()
          local builtin = require('telescope.builtin')
          builtin.lsp_incoming_calls()
        end,
        desc = 'Lists LSP incoming calls for word under the cursor',
      },
      {
        '<leader>sf',
        function()
          local telescope = require('telescope')

          local function telescope_buffer_dir()
            return vim.fn.expand('%:p:h')
          end

          telescope.extensions.file_browser.file_browser({
            path = '%:p:h',
            cwd = telescope_buffer_dir(),
            respect_gitignore = false,
            hidden = true,
            grouped = true,
            previewer = false,
            initial_mode = 'normal',
            layout_config = { height = 40 },
          })
        end,
        desc = 'Open File Browser with the path of the current buffer',
      },
    },
  },
}
