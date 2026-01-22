// Feather disable all

function PfGetDisplayMargins()
{
    static _system = __PfSystem();
    static _result = {};
    
    with(_result)
    {
        left   = _system.__displayMarginLeft;
        top    = _system.__displayMarginTop;
        right  = _system.__displayMarginRight;
        bottom = _system.__displayMarginBottom;
    }
    
    return _result;
}