return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {

    copilot = {
      endpoint = "https://api.githubcopilot.com",
      model = "gpt-4o-2024-08-06",
      proxy = nil, -- [protocol://]host[:port] Use this proxy
      allow_insecure = false, -- Allow insecure server connections
      timeout = 30000, -- Timeout in milliseconds
      temperature = 0,
      max_tokens = 20480,
    },

    -- provider = "claude", -- Change from "anthropic" to "claude"
    -- claude = { -- Change from "anthropic" to "claude"
    --   model = "claude-3-7-sonnet-20250219",
    --   api_key = vim.env.ANTHROPIC_API_KEY,
    --   timeout = 60000,
    --   temperature = 0,
    --   max_tokens = 4096,
    --   endpoint = "https://api.anthropic.com", -- Add this from the default config
    -- },
    -- -- Your other config options remain unchanged
  },
  build = "make",
  dependencies = {
    -- Dependencies remain unchanged
    "nvim-treesitter/nvim-treesitter",
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- Optional dependencies
    "echasnovski/mini.pick",
    "nvim-telescope/telescope.nvim",
    "hrsh7th/nvim-cmp",
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
    "zbirenbaum/copilot.lua",
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}
