return {
  "nvim-java/nvim-java",
  dependencies = {
    "neovim/nvim-lspconfig",
    "folke/which-key.nvim",
  },
  config = function()
    -- Set up nvim-java
    require("java").setup({
      -- Uncomment and customize as needed
      -- root_markers = {
      --   "settings.gradle", "settings.gradle.kts", "pom.xml", "build.gradle",
      --   "mvnw", "gradlew", "build.gradle.kts",
      -- },
    })

    -- Configure keymaps without which-key.register
    local opts = { noremap = true, silent = true }

    -- Java build and run commands
    vim.keymap.set("n", "<leader>f1", "<cmd>JavaBuildBuildWorkspace<CR>", { desc = "Build Workspace" })
    vim.keymap.set("n", "<leader>f2", "<cmd>JavaBuildCleanWorkspace<CR>", { desc = "Clean Workspace" })
    vim.keymap.set("n", "<leader>f3", "<cmd>JavaRunnerRunMain<CR>", { desc = "Run Main" })
    vim.keymap.set("n", "<leader>f4", "<cmd>JavaRunnerStopMain<CR>", { desc = "Stop Main" })
    vim.keymap.set("n", "<leader>f5", "<cmd>JavaRunnerToggleLogs<CR>", { desc = "Toggle Runner Logs" })
    vim.keymap.set("n", "<leader>f6", "<cmd>JavaDapConfig<CR>", { desc = "Configure DAP" })
    vim.keymap.set("n", "<leader>f7", "<cmd>JavaTestRunCurrentClass<CR>", { desc = "Run Current Class Test" })
    vim.keymap.set("n", "<leader>f8", "<cmd>JavaTestDebugCurrentClass<CR>", { desc = "Debug Current Class Test" })
    vim.keymap.set("n", "<leader>f9", "<cmd>JavaTestRunCurrentMethod<CR>", { desc = "Run Current Method Test" })
    vim.keymap.set("n", "<leader>f10", "<cmd>JavaTestDebugCurrentMethod<CR>", { desc = "Debug Current Method Test" })
    vim.keymap.set("n", "<leader>f11", "<cmd>JavaTestViewLastReport<CR>", { desc = "View Last Test Report" })
    vim.keymap.set("n", "<leader>f12", "<cmd>JavaProfile<CR>", { desc = "Open Profiles UI" })

    -- Java refactor commands
    vim.keymap.set("n", "<leader>rv", "<cmd>JavaRefactorExtractVariable<CR>", { desc = "Extract Variable" })
    vim.keymap.set(
      "n",
      "<leader>ra",
      "<cmd>JavaRefactorExtractVariableAllOccurrence<CR>",
      { desc = "Extract Variable All" }
    )
    vim.keymap.set("n", "<leader>rc", "<cmd>JavaRefactorExtractConstant<CR>", { desc = "Extract Constant" })
    vim.keymap.set("n", "<leader>rm", "<cmd>JavaRefactorExtractMethod<CR>", { desc = "Extract Method" })
    vim.keymap.set("n", "<leader>rf", "<cmd>JavaRefactorExtractField<CR>", { desc = "Extract Field" })
    vim.keymap.set("n", "<leader>rs", "<cmd>JavaSettingsChangeRuntime<CR>", { desc = "Change Runtime" })

    -- Add command for running with arguments
    vim.api.nvim_create_user_command("JavaRunMainArgs", function(args)
      vim.cmd("JavaRunnerRunMain " .. args.args)
    end, { nargs = "*" })

    -- Command mode mapping (this is still needed)
    vim.keymap.set("c", "<leader>f3", "JavaRunMainArgs ", { desc = "Run Main with args" })

    -- Optionally register groups with which-key if you still want the grouping
    local which_key = require("which-key")
    which_key.add({
      ["<leader>f"] = { name = "+Java" },
      ["<leader>r"] = { name = "+Refactor" },
    })
  end,
}
