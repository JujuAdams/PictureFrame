# PfApply

&nbsp;

	PfApply(_configStruct, [_resizeWindow = false], [_ignoreCamera = false])

 Applies a PictureFrame configuration struct, setting necessary native GameMaker values to ensure that the values in the configuration struct accurately affect the game. This function returns the result struct that is generated internally. 

 The "resizeWindow" argument controls whether PictureFrame should resize the game window when calling this function. This guarantees that no black bars will appear when the game is windowed. This value is only relevant when the game is not fullscreened and is therefore only relevant on desktop platforms (Windows, MacOS, Linux).

?> Automatic drawing of the application surface will always be disabled by PfApply() by calling application_surface_draw_enable(false). This means that without further action, your game will not be visible. You should call [PfPostDrawAppSurface()](PfPostDrawAppSurface) in a Post Draw event to ensure that your application surface is visible for the player.

PfApply() calls the following functions to set native GameMaker values:

* Camera position and size. PfApply() presumes that you are using GameMaker's native view system and that you're using view[0] for your game view. If a camera's width or height changes then it will resize, keeping the centre of the view static.

	Functions called:
		view_enabled = true
		view_set_visible(0, true)
		camera_set_view_pos(view_get_camera(0), ...)
		camera_set_view_size(view_get_camera(0), ...)

* View width and height. PfApply() presumes that you are using GameMaker's native view system and that you're using view[0] for your game view.
	Functions called:
 		view_set_wport(0, ...)
		view_set_hport(0, ...)

* Application surface size. PfApply() will set the size of the application surface to match the size of the view.

	Functions called:
    	surface_resize(application_surface, ...)

* Window position and size, including fullscreen state. If the window's size changes then the window will be resized keeping the centre of the window static on the display. PfApply() will only adjust the window when on desktop platforms (Windows, MacOS, Linux).

	Functions called:
    	window_set_fullscreen(...)
    	window_set_rectangle(...)

* GUI layer scale.

	Functions called:
  		display_set_gui_maximize(...)
