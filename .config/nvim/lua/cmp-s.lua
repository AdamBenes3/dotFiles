---@diagnostic disable: redundant-parameter
require'luasnip/loaders/from_vscode'.lazy_load()
local kind_icons = {
	Text = "  ",
	Method = "  ",
	Function = "  ",
	Constructor = "  ",
	Field = "  ",
	Variable = "  ",
	Class = " ﰮ ",
	Interface = "  ",
	Module = "  ",
	Property = " 襁",
	Unit = "  ",
	Value = "  ",
	Enum = " 練",
	Keyword = "  ",
	Snippet = "  ",
	Color = "  ",
	File = "  ",
	Folder = "  ",
	Reference = "  ",
	EnumMember = "  ",
	Constant = " ﲀ ",
	Struct = " ﳤ ",
	Event = "  ",
	Operator = "  ",
	TypeParameter = "  ",
}

vim.o.completeopt = "menu,menuone,noselect"
local cmp = require "cmp"
local luasnip = require "luasnip"
cmp.setup {
	snippet = {expand = function(args) luasnip.lsp_expand(args.body) end},
	mapping = {
		['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), {"i", "c"}),
		['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), {"i", "c"}),
		['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), {"i", "c"}),
		['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		['<Esc>'] = cmp.mapping({i = cmp.mapping.abort(), c = cmp.mapping.close()}),
		['<CR>'] = cmp.mapping({
			i = cmp.mapping.confirm({behavior = cmp.ConfirmBehavior.Replace, select = false}),
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif cmp.get_selected_entry() ~= nil and luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			else
				fallback()
			end
		end, {"i", "s"}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {"i", "s"}),
	},
	formatting = {
		format = function(entry, item)
			local name = entry.source.name
			item.kind = name == "nvim_lua" and "  " or name == "calc" and "  " or name == "buffer" and
							            "  " or name == "latex_symbols" and "  " or name == "emoji" and "" or
							            kind_icons[item.kind]
			item.menu = ""
			return item
		end,
	},
	completion = {keyword_length = 2},
	documentation = {border = {"╭", "─", "╮", "│", "╯", "─", "╰", "│"}},
	experimental = {ghost_text = true},
	sources = cmp.config.sources {
		{name = "nvim_lua"},
		{name = "nvim_lsp"},
		{name = "luasnip"},
		{name = "calc"},
		{name = "path"},
		{name = "emoji"},
		-- {name = "latex_symbols"},
		-- {name = "buffer"}
	},
}

cmp.setup.cmdline(":", {sources = {{name = "cmdline"}, {name = "path"}}})
cmp.setup.cmdline("/", {sources = {{name = "buffer"}}})

_G.capabilities = require'cmp_nvim_lsp'.update_capabilities(vim.lsp.protocol
				                                                            .make_client_capabilities())
vim.cmd("hi link CompeDocumentation Pmenu")
