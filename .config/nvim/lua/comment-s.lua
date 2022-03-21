require'Comment'.setup {
	ignore = '^$',
	padding = true,
	mappings = {basic = true, extra = false, extended = false},
	pre_hook = function(ctx)
		local U = require "Comment.utils"

		local location = nil
		if ctx.ctype == U.ctype.block then
			location = require'ts_context_commentstring.utils'.get_cursor_location()
		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			location = require'ts_context_commentstring.utils'.get_visual_start_location()
		end

		return require'ts_context_commentstring.internal'.calculate_commentstring {
			key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
			location = location,
		}
	end,
}
map("n", "<C-S-C>", "gcc")
map("v", "<C-S-C>", "gc")
map("i", "<C-S-C>", "<Esc>gcca")
map("x", "<C-S-X>", "gc")
map("n", "<C-S-X>", "gbc")
map("i", "<C-S-X>", "<Esc>gbca")
map("x", "<C-S-X>", "gb")
map("n", "<M-x>", "gca}")
map("i", "<M-x>", "<Esc>gca}a")
map("x", "<M-x>", "gb")
map("n", "<M-S-X>", "gbip")
map("i", "<M-S-X>", "<Esc>gbipa")
map("x", "<M-S-X>", "gb")
map("x", "<M-c>", "gc")
map("n", "<M-C>", "gcip")
map("i", "<M-C>", "<Esc>gcipa")
map("x", "<M-C>", "gc")
