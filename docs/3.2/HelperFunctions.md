# Helper Functions

&nbsp;

PictureFrame comes with a number of functions designed to quickly and easily calculate some important values.

&nbsp;

## `PfMouseX`

`PfMouseX()`

**Returns:** Number, the corrected mouse x-coordinate in room-space

|Name        |Datatype|Purpose|
|------------|--------|-------|
|No arguments|        |       |

Returns the x-coordinate of the mouse in room-space, after being corrected for all the weird and wonderful things that PictureFrame does.

If `PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS` (which it is out of the box) then the native GameMaker constant `mouse_x` will be mapped to this functions. This means you shouldn't have to change any code for mouse position detection to work automatically.

&nbsp;

## `PfMouseY`

`PfMouseY()`

**Returns:** Number, the corrected mouse y-coordinate in room-space

|Name        |Datatype|Purpose|
|------------|--------|-------|
|No arguments|        |       |

Returns the y-coordinate of the mouse in room-space, after being corrected for all the weird and wonderful things that PictureFrame does.

If `PICTURE_FRAME_REPLACE_NATIVE_MOUSE_FUNCTIONS` (which it is out of the box) then the native GameMaker constant `mouse_y` will be mapped to this functions. This means you shouldn't have to change any code for mouse position detection to work automatically.

&nbsp;

## `PfGuiToRoom`

`PfGuiToRoom(x, y)`

**Returns:** Struct, the transformed coordinates

|Name|Datatype|Purpose                  |
|----|--------|-------------------------|
|`x` |number  |x-coordinate in GUI-space|
|`y` |number  |y-coordinate in GUI-space|

Converts a GUI-space coordinate to a room-space coordinate. This function returns a static struct which is liable to change unexpectedly. If you need to store the returned coordinates, please make a copy of the struct.

?> This function requires [`PfApply()`](PfApply) to have been called in order to work properly.

&nbsp;

## `PFRoomToGui`

`PfRoomToGui(x, y)`

**Returns:** Struct, the transformed coordinates

|Name|Datatype|Purpose                   |
|----|--------|--------------------------|
|`x` |number  |x-coordinate in room-space|
|`y` |number  |y-coordinate in room-space|

Converts a room-space coordinate to a GUI-space coordinate. This function returns a struct which is liable to change unexpectedly. If you need to store the returned coordinates, please make a copy of the struct.

?> This function requires [`PfApply()`](PfApply) to have been called in order to work properly.

&nbsp;

## `PfRoomToWindow`

`PfRoomToWindow(x, y)`

**Returns:** Struct, the transformed coordinates

|Name|Datatype|Purpose                   |
|----|--------|--------------------------|
|`x` |number  |x-coordinate in room-space|
|`y` |number  |y-coordinate in room-space|

Converts a room-space coordinate to a window-space coordinate. This function returns a static struct which is liable to change unexpectedly. If you need to store the returned coordinates, please make a copy of the struct.

?> This function requires [`PfApply()`](PfApply) to have been called in order to work properly.

&nbsp;

## `PfWindowToRoom`

`PfWindowToRoom(x, y)`

**Returns:** Struct, the transformed coordinates

|Name|Datatype|Purpose                     |
|----|--------|----------------------------|
|`x` |number  |x-coordinate in window-space|
|`y` |number  |y-coordinate in window-space|

Converts a window-space coordinate to a room-space coordinate. This function returns a static struct which is liable to change unexpectedly. If you need to store the returned coordinates, please make a copy of the struct.

?> This function requires [`PfApply()`](PfApply) to have been called in order to work properly.
