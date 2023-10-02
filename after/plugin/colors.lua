function Color(color)
	color = color or "rose-pine"
	vim.cmd.colorscheme(color)
end

Color()
