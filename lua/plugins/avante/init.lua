return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- Choose one provider
    provider = "anthropic", -- Use this line for Claude
    -- provider = "ollama",  -- Or uncomment this and comment the above for Ollama

    -- Provider configurations
    anthropic = {
      model = "claude-3-7-sonnet-20250219", -- Using Claude 3.7 Sonnet
      api_key = vim.env.ANTHROPIC_API_KEY, -- Load from environment variable
      timeout = 60000, -- Increased timeout for Claude
      temperature = 0,
      max_tokens = 4096,
    },
    ollama = {
      model = "qwen2.5-coder:14b",
    },
  },
  build = "make",
  dependencies = {
    -- Your dependencies remain unchanged
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
