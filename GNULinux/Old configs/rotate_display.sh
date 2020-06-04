#!/bin/sh

# I created this by following a template long ago; so long ago that I'm unable to find the template.
# Find the line in "xrandr -q --verbose" output that contains current screen orientation and "strip" out current orientation.

rotation="$(xrandr -q --verbose | grep 'connected' | egrep -o  '\) (normal|left|inverted|right) \(' | egrep -o '(normal|left|inverted|right)')"

# Using current screen orientation proceed to rotate screen and input tools.

case "$rotation" in
    normal)
    # rotate to the left
    xrandr -o left
    xsetwacom set "Wacom Serial Penabled 1FG Touchscreen Pen stylus" rotate ccw
    xsetwacom set "Wacom Serial Penabled 1FG Touchscreen Finger touch" rotate ccw
    xsetwacom set "Wacom Serial Penabled 1FG Touchscreen Pen eraser" rotate ccw
    ;;
    left)
    # rotate to inverted
    xrandr -o inverted
    xsetwacom set "Wacom Serial Penabled 1FG Touchscreen Pen stylus" rotate half
    xsetwacom set "Wacom Serial Penabled 1FG Touchscreen Finger touch" rotate half
    xsetwacom set "Wacom Serial Penabled 1FG Touchscreen Pen eraser" rotate half
    ;;
    inverted)
    # rotate to the right
    xrandr -o right
    xsetwacom set "Wacom Serial Penabled 1FG Touchscreen Pen stylus" rotate  cw
    xsetwacom set "Wacom Serial Penabled 1FG Touchscreen Finger touch" rotate cw
    xsetwacom set "Wacom Serial Penabled 1FG Touchscreen Pen eraser" rotate cw
    ;;
    right)
    # rotate to normal
    xrandr -o normal
    xsetwacom set "Wacom Serial Penabled 1FG Touchscreen Pen stylus" rotate none
    xsetwacom set "Wacom Serial Penabled 1FG Touchscreen Finger touch" rotate none
    xsetwacom set "Wacom Serial Penabled 1FG Touchscreen Pen eraser" rotate none
    ;;
esac
