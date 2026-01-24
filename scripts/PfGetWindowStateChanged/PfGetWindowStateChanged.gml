// Feather disable all

/// Returns whether the window state changed this frame. This function will return `true` only on
/// the frame that a change was detected. You can use this information to allow the game to adapt
/// to the new state. This is handy on desktop platforms whether you may want the player to be able
/// to resize the window and the game needs to adjust. It is further helpful on mobile platforms
/// where a device rotation to and from landscape and portrait is reflected as a window size
/// change.
/// 
/// Window state that is tracked is:
/// 
/// - Window width/height
/// - Fullscreen state
/// - Device orientation (on mobile devices)
/// - Device inset areas e.g. for notch or display cutouts
/// 
/// Example:
/// 
///   if (PfGetWindowStateChanged())
///   {
///       // Update our configuration to reflect the new window state
///       PfConfigSetWindowVars(configStruct);
///       
///       // Reapply the configuration struct to adapt to the new window size. We don't want to
///       // resize the window otherwise we'll get nasty glitching
///       PfApply(configStruct, false);
///   }

function PfGetWindowStateChanged()
{
    static _system = __PfSystem();
    return _system.__windowStateChanged;
}
