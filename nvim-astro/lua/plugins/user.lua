return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "bkad/CamelCaseMotion",
    init = function()
      local opts = { remap = true, silent = true }
      vim.keymap.set({ "n", "o", "x" }, "w", "<Plug>CamelCaseMotion_w", opts)
      vim.keymap.set({ "n", "o", "x" }, "b", "<Plug>CamelCaseMotion_b", opts)
      vim.keymap.set({ "n", "o", "x" }, "e", "<Plug>CamelCaseMotion_e", opts)
      vim.keymap.set({ "n", "o", "x" }, "ge", "<Plug>CamelCaseMotion_ge", opts)
      vim.keymap.set({ "o", "x" }, "iw", "<Plug>CamelCaseMotion_iw", opts)
      vim.keymap.set({ "o", "x" }, "ib", "<Plug>CamelCaseMotion_ib", opts)
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize dashboard options
  {
    "folke/snacks.nvim",
    opts = {
      dashboard = {
        preset = {
          header = table.concat({
            " █████  ███████ ████████ ██████   ██████ ",
            "██   ██ ██         ██    ██   ██ ██    ██",
            "███████ ███████    ██    ██████  ██    ██",
            "██   ██      ██    ██    ██   ██ ██    ██",
            "██   ██ ███████    ██    ██   ██  ██████ ",
            "",
            "███    ██ ██    ██ ██ ███    ███",
            "████   ██ ██    ██ ██ ████  ████",
            "██ ██  ██ ██    ██ ██ ██ ████ ██",
            "██  ██ ██  ██  ██  ██ ██  ██  ██",
            "██   ████   ████   ██ ██      ██",
          }, "\n"),
        },
      },
    },
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "mrjones2014/smart-splits.nvim",
    lazy = false, -- Рекомендуется не лениво грузить для лучшей интеграции
    opts = {
      -- Ваши опции (необязательно, здесь показаны настройки по умолчанию)
      ignored_filetypes = { "NvimTree", "neo-tree", "dashboard" }, -- Игнорируйте эти типы окон при ресайзе
      ignored_buftypes = { "nofile", "quickfix", "prompt" },
      default_amount = 3, -- Количество строк/столбцов для ресайза по умолчанию
      at_edge = "wrap", -- Что делать при достижении края: 'wrap', 'split', 'stop'
      -- ... другие опции, если нужны
    },
    config = function(_, opts)
      require("smart-splits").setup(opts)

      -- РЕКОМЕНДУЕМЫЕ КЛАВИШИ
      -- Ресайз сплитов
      vim.keymap.set("n", "<A-h>", require("smart-splits").resize_left)
      vim.keymap.set("n", "<A-j>", require("smart-splits").resize_down)
      vim.keymap.set("n", "<A-k>", require("smart-splits").resize_up)
      vim.keymap.set("n", "<A-l>", require("smart-splits").resize_right)
      -- Навигация между сплитами
      vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
      vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
      vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
      vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
      -- Перемещение буферов между окнами
      vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
      vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
      vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
      vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)
    end,
  },
}
