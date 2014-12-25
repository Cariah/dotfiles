dotfiles
========

My dotfiles

:memo: modified /usr/share/awesome/lib/vicious/unit.lua changed local function update to function update.

function `update` is used by ncmpcpp: `execute_on_song_change = "echo 'vicious.update(mpdwidget)' | awesome-client"`
this will instantly update the songname in `mpdwidget`.


:memo: modified /usr/sbin/lightdm-session line 37 & 43:
from: `xrdb -nocpp -merge` | to: `xrdb -merge` 

Currently using Vundle for vim plugins
Also, powerline patched font +1

