-- Wicked Widets

-- mpd widget
-- Initialize widget
mpdwidget = widget({ type = "textbox" })
-- Register widget
vicious.register(mpdwidget, vicious.widgets.mpd,
    function (widget, args)
        if args["{state}"] == "Stop" then 
            return "| <span color='#e2e8e9'>⮕</span> Not Playing "
        elseif args["{state}"] == "Pause" then
        	return "| <span color='#e2e8e9'>⮕</span> Paused "
        else
        	if args["{Artist}"] == "N/A" then
            	return "| <span color='#e2e8e9'>⮕</span> "..args["{file}"].." "
            else
            	return "| <span color='#e2e8e9'>⮕</span> "..args["{Artist}"]..' - '.. args["{Title}"].." "
            end
        end
    end, 10)

-- Date
-- Initialize widget
datewidget = widget({ type = "textbox" })
-- Register widget
vicious.register(datewidget, vicious.widgets.date, " %b %d, <span color='#e2e8e9'>⮖</span> %R ", 60)
