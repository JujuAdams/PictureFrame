// Feather disable all

if (async_load[? "type"] == "DisplayLayoutInfo")
{
    with(__PfSystem())
    {
        var _displayMarginLeft   = async_load[? "safeinsetleft"  ];
        var _displayMarginTop    = async_load[? "safeinsettop"   ];
        var _displayMarginRight  = async_load[? "safeinsetright" ];
        var _displayMarginBottom = async_load[? "safeinsetbottom"];
        
        if ((_displayMarginLeft   != __displayMarginLeft  )
        ||  (_displayMarginTop    != __displayMarginTop   )
        ||  (_displayMarginRight  != __displayMarginRight )
        ||  (_displayMarginBottom != __displayMarginBottom))
        {
            __windowStateChanged = true;
            
            __displayMarginLeft   = _displayMarginLeft;
            __displayMarginTop    = _displayMarginTop;
            __displayMarginRight  = _displayMarginRight;
            __displayMarginBottom = _displayMarginBottom;
        }
    }
}