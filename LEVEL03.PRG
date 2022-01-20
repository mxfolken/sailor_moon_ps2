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
// process:level_03                                                           //
// ENGINE: PLATFORM                                                           //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process level_03()
private
	int m_player_icon;		
begin	

 
	file = id_fpg_stage01;

	
	id_CANAL_track01_snd = play_wav(id_track01_snd,-1);

	clear_screen();


	put_screen(id_fpg_stage01,1);


	echo("STAGE 03 RUNING: ");
	t_free_mem = IOSYS_CALL_FREE_RAM(); say(t_free_mem);

	serena(Difficulty[id_Level][1],Difficulty[id_Level][2],25,120); //25,120 skip=300,178


	write(0,50,10, 0,"SCORE:"); write_int(0,100, 10, 0,&Player_score);    
	write(0,50,20, 0,"LEVEL:"); write_int(0,100, 20, 0,&id_Level);    
	write(0,50,30, 0,"LIVES:"); write_int(0,100, 30, 0,&Player_lives);
	write(0,50,40, 0,"VIT  :"); write_int(0,100, 40, 0,&Player_vit);
	write(0,50,50, 0,"PM   :"); write_int(0,100, 50, 0,&Player_power);

	//write(0,10,210,0,"x:");   
	//write_int(0, 30, 210, 0,&x);

	//write(0,10,220,0,"y:");     
	//write_int(0, 30,220, 0,&y);   


	timer[1]=0;

	m_player_icon = 38;

	//show_mouse();

	put_rupia(14,87,198);
	put_rupia(14,144,206);
	put_rupia(14,207,220);
	put_rupia(14,270,220);
	put_rupia(14,307,184);

	dagger();


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



		if(timer[1] > 500)
			timer[1] = 0;
			dagger();
		end


			if (Player_x == 300 && Player_y == 178)
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

	//Free resources
	unload_wav(id_track01_snd);
	fpg_unload(id_fpg_stage01);
	
	//DEBUG
	echo("BEFORE STAGE-04:");
	t_free_mem = IOSYS_CALL_FREE_RAM(); say(t_free_mem); 

	clear_screen();
	delete_text(0);

	//id_loading_wait = load_png("GMLOAD.TTE");
	put_screen(0,id_loading_wait);
    frame;

	//Load Resources global
	drawing_color(rgb(255,0,0)); draw_box(10,220,90,230); frame;

	id_fpg_stage01         = load_fpg("STAGE04.DXD");   draw_box(10,220,160,230); frame; 
	id_track01_snd         = load_wav("TRACK03.ADX");   draw_box(10,220,260,230); frame;
	id_raven_snd           = load_wav("RAVEN.ADX");     draw_box(10,220,310,230); frame;

	DELAY

	delete_draw(0);
	clear_screen();

	//GO STAGE: 04
	id_Level = 4;
	
	Player_vit   = 100;
	//Player_power = 1;
	Player_power_value = Difficulty[4][2];
	Player_lives+=1;
	Player_score = 0;
	Player_game_over = false;
	Player_winner = false;
	Player_next_level = 30;
	Player_mode_platform = MODE_BEATEM_UP;

	level_04();

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:show_mouse                                                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process show_mouse()
begin

	file = spr_ogro;
	graph=23;
	x=222;
	y=204;

	//write(0,10,190,0,"x:");   
	//write_int(0, 30, 190, 0,&x);

	//write(0,10,200,0,"y:");     
	//write_int(0, 30, 200, 0,&y);   

	//write(0,10,220,0,"c:");     
	//write_int(0, 30, 220, 0,&gl_rgb);   

	loop

		if(Player_winner || Player_game_over)
			break;
		end

		if(JOY_PS2_RIGHT(0) || key(_RIGHT)) 
			if(x<309) x+=3; end 
		end

		if(JOY_PS2_LEFT(0) || key(_LEFT)) 
			if(x>9) x-=3; end 
		end

		if(JOY_PS2_UP(0) || key(_UP)) 
			if(y>9) y-=3; end 
		end

		if(JOY_PS2_DOWN(0) || key(_DOWN)) 
			if(y<228) y+=3; end 
		end


		gl_rgb = get_pixel(x,y);

		frame;
	end

	frame;

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:dagger                                                             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process dagger()	
private	
	int m_y_move;
begin

	file = spr_ogro;
	graph=16;
	x=rand(30,280);
	y=-100;
	m_y_move=-100;

	repeat

		if(Player_winner == true || Player_game_over == true)
			break;
		end

		if(collision(type serena))
			Player_vit = Player_vit - 20;
			break;
		end
		m_y_move+=1;
		y+=1;
		frame;
	until(m_y_move > 700)



	frame;


end
