-- local bundles = {
--     vim.fn.glob(
--         "~/.config/nvim/.debuggers/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
-- };

require'jdtls'.start_or_attach({
	on_attach = function(client, bufnr) return require'lsp'.common_on_attach(client, bufnr) end,
	cmd = {"java-lsp.sh", vim.fn.getcwd()},
	root_dir = require'jdtls.setup'.find_root({"build.xml", "pom.xml", ".git", "gradlew", "mvnw", "build.gradle"})
	-- init_options = {bundles = bundles}
})
