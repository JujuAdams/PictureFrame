# Helper Functions

&nbsp;

PictureFrame comes with a number of functions designed to quickly and easily calculate some important values.

&nbsp;

## PfMouseX, PfMouseY

	PfMouseX
	returns: number

	PfMouseY
	returns: number

Returns the x and y coordinates (respectively) of the mouse in roomspace, after being corrected for all the weird and wonderful things that PictureFrame does.

If PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS (which it is out of the box) then the native GameMaker constants "mouse_x" and "mouse_y" will be mapped to these functions. This means you shouldn't have to change any code for mouse position detection to work automatically.

?> The following functions require [PfApply](PfApply) to have been called in order to work properly.

## PfGuiToRoom

	PfRoomToGui(_x,_y)
	returns: struct

Converts a GUI-space coordinate to a room-space coordinate. This function returns a static struct which is liable to change unexpectedly. If you need to store the returned coordinates, please make a copy of the struct.

## PFRoomToGui

	PfGuiToRoom(_x, _y)
	returns: struct

Converts a room-space coordinate to a GUI-space coordinate. This function returns a struct which is liable to change unexpectedly. If you need to store the returned coordinates, please make a copy of the struct.

## PfRoomToWindow
	PfRoomToWindow(_x,_y)
	returns: struct

Converts a room-space coordinate to a window-space coordinate. This function returns a static struct which is liable to change unexpectedly. If you need to store the returned coordinates, please make a copy of the struct.

## PfWindowToRoom

	PfWindowToRoom(_x, _y)
	returns: struct

Converts a window-space coordinate to a room-space coordinate. This function returns a static struct which is liable to change unexpectedly. If you need to store the returned coordinates, please make a copy of the struct.