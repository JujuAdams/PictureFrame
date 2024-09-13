# PfPostDrawAppSurface

&nbsp;

`PfWindowSizeChanged()`

&nbsp;

**Returns:** Boolean, whether the window size or orientation changed

|Name        |Datatype|Purpose|
|------------|--------|-------|
|No arguments|        |       |

Returns whether the game window changed size this frame. This function will return `true` only if the frame that window size changed. You can use this information to allow the game to rescale to the new window dimensions. This is handy on desktop platforms whether you may want the player to be able to expand or contract the window. It further helpful on mobile platforms where a device rotation to and from landscape and portrait is reflected as a window size change.

?> It is recommended to call this function in the Post Draw event. This will work around potential rendering glitches when the window changes shape.

Example:

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
