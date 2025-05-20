return {
  -- LSP Configuration for Dart/Flutter
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP Installer for easy setup of 'dartls'
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    opts = {
      servers = {
        -- Dart LSP configuration
        dartls = {
          -- This is typically handled by mason-lspconfig, but explicitly setting
          -- cmd or root_dir can be useful for specific setups.
          -- Example:
          -- cmd = { "dart", "language-server", "--protocol=lsp" },
          -- filetypes = { "dart" },
          -- root_dir = function(fname)
          --   return require('lspconfig.util').root_pattern("pubspec.yaml")(fname)
          -- end,
          settings = {
            dart = {
              -- You can add specific Dart LSP settings here
              -- For example, to enable "organize imports on save"
              completeFunctionCalls = true,
              showTodos = true,
              analysisExcludedFolders = {
                "**/.dart_tool/**",
                "**/.fvm/**",
              },
            },
          },
        },
      },
    },
    ---@param opts lspconfig.options
    ---@param client_capabilities table
    ---@param config table
    ---@param client vim.lsp.Client
    ---@param bufnr number
    ---@param lsp_options table
    config = function(_, _, _, _, _)
      require("mason-lspconfig").setup({
        ensure_installed = { "dartls" },
      })
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            on_attach = function(client, bufnr)
              -- Recommended keymaps for LSP. LazyVim usually sets up default ones.
              -- If you want custom keymaps for Dart, define them here.
              -- For example, for "organize imports"
              if client.name == "dartls" then
                vim.keymap.set("n", "<leader>so", function()
                  vim.lsp.buf.execute_command({
                    command = "dart.organizeImports",
                    arguments = { vim.api.nvim_buf_get_name(bufnr) },
                  })
                end, { desc = "Organize Imports" })
              end
            end,
            settings = {
              dart = {
                completeFunctionCalls = true,
                showTodos = true,
              },
            },
          })
        end,
      })
    end,
  },

  -- Debugging with nvim-dap
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- Debugger UI (Optional but highly recommended)
      "rcarriga/nvim-dap-ui",
      -- Adapters for nvim-dap (Flutter/Dart specifically)
      "nvim-telescope/telescope-dap.nvim", -- Optional: for fuzzy finding dap configurations
    },
    opts = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup({
        -- UI configurations for the debugger
        elements = {
          -- Example elements, adjust as needed
          "scopes",
          "breakpoints",
          "stacks",
          "watches",
          "repl",
          "console",
        },
        layouts = {
          {
            elements = {
              { id = "scopes", size = 0.35 },
              { id = "breakpoints", size = 0.25 },
              { id = "stacks", size = 0.4 },
            },
            size = 0.3,
            position = "left",
          },
          {
            elements = {
              { id = "repl", size = 0.5 },
              { id = "watches", size = 0.5 },
            },
            size = 0.2,
            position = "bottom",
          },
        },
      })

      dap.listeners.after.event("initialized", function()
        dapui.open()
      end)
      dap.listeners.before.event("terminated", function()
        dapui.close()
      end)
      dap.listeners.before.event("disconnected", function()
        dapui.close()
      end)

      -- Flutter/Dart DAP configuration
      -- The 'dart-debug-adapter' is often installed globally with Dart SDK,
      -- or can be found in your Flutter SDK path.
      -- If not, you might need to install it: `dart pub global activate dart_debug_adapter`
      dap.adapters.dart = {
        type = "server",
        host = "127.0.0.1",
        port = 8123, -- Or whatever port the debug adapter listens on
        executable = {
          command = "dart",
          args = { "debug_adapter" },
        },
      }

      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch current file (Dart)",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
      }

      -- For Flutter projects, you'll want to specify the entry point
      -- This is typically `lib/main.dart` for a standard Flutter app.
      -- The `tool.flutter_tools` path is essential for hot reload/restart,
      -- device selection, etc.
      dap.configurations.dart = {
        {
          type = "dart",
          request = "launch",
          name = "Launch Flutter app",
          program = "${workspaceFolder}/lib/main.dart", -- Adjust if your entry point is different
          tool = "flutter_tools", -- This is crucial!
          flutterMode = "debug", -- "debug", "profile", "release"
          cwd = "${workspaceFolder}",
          args = {},
          deviceId = nil, -- You can specify a device ID here (e.g., "emulator-5554")
          -- if deviceId is nil, it will prompt you to choose one
        },
        {
          type = "dart",
          request = "attach",
          name = "Attach to Flutter app",
          tool = "flutter_tools",
          -- The port will usually be discovered automatically if you use `flutter attach`
          -- Or you can specify it if you know it.
        },
      }
    end,
    keys = {
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "DAP Continue",
      },
      {
        "<leader>dt",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "DAP Toggle Breakpoint",
      },
      {
        "<leader>dpc",
        function()
          require("dap").set_breakpoint(nil, nil, vim.fn.input("Condition: "))
        end,
        desc = "DAP Set Conditional Breakpoint",
      },
      {
        "<leader>dr",
        function()
          require("dap").repl.toggle()
        end,
        desc = "DAP Toggle REPL",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "DAP Toggle UI",
      },
      {
        "<leader>ds",
        function()
          require("dap").step_over()
        end,
        desc = "DAP Step Over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "DAP Step Into",
      },
      {
        "<leader>do",
        function()
          require("dap").step_out()
        end,
        desc = "DAP Step Out",
      },
      {
        "<leader>dgr",
        function()
          require("dap").run_last()
        end,
        desc = "DAP Run Last",
      },
      {
        "<leader>drt",
        function()
          require("dap.repl").open()
        end,
        desc = "DAP Open REPL",
      },
      {
        "<leader>dL",
        function()
          require("dap.ui.variables").hover()
        end,
        desc = "DAP Hover Variable",
      },
    },
  },

  -- Flutter Specific Tools (Hot Reload, Devices, etc.)
  {
    "akinsho/flutter-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim", -- A common dependency for many plugins
      "mfussenegger/nvim-dap", -- Ensure nvim-dap is configured
    },
    ft = "dart", -- Only load for dart files
    opts = {
      -- You can configure various aspects of flutter-tools here
      -- See: https://github.com/akinsho/flutter-tools.nvim#options
      lsp = {
        -- You can disable the LSP handled by flutter-tools if you prefer
        -- to manage it completely with nvim-lspconfig and mason-lspconfig.
        -- If you set `enabled = false` here, ensure your `dartls` config
        -- in `nvim-lspconfig` is robust.
        enabled = true,
        -- If enabled, flutter-tools will automatically setup dartls.
        -- It might conflict with nvim-lspconfig's setup, so choose one.
        -- For LazyVim, it's often better to let `nvim-lspconfig` manage `dartls`.
        -- So, you might want to set `enabled = false` here and ensure your `dartls`
        -- config in `nvim-lspconfig` is correct.
        -- Example of disabling it:
        -- enabled = false,
        -- settings = { -- This would be passed to `dartls`
        --   dart = {
        --     completeFunctionCalls = true,
        --   },
        -- },
      },
      debugger = {
        enabled = true,
        -- Set to false if you want to use a different DAP adapter setup
        -- or if nvim-dap is already fully configured for Dart.
        -- However, flutter-tools' debugger integration is quite good.
        -- This will automatically configure `dap.adapters.dart` and `dap.configurations.dart`
        -- for you, making it easier.
      },
      dev_log = {
        enabled = true,
        -- The size of the dev log window, if enabled.
        size = 80,
      },
      closing_tags = {
        -- Automatically close Flutter widgets with a closing tag.
        -- This is very helpful for readability.
        enabled = true,
        -- Exclude specific widgets if needed (e.g., those that don't take children)
        exclude = {},
      },
      widget_guides = {
        enabled = true, -- Visual guides for widget trees
        indent = 2,
      },
      -- If you want to enable hot reload on save
      hot_reload_on_save = false, -- Set to true if you prefer hot reload on save
      hot_restart_on_save = false, -- Set to true if you prefer hot restart on save
      -- Command to run flutter, e.g., 'flutter' or '/path/to/your/flutter/bin/flutter'
      flutter_path = "flutter",
      -- These options will be passed to `flutter_tools` commands
      -- E.g., `flutter run --device chrome`
      run_via_dap = true, -- Recommended for debugging integration
      -- Flutter commands and their keybinds
      ui = {
        border = "rounded", -- "rounded", "single", "double", "none"
        active = "Diagnostic",
        padding = 1,
        floating = {
          max_width = 80,
          max_height = 0.9,
          -- Other floating window options for various popups
        },
      },
    },
    keys = {
      -- You can remap or add your own keybindings here
      {
        "<leader>fr",
        function()
          require("flutter-tools").run()
        end,
        desc = "Flutter Run",
      },
      {
        "<leader>fR",
        function()
          require("flutter-tools").restart()
        end,
        desc = "Flutter Hot Restart",
      },
      {
        "<leader>fh",
        function()
          require("flutter-tools").hot_reload()
        end,
        desc = "Flutter Hot Reload",
      },
      {
        "<leader>fD",
        function()
          require("flutter-tools").dev_log_toggle()
        end,
        desc = "Flutter Toggle Dev Log",
      },
      {
        "<leader>fd",
        function()
          require("flutter-tools").device_select()
        end,
        desc = "Flutter Select Device",
      },
      {
        "<leader>fp",
        function()
          require("flutter-tools").start_performance_overlay()
        end,
        desc = "Flutter Performance Overlay",
      },
      {
        "<leader>fs",
        function()
          require("flutter-tools").stop()
        end,
        desc = "Flutter Stop",
      },
      {
        "<leader>fT",
        function()
          require("flutter-tools").open_timeline()
        end,
        desc = "Flutter Open Timeline",
      },
      {
        "<leader>fc",
        function()
          require("flutter-tools").clean()
        end,
        desc = "Flutter Clean",
      },
      {
        "<leader>fg",
        function()
          require("flutter-tools").generate_localizations()
        end,
        desc = "Flutter Generate Localizations",
      },
      {
        "<leader>fu",
        function()
          require("flutter-tools").upgrade()
        end,
        desc = "Flutter Upgrade",
      },
      {
        "<leader>ff",
        function()
          require("flutter-tools").fix()
        end,
        desc = "Flutter Fix",
      },
    },
  },

  --
  -- -- Snippet engine (LazyVim usually defaults to `luasnip`)
  -- {
  --   "L3MON4D3/LuaSnip",
  --   -- If you want custom Flutter snippets, this is where you'd add them.
  --   -- LazyVim might have a dedicated place for snippets, check your config.
  --   -- Example (basic, you'd define more robust ones):
  --   -- config = function(plugin, opts)
  --   --   require("luasnip").setup.load_snips({ paths = { "~/.config/nvim/lua/custom-snippets" } })
  --   -- end,
  -- },
  --
  -- -- Autocomplete (LazyVim typically uses `nvim-cmp`)
  -- {
  --   "hrsh7th/nvim-cmp",
  --   dependencies = {
  --     "saadparwaiz1/cmp_luasnip",
  --     "hrsh7th/cmp-nvim-lsp", -- For LSP completion
  --     -- Add any other cmp sources you use
  --   },
  --   -- Ensure cmp is configured to use LSP and snippets for Dart files.
  --   -- LazyVim's default cmp setup usually handles this well.
  --   -- You might not need to add anything specific here unless you want
  --   -- very fine-grained control for Dart.
  -- },
}
