battery_widget_new = widget({ type = "textbox" })

function battery_status_new()
	local col_bar_dark = "#021B21" --656975
	local col_bar_light = "#9CA2A3"
	local bs = "⮶"

	local spacer  = " "
	local fstatus   = io.open("/sys/class/power_supply/BAT0/status")
	local fcapacity = io.open("/sys/class/power_supply/BAT0/capacity")
	local status  = fstatus:read()
	local capacity  = fcapacity:read()
	local capint = tonumber(capacity)

	if status:match("Charging") then
		if capint > 95 then
			dir = "<span color='#7CBF9E'>⮎ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'></span>"
		elseif capint > 85 then
			dir = "<span color='#7CBF9E'>⮒ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs.."</span>"
		elseif capint > 75 then
			dir = "<span color='#7CBF9E'>⮒ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs.."</span>"
		elseif capint > 65 then
			dir = "<span color='#7CBF9E'>⮒ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs.."</span>"
		elseif capint > 55 then
			dir = "<span color='#7CBF9E'>⮒ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs.."</span>"
		elseif capint > 45 then
			dir = "<span color='#7CBF9E'>⮒ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs..bs.."</span>"
		elseif capint > 35 then
			dir = "<span color='#7CBF9E'>⮒ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs..bs..bs.."</span>"
		elseif capint > 25 then
			dir = "<span color='#7CBF9E'>⮒ </span><span color='"..col_bar_light.."'>"..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs..bs..bs..bs.."</span>"
		elseif capint > 15 then
			dir = "<span color='#7CBF9E'>⮒ </span><span color='"..col_bar_light.."'>"..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs..bs..bs..bs..bs.."</span>"
		elseif capint > 5 then
			dir = "<span color='#7CBF9E'>⮒ </span><span color='"..col_bar_light.."'>"..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs..bs..bs..bs..bs..bs.."</span>"
		else
			dir = "<span color='#7CBF9E'>⮒ </span><span color='"..col_bar_light.."'></span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs..bs..bs..bs..bs..bs..bs.."</span>"
		end

	elseif status:match("Discharging") then
		if capint > 95 then
			dir = "<span color='#7CBF9E'>⮏ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'></span>"
		elseif capint > 85 then
			dir = "<span color='#7CBF9E'>⮏ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs.."</span>"
		elseif capint > 75 then
			dir = "<span color='#7CBF9E'>⮏ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs.."</span>"
		elseif capint > 65 then
			dir = "<span color='#7CBF9E'>⮏ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs.."</span>"
		elseif capint > 55 then
			dir = "<span color='#7CBF9E'>⮑ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs.."</span>"
		elseif capint > 45 then
			dir = "<span color='#7CBF9E'>⮑ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs..bs.."</span>"
		elseif capint > 35 then
			dir = "<span color='#7CBF9E'>⮑ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs..bs..bs.."</span>"
		elseif capint > 25 then
			dir = "<span color='#7CBF9E'>⮑ </span><span color='"..col_bar_light.."'>"..bs..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs..bs..bs..bs.."</span>"
		elseif capint > 15 then
			dir = "<span color='#7CBF9E'>⮐ </span><span color='"..col_bar_light.."'>"..bs..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs..bs..bs..bs..bs.."</span>"
		elseif capint > 5 then
			dir = "<span color='#7CBF9E'>⮐ </span><span color='"..col_bar_light.."'>"..bs.."</span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs..bs..bs..bs..bs..bs.."</span>"
			naughty.notify({
				title    = "Battery Warning",
				text    = "Battery low! "..capacity.."% left!",
				timeout   = 5,
				position  = "top_right",
				fg      = beautiful.fg_urgent,
				bg      = beautiful.bg_urgent,
			})
		else
			dir = "<span color='#7CBF9E'>⮐ </span><span color='"..col_bar_light.."'></span><span color='"..col_bar_dark.."'>"..bs..bs..bs..bs..bs..bs..bs..bs..bs..bs.."</span>"
		end
	elseif status:match("Full") then
		dir = "<span color='#A2D9B1'>⮎ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'></span>"
	else
		dir = "<span color='#C2454E'>⮎ </span><span color='"..col_bar_light.."'>"..bs..bs..bs..bs..bs..bs..bs..bs..bs..bs.."</span><span color='"..col_bar_dark.."'></span>"

	end
	battery_widget_new.text = "| " .. dir.." "
	fstatus:close()
	fcapacity:close()
end


battery_timer_new = timer({ timeout = 90 })
battery_timer_new:add_signal("timeout", function() battery_status_new() end)
battery_timer_new:start()
