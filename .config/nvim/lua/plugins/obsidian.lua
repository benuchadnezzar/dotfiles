local vault = vim.fn.expand("~/Documents/Obsidian Vault")

return {
  "obsidian-nvim/obsidian.nvim",
  version = "*",

  ft = "markdown",
  cmd = "Obsidian",

  keys = {
    {
      "<leader>ov",
      "<cmd>Obsidian display<cr>",
      desc = "Obsidian vault",
    },
  },

  opts = {
    legacy_commands = false,

    workspaces = {
      {
        name = "personal",
        path = vault,
      },
    },

    note_id_func = function(title)
      if title and title ~= "" then
        return title
      end

      return require("obsidian.builtin").zettel_id()
    end,

    frontmatter = {
      func = function(note)
        local out = require("obsidian.builtin").frontmatter(note)

        out.id = nil

        return out
      end,
    },

    templates = {
      folder = "Templates",
    },

    callbacks = {
      post_setup = function()
        require("obsidian").register_command("display", {
          nargs = 0,

          func = function()
            Snacks.picker.explorer({
              cwd = vault,
              tree = true,
              auto_close = true,

              layout = {
                preview = false,
                layout = {
                  box = "vertical",
                  position = "float",
                  width = 0.55,
                  height = 0.70,
                  border = "rounded",

                  {
                    win = "input",
                    height = 1,
                    border = "bottom",
                    title = " 󰠮 Obsidian Vault ",
                    title_pos = "center",
                  },

                  {
                    win = "list",
                  },
                },
              },
            })
          end,
        })
      end,
    },
    ui = {
      enable = false,
    },
  },
}
