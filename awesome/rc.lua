-- Standard awesome library
require("awful")
require("awful.autofocus")
require("awful.rules")
require('awful.remote')
-- Theme handling library
require("beautiful")
-- Notification library
require("naughty")
-- Wicked
require("vicious")
-- Load Debian menu entries
require("debian.menu")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
	naughty.notify({ preset = naughty.config.presets.critical,
		title = "Oops, there were errors during startup!",
		text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
local in_error = false
awesome.add_signal("debug::error", function (err)
		-- Make sure we don't go into an endless error loop
		if in_error then return end
		in_error = true

		naughty.notify({ preset = naughty.config.presets.critical,
			title = "Oops, an error happened!",
			text = err })
		in_error = false
		end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, and wallpapers
--beautiful.init("/usr/share/awesome/themes/zenburn/theme.lua")
beautiful.init("/home/roelof/.config/awesome/themes/kawai-cariah/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "st"
filemanage = "pcmanfm"
editor = os.getenv("EDITOR") or "vim"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"
wirelessinterface = 'wlan0'
wiredinterface =    'eth0'

-- Table of layouts to cover with awful.layout.inc, order matters.
layouts =
{
	awful.layout.suit.floating,
	awful.layout.suit.tile,
	awful.layout.suit.tile.left,
	awful.layout.suit.tile.bottom,
	awful.layout.suit.tile.top,
	awful.layout.suit.fair,
	awful.layout.suit.fair.horizontal,
	awful.layout.suit.spiral,
	awful.layout.suit.spiral.dwindle,
	awful.layout.suit.max,
	awful.layout.suit.max.fullscreen,
	awful.layout.suit.magnifier
}
-- }}}

-- {{{ Tags
-- Define a tag table which hold all screen tags.
tags = {}
for s = 1, screen.count() do
	-- Each screen has its own tag table.
	tags[s] = awful.tag({ "main", "www", "term", " IV ", " V ", " VI "}, s, layouts[1])
end
-- }}}

-- {{{ Run once
function run_once(prg)
	awful.util.spawn_with_shell("pgrep -u $USER -x " .. prg .. " || (" .. prg .. ")")
end

run_once("nm-applet")
--awful.util.spawn("xscreensaver -nosplash", false)
awful.util.spawn("xfsettingsd", false)
--awful.util.spawn("mpd /home/roelof/.mpd/mpd.conf", false)
run_once("xfce4-power-manager")
awful.util.spawn("wmname LG3D", false)
-- }}}

-- {{{ Menu
-- Create a laucher widget and a main menu
myawesomemenu = {
{ "manual", terminal .. " -e man awesome" },
{ "edit config", editor_cmd .. " " .. awesome.conffile },
{ "restart", awesome.restart },
{ "quit", awesome.quit }
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
	{ "Debian", debian.menu.Debian_menu.Debian },
	{ "Terminal", terminal },
	{ "File System", filemanage }
}
})

mylauncher = awful.widget.launcher({ image = image(beautiful.awesome_icon),
	menu = mymainmenu })
-- }}}
-- {{{ Wibox
-- Create a textclock widget
mytextclock = awful.widget.textclock({ align = "right" })

-- Create a systray
mysystray = widget({ type = "systray" })

space = widget({ type= 'textbox' })
space.text = '  '
space1 = widget({ type = 'textbox' })
space1.text = ' '
spacer = widget({ type = 'textbox' })
spacer.text = ' <span color="' .. theme.bg_focus .. '">|</span> '

-- Date
datewidget = widget({ type = "textbox" })
vicious.register(datewidget, vicious.widgets.date, " %b %d, <span color='#e2e8e9'>⮖</span> %R ", 1)

require('mpd')
require('volume')
require('memory')
require('netdown')
require('netup')
require('battery')
require('sensor')

-- Create a wibox for each screen and add it
mywibox = { }
mypromptbox = { }
mylayoutbox = { }
mytaglist = { }
mytaglist.buttons = awful.util.table.join(
	awful.button({ }, 1, awful.tag.viewonly),
	awful.button({ modkey }, 1, awful.client.movetotag),
	awful.button({ }, 3, awful.tag.viewtoggle),
	awful.button({ modkey }, 3, awful.client.toggletag),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
	)
mytasklist = {}
mytasklist.buttons = awful.util.table.join(
	awful.button({ }, 1, function (c)
		if c == client.focus then
			c.minimized = true
		else
			if not c:isvisible() then
				awful.tag.viewonly(c:tags()[1])
			end
												  -- This will also un-minimize
												  -- the client, if needed
												  client.focus = c
												  c:raise()
											  end
											  end),
	awful.button({ }, 3, function ()
		if instance then
			instance:hide()
			instance = nil
		else
			instance = awful.menu.clients({ width=250 })
		end
		end),
	awful.button({ }, 4, function ()
		awful.client.focus.byidx(1)
		if client.focus then client.focus:raise() end
		end),
	awful.button({ }, 5, function ()
		awful.client.focus.byidx(-1)
		if client.focus then client.focus:raise() end
		end))

for s = 1, screen.count() do
	-- Create a promptbox for each screen
	mypromptbox[s] = awful.widget.prompt({ layout = awful.widget.layout.horizontal.leftright })
	-- Create an imagebox widget which will contains an icon indicating which layout we're using.
	-- We need one layoutbox per screen.
	mylayoutbox[s] = awful.widget.layoutbox(s)
	mylayoutbox[s]:buttons(awful.util.table.join(
		awful.button({ }, 1, function () awful.layout.inc(layouts, 1) end),
		awful.button({ }, 3, function () awful.layout.inc(layouts, -1) end),
		awful.button({ }, 4, function () awful.layout.inc(layouts, 1) end),
		awful.button({ }, 5, function () awful.layout.inc(layouts, -1) end)))
	-- Create a taglist widget
	mytaglist[s] = awful.widget.taglist(s, awful.widget.taglist.label.all, mytaglist.buttons)

	-- Create a tasklist widget
	mytasklist[s] = awful.widget.tasklist(function(c)
		return awful.widget.tasklist.label.currenttags(c, s)
		end, mytasklist.buttons)

	-- Create the wibox
	mywibox[s] = { }
	mywibox[s][1] = awful.wibox({ position = 'top', screen = s })
	mywibox[s][2] = awful.wibox({ position = 'bottom', screen = s })

	-- Add widgets to the wibox - order matters
	mywibox[s][1].widgets = {
	mylayoutbox[s],
	space1,
	mytaglist[s],
	mypromptbox[s], {
			-- Widgets
			space,
			sensorwidget, spacer,
			memwidget, spacer,
			batwidget, spacer,
			netdownwidget, netdownicon, spacer,
			space,
			--netupwidget, netupicon, spacer,
			volwidget, spacer,
			mpdwidget, space1, spacer,
			layout = awful.widget.layout.horizontal.rightleft,
			},
			layout = awful.widget.layout.horizontal.leftright
		}
		mywibox[s][2].widgets = {
		datewidget,
		s == 1 and mysystray or nil, {
		mylauncher,
		mytasklist[s],
		layout = awful.widget.layout.horizontal.leftright
		},
		layout = awful.widget.layout.horizontal.rightleft
	}
end
-- }}}

