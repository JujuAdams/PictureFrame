# PfConfigSetWindowVars

&nbsp;

`PfConfigSetWindowVars(configStruct)`

**Returns:** N/A (`undefined`)

|Name            |Datatype|Purpose                       |
|----------------|--------|------------------------------|
|`[configStruct]`|struct  |Configuration struct to modify|

Updates window variables in the configuration struct. This is helpful to call after detecting a window state change with `PfGetWindowStateChanged()` to refresh a config struct.

Variables adjusted are:

|Name                             |Datatype|Purpose                      |
|---------------------------------|--------|-----------------------------|
|`.fullscreen`                    |boolean |Fullscreen state for the game|
|`.windowWidth`<br>`.windowHeight`|number  |Size of the game window      |
