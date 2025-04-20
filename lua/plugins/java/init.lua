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
          jdtls = function() -- Your nvim-java configuration
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

            -- Setup the which-key spec for Java
            require("which-key").setup({
              spec = {
                { "<leader>j", group = "[J]ava", icon = "☕" }, -- Add this to your existing spec
              },
            })

            -- Register Java keybindings using correct which-key pattern
            require("which-key").register({
              j = {
                name = "Java",
                -- Build/Run commands
                b = { ":JavaBuildBuildWorkspace<CR>", "Build Workspace" },
                c = { ":JavaBuildCleanWorkspace<CR>", "Clean Workspace" },
                r = { ":JavaRunnerRunMain<CR>", "Run Main" },
                s = { ":JavaRunnerStopMain<CR>", "Stop Main" },
                l = { ":JavaRunnerToggleLogs<CR>", "Toggle Runner Logs" },
                d = { ":JavaDapConfig<CR>", "Configure DAP" },
                t = { ":JavaTestRunCurrentClass<CR>", "Run Current Class Test" },
                T = { ":JavaTestDebugCurrentClass<CR>", "Debug Current Class Test" },
                m = { ":JavaTestRunCurrentMethod<CR>", "Run Current Method Test" },
                M = { ":JavaTestDebugCurrentMethod<CR>", "Debug Current Method Test" },
                v = { ":JavaTestViewLastReport<CR>", "View Last Test Report" },
                p = { ":JavaProfile<CR>", "Open Profiles UI" },

                -- Refactoring commands
                a = { ":JavaRefactorExtractVariableAllOccurrence<CR>", "Extract Variable All" },
                C = { ":JavaRefactorExtractConstant<CR>", "Extract Constant" },
                f = { ":JavaRefactorExtractField<CR>", "Extract Field" },
                e = { ":JavaRefactorExtractMethod<CR>", "Extract Method" },
                S = { ":JavaSettingsChangeRuntime<CR>", "Change Runtime" },
                x = { ":JavaRefactorExtractVariable<CR>", "Extract Variable" },
              },
            }, { prefix = "<leader>" })

            -- Add keymaps for JavaRunnerRunMain with arguments
            vim.api.nvim_create_user_command("JavaRunMainArgs", function(args)
              vim.cmd("JavaRunnerRunMain " .. args.fargs)
            end, { nargs = "*" })

            -- Command mode mapping for running with arguments
            vim.keymap.set("c", "<leader>jr", "JavaRunMainArgs ", { desc = "Run Main with args" })
          end,
        },
      },
    },
  },
  -- Ensure the plugin loads for Java files
  ft = { "java" },
}
