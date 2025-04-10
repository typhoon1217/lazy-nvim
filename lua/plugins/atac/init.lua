return {
  "NachoNievaG/atac.nvim",
  event = "VeryLazy",
  dependencies = { "akinsho/toggleterm.nvim" },
  config = function()
    require("atac").setup({
      dir = "~/tmp/atac", -- By default, the dir will be set as /tmp/atac
    })
  end,
}
