<h1 align="center">PictureFrame 2.0.0</h1>

<p align="center">Camera/view/GUI/window/application surface calculator for GameMaker</p>

<p align="center"><a href="https://github.com/JujuAdams/PictureFrame/releases/">Download the .yymps</a></p>

&nbsp;

PictureFrame is a one-script library. You can read the <a href="https://github.com/JujuAdams/PictureFrame/blob/main/PictureFrame/scripts/PictureFrame/PictureFrame.gml">code and comments here</a>.

Getting your game's scaling right in GameMaker is an eternal chore. There are multiple scaling factors applied throughout the render pipeline which are all multiplied together to give you the final image displayed to players. This is hard enough to wrap your head around for simple games. If you're looking to add an extra bit of polish by adapting to different screen resolutions and aspect ratios then organising the various render stages becomes confusing.

PictureFrame is a library that smoothes out the process by providing an API that calculates the dimensions and scaling factors for each stage of the render pipeline. PictureFrame works by calling a handful of functions to set input parameters for the calculator. These parameters define what behaviour is allowed. The `.Apply()` function can then be called to apply the calculated output values to your game, or you can call the getter functions to retrieve specific values for yourself.

PictureFrame will calculate the following output values for you:
- Camera width/height
- Viewport width/height
- Application surface width/height
- GUI layer width/height
- Application surface draw position and draw scale
- Size of black bar margins around the application surface when the application surface is small than the window

PictureFrame uses the following input parameters:
- Camera minimum width/height (the "safe area")
- Camera maximum width/height
- Whether the viewport should be "pixel perfect" (a.k.a. an integer scale of the camera)
- Maximum scale for the viewport relative to the camera dimensions
- Size of the game window
- Whether the game window can be resized by the player on desktop OSes
- Either the target width or target height for the GUI layer (or neither)
- Whether the application surface should be drawn as "pixel perfect" (a.k.a. at an integer scale)

PictureFrame is suitable for pixel art games and for high resolution games. It can calculate correct camera sizes regardless of device is especially suited for the wide variety of aspect ratios found on mobile devices.
