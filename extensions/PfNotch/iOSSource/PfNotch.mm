@implementation PfNotch

-(double)GetNotchLeft
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

@end