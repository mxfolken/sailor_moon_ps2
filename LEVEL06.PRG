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
// process:level_06                                                           //
// ENGINE: BINGO                                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process level_06()
private
	int m_card;
	int m_serena_card;
	int m_blue_card;
	int m_purple_card;	
	int m_card1;
	int m_card2;
	int m_card3;
	int m_bingo_card;
	string m_value;
begin	
 
	file = id_fpg_stage01;
	
	id_CANAL_track01_snd = play_wav(id_track01_snd,-1);

	clear_screen();
	put_screen(id_fpg_stage01,1);

	m_card=3;
	m_serena_card=4;
	m_blue_card=5;
	m_purple_card=6;	

	m_card1 = m_card;
	m_card2 = m_card;
	m_card3 = m_card;

	echo("STAGE 06 RUNING: ");
	t_free_mem = IOSYS_CALL_FREE_RAM(); say(t_free_mem);
	
	write(0,120,45, 0,"What is the card"); 
	write(0,120,55, 0,"with Serenas's"); 
	write(0,120,65, 0,"face? "); 

	write_string(0,150,190,0,&m_value); 


	//write(0,10,60,0,"x:");   
	//write_int(0, 30, 60, 0,&x);

	//write(0,10,80,0,"y:");     
	//write_int(0, 30, 80, 0,&y);   

	show_mouse();

	//---------Bingo routine------------------------------------	
	
	//-----------------------------------------------------------

	loop
			cmd_exit();

			if(gl_bingo)

				if(m_bingo_card == 1)
					m_card1 = 4;
					m_card2 = 5;
					m_card3 = 6;
				end

				if(m_bingo_card == 2)
					m_card1 = 5;
					m_card2 = 4;
					m_card3 = 6;
				end

				if(m_bingo_card == 3)
					m_card1 = 6;
					m_card2 = 5;
					m_card3 = 4;
				end

				if(Player_bingo)
					m_value = "You get 400 points!";
				else
					m_value = "You lose all your points!";
				end				

			end

			if(gl_bingo == false)
				m_bingo_card = rand(1,3);
			end

			bingo_cards(172,147,m_card1,1,m_bingo_card);

			bingo_cards(230,147,m_card2,2,m_bingo_card);

			bingo_cards(283,147,m_card3,3,m_bingo_card);


			if(Player_winner)
				break;
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
	echo("BEFORE STAGE-07:");
	t_free_mem = IOSYS_CALL_FREE_RAM(); say(t_free_mem); 

	clear_screen();
	delete_text(0);

	//id_loading_wait = load_png("GMLOAD.TTE");
	put_screen(0,id_loading_wait);
    frame;

	//Load Resources global
	drawing_color(rgb(255,0,0)); draw_box(10,220,90,230); frame;

	id_fpg_stage01         = load_fpg("STAGE07.DXD");    draw_box(10,220,160,230); frame; 
	id_track01_snd         = load_wav("TRACK05.ADX");    draw_box(10,220,310,230); frame;

	DELAY

	delete_draw(0);
	clear_screen();

	//GO STAGE: 07
	id_Level = 7;
	
	Player_vit   = 100;
	//Player_power = 1;
	Player_power_value = Difficulty[7][2];
	Player_lives+=1;
	Player_score = 0;
	Player_game_over = false;
	Player_winner = false;
	Player_next_level = 30;
	Player_mode_platform = MODE_BEATEM_UP;

	level_07();

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:bingo_cards                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process bingo_cards(int px,int py,int pgfx, int pID, int pBingo)
private
	int m_pid;
	int m_bingo;	
begin

	file = id_fpg_stage01;
	graph=pgfx;
	x=px;
	y=py;
	m_pid = pID;
	m_bingo = pBingo;

	if(gl_bingo == false)
		if(collision(type show_mouse))
			if(JOY_PS2_CROSS(0) || key(_X))
				if(m_pid == m_bingo)
					gl_bingo = true;
					Player_gl_score+=400;
					Player_bingo = true;
				else
					gl_bingo = true;
					Player_gl_score=0;
					Player_bingo = false;
				end
			end
		end
	end



	frame;

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:cmd_exit                                                           //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process cmd_exit()
begin

	file = id_fpg_stage01;
	graph=7;
	x=279;
	y=216;

		if(collision(type show_mouse))
			if(JOY_PS2_CROSS(0) || key(_X))
				Player_winner = true;
			end
		end

	frame;

end
