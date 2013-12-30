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

-- Bami widget
-- bamiwidget = widget({ type = "textbox" })

-- function bami_status()
--     local bami_state = {
--         ["{cdf"] = 0,
--         ["{dur}"] = 0,
--     }

--     local f = io.popen("echo '' | python -O /home/roelof/.config/awesome/untitled.pyc")
--     for line in f:lines() do
--         for k,v in string.gmatch(line, "([%w]+):[%s](.*)$") do
--             if      k == "dur" then bami_state["{"..k.."}"] = v
--             elseif  k == "cdf" then bami_state["{"..k.."}"] = v
--             end
--         end
--     end
--     f:close()
--     bamiwidget.text = " | CDF: "..bami_state["{cdf}"].." - DUR: "..bami_state["{dur}"]
-- end
-- bamitimer = timer({ timeout = 60 })
-- bamitimer:add_signal("timeout", function() bami_status() end)
-- bamitimer:start()
-- Date
-- Initialize widget
datewidget = widget({ type = "textbox" })
-- Register widget
vicious.register(datewidget, vicious.widgets.date, " %b %d, <span color='#e2e8e9'>⮖</span> %R ", 60)
