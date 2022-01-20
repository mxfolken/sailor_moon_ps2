////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//    This program is free software: you can redistribute it and/or modify    //
//    it under the terms of the GNU General Public License as published by    //
//    the Free Software Foundation, either version 3 of the License, or       //
//    (at your option) any later version.                                     //
//                                                                            //
//    This program is distributed in the hope that it will be useful,         //
//    but WITHOUT ANY WARRANTY; without even the implied warranty of          //
//    MERCHANTABILITY or FITNESS for A PARTICULAR PURPOSE.  See the           //
//    GNU General Public License for more details.                            //
//                                                                            //
//    You should have received a copy of the GNU General Public License       //
//    along with this program.  if not, see <http://www.gnu.org/licenses/>.   //
//	                                                                          //
//	  Nova32 Development Software                                             //
//	  Nova32 Animation Studios (NAS)                                          //
//	  (c) Rolando Fernandez Benavidez 2017.                                   //
//	  GNU General Public License                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

import "mod_draw";
import "mod_joy";
import "mod_key";
import "mod_map";
import "mod_math";
import "mod_proc";
import "mod_grproc";
import "mod_rand";
import "mod_screen";
import "mod_scroll";
import "mod_sound";
import "mod_text";
import "mod_video";
//import "mod_file";
import "mod_time";
import "mod_string";
//import "mod_mouse";
import "mod_say";
//import "mod_sort";
import "mod_wm";
import "mod_mem";
//import "mod_blendop";
import "mod_timers";
//import "mod_effects";
//import "mod_path";
//import "mod_m7";
//import "mod_dir";
//import "mod_sys";


#define PS2_NULL_DRIVER    -1
#define PS2_DRIVE_MC0       0
#define PS2_DRIVE_MC1       1
#define PS2_DRIVE_HDD0      2
#define PS2_DRIVE_CDFS      3
#define PS2_DRIVE_CDROM0    4
#define PS2_DRIVE_MASS0     5
#define PS2_DRIVE_MASS1     6
#define PS2_DRIVE_HOST      7
#define PS2_DRIVE_MASS      8


//HARDWARE CORE VALUES
#define PLAYSTATION2_HARDWARE  777	
#define SMALLENGINE_DS         1
#define BIGENGINE_DS           2
#define NOTHING                0
#define NIL                    0
#define DUMMY                  0
#define SNDENV                -1
#define INTRO_DEMO             1
#define INTRO_STARTING         2
#define EVENT_PUSH             2
#define EVENT_OFF              0
#define EVENT_ON               1
#define PS2_MEMORY_CARD1       0
#define PS2_MEMORY_CARD2       1

#define PS2_VIDEO              1
#define SDK_VIDEO              2

//PLAYSTATION2 CONTROL MAPPER
#define JOY_PS2_CROSS(A)     JOY_GETBUTTON(A,1)
#define JOY_PS2_CIRCLE(A)    JOY_GETBUTTON(A,2)
#define JOY_PS2_SQUARE(A)    JOY_GETBUTTON(A,0)
#define JOY_PS2_TRIANGLE(A)  JOY_GETBUTTON(A,3)
#define JOY_PS2_SELECT(A)    JOY_GETBUTTON(A,4)
#define JOY_PS2_START(A)     JOY_GETBUTTON(A,5)
#define JOY_PS2_L1(A)        JOY_GETBUTTON(A,6)
#define JOY_PS2_L2(A)        JOY_GETBUTTON(A,8)
#define JOY_PS2_L3(A)        JOY_GETBUTTON(A,10)
#define JOY_PS2_R1(A)        JOY_GETBUTTON(A,7)
#define JOY_PS2_R2(A)        JOY_GETBUTTON(A,9)
#define JOY_PS2_R3(A)        JOY_GETBUTTON(A,11)
#define JOY_PS2_RIGHT(A)     (JOY_GETAXIS(A,0) >= 10000)
#define JOY_PS2_LEFT(A)      (JOY_GETAXIS(A,0) <= -10000)
#define JOY_PS2_UP(A)        (JOY_GETAXIS(A,1) <= -10000)
#define JOY_PS2_DOWN(A)      (JOY_GETAXIS(A,1) >= 10000)

#define TRACE                write(0,10,200,0,"===> TRACE");loop if(key(_ESC)) exit("",-1); end frame; end
#define DELAY                timer[0]=0; loop if(timer[0]>=300) timer[0]=0; break; end frame; end 

