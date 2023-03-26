
#function setup_wacom {
#    #Change DVI-I-1 to what monitor you want from running command: xrandr
#    local monitor="DP-1-1-2"
#    local pad_name="Wacom Intuos PT M 2 Pad pad"
#
#    #undo
#    #xsetwacom --set "$pad_name" Button 1 "key +ctrl +z -z -ctrl" 
#
#    #define next 2 however you like, I have mine mapped for erase in krita
#    #xsetwacom --set "$pad_name" Button 2 "key e"
#    #xsetwacom --set "$pad_name" Button 3 "key h"
#
#    local id_stylus=`xinput | grep "Pen stylus" | cut -f 2 | cut -c 4-5`
#
#    xinput map-to-output $id_stylus $monitor
#}
#
#function wacom_slower_stylus {
#    device=$(xinput list | grep Wacom | grep stylus | grep -Po 'id=\K[^ ].')
#    property=$(xinput list-props $device | grep "Constant Deceleration" | grep -Po '\(\K[^\)]+')
#    xinput set-prop $device $property 5.0
#}
