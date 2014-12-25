sensorwidget = widget({ type = 'textbox' })
vicious.register(sensorwidget, vicious.widgets.thermal, function(widget, args)
	local temp = tonumber(args[1])
	if temp > 63 then
		naughty.notify({
			preset = naughty.config.presets.critical,
			title = 'Temperature Warning',
			text = 'Is it me or is it hot in here?',
			timeout = 10,
			})
		temp = '<span color="#C2454E">' .. temp .. '</span>'
	end
	return temp .. '<span color="#A2D9B1">°C</span>'
	end, 5, 'thermal_zone0')

