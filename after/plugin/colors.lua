function Color(color)
	color = color or "omni"
	vim.cmd.colorscheme(color)
end

Color()
