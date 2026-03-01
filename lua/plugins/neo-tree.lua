return { 

	"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false,
		keys = {
            { "<leader>e", ":Neotree toggle<CR>", desc = "Toggle Neo-tree" },
            { "<C-n>", "<cmd>Neotree focus<cr>", desc = "Focus Neo-tree" },
            { "<C-p>", "<cmd>wincmd p<cr>", desc = "Go back to previous window" },
		},
}