-- {{{ Mouse bindings
root.buttons(awful.util.table.join(
	awful.button({ }, 3, function () mymainmenu:toggle() end),
	awful.button({ }, 4, awful.tag.viewnext),
	awful.button({ }, 5, awful.tag.viewprev)
	))
-- }}}

-- {{{ Key bindings
globalkeys = awful.util.table.join(
	awful.key({ modkey,           }, "Left",   awful.tag.viewprev       ),
	awful.key({ modkey,           }, "Right",  awful.tag.viewnext       ),
	awful.key({ modkey,           }, "Escape", awful.tag.history.restore),

	awful.key({ modkey,           }, "j",
		function ()
			awful.client.focus.byidx( 1)
			if client.focus then client.focus:raise() end
			end),
	awful.key({ modkey,           }, "k",
		function ()
			awful.client.focus.byidx(-1)
			if client.focus then client.focus:raise() end
			end),
	awful.key({ modkey,           }, "w", function () mymainmenu:show({keygrabber=true}) end),

	-- Layout manipulation
	awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end),
	awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end),
	awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end),
	awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end),
	awful.key({ modkey,           }, "u", awful.client.urgent.jumpto),
	awful.key({ modkey,           }, "Tab",
		function ()
			awful.client.focus.history.previous()
			if client.focus then
				client.focus:raise()
			end
			end),

	-- Standard program
	awful.key({ modkey,           }, "Return", function () awful.util.spawn(terminal) end),
	awful.key({ modkey, "Control" }, "r", awesome.restart),
	awful.key({ modkey, "Shift"   }, "q", awesome.quit),

	awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
	awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
	awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1)      end),
	awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1)      end),
	awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1)         end),
	awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1)         end),
	awful.key({ modkey,           }, "space", function () awful.layout.inc(layouts,  1) end),
	awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(layouts, -1) end),
	awful.key({ "Control" , "Mod1" }, "l", function() awful.util.spawn("dm-tool lock", false) end),

	awful.key({ modkey, "Control" }, "n", awful.client.restore),

	-- Mofokin' volume controls
	awful.key({ }, "XF86AudioRaiseVolume", function ()
		awful.util.spawn("amixer set Master 5%+", false) end),
	awful.key({ }, "XF86AudioLowerVolume", function ()
		awful.util.spawn("amixer set Master 5%-", false) end),
	awful.key({ }, "XF86AudioMute", function ()
		local fd    = io.popen("amixer sget Master")
		local status = fd:read("*all")
		fd:close()

		awful.util.spawn("amixer set Master toggle")

		status = string.match(status, "%[(o[^%]]*)%]")
	   -- if audio muted
	   if string.find(status, "on", 1, true) then
		naughty.notify({
			title   = "Audio Muted.",
			text    = "Audio has been muted.",
			icon 	= beautiful.audio_muted_icon,
			timeout = 3
			})
		else
		-- if audio is unmuted
		naughty.notify({
			title   = "Audio unmuted.",
			text    = "Audio has been unmuted.",
			icon 	= beautiful.audio_high_icon,
			timeout = 3
			})
	end
	end),

	-- Prompt
	awful.key({ modkey }, "r", function () mypromptbox[mouse.screen]:run() end),

	awful.key({ modkey }, "x",
		function ()
			awful.prompt.run({ prompt = "Run Lua code: " },
				mypromptbox[mouse.screen].widget,
				awful.util.eval, nil,
				awful.util.getdir("cache") .. "/history_eval")
			end)
	)

