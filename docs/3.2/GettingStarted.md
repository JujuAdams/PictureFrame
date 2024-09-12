# Getting Started

&nbsp;

## The Short Version

1. Import the .yymps file
2. At the start of the game, call one of the config struct creator functions. These are `PfConfigPixelArt()`, `PfConfigHighRes()`, and `PfConfigGeneral()`. The latter is the most flexible. All three functions will return the same type of struct, you can read more about what variables can be adjusted in the [script documentation](https://github.com/JujuAdams/PictureFrame/blob/dev/scripts/PfConfigGeneral/PfConfigGeneral.gml)
3. Call `PfApply()` using the config struct we just created. You may want to set the optional `resizeWindow` parameter to `true` the first time you call this function in the flow of your game
4. Create a Post-Draw event in a persistent object instance and call `PfPostDrawAppSurface()` in that event (or your game won't be visible!)

?> You may notice unexpected behaviours with the mouse position after installing PictureFrame. Please check [PfConfigMacros](PfConfigMacros) for more information.

&nbsp;

## Use Case: Pixel-perfect Art

As the name suggests, this is the kind of rendering you want for pixel art games; it'll resize the art to preserve the pixels, without stretching or distorting them. It does this by making sure the camera-to-view scale is a whole number using `.viewPixelPerfect`, and the same for the scale at which the application surface is rendered to the window (`.surfacePixelPerfect`).

1. Import the .yymps file
2. At the start of the game, call `PfConfigPixelArt()` at initialisation and edit the struct to set your desired values
3. Call `PfApply()` using the config struct we just created. You may want to set the optional `resizeWindow` parameter to `true` the first time you call this function in the flow of your game
4. Create a Post-Draw event in a persistent object instance and call `PfPostDrawAppSurface()` in that event (or your game won't be visible!)

&nbsp;

## Use Case: HD Resolution

`PfConfigHighRes()` focuses on automatically scaling the camera and view to any aspect ratio, making it great for mobile games. 

1. Import the .yymps file
2. At the start of the game, call `PfConfigHighRes()` at initialisation and edit the struct to set your desired values
3. Call `PfApply()` using the config struct we just created. You may want to set the optional `resizeWindow` parameter to `true` the first time you call this function in the flow of your game
4. Create a Post-Draw event in a persistent object instance and call `PfPostDrawAppSurface()` in that event (or your game won't be visible!)

&nbsp;

## Use Case: Detecting Window Size Changes

PictureFrame has a built in function that returns **true** if the window size has changed. This can be useful on both desktop (when moving from fullscreen/windowed, changing resolution, or for allowing the player to resize the window) and mobile (to detect landscape/portrait rotation). See [PfWindowSizeChanged()](PfWindowSizeChanged) for more details.

```gml
if (PfWindowSizeChanged())
{
    //Update our configuration
    configStruct.fullscreen   = window_get_fullscreen();
    configStruct.windowWidth  = window_get_width();
    configStruct.windowHeight = window_get_height();
    
    //Reapply to adapt to the new window size
    PfApply(configStruct);
}
```

&nbsp;

## Use Case: Smooth Camera Movement with Pixel-perfect Rendering

When using a pixel-perfect camera on larger screens, you may find the camera "jitters" when it moves as it tries to render pixels that don't fit neatly onto the grid. This happens because the pixels are scaled by integers, but the camera's position is a float. Fortunately, PictureFrame can fix this for you by rendering some extra pixels around the camera, then offsetting the surface rendering to match the camera's fractional value, keeping it nice and smooth.

PictureFrame can do all the maths for you:

1. Set `.cameraOverscan` to 1 when creating a PictureFrame config struct (e.g. the struct returned by [PfConfigPixelArt()](PfConfigPixelArt))

2. Store your own camera x/y position that is the precise decimal value. When you call `camera_set_view_pos()` to set GameMaker's internal camera position make sure to `floor()` the position so that GameMaker renders at an clean integer position

3. When you call `PfPostDrawAppSurface()` in the Post-Draw event, set the `fracCameraX` and `fracCameraY` parameters to the fractional part of your camera x/y position

You can look at the oDemoSmoothCamera object in the repo for a practical example. Here is an abbreviated copy of the code for quick reference:

```gml
/// Create Event

//Create a new config using a template config that uses a pixel perfect camera
configStruct = PfConfigPixelArt(640, 320, 640, 320);

//We'll be taking advantage of the overscan feature for smooth camera movement
configStruct.cameraOverscan = 1;

//Apply the configuration struct to the pipeline
PfApply(configStruct, true);

//Set up some camera tracking variables
var _camera = view_get_camera(0);
cameraX = camera_get_view_x(_camera);
cameraY = camera_get_view_y(_camera);
cameraTargetX = cameraX;
cameraTargetY = cameraY;
```
```gml
/// Step Event

//Move the camera when the player clicks
var _camera = view_get_camera(0);

if (mouse_check_button_pressed(mb_left))
{
    cameraTargetX = mouse_x - camera_get_view_width(_camera)/2;
    cameraTargetY = mouse_y - camera_get_view_height(_camera)/2;
}

//Lerp towards the camera target
//This will generate decimal camera positions
cameraX = lerp(cameraX, cameraTargetX, 0.1);
cameraY = lerp(cameraY, cameraTargetY, 0.1);

//Set the GameMaker camera position to integer positions
camera_set_view_pos(_camera, floor(cameraX), floor(cameraY));
```
```gml
/// Post-Draw Event

//Draw the application surface using PictureFrame's anti-jitter feature
PfPostDrawAppSurface(undefined, undefined, undefined, frac(cameraX), frac(cameraY));
```
