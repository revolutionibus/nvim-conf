return{
    {
	"L3MON4D3/LuaSnip",
	-- follow latest release.
	version = "v2.2.0", -- Replace <CurrentMajor> by the latest released major (first number of latest release)

	-- install jsregexp (optional!).
	-- build = "make install_jsregexp"

	config = function()
		local ls = require("luasnip")
		-- Require the snippets file
		local tex_snippets = require 'config.snippets.tex'  -- Ensure this path is correct

		-- Key mappings for LuaSnip
		vim.keymap.set("i", "<C-k>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			end
		end, { silent = true })
		vim.keymap.set("i", "<C-n>", function() ls.jump(-1) end, { silent = true }) -- Jump to previous snippet
		vim.keymap.set("i", "<C-c>", function() ls.choice_active() end, { silent = true }) -- Choose option in choice node
    end
}
}