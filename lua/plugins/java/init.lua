return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          jdtls = {
            settings = {
              java = {
                configuration = {
                  runtimes = {
                    {
                      name = "openjdk-17",
                      path = "/usr/bin/java",
                    },
                  },
                },
              },
            },
          },
        },
        setup = {
          jdtls = function()
            -- Your nvim-java configuration goes here
            require("java").setup({
              root_markers = {
                "settings.gradle",
                "settings.gradle.kts",
                "pom.xml",
                "build.gradle",
                "mvnw",
                "gradlew",
                "build.gradle",
                "build.gradle.kts",
              },
            })

            local wk = require("which-key")

            wk.register({
              ["<leader>f1"] = { ":JavaBuildBuildWorkspace<CR>", "Build Workspace" },
              ["<leader>f2"] = { ":JavaBuildCleanWorkspace<CR>", "Clean Workspace" },
              ["<leader>f3"] = { ":JavaRunnerRunMain<CR>", "Run Main" },
              ["<leader>f4"] = { ":JavaRunnerStopMain<CR>", "Stop Main" },
              ["<leader>f5"] = { ":JavaRunnerToggleLogs<CR>", "Toggle Runner Logs" },
              ["<leader>f6"] = { ":JavaDapConfig<CR>", "Configure DAP" },
              ["<leader>f7"] = { ":JavaTestRunCurrentClass<CR>", "Run Current Class Test" },
              ["<leader>f8"] = { ":JavaTestDebugCurrentClass<CR>", "Debug Current Class Test" },
              ["<leader>f9"] = { ":JavaTestRunCurrentMethod<CR>", "Run Current Method Test" },
              ["<leader>f10"] = { ":JavaTestDebugCurrentMethod<CR>", "Debug Current Method Test" },
              ["<leader>f11"] = { ":JavaTestViewLastReport<CR>", "View Last Test Report" },
              ["<leader>f12"] = { ":JavaProfile<CR>", "Open Profiles UI" },
              ["<leader>rv"] = { ":JavaRefactorExtractVariable<CR>", "Extract Variable" },
              ["<leader>ra"] = { ":JavaRefactorExtractVariableAllOccurrence<CR>", "Extract Variable All" },
              ["<leader>rc"] = { ":JavaRefactorExtractConstant<CR>", "Extract Constant" },
              ["<leader>rm"] = { ":JavaRefactorExtractMethod<CR>", "Extract Method" },
              ["<leader>rf"] = { ":JavaRefactorExtractField<CR>", "Extract Field" },
              ["<leader>rs"] = { ":JavaSettingsChangeRuntime<CR>", "Change Runtime" },
            }, { prefix = "<leader>", mode = "n", silent = true })

            -- Add keymaps for JavaRunnerRunMain with arguments
            vim.api.nvim_create_user_command("JavaRunMainArgs", function(args)
              vim.cmd("JavaRunnerRunMain " .. args.fargs)
            end, { nargs = "*" })

            wk.register({
              ["<leader>f3"] = { ":JavaRunMainArgs ", "Run Main with args" },
            }, { prefix = "<leader>", mode = "c", silent = true })
          end,
        },
      },
    },
  },
}
