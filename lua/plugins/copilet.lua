return {
	"github/copilot.vim",
	lazy = false,
	config = function()
		vim.keymap.set("n", "<leader>d", function()
			if vim.g.copilot_enabled == 1 then
				vim.cmd("Copilot disable")
				print("Copilot OFF")
			else
				vim.cmd("Copilot enable")
				print("Copilot ON")
			end
		end, { desc = "Toggle Copilot" })
	end,
}
