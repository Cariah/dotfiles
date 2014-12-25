batwidget = widget({ type = 'textbox' })
vicious.register(batwidget, vicious.widgets.bat, function(widget, args)
	local percent = args[2] .. '%'
	if args[1] == '-' and args[2] < 25 then
		percent = '<span color="' .. theme.bg_urgent .. '">' .. args[2] .. '%</span>'
	end
	if args[1] == '-' and args[2] < 20 then
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = 'Low power',
			text = "I'm dying! Plug me in!",
			timeout = 15,
			})
	end
	if args[1] == '-' then
		args[1] = '<span color="#C2454E">-</span>'
		elseif args[1] == '+' then
			args[1] = '<span color="#A2D9B1">+</span>'
		else
			args[1] = '<span color="#A2D9B1">⮎ </span>'
		end
		return args[1] .. percent
		end, 20, 'BAT0')

