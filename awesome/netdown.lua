netdownicon = widget({ type = 'textbox' })
netdownicon.text = '<span color="#e2e8e9">⮵ </span>'
netdownwidget = widget({ type = 'textbox' })
vicious.register(netdownwidget, vicious.widgets.net, function(widget, args)
 local i = ''
 if args['{' .. wirelessinterface .. ' carrier}'] == 1 then
     i = wirelessinterface
 elseif args['{' .. wiredinterface .. ' carrier}'] == 1 then
     i = wiredinterface
 else
     netdownicon.visible = false
     return 'disconnected'
 end
 netdownicon.visible = true
 return args['{' .. i .. ' down_kb}'] .. 'k<span color="#657b83">/' .. string.format('%.0f', args['{' .. i .. ' rx_mb}']) .. 'M</span> '
end, 2.5)

