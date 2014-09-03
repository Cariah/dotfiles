dotfiles
========

Mu dotfiles

:memo: modified /usr/share/awesome/lib/vicious/unit.lua changed local function update to function update.

function `update` is used by ncmpcpp: `execute_on_song_change = "echo 'vicious.update(mpdwidget)' | awesome-client"`
this will instantly update the songname in `mpdwidget`.


:memo: modified /usr/sbin/lightdm-session line 37 & 43:
from: `xrdb -nocpp -merge` | to: `xrdb -merge` 

using http://Github.com/Phallus/fonts

and

http://Github.com/lucy/tewi-font


TODO:
Add some functions
Cleanup unused stuff in .bashrc etc.


Currently werks on `myMachine™` Lubuntu 14.04
