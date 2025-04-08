return{
	{
		"echasnovski/mini.nvim",
		enabled = true, -- make it false to switch it off
		config = function()
			local statusline = require 'mini.statusline'
			statusline.setup {use_icons = true}
			require('mini.ai').setup { n_lines = 500 }

			-- Add/delete/replace surroundings (brackets, quotes, etc.)
			--
			-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
			-- - sd'   - [S]urround [D]elete [']quotes
			-- - sr)'  - [S]urround [R]eplace [)] [']
			require('mini.surround').setup()
	  
			-- Simple and easy statusline.
			--  You could remove this setup call if you don't like it,
			--  and try some other statusline plugin
			local statusline = require 'mini.statusline'
			-- set use_icons to true if you have a Nerd Font
			statusline.setup { use_icons = vim.g.have_nerd_font }
	  
			-- You can configure sections in the statusline by overriding their
			-- default behavior. For example, here we set the section for
			-- cursor location to LINE:COLUMN
			---@diagnostic disable-next-line: duplicate-set-field
			statusline.section_location = function()
			  return '%2l:%-2v'
			end
		end,
	},
	--{'github/copilot.vim',},
  { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },
  {
    'chipsenkbeil/distant.nvim', 
    branch = 'v0.3',
    config = function()
        require('distant'):setup()
    end
},
}
