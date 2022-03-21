local gl = require "galaxyline"
local gls = gl.section

local condition = require "galaxyline.condition"
gl.short_line_list = {"NvimTree", "dbui", "packer", "startify", "help", "rnvimr"}

local mode_color = {
	n = "Contrast",
	i = "Highlight",
	v = "Yellow",
	[""] = "Yellow",
	V = "Yellow",
	c = "LightRed",
	no = "LightContrast",
	s = "Orange",
	S = "Orange",
	[""] = "Orange",
	ic = "Yellow",
	R = "Red",
	Rv = "Red",
	cv = "Blue",
	ce = "LightBlue",
	r = "Cyan",
	rm = "LightCyan",
	["r?"] = "LightCyan",
	["!"] = "Blue",
	t = "Red",
}
gls.left[1] = {
	ViMode = {
		provider = function()
			-- auto change color according the vim mode
			hi("GalaxyViMode", mode_color[vim.fn.mode()], "Black")
			return "▊"
		end,
		highlight = {"NONE", colours.Black[1]},
	},
}
vim.fn.getbufvar(0, "ts")

gls.left[2] = {
	BufferIcon = {provider = "BufferIcon", highlight = {colours.LightGrey[1], colours.Black[1]}},
}

gls.left[3] = {
	Permission = {
		provider = function() if vim.bo.readonly then return "" end end,
		separator = " ",
		separator_highlight = {"NONE", colours.Black[1]},
		highlight = {colours.Orange[1], colours.Black[1]},
	},
}

--[[
gls.left[4] = {
	GitBranch = {
		provider = 'GitBranch',
		condition = condition.check_git_workspace,
		icon = ' ',
		separator = ' ',
		separator_highlight = {'NONE', colours.Black[1]},
		highlight = {colours.LightGrey[1], colours.Black[1]},
	},
}
gls.left[5] = {
	DiffAdd = {
		provider = 'DiffAdd',
		condition = condition.hide_in_width,
		icon = ' ',
		highlight = {colours.Green[1], colours.Black[1]},
	},
}
gls.left[6] = {
	DiffModified = {
		provider = 'DiffModified',
		condition = condition.hide_in_width,
		icon = '柳',
		highlight = {colours.Blue[1], colours.Black[1]},
	},
}
gls.left[7] = {
	DiffRemove = {
		provider = 'DiffRemove',
		condition = condition.hide_in_width,
		icon = ' ',
		highlight = {colours.Red[1], colours.Black[1]},
	},
}
]]

gls.right = {
	{
		WordCount = {
			provider = function()
				local content = table.concat(vim.api.nvim_buf_get_lines(0, 0, -1, false), " ")
				local _, words = content:gsub("%S+", "")
				return words .. "W"
			end,
			condition = function() return vim.bo.filetype == "text" end,
			separator = " ",
			separator_highlight = {"NONE", colours.Black[1]},
			highlight = {colours.Magenta[1], colours.Black[1]},
		},
	},
	{
		DiagnosticError = {
			provider = "DiagnosticError",
			icon = " ",
			highlight = {colours.LightRed[1], colours.Black[1]},
		},
	},
	{
		DiagnosticWarn = {
			provider = "DiagnosticWarn",
			icon = " ",
			highlight = {colours.LightOrange[1], colours.Black[1]},
		},
	},
	{
		DiagnosticHint = {
			provider = "DiagnosticHint",
			icon = " ",
			highlight = {colours.LightYellow[1], colours.Black[1]},
		},
	},
	{
		DiagnosticInfo = {
			provider = "DiagnosticInfo",
			icon = " ",
			highlight = {colours.LightOlive[1], colours.Black[1]},
		},
	},
	{
		ShowLspClient = {
			provider = "GetLspClient",
			condition = condition.hide_in_width,
			icon = " ",
			separator = " ",
			separator_highlight = {"NONE", colours.Black[1]},
			highlight = {colours.Magenta[1], colours.Black[1]},
		},
	},
	{
		BufferType = {
			provider = function() return vim.bo.filetype end,
			-- condition = condition.hide_in_width,
			separator = " ",
			separator_highlight = {"NONE", colours.Black[1]},
			highlight = {colours.Orange[1], colours.Black[1]},
		},
	},
	{
		Tabstop = {
			provider = function() return vim.api.nvim_buf_get_option(0, "shiftwidth") end,
			icon = "_",
			separator = " ",
			separator_highlight = {"NONE", colours.Black[1]},
			highlight = {colours.Yellow[1], colours.Black[1]},
		},
	},
	{
		LineInfo = {
			provider = function()
				return vim.fn.line(".") .. ":" .. vim.fn.virtcol(".") .. "/" .. vim.fn.line("$")
			end,
			separator = " ",
			separator_highlight = {"NONE", colours.Black[1]},
			highlight = {colours.Green[1], colours.Black[1]},
		},
	},
	{
		Percent = {
			provider = function()
				local current_line = vim.fn.line(".")
				local total_line = vim.fn.line("$")
				if current_line == 1 then
					return "Top"
				elseif current_line == total_line then
					return "Bot"
				else
					return math.modf((current_line / total_line) * 100) .. "%"
				end
			end,
			separator = " ",
			separator_highlight = {"NONE", colours.Black[1]},
			highlight = {colours.Cyan[1], colours.Black[1]},
		},
	},
}
gls.short_line_left[1] = gls.left[1]
gls.short_line_left[2] = {
	BufferType = {
		provider = "FileTypeName",
		separator = " ",
		separator_highlight = {"NONE", colours.Black[1]},
		highlight = {colours.Orange[1], colours.Black[1]},
	},
}

gls.short_line_left[3] = {
	SFileName = {
		provider = "SFileName",
		condition = condition.buffer_not_empty,
		highlight = {colours.LightGrey[1], colours.Black[1]},
	},
}

gls.short_line_right[1] = {
	BufferIcon = {provider = "BufferIcon", highlight = {colours.LightGrey[1], colours.Black[1]}},
}
