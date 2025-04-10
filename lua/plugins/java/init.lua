return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      event = "BufReadPre",
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
            -- Your nvim-java configuration
            require("java").setup({
              --  list of file that exists in root of the project
              root_markers = {
                "settings.gradle",
                "settings.gradle.kts",
                "pom.xml",
                "build.gradle",
                "mvnw",
                "gradlew",
                "build.gradle",
                "build.gradle.kts",
                ".git",
              },
              jdtls = {
                version = "v1.43.0",
              },
              lombok = {
                version = "nightly",
              },
              -- load java test plugins
              java_test = {
                enable = true,
                version = "0.40.1",
              },
              -- load java debugger plugins
              java_debug_adapter = {
                enable = true,
                version = "0.58.1",
              },
              spring_boot_tools = {
                enable = true,
                version = "1.55.1",
              },
              jdk = {
                -- install jdk using mason.nvim
                auto_install = true,
                version = "17.0.2",
              },
              notifications = {
                -- enable 'Configuring DAP' & 'DAP configured' messages on start up
                dap = true,
              },
              verification = {
                invalid_order = true,
                duplicate_setup_calls = true,
                invalid_mason_registry = false,
              },
              mason = {
                registries = {
                  "github:nvim-java/mason-registry",
                },
              },
            })

            -- Setup the which-key mappings using a simpler approach
            local wk = require("which-key")

            -- Register for normal mode
            wk.register({
              ["<leader><leader>"] = {
                f = {
                  name = "Java Build/Run",
                  ["1"] = { ":JavaBuildBuildWorkspace<CR>", "Build Workspace" },
                  ["2"] = { ":JavaBuildCleanWorkspace<CR>", "Clean Workspace" },
                  ["3"] = { ":JavaRunnerRunMain<CR>", "Run Main" },
                  ["4"] = { ":JavaRunnerStopMain<CR>", "Stop Main" },
                  ["5"] = { ":JavaRunnerToggleLogs<CR>", "Toggle Runner Logs" },
                  ["6"] = { ":JavaDapConfig<CR>", "Configure DAP" },
                  ["7"] = { ":JavaTestRunCurrentClass<CR>", "Run Current Class Test" },
                  ["8"] = { ":JavaTestDebugCurrentClass<CR>", "Debug Current Class Test" },
                  ["9"] = { ":JavaTestRunCurrentMethod<CR>", "Run Current Method Test" },
                  ["10"] = { ":JavaTestDebugCurrentMethod<CR>", "Debug Current Method Test" },
                  ["11"] = { ":JavaTestViewLastReport<CR>", "View Last Test Report" },
                  ["12"] = { ":JavaProfile<CR>", "Open Profiles UI" },
                },
                r = {
                  name = "Java Refactoring",
                  a = { ":JavaRefactorExtractVariableAllOccurrence<CR>", "Extract Variable All" },
                  c = { ":JavaRefactorExtractConstant<CR>", "Extract Constant" },
                  f = { ":JavaRefactorExtractField<CR>", "Extract Field" },
                  m = { ":JavaRefactorExtractMethod<CR>", "Extract Method" },
                  s = { ":JavaSettingsChangeRuntime<CR>", "Change Runtime" },
                  v = { ":JavaRefactorExtractVariable<CR>", "Extract Variable" },
                },
              },
            })

            -- Add keymaps for JavaRunnerRunMain with arguments
            vim.api.nvim_create_user_command("JavaRunMainArgs", function(args)
              vim.cmd("JavaRunnerRunMain " .. args.fargs)
            end, { nargs = "*" })

            -- For command mode mapping, use vim.keymap.set instead of which-key
            vim.keymap.set("c", "<leader><leader>f3", "JavaRunMainArgs ", { desc = "Run Main with args" })
          end,
        },
      },
    },
  },
  -- Ensure the plugin loads for Java files
  ft = { "java" },
}
