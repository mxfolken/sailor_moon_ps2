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

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:level_12                                                           //
// ENGINE: SCROLL + RAVEN'S                                                   //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process level_12()
private
	int m_player_icon;	
begin	
 
	file = id_fpg_stage01;
	
	id_CANAL_track01_snd = play_wav(id_track01_snd,-1);

	clear_screen();


 	define_region(1, 0, 0,320,240);
 	start_scroll(0, id_fpg_stage01,1,0,1,1);
 	scroll.camera=id;
 	ctype=c_scroll;


	echo("STAGE 12 RUNING: ");
	t_free_mem = IOSYS_CALL_FREE_RAM(); say(t_free_mem);

	serena(Difficulty[id_Level][1],Difficulty[id_Level][2],30,160);
	
	x=160;
	background_x = x;

	write(0,50,10, 0,"SCORE:"); write_int(0,100, 10, 0,&Player_score);    
	write(0,50,20, 0,"LEVEL:"); write_int(0,100, 20, 0,&id_Level);    
	write(0,50,30, 0,"LIVES:"); write_int(0,100, 30, 0,&Player_lives);
	write(0,50,40, 0,"VIT  :"); write_int(0,100, 40, 0,&Player_vit);
	write(0,50,50, 0,"PM   :"); write_int(0,100, 50, 0,&Player_power);


	//write(0,10,60,0,"x:");   
	//write_int(0, 30, 60, 0,&x);

	//write(0,10,80,0,"y:");     
	//write_int(0, 30, 80, 0,&y);   


	timer[0]=0;
	timer[1]=0;
	timer[2]=0;
	m_player_icon = 38;


	//SKIP LEVEL-----------------
	//x=2566; 
	//Player_score = 40;
	//---------------------------

	loop

			if(timer[0] > 300)
				timer[0]=0;
				raven(1,Difficulty[4][10],Difficulty[4][11]);
			end

			if(timer[1] > 400)
				timer[1]=0;
				raven(2,Difficulty[4][10],Difficulty[4][11]);
			end

			background_x=0;

			serena_icon(m_player_icon); //38,39,41

			if(timer[2] > 700 && Player_game_over == false)
				timer[2]=0;
				if(m_player_icon == 38)
					m_player_icon=39;
				else
					m_player_icon=38;
				end
			end


			//if (Player_score >= Player_next_level)
				if(x >= 2566)
					Player_gl_score+=Player_score;
					Player_winner = true;
					break;			
				end
			//end

			if (Player_vit <= 0 && Player_lives <= 0)
				Player_game_over = true;
				m_player_icon = 41;
			end

			if (Player_vit <= 0)
				if(Player_lives >= 1)
					Player_vit+=100;
					Player_lives-=1;
				end
			end

			if(key(_ESC))
	   			exit("",0);
			end


			if(Player_game_over == false && Player_jump == false)

	        	if(key(_RIGHT) || JOY_PS2_RIGHT(0)) // || JOY_PS2_RIGHT(0)) && x <1800)
		   			
	        		if(x < 2566)
		   				x+=3;
		   				background_x=3;
		   			end

				end


	        	//if(key(_LEFT) || JOY_PS2_LEFT(0)) // || JOY_PS2_LEFT(0)) && x > 200)

	        		//if(x > 160)
		   				//x-=3;
		   				//background_x=-3;
		   			//end

				//end

			end


		frame;
    end
	
	stop_wav(id_CANAL_track01_snd);
	stop_scroll(0);

	//Free resources
	unload_wav(id_track01_snd);
	fpg_unload(id_fpg_stage01);

	//DEBUG
	echo("BEFORE STAGE-13:");
	t_free_mem = IOSYS_CALL_FREE_RAM(); say(t_free_mem); 

	clear_screen();
	delete_text(0);

	//id_loading_wait = load_png("GMLOAD.TTE");
	put_screen(0,id_loading_wait);
    frame;

	//Load Resources global
	drawing_color(rgb(255,0,0)); draw_box(10,220,90,230); frame;

	id_fpg_stage01         = load_fpg("STAGE13.DXD");   draw_box(10,220,160,230); frame; 
	id_track01_snd         = load_wav("TRACK06.ADX");    draw_box(10,220,310,230); frame;

	DELAY

	delete_draw(0);
	clear_screen();

	//GO STAGE: 13
	id_Level = 13;
	
	Player_vit   = 100;
	//Player_power = 1;
	Player_power_value = Difficulty[13][2];
	Player_lives+=1;
	Player_score = 0;
	Player_game_over = false;
	Player_winner = false;
	Player_next_level = 30;
	Player_mode_platform = MODE_BEATEM_UP;

	level_13();

end


