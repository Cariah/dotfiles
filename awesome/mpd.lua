
mpdwidget = widget({ type = "textbox" })
vicious.register(mpdwidget, vicious.widgets.mpd,
	function (widget, args)
		if args["{state}"] == ("Stop" or "N/A") then
			return "<span color='#e2e8e9'></span> Not Playing "
			elseif args["{state}"] == "Pause" then
				return "<span color='#e2e8e9'></span> Paused "
			else
				if args["{Artist}"] == "N/A" then
					return "<span color='#e2e8e9'></span> "..args["{file}"].." "
				else
					return "<span color='#e2e8e9'></span> "..args["{Artist}"]..' - '.. args["{Title}"].." "
				end
			end
			end, 3)

mpdwidget:buttons( awful.util.table.join(
	awful.button({ }, 3, function() awful.util.spawn_with_shell('ncmpcpp ', false) end),
	awful.button({ }, 1, function() awful.util.spawn_with_shell('mpc toggle', false) end),
	awful.button({ }, 4, function() awful.util.spawn_with_shell('mpc prev', false) end),
	awful.button({ }, 5, function() awful.util.spawn_with_shell('mpc next', false) end)
	))
