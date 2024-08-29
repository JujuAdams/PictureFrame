# Getting Started

&nbsp;

# The Short Version

1. Import the .yymps file
2. Call one of the PfConfig...() functions at initialisation and edit the returned struct to set your desired values.
3. Call PfApply() or PfCalculate() to apply the configurated struct to your game.
4. In a Post Draw event somewhere, call PfPostDrawAppSurface() (or your game won't be visible!)
5. To detect a change in window size (e.g. switching from fullscreen to windowed, rotating from window to landscape, or changing resolution), call PfWindowSizeChanged(), then PfApply() (see [PfWindowSizeChanged()](PfWindowSizeChanged) for more details)

# The Long Version

