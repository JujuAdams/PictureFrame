&nbsp;

<h1 align="center">PictureFrame 4.1</h1>
<p align="center">Render pipeline calculator for GameMaker 2024.14</p>

<p align="center"><a href="https://github.com/JujuAdams/PictureFrame/releases/" target="_blank">Download the .yymps</a></p>

---

Getting your game's scaling right in GameMaker is an eternal chore. There are multiple scaling factors applied throughout the render pipeline which are all multiplied together to give you the final image displayed to players. This is hard enough to wrap your head around for simple games. If you're looking to add an extra bit of polish by adapting to different screen resolutions and aspect ratios then organising the various render stages becomes very confusing very fast.

PictureFrame will calculate the following output values for you:
- Camera width/height
- Viewport width/height
- Application surface width/height
- GUI layer width/height and position, taking into account the notch/display cutout on a phone
- Application surface draw position and draw scale, taking into account the notch/display cutout on a phone
- Size of black bar margins around the application surface when the application surface is small than the window

You can call `PfCalculate()` to read these values so you can manage the pipeline yourself ... or you can call `PfApply()` to have PictureFrame take care of it all for you.

PictureFrame uses the following input parameters:
- Target camera size
- Camera minimum width/height (the "safe area")
- Camera maximum width/height
- Camera overscan size (useful for smoothing pixel perfect camera movement)
- Maximum scale for the viewport relative to the camera dimensions
- Whether the viewport should be pixel perfect (a.k.a. an integer scale of the camera)
- Whether the game should be displayed fullscreen
- Whether black bars should be trimmed off the window (desktop only)
- Size of the game window
- Whether the GUI layer should stretch over the application surface or the entire window
- Target width and/or target height for the GUI layer
- How the GUI layer's coordinate system should be calculated
- The scaling factor for GUI graphics
- Whether the GUI layer should avoid the notch/display cutout on a phone
- Whether the application surface should avoid the notch/display cutout on a phone
- Whether the application surface should be drawn as "pixel perfect" (a.k.a. at an integer scale) to the window
- Overscan scale for adapting to CRT monitors (a compliance requirement for PS4 games)

PictureFrame is suitable for pixel art games and for high resolution games. It can calculate correct camera sizes regardless of device is especially suited for the wide variety of aspect ratios found on mobile devices. PictureFrame only supports rendering of one view at a time and does not handle split-screen games.

## What does PictureFrame not do?

PictureFrame is unconcerned with where your camera is pointing. Camera control is a complex topic and contributes to gamefeel in a significant way and this library steers clear of interfering with that part of your game. It is regrettably a common mistake for library makers to confuse managing the render pipeline with camera control. PictureFrame can tell you the width and height of the camera but it does not go further than that.

PictureFrame also does support multiple cameras and viewports, nor does it support HTML5 or Opera GX (at the moment at least).
