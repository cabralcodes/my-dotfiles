#!/bin/bash


img=$(zenity --file-selection --title="Escolher Wallpaper")

[ -n "$img" ] && awww img "$img"
