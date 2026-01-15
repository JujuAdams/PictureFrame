// Feather disable all

/// Returns the layout struct that is currently applied. This is the same as the layout struct
/// that is returned by `PfApply()` itself. Bear in mind that `PfApply()` is called on boot
/// automatically so the struct returned by this function should always contain some information.
/// 
/// If you have modified the window state (such as resizing the window) then this function will not
/// necessarily return good data. You should take care to call `PfApply()` when the window state
/// changes.
/// 
/// N.B. You shouldn't edit the layout struct as this may cause rendering errors.

function PfGetAppliedLayoutStruct()
{
    static _system = __PfSystem();
    return _system.__layoutStruct;
}