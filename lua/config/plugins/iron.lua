return{
'Vigemus/iron.nvim',
  config = function()
  local iron = require("iron.core")
local view = require("iron.view")
local common = require("iron.fts.common")

iron.setup {
  config = {
    -- Whether a repl should be discarded or not
    scratch_repl = true,
    -- Your repl definitions come here
    repl_definition = {
      sh = {
        -- Can be a table or a function that
        -- returns a table (see below)
        command = {"zsh"}
      },
      python = {
        command = { "ipython" },  -- or { "ipython", "--no-autoindent" }
        format = common.bracketed_paste_python,
        block_dividers = { "# %%", "#%%" },
      }
    },
    -- set the file type of the newly created repl to ft
    -- bufnr is the buffer id of the REPL and ft is the filetype of the 
    -- language being used for the REPL. 
    repl_filetype = function(bufnr, ft)
      return ft
      -- or return a string name such as the following
      -- return "iron"
    end,
    -- How the repl window will be displayed
    -- See below for more information
    --repl_open_cmd = view.bottom(40)


    -- repl_open_cmd can also be an array-style table so that multiple 
    -- repl_open_commands can be given.
    -- When repl_open_cmd is given as a table, the first command given will
    -- be the command that `IronRepl` initially toggles.
    -- Moreover, when repl_open_cmd is a table, each key will automatically
    -- be available as a keymap (see `keymaps` below) with the names 
    -- toggle_repl_with_cmd_1, ..., toggle_repl_with_cmd_k
    -- For example,
    -- 
     repl_open_cmd = {
       view.split.vertical.rightbelow("%50"), -- cmd_1: open a repl to the right
       view.split.rightbelow("%25")  -- cmd_2: open a repl below
     }

  },
  -- Iron doesn't set keymaps by default anymore.
  -- You can set them here or manually add keymaps to the functions in iron.core
  keymaps = {
    toggle_repl = "<space>rr", -- toggles the repl open and closed.
    -- If repl_open_command is a table as above, then the following keymaps are
    -- available
    -- toggle_repl_with_cmd_1 = "<space>rv",
    -- toggle_repl_with_cmd_2 = "<space>rh",
    restart_repl = "<leader>rR", -- calls `IronRestart` to restart the repl
    send_motion = "<leader>sc",
    visual_send = "<space>sc",
    send_file = "<space>sf",
    send_line = "<space>sl",
    send_paragraph = "<space>sp",
    send_until_cursor = "<space>su",
    send_mark = "<space>sm",
    send_code_block = "<space>sb",
    send_code_block_and_move = "<space>sn",
    mark_motion = "<space>mc",
    mark_visual = "<space>mc",
    remove_mark = "<space>md",
    cr = "<space>s<cr>",
    interrupt = "<space>s<space>",
    exit = "<space>sq",
    clear = "<space>cl",
  },
  -- If the highlight is on, you can change how it looks
  -- For the available options, check nvim_set_hl
  highlight = {
    italic = true
  },
  ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<space>rf', '<cmd>IronFocus<cr>')
vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')
vim.keymap.set("n", "<S-CR>", function()
  local start_line = vim.fn.search("# %%", "bnW")
  local end_line = vim.fn.search("# %%", "nW")

  -- If we're at the last cell, send till the end of the file
  if end_line == 0 then
    end_line = vim.fn.line("$")
  else
    end_line = end_line - 1
  end

  -- Send the lines as a range
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  require("iron.core").send(nil, lines)
end, { desc = "Send Jupyter cell" })

vim.keymap.set("n", "<localleader>ll", function()
  -- Get visual selection range

  local start_line = vim.fn.search("# %%","bnW")
  local end_line = vim.fn.search("# %%","nW")
  if end_line == 0 then
    end_line = vim.fn.line("$")
  else
    end_line = end_line - 1
  end
      
  --if start_line > end_line then
    --start_line, end_line = end_line, start_line
  --end
  print("Start line:", start_line)
  print("End line:", end_line)
  -- Get the selected lines  
  local filtered_lines = {}
  for _, line in ipairs(lines) do
    if not line:match("^# %%") then
      table.insert(filtered_lines, line)
    end
  end
  --local lines = vim.api.nvim_buf_get_lines(1, start_line - 1, end_line, false)
  local code_block = table.concat(filtered_lines, "\n") -- Join with newlines + 2x newline to flush execution

  -- Send as one block string
  require("iron.core").send(nil, { code_block })
end, { desc = "Send block to REPL as one execution", noremap = true, silent = true })
end
  }
  
