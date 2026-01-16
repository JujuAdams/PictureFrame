# PfDebugWindow

&nbsp;

`PfDebugWindow([configStruct=none])`

**Returns:** N/A (`undefined`)

|Name            |Datatype|Purpose                                                                                  |
|----------------|--------|-----------------------------------------------------------------------------------------|
|`[configStruct]`|struct  |Optional. Configuration struct to focus, as created by one of the `PfConfig*()` functions|

Creates a debug view for PictureFrame using GameMaker's native `dbg_*` functions. You should call this function once to create the view. If you want to change which configuration struct is being targeted then call the function using the new struct reference.

If you provide a configuration struct when calling `PfDebugWindow()` then you can edit that struct in the debug view. You can execute `PfApply()` struct to the render state by clicking the appropriate button.

Additionally, the debug view shows the current window state as reported by GameMaker and the layout struct that was generated the last time `PfApply()` was called.