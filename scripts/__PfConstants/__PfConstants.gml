// Feather disable all

//////////////////////////////////////////////////////////
//                                                      //
// Customisation options can be found in `__PfConfig()` //
//                                                      //
//////////////////////////////////////////////////////////

#macro PICTURE_FRAME_VERSION  "4.2.0-alpha"
#macro PICTURE_FRAME_DATE     "2026-08-11"

#macro PICTURE_FRAME_ON_DESKTOP  ((os_browser == browser_not_a_browser) && ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux)))
#macro PICTURE_FRAME_ON_MOBILE   ((os_type == os_ios) || (os_type == os_android))
#macro PICTURE_FRAME_ON_GXGAMES  (os_type == os_gxgames)