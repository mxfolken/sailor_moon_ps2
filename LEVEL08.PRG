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
// process:level_08                                                           //
// ENGINE: BEAT'EM UP                                                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process level_08()
private
	int m_player_icon;	
	int m_rupia_color;
	int m_max_rupias;
	int m_max_meat;
	int m_max_heart;
	int m_max_potion;
	int m_value;
begin	
 
	file = id_fpg_stage01;
	
	id_CANAL_track01_snd = play_wav(id_track01_snd,-1);

	clear_screen();


 	define_region(1, 0, 0,320,240);
 	start_scroll(0, id_fpg_stage01,1,0,1,1);
 	scroll.camera=id;
 	ctype=c_scroll;


	echo("STAGE 08 RUNING: ");
	t_free_mem = IOSYS_CALL_FREE_RAM(); say(t_free_mem);

	serena(Difficulty[id_Level][1],Difficulty[id_Level][2],30,160);
	
	x+=160;
	background_x = x;

	timer[0]=0;
	timer[1]=0;
	timer[2]=0;
	timer[3]=0;
	timer[4]=0;
	timer[5]=0;
	timer[6]=0;

	write(0,50,10, 0,"SCORE:"); write_int(0,100, 10, 0,&Player_score);    
	write(0,50,20, 0,"LEVEL:"); write_int(0,100, 20, 0,&id_Level);    
	write(0,50,30, 0,"LIVES:"); write_int(0,100, 30, 0,&Player_lives);
	write(0,50,40, 0,"VIT  :"); write_int(0,100, 40, 0,&Player_vit);
	write(0,50,50, 0,"PM   :"); write_int(0,100, 50, 0,&Player_power);


	m_player_icon = 38;
	m_rupia_color = 14;
	m_max_rupias = 0;
	m_max_potion = 0;
	m_max_heart = 0;
	m_max_meat = 0;

	loop

			background_x=0;

			//ITEM HEART--------------------------------
			if(timer[6] > 1800) 

				timer[6]=0;
				//m_value = rand(1,10);

				//if(m_value == 9)

					if(m_max_heart < 1)
						m_max_heart+=1;
						item_heart();
					end

				//end

			end

			//ITEM MEAT--------------------------------
			if(timer[5] > 1300)

				timer[5]=0;
				//m_value = rand(1,10);

				//if(m_value == 10)

					if(m_max_meat <= 10)
						m_max_meat+=1;
						item_meat();
					end

				//end

			end

			//ITEM POTION--------------------------------
			if(timer[4] > 1700)

				timer[4]=0;
				//m_value = rand(1,10);

				//if(m_value == 7)
				
					if(m_max_potion <= 2)
						m_max_potion+=1;
						item_potion();
					end

				//end

			end

			//ITEM RUPIAS--------------------------------
			if(timer[3] > 1500)

				timer[3]=0;
				m_value = rand(1,10);

				//if(m_value == 5)					

					if(m_rupia_color == 14)
						m_rupia_color=15;
					else
						m_rupia_color=14;
					end

					if(m_max_rupias <= 7)
						m_max_rupias+=1;
						item_rupia(m_rupia_color);
					end

				//end

			end
			//-------------------------------------------

			serena_icon(m_player_icon); //38,39,41

			if(timer[2] > 700 && Player_game_over == false)
				timer[2]=0;
				if(m_player_icon == 38)
					m_player_icon=39;
				else
					m_player_icon=38;
				end
			end


			if (Player_score >= Player_next_level)
				Player_gl_score+=Player_score;
				Player_winner = true;
				break;			
			end

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


			if(timer[1] > 1500)
				ogro(0,Difficulty[id_Level][3],Difficulty[id_Level][4]);
				timer[1]=0;
			end


			if(timer[0] > 3000)
				vampire(1,Difficulty[id_Level][5],Difficulty[id_Level][6]);
				timer[0]=0;
			end

			if(key(_ESC))
	   			exit("",0);
			end


			if(Player_game_over == false && Player_jump == false)

	        	if(key(_RIGHT) || JOY_PS2_RIGHT(0)) // || JOY_PS2_RIGHT(0)) && x <1800)
		   			x+=3;
		   			background_x=3;
				end


	        	//if(key(_LEFT) || JOY_PS2_LEFT(0)) // || JOY_PS2_LEFT(0)) && x > 200)
		   			//x-=3;
		   			//background_x=-3;
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
	echo("BEFORE STAGE-09:");
	t_free_mem = IOSYS_CALL_FREE_RAM(); say(t_free_mem); 

	clear_screen();
	delete_text(0);

	//id_loading_wait = load_png("GMLOAD.TTE");
	put_screen(0,id_loading_wait);
    frame;

	//Load Resources global
	drawing_color(rgb(255,0,0)); draw_box(10,220,90,230); frame;

	id_fpg_stage01         = load_fpg("STAGE09.DXD");   draw_box(10,220,160,230); frame; 
	id_track01_snd         = load_wav("TRACK07.ADX");   draw_box(10,220,310,230); frame;

	DELAY

	delete_draw(0);
	clear_screen();

	//GO STAGE: 09
	id_Level = 9;
	
	Player_vit   = 100;
	//Player_power = 1;
	Player_power_value = Difficulty[9][2];
	Player_lives+=1;
	Player_score = 0;
	Player_game_over = false;
	Player_winner = false;
	Player_next_level = 40;
	Player_mode_platform = MODE_BEATEM_UP;

	level_09(); 

end


