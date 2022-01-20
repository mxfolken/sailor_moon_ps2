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
//	  (c) Rolando Fernandez Benavidez 2021.                                   //
//	  GNU General Public License                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
//                        S A I L O R     M O O N                             //
//                          SONY PlayStation 2                                //
// By Rolando Fernandez Benavidez                                             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////
//  LOGS:                                                                     //
//  --------------------------------------------------------------------------//
//  DATE {mm/dd/yyyy}     TIME        SUMMARY                      PROGRAMMER //
//  --------------------------------------------------------------------------//
//  12/20/2021            11:11 am    Create, BennuGD              RFB        //
//  12/21/2021            04:07 pm    Update IO.SYS loader         RFB        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

program SAILORM;

global

	#define MODE_BEATEM_UP   1
	#define MODE_PLATFORM    2
	#define MODE_FIGHTER     3

	//Graphics
	int id_fpg_intro;
	int id_fpg_stage01;
	int spr_transform;
	int spr_serena;
	int spr_serena_icon;
	int spr_vampire;
	int spr_ogro;
	int spr_dragon;
	int spr_anim_sailors;
	
	//Sounds
	int id_track00_snd;
	int id_CANAL_track00_snd;

	int id_track01_snd;
	int id_CANAL_track01_snd;

	int id_action_snd;
	int id_kick_snd;
	int id_power_snd;
	int id_laser_snd;
	int id_dragon_scream_snd;
	int id_witch_snd;
	int id_ogro_snd;
	int id_raven_snd;

	//CORE
	int id_device;
	int t_free_mem;
	int t_total_mem;
	int id_loading_wait;
	byte id_max_cetros;	
	int background_x;
	int background_y;
	int gl_RGB;
	byte gl_bingo; 
	byte gl_dragon_dead;

	int  Player_x;
	int  Player_y;
	byte Player_dir;
	int  Player_score;
	int  Player_gl_score;
	int  Player_lives;
	int  Player_vit;
	int  Player_power;
	int  Player_power_value;
	int  Player_damage;
	byte Player_game_over;
	byte Player_winner;
	int  Player_continues;
	int  Player_next_level;
	byte Player_walk;
	byte Player_jump;
	byte Player_mode_platform;   		
	byte Player_bingo;

	byte id_menu_finis;

	int id_Level;

	int Difficulty[30][20]; //[1=idx, 1=Serena damage
                            //      , 2=Serena power
                            //      , 3=Ogro vit
                            //      , 4=Ogro damage 
                            //      , 5=Vampire vit
                            //      , 6=Vampire damage  
                            //      , 7=Dragon vit
                            //      , 8=Dragon attack
                            //      , 9=Dragon fire
                            //      ,10=Raven vit
                            //      ,11=Raven damage

include "ps2.prg"
include "sartup.prg"
include "level01.prg"
include "level02.prg"
include "level03.prg"
include "level04.prg"
include "level05.prg"
include "level06.prg"
include "level07.prg"
include "level08.prg"
include "level09.prg"
include "level10.prg"
include "level11.prg"
include "level12.prg"
include "level13.prg"
include "level14.prg"
include "charac.prg"
include "menu.prg"