clientkeys = awful.util.table.join(
	awful.key({ modkey,           }, "f",      function (c) c.fullscreen = not c.fullscreen  end),
	awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end),
	awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ),
	awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end),
	awful.key({ modkey,           }, "o",      awful.client.movetoscreen                        ),
	awful.key({ modkey, "Shift"   }, "r",      function (c) c:redraw()                       end),
	awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end),
	awful.key({ modkey,           }, "n",
		function (c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
			end),
	awful.key({ modkey,           }, "m",
		function (c)
			c.maximized_horizontal = not c.maximized_horizontal
			c.maximized_vertical   = not c.maximized_vertical
			end),
	awful.key({ modkey, "Shift" }, "t",
		function (c)
			if   c.titlebar then awful.titlebar.remove(c)
				else awful.titlebar.add(c, { modkey = modkey }) end
				end)
	)

-- Compute the maximum number of digit we need, limited to 9
keynumber = 0
for s = 1, screen.count() do
	keynumber = math.min(9, math.max(#tags[s], keynumber));
end

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, keynumber do
	globalkeys = awful.util.table.join(globalkeys,
		awful.key({ modkey }, "#" .. i + 9,
			function ()
				local screen = mouse.screen
				if tags[screen][i] then
					awful.tag.viewonly(tags[screen][i])
				end
				end),
		awful.key({ modkey, "Control" }, "#" .. i + 9,
			function ()
				local screen = mouse.screen
				if tags[screen][i] then
					awful.tag.viewtoggle(tags[screen][i])
				end
				end),
		awful.key({ modkey, "Shift" }, "#" .. i + 9,
			function ()
				if client.focus and tags[client.focus.screen][i] then
					awful.client.movetotag(tags[client.focus.screen][i])
				end
				end),
		awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
			function ()
				if client.focus and tags[client.focus.screen][i] then
					awful.client.toggletag(tags[client.focus.screen][i])
				end
				end))
end

clientbuttons = awful.util.table.join(
	awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
	awful.button({ modkey }, 1, awful.mouse.client.move),
	awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = { },
		properties = {
			border_width = beautiful.border_width,
			border_color = beautiful.border_normal,
			focus = true,
			keys = clientkeys,
			buttons = clientbuttons,
			size_hints_honor = false,
		}
	},
	{
		rule = { class = "MPlayer" },
		properties = { floating = true }
	},
	{
		rule = { class = "pinentry" },
		properties = { floating = true }
	},
	{
		rule = { class = "gimp" },
		properties = { floating = true }
	},
	{
		rule = { class = "asd" },
		properties = {
			floating = true,
		}
	},
	{
		rule = { class = "GUVCVideo" },
		properties = { floating = true }
	},

		-- Set Chrome on screen1 tag 2
		--{ rule = { class = "Google-chrome" },
		--  properties = {
		--  tag = tags[1][2],
		--  border_width = 0
		--  }, },
		-- Set Firefox to always map on tags number 2 of screen 1.
		--{ rule = { class = "Firefox" },
		--  properties = { tag = tags[1][2] } },
	{
		rule = { class = "Transmission" },
		properties = { tag = tags[1][5] } },

		{ rule = { class = "Skype" },
		properties = { tag = tags[1][4] } },
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.add_signal("manage", function (c, startup)
	-- Add a titlebar
	-- awful.titlebar.add(c, { modkey = modkey })

	-- Enable sloppy focus
	c:add_signal("mouse::enter", function(c)
		if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
			and awful.client.focus.filter(c) then
			client.focus = c
		end
		end)

	if not startup then
		-- Set the windows at the slave,
		-- i.e. put it at the end of others instead of setting it master.
		-- awful.client.setslave(c)

		-- Put windows in a smart way, only if they does not set an initial position.
		if not c.size_hints.user_position and not c.size_hints.program_position then
			awful.placement.no_overlap(c)
			awful.placement.no_offscreen(c)
		end
	end
	end)

client.add_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.add_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}
