&nbsp;

<h1 align="center">PictureFrame 3.2</h1>
<p align="center">Camera/view/GUI/window/application surface calculator for GameMaker 2024.6</p>

<p align="center"><a href="https://github.com/JujuAdams/PictureFrame/releases/" target="_blank">Download the .yymps</a></p>

---

PictureFrame calculates the correct values for your render pipeline for you. This includes the size of the camera, the view, the application surface, and the GUI layer. PictureFrame is suitable for pixel art games and for high resolution games. It can calculate correct camera sizes regardless of device is especially suited for the wide variety of aspect ratios found on mobile devices.

Getting your game's scaling right in GameMaker is an eternal chore. There are multiple scaling factors applied throughout the render pipeline which are all multiplied together to give you the final image displayed to players. This is hard enough to wrap your head around for simple games. If you're looking to add an extra bit of polish by adapting to different screen resolutions and aspect ratios then organising the various render stages becomes very confusing very fast. PictureFrame does this job for you using a constraint-based system.

&nbsp;

PictureFrame will calculate the following output values for you:

- Camera width/height

- Viewport width/height

- Application surface width/height

- GUI layer width/height

- Application surface draw position and draw scale

- Size of black bar margins around the application surface when the application surface is small than the window

You can then apply these values yourself, or call `PfApply()` to have PictureFrame take care of it for you.

&nbsp;

PictureFrame uses the following input parameters:

- Camera minimum width/height (the "safe area")

- Camera maximum width/height

- Camera overscan size (useful for smoothing pixel perfect camera movement)

- Maximum scale for the viewport relative to the camera dimensions

- Whether the viewport should be pixel perfect (a.k.a. an integer scale of the camera)

- Whether the game should be displayed fullscreen

- Size of the game window

- The target width and/or target height for the GUI layer (or neither)

- Whether the application surface should be drawn as "pixel perfect" (a.k.a. at an integer scale)

- Overscan scale for adapting to CRT monitors (a compliance requirement for PS4 games)