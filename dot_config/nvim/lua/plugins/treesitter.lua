-- nvim-treesitter's `master` branch is archived and is broken on Neovim 0.12
-- (its predicates/directives still expect the removed `all = false` behaviour),
-- so this follows the `main` rewrite instead.
--
-- `main` is a different plugin: it only installs parsers and queries. Every
-- feature that used to be a `configs.setup` module now comes from Neovim
-- itself, so highlighting is started by hand below. It needs the tree-sitter
-- CLI (`brew install tree-sitter-cli`) and does not support lazy-loading.
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		local nts = require("nvim-treesitter")

		-- Parsers and queries are installed into ~/.local/share/nvim/site,
		-- which `setup()` prepends to 'runtimepath'.
		nts.setup()

		nts.install({
			"bash",
			"c",
			"elixir",
			"fish",
			"heex",
			"html",
			"javascript",
			"json",
			"lua",
			"query",
			"typescript",
			"vim",
			"vimdoc",
		})

		local installed = {}
		for _, lang in ipairs(require("nvim-treesitter.config").get_installed("parsers")) do
			installed[lang] = true
		end

		local function start(buf, lang)
			if vim.api.nvim_buf_is_valid(buf) then
				pcall(vim.treesitter.start, buf, lang)
			end
		end

		-- Replaces the old `highlight.enable` + `auto_install` options: enable
		-- treesitter per buffer, fetching the parser on first use.
		local tried = {}
		vim.api.nvim_create_autocmd("FileType", {
			group = vim.api.nvim_create_augroup("treesitter_start", { clear = true }),
			desc = "Start treesitter highlighting, installing the parser if needed",
			callback = function(ev)
				local lang = vim.treesitter.language.get_lang(ev.match)
				if not lang then
					return
				end

				if installed[lang] then
					start(ev.buf, lang)
					return
				end

				-- One install attempt per language per session.
				if tried[lang] or not vim.list_contains(nts.get_available(), lang) then
					return
				end
				tried[lang] = true

				nts.install(lang):await(function(err)
					if err then
						return
					end
					installed[lang] = true
					vim.schedule(function()
						start(ev.buf, lang)
					end)
				end)
			end,
		})
	end,
}
