return {
  "sei40kr/jupyter.nvim",
  build = ":UpdateRemotePlugins",
  config = function()
    require("jupyter").setup({
      default_kernel = "python3",
    })

    local KERNEL_BOUND_KEYS = {
      "<M-CR>",
      "<leader>jj",
      "<leader>ja",
      "<leader>jc",
      "<leader>jC",
      "<leader>jr",
      "<leader>jq",
      "<leader>ji",
    }

    -- Editing verbs: always available on supported filetypes
    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "python", "julia", "r" },
      callback = function(ev)
        local jupyter = require("jupyter")
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, silent = true, desc = desc })
        end

        -- Cell navigation (bracket-motion family: ]d, ]g, ]q, ]j…)
        map("]j", jupyter.next_cell, "Next Cell")
        map("[j", jupyter.prev_cell, "Previous Cell")

        -- Cell editing
        map("<leader>jo", jupyter.insert_cell_below, "Insert Cell Below")
        map("<leader>jO", jupyter.insert_cell_above, "Insert Cell Above")
        map("<leader>jd", jupyter.delete_cell, "Delete Cell")
        map("<leader>jm", jupyter.merge_with_prev, "Merge with Previous")
        map("<leader>js", jupyter.split_at_cursor, "Split Cell at Cursor")

        -- Kernel lifecycle entry point
        map("<leader>jk", function()
          jupyter.start_kernel()
        end, "Start Kernel")
      end,
    })

    -- Kernel-bound verbs: live only between JupyterKernelReady and JupyterDeinitPre
    vim.api.nvim_create_autocmd("User", {
      pattern = "JupyterKernelReady",
      callback = function(ev)
        local jupyter = require("jupyter")
        local function map(lhs, rhs, desc)
          vim.keymap.set("n", lhs, rhs, { buffer = ev.data.bufnr, silent = true, desc = desc })
        end

        map("<M-CR>", jupyter.execute_and_advance, "Execute Cell and Advance")
        map("<leader>jj", jupyter.execute_cell, "Execute Cell")
        map("<leader>ja", jupyter.execute_all, "Execute All Cells")
        map("<leader>jc", jupyter.clear_cell, "Clear Cell Output")
        map("<leader>jC", jupyter.clear_all_outputs, "Clear All Outputs")
        map("<leader>jr", jupyter.restart_kernel, "Restart Kernel")
        map("<leader>jq", jupyter.stop_kernel, "Stop Kernel")
        map("<leader>ji", jupyter.hover, "Inspect Symbol")
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      pattern = "JupyterDeinitPre",
      callback = function(ev)
        for _, lhs in ipairs(KERNEL_BOUND_KEYS) do
          pcall(vim.keymap.del, "n", lhs, { buffer = ev.data.bufnr })
        end
      end,
    })
  end,
}
