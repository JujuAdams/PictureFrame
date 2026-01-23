#import "PfNotch.h"

@implementation PfNotch
{
}

-(double)NotchGetLeft
{
    if (@available(iOS 11.0, *))
    {
        return [[UIScreen mainScreen] nativeScale]*UIApplication.sharedApplication.keyWindow.safeAreaInsets.left;
    }
    else
    {
        return 0.0;
    }
}

-(double)NotchGetTop
{
    if (@available(iOS 11.0, *))
    {
        return [[UIScreen mainScreen] nativeScale]*UIApplication.sharedApplication.keyWindow.safeAreaInsets.top;
    }
    else
    {
        return 0.0;
    }
}

-(double)NotchGetRight
{
    if (@available(iOS 11.0, *))
    {
        return [[UIScreen mainScreen] nativeScale]*UIApplication.sharedApplication.keyWindow.safeAreaInsets.right;
    }
    else
    {
        return 0.0;
    }
}

-(double)NotchGetBottom
{
    if (@available(iOS 11.0, *))
    {
        return [[UIScreen mainScreen] nativeScale]*UIApplication.sharedApplication.keyWindow.safeAreaInsets.bottom;
    }
    else
    {
        return 0.0;
    }
}

@end
