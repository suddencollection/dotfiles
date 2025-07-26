-- if true then return {} end -- WARN REMOVE THIS LINE TO ACTIVATE THIS FILE

-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  --<<CUSTOM>>{
  "srcery-colors/srcery-vim", {},
  --
  {
    "rcarriga/nvim-notify",
    opts = function(_, opts) 
        -- require("lsp_signature").setup()
        opts.background_colour = "#000000"
        return opts
    end
  },

  --<<CUSTOM>>}

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {
        "                                               ",
        "      db                mm                     ",
        "     ;MM:               MM                     ",
        '    ,V^MM     ,pP"Ybd mmMMmm  7Mb,od8 ,pW"Wq   ',
        "   ,M   MM    8I        MM     MM    6W'    Wb ",
        "   AbmmmqMA    YMMMa    MM     MM    8M     M8 ",
        "  A'     VML  L    I8   MM     MM    YA    ,A9 ",
        " AMA     AMMA M9mmmP'    Mbmo JMML     Ybmd9'  ",
        "                                               ",
        "  MN      M              db                    ",
        "  MMN     M                                    ",
        "  M YMb   M  7M     MF   MM    MMpMMMb pMMMb   ",
        "  M   MN  M   VA   ,V    MM    MM    MM    MM  ",
        "  M    MM M    VA ,V     MM    MM    MM    MM  ",
        "  M     YMM     VVV      MM    MM    MM    MM  ",
        " JML     YM      W      JMML  JMML  JMML  JMML ",
      }
      return opts
    end,
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
}
