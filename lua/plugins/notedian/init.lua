return {
  "gokhangeyik/notesidian.nvim",
  -- "notesidian.nvim",
  lazy = true,
  -- enabled = false,
  -- dev = true,
  -- event = "VeryLazy",
  opts = {
    notes_root = "$NOTES",
  },
  keys = {
    {
      "<leader>od",
      function()
        require("notesidian").create_daily_note()
      end,
      desc = "Create or edit daily note",
    },
    {
      "<leader>ol",
      function()
        require("notesidian").create_todo_list()
      end,
      desc = "Create or edit Todo List",
    },
    {
      "<leader>oc",
      function()
        require("notesidian").toggle_checkbox()
      end,
      desc = "Toggle Todo List Checkbox",
    },
    {
      "<leader>of",
      function()
        require("notesidian").find_notes()
      end,
      desc = "Search Notes",
    },
  },
}
