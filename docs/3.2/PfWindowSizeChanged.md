
	PfWindowSizeChanged()
	returns: boolean

Returns whether the game window changed size this frame. This function will return **true** only if the frame that window size changed. You can use this information to allow the game to rescale to the new window dimensions. This is handy on desktop platforms whether you may want the player to be able to expand or contract the window. It further helpful on mobile platforms where a device rotation to and from landscape and portrait is reflected as a window size change. To do this in real time on mobile, it's recommended to call this in a Post-Draw event.

Example:

	if (PfWindowSizeChanged())
  		{
      		//Update our configuration
      		configStruct.fullscreen   = window_get_fullscreen();
      		configStruct.windowWidth  = window_get_width();
      		configStruct.windowHeight = window_get_height();
      
      		//Reapply to adapt to the new window size
      		PfApply(configStruct);
  	}