#!/usr/bin/env bash

(sleep 1 && (
		xrdb -load$HOME/.Xresources
)) &

exec ck-launch-session dbus-launch $1
