return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-mini/mini.nvim",
    },

    opts = function(_, opts)
      opts.preset = "obsidian"

      opts.heading = opts.heading or {}
      opts.heading.icons = {
        "󰲡 ",
        "󰲣 ",
        "󰲥 ",
        "󰲧 ",
        "󰲩 ",
        "󰲫 ",
      }

      opts.checkbox = {
        enabled = true,
      }

      -- render-latex.nvim will handle LaTeX instead
      opts.latex = {
        enabled = false,
      }

      return opts
    end,
  },

  {
    "techwizrd/render-latex.nvim",
    ft = "markdown",
    opts = {},
  },
}
