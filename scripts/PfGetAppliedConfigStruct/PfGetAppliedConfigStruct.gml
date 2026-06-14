// Feather disable all

/// Returns a copy of the struct that was last used with `PfApply()`. This is mostly useful for
/// debugging.

function PfGetAppliedConfigStruct()
{
    static _system = __PfSystem();
    return _system.__configStruct;
}