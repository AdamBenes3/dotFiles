-- for sumneko_lua to work, you need to have a .git dir in parent
-- directory of your current file, otherwise it will keep recursively
-- searching for the .git directory -> keep the empty .git dir here
require "autocommands"
require "plugins"
require "settings"
require "keymappings"
vim.cmd "colorscheme nerdcontrast"
