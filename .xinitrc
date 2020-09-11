#For high dpi monitors, set GDK_SCALE=2 for gtk/gdk(?) - used by google chrome
#export GDK_SCALE=2
xrdb ~/.Xresources
xrandr --dpi 158x150
wallpaper.sh &
tinyXClock &
exec dwm 
