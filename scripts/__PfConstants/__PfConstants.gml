// Feather disable all

////////////////////////////////////////////////////////////////////////////
//                                                                        //
// You're welcome to use any of the following macros in your game but ... //
//                                                                        //
//                       DO NOT EDIT THIS SCRIPT                          //
//                       Bad things might happen.                         //
//                                                                        //
//            Customisation options can be found in `__PfConfig()`        //
//                                                                        //
////////////////////////////////////////////////////////////////////////////

#macro PICTURE_FRAME_VERSION  "4.1.3-alpha"
#macro PICTURE_FRAME_DATE     "2026-01-24"

#macro PICTURE_FRAME_ON_DESKTOP  ((os_browser == browser_not_a_browser) && ((os_type == os_windows) || (os_type == os_macosx) || (os_type == os_linux)))
#macro PICTURE_FRAME_ON_MOBILE   ((os_type == os_ios) || (os_type == os_android))