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
// process:menu                                                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process menu()
begin

	file = spr_anim_sailors;
	graph=6;
	x=160;
	y=120;
	z=1;

	clear_screen();

	id_menu_finis = false;
	

	timer[0]=0;

	loop	


		if(timer[0] > 14)
			timer[0]=0;
			menu_text();
		end

		if(JOY_PS2_START(0) || key(_ENTER)) 
			id_menu_finis=true;
			break; 
		end

		if(key(_ESC)) exit("",0); end

		frame;
	end


	stop_wav(id_CANAL_track00_snd);	
	transform();

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:menu_text                                                          //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process menu_text()
begin

	file = spr_anim_sailors;
	graph=7;
	x=80;
	y=80;
	z=0;
	frame;

end	

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:serena_transformation                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process serena_transformation(int pGraphics)
begin

	graph=pGraphics;
	x=160;
	y=120;
	frame;
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:transform                                                          //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process transform()
private
	int  m_graphics;
	byte m_phase0;
	byte m_phase1;
	byte m_phase2;
	byte m_phase3;
	byte m_phase4;
	byte m_phase5;
	byte m_phase6;
	byte m_scroll;
	byte m_finis;
begin

	file = spr_transform;

	clear_screen();

 	define_region(1, 0, 0,320,240);
 	start_scroll(0, spr_transform,1,0,1,1);
 	scroll.camera=id;
 	ctype=c_scroll;


	id_CANAL_track01_snd = play_wav(id_track01_snd,1);

	m_graphics=2;
	timer[0]=0;
	timer[1]=0;
	m_phase0 = true;
	m_phase1 = false;
	m_phase2 = false;
	m_phase3 = false;
	m_phase4 = false;
	m_phase5 = false;
	m_phase6 = false;
	m_scroll = true;
	m_finis  = false;

	loop

		if(m_finis) break; end

		if(m_phase0)
			if(timer[0]>5)
				timer[0]=0;
				if(m_graphics < 3)
					m_graphics++;
				else
					m_graphics=2;
				end
			end
			if(timer[1]>300)
				timer[1]=0;
				m_phase0 = false;
				m_phase1 = true;
			end
		end

		if(m_phase1)
			m_graphics = 4;
			if(timer[1]>200)
				timer[1]=0;
				m_phase1 = false;
				m_phase2 = true;
			end
		end

		if(m_phase2)
			m_graphics = 5;
			if(timer[1]>200)
				timer[1]=0;
				m_phase2 = false;
				m_phase3 = true;				
			end
		end

		if(m_phase3)

			if(m_scroll)
				stop_scroll(0);				
				m_graphics=6;
				m_scroll = false;
			end

			if(timer[1]>200)
				timer[1]=0;
				m_phase3 = false;
				m_phase4 = true;				
			end
		end

		if(m_phase4)

			m_graphics=7;

			if(timer[1]>200)
				timer[1]=0;
				m_phase4 = false;
				m_phase5 = true;				
			end
		end

		if(m_phase5)

			m_graphics=8;

			if(timer[1]>200)
				timer[1]=0;
				m_phase5 = false;
				m_phase6 = true;				
			end
		end


		if(m_phase6)
			if(timer[1]>400)
				timer[1]=0;
				m_phase6 = false;
				m_finis = true;				
			end
		end

		serena_transformation(m_graphics);

		x+=3;
		frame;
	end

	stop_wav(id_CANAL_track01_snd);

	//Free Resources
	fpg_unload(spr_transform);
	fpg_unload(spr_anim_sailors);
	unload_wav(id_track00_snd);
	unload_wav(id_track01_snd);


	//DEBUG
	echo("BEFORE STAGE-01:");
	t_free_mem = IOSYS_CALL_FREE_RAM(); say(t_free_mem); 

	clear_screen();	
	//id_loading_wait = load_png("GMLOAD.TTE");
	put_screen(0,id_loading_wait);
    frame;

	//Load Resources global
	drawing_color(rgb(255,0,0)); draw_box(10,220,30,230); frame;

	spr_serena     = load_fpg("SERENA.DXD");   draw_box(10,220, 60,230); frame; 
	spr_vampire    = load_fpg("VAMPIRE.DXD");  draw_box(10,220, 90,230); frame;
	spr_ogro       = load_fpg("OGRO.DXD");     draw_box(10,220,140,230); frame;
	spr_dragon     = load_fpg("DRAGON.DXD");   draw_box(10,220,160,230); frame;
	id_action_snd  = load_wav("ACTION.ADX");   draw_box(10,220,180,230); frame;
	id_kick_snd    = load_wav("KICK.ADX");     draw_box(10,220,200,230); frame;
	id_power_snd   = load_wav("POWER.ADX");    draw_box(10,220,260,230); frame;	
	id_fpg_stage01 = load_fpg("STAGE01.DXD");  draw_box(10,220,270,230); frame;
	id_track01_snd = load_wav("TRACK01.ADX");  draw_box(10,220,280,230); frame;
	id_witch_snd   = load_wav("WITCH.ADX");    draw_box(10,220,290,230); frame;
	id_ogro_snd    = load_wav("OGRO.ADX");     draw_box(10,220,300,230); frame;
	id_laser_snd   = load_wav("LASER.ADX");    draw_box(10,220,310,230); frame;

	DELAY	

	delete_draw(0);
	clear_screen();


	//GO STAGE: 01
	id_Level = 1;	
	
	Player_gl_score = 0;
	Player_continues = 3;

	Player_vit   = 100;
	Player_power = 0;
	Player_power_value = Difficulty[1][2]; 
	Player_lives = 3;
	Player_score = 0;
	Player_game_over = false;
	Player_winner = false;
	Player_next_level = 30;
	
	Player_mode_platform = MODE_BEATEM_UP;
	
	game_over_system();
	level_01();  
	
