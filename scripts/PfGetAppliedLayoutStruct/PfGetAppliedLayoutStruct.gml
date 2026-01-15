// Feather disable all

/// Returns the layout struct that is currently applied. This is the same as the layout struct
/// that is returned by `PfApply()` itself.
/// 
/// N.B. You shouldn't edit the layout struct as this may cause rendering errors.

function PfGetAppliedLayoutStruct()
{
    static _system = __PfSystem();
    return _system.__layoutStruct;
}