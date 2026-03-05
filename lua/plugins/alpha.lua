return {
	"goolord/alpha-nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },

	config = function()
		local alpha = require("alpha")
		local dashboard = require("alpha.themes.dashboard")

		local logo = [[
        ███╗   ██╗██╗   ██╗██╗███╗   ███╗
        ████╗  ██║██║   ██║██║████╗ ████║
        ██╔██╗ ██║██║   ██║██║██╔████╔██║
        ██║╚██╗██║╚██╗ ██╔╝██║██║╚██╔╝██║
        ██║ ╚████║ ╚████╔╝ ██║██║ ╚═╝ ██║
        ╚═╝  ╚═══╝  ╚═══╝  ╚═╝╚═╝     ╚═╝
               h j k l ONLY!!
        ]]

		dashboard.section.header.val = vim.split(logo, "\n")

		dashboard.section.buttons.val = {
			dashboard.button("f", "  Find file", "<cmd>Telescope find_files<cr>"),
			dashboard.button("n", "  New file", "<cmd>ene | startinsert<cr>"),
			dashboard.button("r", "  Recent files", "<cmd>Telescope oldfiles<cr>"),
			dashboard.button("g", "  Find text", "<cmd>Telescope live_grep<cr>"),
			dashboard.button("c", "  Config", "<cmd>cd $HOME/.config/nvim | Telescope find_files<cr>"),
			dashboard.button("s", "  Restore Session", "<cmd>lua require('persistence').load()<cr>"),
			dashboard.button("l", "󰒲  Lazy", "<cmd>Lazy<cr>"),
			dashboard.button("q", "  Quit", "<cmd>qa<cr>"),
		}

		for _, button in ipairs(dashboard.section.buttons.val) do
			button.opts.hl = "AlphaButtons"
			button.opts.hl_shortcut = "AlphaShortcut"
		end

		dashboard.section.header.opts.hl = "AlphaHeader"
		dashboard.section.buttons.opts.hl = "AlphaButtons"

		alpha.setup(dashboard.opts) -- 🔥 THIS WAS MISSING
	end,
}
