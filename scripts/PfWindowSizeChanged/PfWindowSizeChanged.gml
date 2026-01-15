// Feather disable all

/// Returns whether the game window changed size this frame. This function will return <true> only
/// only the frame that window size changed. You can use this information to allow the game to
/// rescale to the new window dimensions. This is handy on desktop platforms whether you may want
/// the player to be able to expand or contract the window. It further helpful on mobile platforms
/// where a device rotation to and from landscape and portrait is reflected as a window size
/// change.
/// 
/// Example:
/// 
///   if (PfWindowSizeChanged())
///   {
///       // Update our configuration to reflect the new window state
///       PfConfigSetWindowVars();
///       
///       // Reapply the configuration struct to adapt to the new window size. We don't want to
///       // resize the window otherwise we'll get nasty glitching
///       PfApply(configStruct, false);
///   }

function PfWindowSizeChanged()
{
    static _system = __PfSystem();
    
    return _system.__windowSizeChanged;
}