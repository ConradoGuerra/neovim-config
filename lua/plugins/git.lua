return {
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signs_staged = {
          add = { text = "┃" },
          change = { text = "┃" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signs_staged_enable = true,
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          follow_files = true,
        },
        auto_attach = true,
        attach_to_untracked = false,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
          virt_text_priority = 100,
          use_focus = true,
        },
        current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000, -- Disable if file is longer than this (in lines)
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })
      local gitsigns = require("gitsigns")

      vim.keymap.set("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gitsigns.nav_hunk("next")
        end
      end)

      vim.keymap.set("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gitsigns.nav_hunk("prev")
        end
      end)
      vim.keymap.set("n", "<leader>hr", gitsigns.reset_hunk)

      vim.keymap.set("n", "<leader>hp", gitsigns.preview_hunk)

      vim.keymap.set("n", "<leader>hb", function()
        gitsigns.blame_line({ full = true })
      end)

      -- Toggles
      vim.keymap.set("n", "<leader>tb", gitsigns.toggle_current_line_blame)
    end,
  },
  {
    "tpope/vim-fugitive",
    config = function()
      -- Create an autocommand group for fugitive diff wrap settings
      vim.api.nvim_create_augroup("FugitiveDiffWrap", { clear = true })

      -- Add an autocommand to set 'wrap' for diff filetypes
      vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
        group = "FugitiveDiffWrap",
        callback = function()
          local bufname = vim.fn.bufname(vim.fn.bufnr())
          if string.find(bufname, "^fugitive://") or string.find(bufname, "^fugitive:") then
            vim.schedule(function()
              print("Setting wrap for fugitive buffer")
              vim.opt_local.wrap = true
              vim.opt_local.linebreak = true -- Optional: Break lines at word boundaries
              -- vim.opt_local.textwidth = 80  -- Optional: Set text width for wrapping
            end)
          end
        end,
      })
    end,
  },
}
