// Feather disable all

/// Returns the result struct that is currently applied. This is the same as the result struct
/// that is returned by PfApply() itself.
/// 
/// N.B. You shouldn't edit the result struct as this may cause rendering errors.

function PfGetApplied()
{
    static _system = __PfSystem();
    return _system.__resultStruct;
}