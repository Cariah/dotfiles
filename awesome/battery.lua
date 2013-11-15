battery_widget = widget({ type = "textbox" })

function battery_status()
	local spacer  = " "
	local fstatus   = io.open("/sys/class/power_supply/BAT0/status")
	local fcapacity = io.open("/sys/class/power_supply/BAT0/capacity")
	local status  = fstatus:read()
	local capacity  = fcapacity:read()
	local capint = tonumber(capacity)

	if status:match("Charging") then
		if capint < 21 then
			dir = "<span color='#7CBF9E'>⮐ </span>"
		elseif capint > 20 and capint < 46 then
			dir = "<span color='#7CBF9E'>⮑ </span>"
		elseif capint > 45 and capint < 66 then
			dir = "<span color='#7CBF9E'>⮏ </span>"
		elseif capint > 65 and capint < 91 then
			dir = "<span color='#7CBF9E'>⮒ </span>"
		else
			dir = "<span color='#7CBF9E'>⮎ </span>"
		end
	elseif status:match("Discharging") then
		if capint < 21 then
			dir = "<span color='#C2454E'>⮐ </span>"
			if capint < 15 then
			naughty.notify({
				title    = "Battery Warning",
				text    = "Battery low! "..capacity.."% left!",
				timeout   = 5,
				position  = "top_right",
				fg      = beautiful.fg_urgent,
				bg      = beautiful.bg_urgent,
			})
			end
		elseif capint > 20 and capint < 46 then
			dir = "<span color='#C2454E'>⮑ </span>"
		elseif capint > 45 and capint < 66 then
			dir = "<span color='#C2454E'>⮏ </span>"
		elseif capint > 65 and capint < 91 then
			dir = "<span color='#C2454E'>⮒ </span>"
		else
			dir = "<span color='#C2454E'>⮎ </span>"
		end
	elseif status:match("Full") then
		dir = "<span color='#A2D9B1'>⮎ </span>"
	else
		dir = "<span color='#C2454E'>⮎ </span>"
	end
	battery = capacity .. dir
	battery_widget.text = "| " .. battery.."|"
	fstatus:close()
	fcapacity:close()
end


battery_timer = timer({ timeout = 90 })
battery_timer:add_signal("timeout", function() battery_status() end)
battery_timer:start()