begin

	//System initialize for PlayStation 2	
	echo("Sailor Moon the game");
	echo("This game is GNU/GPL v3.0 license");
	echo("(c)Rolando Fernandez Benavidez");
	echo("Nova32 Development Software 2017.");
	
	echo("System initialize for PlayStation 2");

  //set_mode(320,240,16, MODE_DOUBLEBUFFER | MODE_HARDWARE | DOUBLE_BUFFER | HW_SURFACE | MODE_FULLSCREEN | MODE_2XSCALE );	
	set_mode(320,240,32, MODE_DOUBLEBUFFER | MODE_HARDWARE | DOUBLE_BUFFER | HW_SURFACE );	
	


	set_fps(30, 0);
	full_screen = false;

	echo("PlayStation 2, hardware scanning DRIVER...");
  	id_device = IOSYS_CALL_DRIVE();
	
	
	//***********************************************************
	//* NOW LOADING SCREEN ON | PS2...                          *
	//* ========================================================*
	//* You need to draw the image to a few seconds to achieve  * 
	//* deployment on NTSC/PAL based systems.  timer[0]         *
	//***********************************************************
	
	clear_screen();	
	id_loading_wait = load_png("GMLOAD.TTE");
	put_screen(0,id_loading_wait);
    frame;
	
	timer[0]=0;
	loop
		if(timer[0] > 10) break; end
		frame;
    end



	/////////////////////////////////////////////////////////////////////
    //                         C A U T I O N:	                        *
	//*******************************************************************
    //* These files were canceled because they exceed the amount of     *
	//* files that can read the operating system of the PlayStation2,   *
	//* the maximum number of files on a PS2 DVD-R are 43 files,        *
	//* regardless of size, ie not more than 4.7 GB.	                *
	//*******************************************************************
		
	drawing_color(rgb(255,0,0)); draw_box(10,220,60,230); frame;
		    
	//Load Graphics	
	echo("Load main graphics resources from DVD-R unit");
	
	spr_transform    = load_fpg("TRANSFRM.DXD");  draw_box(10,220,100,230); frame;
	spr_anim_sailors = load_fpg("ANIM01.DXD");    draw_box(10,220,180,230); frame;

	//LOAD SOUNDS ADX FORMAT: 11,000HZ 8-bits mono, PCM native struct
	echo("Load main FX sounds resources from DVD-R unit");

	id_track00_snd = load_wav("INTRO.ADX");     draw_box(10,220,250,230); frame;
	id_track01_snd = load_wav("TRANSFRM.ADX");  draw_box(10,220,310,230); frame;
			
	echo("Initialize core for Sailor Moon...");

	DELAY

	delete_draw(0);
	clear_screen();


	//write(0, 10, 200, 0,"FPS:");    
	//write_int(0, 10, 210, 0,&fps);    
	 
	//write(0,10,30,0,"sx:");   
	//write_int(0, 30, 30, 0,&x);

	//write(0,10,40,0,"sy:");     
	//write_int(0, 30, 40, 0,&y);   


	//DEBUG:
	echo("BEFORE ANIMATIONS STARTUP:");
	t_free_mem = IOSYS_CALL_FREE_RAM(); say(t_free_mem); 


	//STAGE:01
	Difficulty[1][1]=1;  //Serena damage
	Difficulty[1][2]=20;  //Serena power_value
	Difficulty[1][3]=3;  //Ogro vit
	Difficulty[1][4]=1;  //Ogro damage
	Difficulty[1][5]=10; //Vampire vit 
	Difficulty[1][6]=1;  //Vampire damage
	//STAGE:02
	Difficulty[2][1]=2;  //Serena damage
	Difficulty[2][2]=10; //Serena power_value
	Difficulty[2][3]=3;  //Ogro vit
	Difficulty[2][4]=1;  //Ogro damage
	Difficulty[2][5]=10; //Vampire vit 
	Difficulty[2][6]=1;  //Vampire damage
	Difficulty[2][7]=700;//Dragon vit
	Difficulty[2][8]=0;  //Dragon attack
	Difficulty[2][9]=50;  //Dragon fire
	//STAGE:03
	Difficulty[3][1]=2;  //Serena damage
	Difficulty[3][2]=20; //Serena power_value
	Difficulty[3][3]=3;  //Ogro vit
	Difficulty[3][4]=1;  //Ogro damage
	Difficulty[3][5]=10; //Vampire vit 
	Difficulty[3][6]=1;  //Vampire damage
	Difficulty[3][7]=0;  //Dragon vit
	Difficulty[3][8]=0;  //Dragon attack
	Difficulty[3][9]=0;  //Dragon fire
	//STAGE:04
	Difficulty[4][1]=2;  //Serena damage
	Difficulty[4][2]=20; //Serena power_value
	Difficulty[4][3]=3;  //Ogro vit
	Difficulty[4][4]=1;  //Ogro damage
	Difficulty[4][5]=10; //Vampire vit 
	Difficulty[4][6]=1;  //Vampire damage
	Difficulty[4][7]=0;  //Dragon vit
	Difficulty[4][8]=0;  //Dragon attack
	Difficulty[4][9]=0;  //Dragon fire
	Difficulty[4][10]=6; //Raven vit
	Difficulty[4][11]=5; //Raven damage
	//STAGE:05
	Difficulty[5][1]=2;  //Serena damage
	Difficulty[5][2]=20; //Serena power_value
	Difficulty[5][3]=3;  //Ogro vit
	Difficulty[5][4]=1;  //Ogro damage
	Difficulty[5][5]=10; //Vampire vit 
	Difficulty[5][6]=1;  //Vampire damage
	Difficulty[5][7]=0;  //Dragon vit
	Difficulty[5][8]=0;  //Dragon attack
	Difficulty[5][9]=0;  //Dragon fire
	Difficulty[5][10]=6; //Raven vit
	Difficulty[5][11]=5; //Raven damage
	//STAGE:06
	Difficulty[6][1]=2;  //Serena damage
	Difficulty[6][2]=20; //Serena power_value
	Difficulty[6][3]=3;  //Ogro vit
	Difficulty[6][4]=1;  //Ogro damage
	Difficulty[6][5]=10; //Vampire vit 
	Difficulty[6][6]=1;  //Vampire damage
	Difficulty[6][7]=0;  //Dragon vit
	Difficulty[6][8]=0;  //Dragon attack
	Difficulty[6][9]=0;  //Dragon fire
	Difficulty[6][10]=6; //Raven vit
	Difficulty[6][11]=5; //Raven damage
	//STAGE:07
	Difficulty[7][1]=2;  //Serena damage
	Difficulty[7][2]=20; //Serena power_value
	Difficulty[7][3]=3;  //Ogro vit
	Difficulty[7][4]=1;  //Ogro damage
	Difficulty[7][5]=10; //Vampire vit 
	Difficulty[7][6]=1;  //Vampire damage
	Difficulty[7][7]=0;  //Dragon vit
	Difficulty[7][8]=0;  //Dragon attack
	Difficulty[7][9]=0;  //Dragon fire
	Difficulty[7][10]=6; //Raven vit
	Difficulty[7][11]=5; //Raven damage
	//STAGE:08
	Difficulty[8][1]=2;  //Serena damage
	Difficulty[8][2]=20; //Serena power_value
	Difficulty[8][3]=3;  //Ogro vit
	Difficulty[8][4]=1;  //Ogro damage
	Difficulty[8][5]=10; //Vampire vit 
	Difficulty[8][6]=1;  //Vampire damage
	Difficulty[8][7]=0;  //Dragon vit
	Difficulty[8][8]=0;  //Dragon attack
	Difficulty[8][9]=0;  //Dragon fire
	Difficulty[8][10]=6; //Raven vit
	Difficulty[8][11]=5; //Raven damage
	//STAGE:09
	Difficulty[9][1]=2;  //Serena damage
	Difficulty[9][2]=20; //Serena power_value
	Difficulty[9][3]=3;  //Ogro vit
	Difficulty[9][4]=1;  //Ogro damage
	Difficulty[9][5]=10; //Vampire vit 
	Difficulty[9][6]=1;  //Vampire damage
	Difficulty[9][7]=0;  //Dragon vit
	Difficulty[9][8]=0;  //Dragon attack
	Difficulty[9][9]=0;  //Dragon fire
	Difficulty[9][10]=6; //Raven vit
	Difficulty[9][11]=5; //Raven damage
	//STAGE:10
	Difficulty[10][1]=2;  //Serena damage
	Difficulty[10][2]=20; //Serena power_value
	Difficulty[10][3]=3;  //Ogro vit
	Difficulty[10][4]=1;  //Ogro damage
	Difficulty[10][5]=10; //Vampire vit 
	Difficulty[10][6]=1;  //Vampire damage
	Difficulty[10][7]=0;  //Dragon vit
	Difficulty[10][8]=0;  //Dragon attack
	Difficulty[10][9]=0;  //Dragon fire
	Difficulty[10][10]=6; //Raven vit
	Difficulty[10][11]=5; //Raven damage
	//STAGE:11
	Difficulty[11][1]=2;  //Serena damage
	Difficulty[11][2]=20; //Serena power_value
	Difficulty[11][3]=3;  //Ogro vit
	Difficulty[11][4]=1;  //Ogro damage
	Difficulty[11][5]=10; //Vampire vit 
	Difficulty[11][6]=1;  //Vampire damage
	Difficulty[11][7]=0;  //Dragon vit
	Difficulty[11][8]=0;  //Dragon attack
	Difficulty[11][9]=0;  //Dragon fire
	Difficulty[11][10]=6; //Raven vit
	Difficulty[11][11]=5; //Raven damage
	//STAGE:12
	Difficulty[12][1]=2;  //Serena damage
	Difficulty[12][2]=20; //Serena power_value
	Difficulty[12][3]=3;  //Ogro vit
	Difficulty[12][4]=1;  //Ogro damage
	Difficulty[12][5]=10; //Vampire vit 
	Difficulty[12][6]=1;  //Vampire damage
	Difficulty[12][7]=0;  //Dragon vit
	Difficulty[12][8]=0;  //Dragon attack
	Difficulty[12][9]=0;  //Dragon fire
	Difficulty[12][10]=6; //Raven vit
	Difficulty[12][11]=5; //Raven damage
	//STAGE:13
	Difficulty[13][1]=2;  //Serena damage
	Difficulty[13][2]=20; //Serena power_value
	Difficulty[13][3]=3;  //Ogro vit
	Difficulty[13][4]=1;  //Ogro damage
	Difficulty[13][5]=10; //Vampire vit 
	Difficulty[13][6]=1;  //Vampire damage
	Difficulty[13][7]=700;  //Dragon vit
	Difficulty[13][8]=0;  //Dragon attack
	Difficulty[13][9]=50;  //Dragon fire
	Difficulty[13][10]=6; //Raven vit
	Difficulty[13][11]=5; //Raven damage
	//STAGE:14
	Difficulty[14][1]=2;  //Serena damage
	Difficulty[14][2]=5; //Serena power_value
	Difficulty[14][3]=3;  //Ogro vit
	Difficulty[14][4]=1;  //Ogro damage
	Difficulty[14][5]=10; //Vampire vit 
	Difficulty[14][6]=1;  //Vampire damage
	Difficulty[14][7]=700;  //Dragon vit
	Difficulty[14][8]=0;  //Dragon attack
	Difficulty[14][9]=80;  //Dragon fire
	Difficulty[14][10]=6; //Raven vit
	Difficulty[14][11]=5; //Raven damage


	//animation_saliors();
	FBI_arcade();

end




