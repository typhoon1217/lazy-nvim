## Description

My Personal Nvim Config is tailored for Spring Boot Java backend development, providing a streamlined and efficient coding experience. It includes a variety of plugins and configurations to enhance productivity and code quality.

## Features

-   Enhanced code completion and navigation
-   Integration with LSP for Java development
-   Custom key mappings for common tasks
-   Support for popular plugins like Telescope, Treesitter, and more

## Dependencies

-   Neovim (version 0.9 or higher)
-   Java Development Kit (JDK)
-   Maven or Gradle

## Installation

```bash
git clone https://github.com/Typhoon-Team/nvim-config.git ~/.config/nvim
```

## Usage

1.  **Clone the repository:**

    ```bash
    git clone https://github.com/Typhoon-Team/nvim-config.git ~/.config/nvim
    ```

2.  **Start Neovim:**

    ```bash
    nvim
    ```

## Configuration

The configuration files are located in `~/.config/nvim`. You can modify the `init.lua` file to customize the settings according to your preferences.

### Key Mappings

Here are some of the key mappings:

| Key Combination | Description                      |
| :-------------- | :------------------------------- |
| `<leader>od`    | Create or edit daily note        |
| `<leader>ol`    | Create or edit Todo List          |
| `<leader>oc`    | Toggle Todo List Checkbox        |
| `<leader>of`    | Search Notes                     |
| `<leader>aA`    | avante: attach Copilot           |
| `<leader>aD`    | avante: detach Copilot           |
| `<leader>j b`   | Build Workspace                  |
| `<leader>j c`   | Clean Workspace                  |
| `<leader>j r`   | Run Main                         |
| `<leader>j s`   | Stop Main                        |
| `<leader>j l`   | Toggle Runner Logs               |
| `<leader>j d`   | Configure DAP                    |
| `<leader>j t`   | Run Current Class Test           |
| `<leader>j T`   | Debug Current Class Test         |
| `<leader>j m`   | Run Current Method Test          |
| `<leader>j M`   | Debug Current Method Test        |
| `<leader>j v`   | View Last Test Report            |
| `<leader>j p`   | Open Profiles UI                 |
| `<leader>j a`   | Extract Variable All             |
| `<leader>j C`   | Extract Constant                 |
| `<leader>j f`   | Extract Field                    |
| `<leader>j e`   | Extract Method                   |
| `<leader>j S`   | Change Runtime                   |
| `<leader>j x`   | Extract Variable                 |

### Plugins

Here's a brief overview of the plugins used in this configuration:

-   **lazy.nvim:** Plugin manager
-   **nvim-treesitter:** Syntax highlighting and code parsing
-   **nvim-lspconfig:** Language Server Protocol configuration
-   **telescope.nvim:** Fuzzy finder
-   **trouble.nvim:** Diagnostics list
-   **nvim-cmp:** Autocompletion framework
-   **nvim-java:** Java development support
-   **notesidian.nvim:** Note-taking plugin
-   **supermaven-nvim:** Code completion
-   **highlight-undo.nvim:** Highlight undo changes
-   **avante.nvim:** AI-powered code completion

## Customization

You can customize the configuration by modifying the Lua files in the `lua/plugins` directory. Each plugin has its own configuration file, allowing you to adjust settings to your liking.

## License

[MIT](LICENSE)

```


