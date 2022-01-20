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
// process:level_14                                                           //
// ENGINE: DRAGON FIGHTER                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process level_14()
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


	echo("STAGE 14 RUNING: ");
	t_free_mem = IOSYS_CALL_FREE_RAM(); say(t_free_mem);

	serena(Difficulty[2][1],Difficulty[2][2],30,160);

	x=481;

	write(0,50,10, 0,"SCORE:"); write_int(0,100, 10, 0,&Player_score);    
	write(0,50,20, 0,"LEVEL:"); write_int(0,100, 20, 0,&id_Level);    
	write(0,50,30, 0,"LIVES:"); write_int(0,100, 30, 0,&Player_lives);
	write(0,50,40, 0,"VIT  :"); write_int(0,100, 40, 0,&Player_vit);
	write(0,50,50, 0,"PM   :"); write_int(0,100, 50, 0,&Player_power);

	write(0,190,10, 0,"DRAGON VIT");

	//write(0,10,210,0,"x:");   
	//write_int(0, 30, 210, 0,&x);

	//write(0,10,220,0,"y:");     
	//write_int(0, 30,220, 0,&y);   


	dragon(Difficulty[2][7],Difficulty[2][8],Difficulty[2][9]);


	timer[1]=0;
	timer[2]=0;

	id_max_cetros = 0;

	m_player_icon = 38;

	loop

		serena_icon(m_player_icon); //38,39,41

		if(timer[2] > 700 && Player_game_over == false)
				timer[2]=0;
				if(m_player_icon == 38)
					m_player_icon=39;
				else
					m_player_icon=38;
				end
		end

		
		dragon_picture();
		dragon_bar(Difficulty[2][7]);


		if(timer[1] > 2000 && id_max_cetros < 3 && Player_power < 10)
			timer[1] = 0;
			serena_cetro_power();
		end


			if ((Player_score >= Player_next_level) && (gl_dragon_dead == true))
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


			if(key(_ESC))
	   			exit("",0);
			end

		frame;
    end
	
	stop_wav(id_CANAL_track01_snd);
	stop_scroll(0);

	//Free resources
	unload_wav(id_track01_snd);
	fpg_unload(id_fpg_stage01);
	
	//DEBUG
	echo("BEFORE END:");
	t_free_mem = IOSYS_CALL_FREE_RAM(); say(t_free_mem); 

	clear_screen();
	delete_text(0);

	//id_loading_wait = load_png("GMLOAD.TTE");
	put_screen(0,id_loading_wait);
    frame;

	//Load Resources global
	drawing_color(rgb(255,0,0)); draw_box(10,220,90,230); frame;

	id_fpg_stage01         = load_fpg("WINNER.DXD");   draw_box(10,220,160,230); frame; 
	id_track01_snd         = load_wav("INTRO.ADX");    draw_box(10,220,310,230); frame;
	

	DELAY

	delete_draw(0);
	clear_screen();

	//GO STAGE: END

	id_CANAL_track01_snd = play_wav(id_track01_snd,-1);

	you_winner();

end