end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:you_lose                                                           //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process you_lose()
begin

	file = spr_ogro;
	graph=10;
	x=160;
	y=120;
	z=-3;

	delete_text(0);

	write(0, 10, 90, 0,"  TOTAL SCORE:");    
	write_int(0,20,100, 0,&Player_gl_score);    

	loop

		if(key(_ENTER) || key(_ESC)) break; end	
		if(JOY_PS2_CROSS(0)) break; end
		if(JOY_PS2_CIRCLE(0)) break; end
		if(JOY_PS2_SQUARE(0)) break; end
		if(JOY_PS2_TRIANGLE(0)) break; end

		frame;
	end

	frame;

	exit("",0);

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:you_winner                                                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process you_winner()
begin

	file = id_fpg_stage01;
	graph=1;
	x=160;
	y=120;
	z=-3;

	delete_text(0);

	write(0, 10, 90, 0,"  TOTAL SCORE:");    
	write_int(0,20,100, 0,&Player_gl_score);    

	loop

		if(key(_ENTER) || key(_ESC)) break; end	
		if(JOY_PS2_CROSS(0)) break; end
		if(JOY_PS2_CIRCLE(0)) break; end
		if(JOY_PS2_SQUARE(0)) break; end
		if(JOY_PS2_TRIANGLE(0)) break; end

		frame;
	end

	frame;

	exit("",0);

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:game_over_system                                                   //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process game_over_system()
begin

	file = spr_serena;

	graph=35;
	x=150;
	y=90;
	z=-1000;

	loop

		if(Player_game_over == true)

			graph=35;

			if(key(_SPACE) || JOY_PS2_START(0))
				
				if(Player_continues > 0)

					Player_continues-=1;
					Player_game_over = false;
					Player_lives = 1;
					Player_Score = 0;
					Player_vit = 100;
					Player_power = 0;

				else
					Player_game_over = true;
					break;
				end


			end

		else
			graph=0;
		end

		frame;

	end

	frame;

	Player_gl_score+=Player_score;
	you_lose();

end
