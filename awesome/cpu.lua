cpu_widget = widget({ type = "textbox" })

function cpu_status()
	local ftemp = io.open("/sys/class/thermal/thermal_zone0/temp")
	local tempinfo = ftemp:read()
	local temp = tonumber(tempinfo/1000)

	if temp < 41 then
		temptext = temp.."<span color='#C7E8D0'>°C</span> "
	elseif temp < 51 then
		temptext = temp.."<span color='#A2D9B1'>°C</span> "
	elseif temp > 50 and temp < 56 then
		temptext = temp.."<span color='#F0DFAF'>°C</span> "
	elseif temp > 55 and temp < 59 then
		temptext = temp.."<span color='#CC9393'>°C</span> "
	elseif temp > 58 and temp < 65 then
		temptext = temp.."<span color='#C27A44'>°C</span> "
	elseif temp > 64 then
		temptext = temp.."<span color='#C2454E'>°C</span> "
		naughty.notify({
				title	= "CPU Temp!",
				text 	= "CPU Temp over 64°C!\nCPU temp: "..temp.."°C.",
				timeout = 5,
				position= "top_right",
				fg      = beautiful.fg_urgent,
				bg      = beautiful.bg_urgent,
		})
	else
		temptext = temp.."<span color='#C2454E'>°C</span> "
	end

	cpu_widget.text = "| "..temptext
	ftemp:close()
end

cpuw_timer = timer({ timeout = 5 })
cpuw_timer:add_signal("timeout", function() cpu_status() end)
cpuw_timer:start()
