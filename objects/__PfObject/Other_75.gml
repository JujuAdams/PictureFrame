// Feather disable all

if (async_load[? "type"] == "DisplayLayoutInfo")
{
    with(__PfSystem())
    {
        __windowStateChanged = true;
        
        __displayMarginLeft   = async_load[? "safeinsetleft"  ];
        __displayMarginTop    = async_load[? "safeinsettop"   ];
        __displayMarginRight  = async_load[? "safeinsetright" ];
        __displayMarginBottom = async_load[? "safeinsetbottom"];
    }
}