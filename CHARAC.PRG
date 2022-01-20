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
// process:serena                                                             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process serena(int pDamage, int pPower,int pX, int pY)
private
	byte dir;
	byte m_Pressed1;    
	byte m_Free1;         
	byte m_Pressed2;    
	byte m_Free2;         
	byte m_Pressed3;    
	byte m_Free3;         
	byte m_Pressed4;    
	byte m_Free4;
	int  m_damage;
	int  m_power;   
	int  C;
	int  m_RGB;
begin

	file = spr_serena;

	graph=1;
	x=pX;
	y=pY;
	z=-2;

	Player_x = x;
	Player_y = y;

	//write(0,10,60,0,"x:");   
	//write_int(0, 30, 60, 0,&x);

	//write(0,10,80,0,"y:");     
	//write_int(0, 30, 80, 0,&y);   

	//write(0,10,100,0,"c:");     
	//write_int(0, 30,100, 0,&gl_RGB);   

	//write(0,10,100,0,"DAMAGE:");     
	//write_int(0, 10,120, 0,&Player_damage);   


	m_damage = pDamage;
	m_power = pPower;


	loop

		if(Player_winner) break; end

		if(Player_game_over == false)


				//Gravity system
				if(Player_mode_platform == MODE_PLATFORM)

					m_RGB = get_pixel(x,y+45);

					//[16 BLUE ON 16-BITS]   [128 BLUE ON 32-BITS]
					if(m_RGB != 0) y+=3; end   
					
					if(y>=300) 
						x=pX;
						y=pY;
						Player_game_over = true; 
					end

				end


				Player_damage=0;
				Player_walk = false;
				Player_jump = false;

				if (JOY_PS2_RIGHT(0) && Player_jump == false)   				

					//RIGHT in platform mode
					if(Player_mode_platform == MODE_PLATFORM)

						if(y<200)
						   			flags = 0;
						   			dir = 0;
						   			Player_dir = dir;

						   				if (x < 300) 
						   				x+=5; 
						   				Player_x = x;
						   				Player_walk = true;
						   				end   			

						   				if(graph >= 2 && graph < 5)
						   					graph+=1;
						   				else
						   					graph=2;
						   				end
						end

					end

					//RIGHT in Beat'em up mode
					if(Player_mode_platform == MODE_BEATEM_UP) 

						   			flags = 0;
						   			dir = 0;
						   			Player_dir = dir;

						   				if (x < 200)  //300
						   				x+=5; 
						   				Player_x = x;
						   				Player_walk = true;
						   				end   			

						   				if(graph >= 2 && graph < 5)
						   					graph+=1;
						   				else
						   					graph=2;
						   				end
				   	end

					//RIGHT in Fighter mode
					if(Player_mode_platform == MODE_FIGHTER) 

						   			flags = 0;
						   			dir = 0;
						   			Player_dir = dir;

						   				if (x < 300) 
						   				x+=5; 
						   				Player_x = x;
						   				Player_walk = true;
						   				end   			

						   				if(graph >= 2 && graph < 5)
						   					graph+=1;
						   				else
						   					graph=2;
						   				end
				   	end



				end

				if (JOY_PS2_LEFT(0) && Player_jump == false)

					//LEFT in mode platform
					if(Player_mode_platform == MODE_PLATFORM)

						if(y<200)
										flags = B_HMIRROR;
										dir = 1;
										Player_dir = dir;

							   			if (x > 20)
										x-=5;
										Player_x = x;
										Player_walk = true;
										end

							   			if(graph >= 2 && graph < 5)
							   				graph+=1;
							   			else
							   				graph=2;
							   			end
					    end

				    else //LEFT in other modes

										flags = B_HMIRROR;
										dir = 1;
										Player_dir = dir;

							   			if (x > 20) 
										x-=5;
										Player_x = x;
										Player_walk = true;
										end

							   			if(graph >= 2 && graph < 5)
							   				graph+=1;
							   			else
							   				graph=2;
							   			end
				    end


				end

				if (JOY_PS2_UP(0) && Player_jump == false && (Player_mode_platform == MODE_BEATEM_UP || Player_mode_platform == MODE_FIGHTER))

		   			
		   			if (y > 116)
					y-=5;
					Player_y = y;
					Player_walk = true;
					end

		   			if(graph >= 2 && graph < 5)
		   				graph+=1;
		   			else
		   				graph=2;
		   			end


				end

				if (JOY_PS2_DOWN(0) && Player_jump == false && (Player_mode_platform == MODE_BEATEM_UP || Player_mode_platform == MODE_FIGHTER))

		   			
		   			if (y < 204)
					y+=5;
					Player_y = y;
					Player_walk = true;
					end

		   			if(graph >= 2 && graph < 5)
		   				graph+=1;
		   			else
		   				graph=2;
		   			end


				end


				  //===================================================================//
				  // PLAYSTATION 2 JOYSTICK                                            //
				  //===================================================================//

		          //--------------------DETECTION BUTTON PRESSED AND FREE (X) ----->      
		          if(JOY_PS2_CROSS(0))       //PS2_BUTTON = (X)
		             m_Pressed1=1;    
		             m_Free1=0;         
		          end
		          
		          if(NOT JOY_PS2_CROSS(0))   //PS2_BUTTON = (X)
		             m_Free1=1;
		          end      

		          //--------------------DETECTION BUTTON PRESSED AND FREE (O) ----->      
		          if(JOY_PS2_CIRCLE(0))       //PS2_BUTTON = (O)
		             m_Pressed2=1;    
		             m_Free2=0;         
		          end
		          
		          if(NOT JOY_PS2_CIRCLE(0))   //PS2_BUTTON = (O)
		             m_Free2=1;
		          end      

		          //--------------------DETECTION BUTTON PRESSED AND FREE ([]) ----->      
		          if(JOY_PS2_SQUARE(0))       //PS2_BUTTON = ([])
		             m_Pressed3=1;    
		             m_Free3=0;         
		          end
		          
		          if(NOT JOY_PS2_SQUARE(0))   //PS2_BUTTON = ([])
		             m_Free3=1;
		          end      

		          //--------------------DETECTION BUTTON PRESSED AND FREE (/\) ----->      
		          if(JOY_PS2_TRIANGLE(0))       //PS2_BUTTON = (/\)
		             m_Pressed4=1;    
		             m_Free4=0;         
		          end
		          
		          if(NOT JOY_PS2_TRIANGLE(0))   //PS2_BUTTON = (/\)
		             m_Free4=1;
		          end      

				  //===================================================================//
				  // PC KEYBOARD                                                       //
				  //===================================================================//
/*
(*
		          //--------------------DETECTION BUTTON PRESSED AND FREE (X) ----->      
		          if(key(_X))       //PS2_BUTTON = (X)
		             m_Pressed1=1;    
		             m_Free1=0;         
		          end
		          
		          if(NOT key(_X))   //PS2_BUTTON = (X)
		             m_Free1=1;
		          end      

		          //--------------------DETECTION BUTTON PRESSED AND FREE (O) ----->      
		          if(key(_O))       //PS2_BUTTON = (O)
		             m_Pressed2=1;    
		             m_Free2=0;         
		          end
		          
		          if(NOT key(_O))   //PS2_BUTTON = (O)
		             m_Free2=1;
		          end      

		          //--------------------DETECTION BUTTON PRESSED AND FREE ([]) ----->      
		          if(key(_Z))       //PS2_BUTTON = ([])
		             m_Pressed3=1;    
		             m_Free3=0;         
		          end
		          
		          if(NOT key(_Z))   //PS2_BUTTON = ([])
		             m_Free3=1;
		          end      

		          //--------------------DETECTION BUTTON PRESSED AND FREE (/\) ----->      
		          if(key(_S))       //PS2_BUTTON = (/\)
		             m_Pressed4=1;    
		             m_Free4=0;         
		          end
		          
		          if(NOT key(_S))   //PS2_BUTTON = (/\)
		             m_Free4=1;
		          end      
*)
*/
				  //===================================================================//
				  // EVENT LISTENER                                                    //
				  //===================================================================//

		         //Event System Button (X)---------------------------------------------
                 if(m_Pressed1 + m_Free1 == 2)    
                   //Clear Buffer for event Button (X)     
                   m_Pressed1=0;
                   m_Free1=0;
                   
				   Player_damage = m_damage;
				   play_wav(id_action_snd,0);
		    	   from graph=16 TO 17;        
	        	   frame(300);              
	   			   end
                   
                 end

		         //Event System Button (O)---------------------------------------------
                 if(m_Pressed2 + m_Free2 == 2)    
                   //Clear Buffer for event Button (O)     
                   m_Pressed2=0;
                   m_Free2=0;
                   
				   Player_damage = m_damage;
				   play_wav(id_kick_snd,0);
			       from graph=19 TO 24;        
		           frame(300);              
		   		   end                   

                 end

		         //Event System Button ([])---------------------------------------------
                 if(m_Pressed3 + m_Free3 == 2)    
                   //Clear Buffer for event Button ([])     
                   m_Pressed3=0;
                   m_Free3=0;
                   
                   if(Player_power > 0)

						   Player_damage = m_power;
						   play_wav(id_power_snd,0); 				
					       from graph=26 TO 32;        
				           frame(300);              
				   		   end

				   		   play_wav(id_laser_snd,0);
				   		   Player_power-=1;
				   		   serena_fire(x,y,dir);
				   		

				  	end

                 end

		         //Event System Button (/\)---------------------------------------------
                 if(m_Pressed4 + m_Free4 == 2)    
                   //Clear Buffer for event Button (/\)     
                   m_Pressed4=0;
                   m_Free4=0;

                   //Jump platform mode
                   if(Player_mode_platform == MODE_PLATFORM)

			                   if(Player_walk == false && y<200)

				                   Player_jump = true;  
				                   play_wav(id_kick_snd,0);                 

				                   graph=11;

							       //from graph=8 TO 12;
							       for(C=1;C<=5;C++)
							       if(dir == 0) if(x<310) x+=7; end Player_x=x; end
							       if(dir == 1) if(x>10) x-=7; end Player_x=x; end
							       if (y > 116) y-=7; Player_y=y; end
						           frame(300);              
						   		   end

							       

							       for(C=1;C<=5;C++)
							       if(dir == 0) if(x<310) x+=7; end Player_x=x; end
							       if(dir == 1) if(x>10) x-=7; end Player_x=x; end
							       if (y < 230) y+=7; Player_y=y; end
						           frame(300);
						           end              

						           graph=13; frame(300);

						        end

					else //Jump normal mode

		                   if(Player_walk == false)

				                   Player_jump = true;  
				                   play_wav(id_kick_snd,0);                 

				                   graph=11;

							       //from graph=8 TO 12;
							       for(C=1;C<=5;C++)
							       if(dir == 0) if(x<310) x+=7; end Player_x=x; end
							       if(dir == 1) if(x>10) x-=7; end Player_x=x; end
							       if (y > 116) y-=7; Player_y=y; end
						           frame(300);              
						   		   end

							       

							       for(C=1;C<=5;C++)
							       if(dir == 0) if(x<310) x+=7; end Player_x=x; end
							       if(dir == 1) if(x>10) x-=7; end Player_x=x; end
							       if (y < 230) y+=7; Player_y=y; end
						           frame(300);
						           end              

						           graph=13; frame(300);

						   end

					end

                 end



		else
			graph=14;			
		end


		frame(200);
		
	end

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:serena_icon                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process serena_icon(int pImage)
begin

	file = spr_serena;
	graph=pImage;
	x=24;
	y=30;
	size=50;	
	frame;

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:serena_cetro_power                                                 //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process serena_cetro_power()	
private	
	int m_y_move;
	int m_y_max;
	int C;
begin

	file = spr_ogro;
	graph=13; //37-serena
	x=rand(30,280);
	y=-100;
	m_y_move=-100;

	m_y_max = rand(125,220);

	id_max_cetros+=1;

	repeat
		m_y_move+=1;
		y+=1;
		frame;
	until(m_y_move > m_y_max)


	for(C=0;C<=300;C++)

		if(Player_winner == true || Player_game_over == true)
			break;
		end

		if(collision(type serena))
			Player_power+=1;
			Player_score+=1;
			break;
		end

		frame(200);
	end

	frame;

	id_max_cetros-=1;

end


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:vampire                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process vampire(byte pDir,int pVit, int pDamage)
private
	byte dir;
	int  r;
	int  vit;
	int  damage;
begin

	file = spr_vampire;
	dir = pDir;

	vit = pVit;
	damage = pDamage;

	graph=1;
	x=300;
	y=rand(80,210);

	//write(0,10,100,0,"x:");   
	//write_int(0, 30, 100, 0,&x);

	//write(0,10,120,0,"y:");     
	//write_int(0, 30,120, 0,&y);  

	if(dir == 0) flags = 0; end
	if(dir == 1) flags = B_HMIRROR; end


	from r=1 to 200;


		//Magic attack of Serena to Vampire
		if(collision(type serena_fire))
			vit-=Player_power_value;			
		end


		if(Player_winner) break; end

		if(collision(type serena))
			if(Player_game_over == false && Player_winner == false)
				Player_vit-=damage;
			end
		end


		if((Player_x+60 >= x) && (Player_x <= x+60))
			if(Player_game_over == false && Player_winner == false)
				vit-=Player_damage;
			end
		end

		if(vit <= 0) 
			Player_score+=1;
			break;
		end


		if((Player_x+60 >= x) && (Player_x <= x+60))

			if(graph >= 4 && graph < 8)
				graph+=1;
			else
				graph=4;
			end

		else
			if(graph >= 1 && graph < 3)
				graph+=1;
			else
				graph=1;
			end
		end

		if(Player_dir == 1) flags = 0; end
		if(Player_dir == 0) flags = B_HMIRROR; end


		x-=1;	

		frame(400);
	end

	if(Player_game_over == false && Player_winner == false)
		play_wav(id_witch_snd,0);
	end

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:ogro                                                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process ogro(byte pDir,int pVit, int pDamage)
private
	byte dir;
	int  r;
	int  vit;
	int  damage;
begin

	file = spr_ogro;
	dir = pDir;

	vit = pVit;
	damage = pDamage;

	graph=1;
	x=300;
	y=rand(122,210);

	//write(0,10,100,0,"x:");   
	//write_int(0, 30, 100, 0,&x);

	//write(0,10,120,0,"y:");     
	//write_int(0, 30,120, 0,&y);   

	if(dir == 0) flags = 0; end
	if(dir == 1) flags = B_HMIRROR; end

	from r=1 to 200;

		//Magic attack of Serena to Ogro
		if(collision(type serena_fire))
			vit-=Player_power_value;			
		end


		if(Player_winner) break; end

		if(collision(type serena))
			if(Player_game_over == false && Player_winner == false)
				Player_vit-=damage;
			end
		end
		
		if((Player_x+60 >= x) && (Player_x <= x+60))
			if(Player_game_over == false && Player_winner == false)
				vit-=Player_damage;
			end
		end

		if(vit <= 0) 
			Player_score+=1;
			break;
		end

		
		if(graph >= 1 && graph < 9)
			graph+=1;
		else
			graph=1;
		end



		x-=14;	

		frame(400);
	end

	if(Player_game_over == false && Player_winner == false)
		play_wav(id_ogro_snd,0);
	end

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:dragon                                                             //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process dragon(int pVit, int pDamageAttack, int pDamageFire)
private
	int  m_vit;
	int  m_damage_attack;
	int  m_damage_fire;
	int  m_dist;
	int  m_id;
	byte m_dir;
begin

	file = spr_dragon;

	m_vit = pVit;
	m_damage_attack = pDamageAttack;
	m_damage_fire = pDamageFire;

	graph=1;
	x=420;
	y=130;
	z=-1;

	//write(0,10,210,0,"x:");   
	//write_int(0, 30, 210, 0,&x);

	//write(0,10,220,0,"y:");     
	//write_int(0, 30,220, 0,&y);   

	timer[0]=0;

	m_id = get_id(type serena);

	loop

		if(Player_winner) break; end

		m_dist = get_dist(m_id);		

		if((m_dist > 80) && (Player_walk == false))
			
			if(Player_x > x) 
				flags = 0;
				m_dir = 0;
				x+=8; 
			end

			if(Player_x < x) 
				flags = B_HMIRROR;
				m_dir = B_HMIRROR;
				x-=8; 
			end

			if(Player_y < y) y-=8; end
			if(Player_y > y) y+=8; end

		end


		if(graph >= 1 && graph < 8)
			graph+=1;
		else
			graph=1;
		end

		//Physical attack of Dragon to Serena
		if(collision(type serena))
			if(Player_game_over == false && Player_winner == false)
				Player_vit-=m_damage_attack;
			end
		end
		
		//Physical attack of Serena to Dragon
		if((Player_x+60 >= x) && (Player_x <= x+60))
			if(Player_game_over == false && Player_winner == false)
				m_vit-=Player_damage;
				Difficulty[2][7]-=Player_damage;
			end
		end

		if(m_vit <= 0) 
			Player_score+=10;
			break;
		end

		
		
		if(m_dir == B_HMIRROR) //RIGHT	
			
			if(timer[0] >= 600)	
				timer[0]=0;

				if(Player_game_over == false && Player_winner == false)
					play_wav(id_dragon_scream_snd,0);
					dragon_fire(x,y,1,m_damage_fire);
				end

			end

		end

		if(m_dir == 0) //LEFT

			if(timer[0] >= 700)	
				timer[0]=0;

				if(Player_game_over == false && Player_winner == false)
					play_wav(id_dragon_scream_snd,0);
					dragon_fire(x,y,2,m_damage_fire);				
				end
			end

		end

		//Magic attack of Serena to Dragon
		if(collision(type serena_fire))
			m_vit-=Player_power_value;
			Difficulty[2][7]-=Player_power_value;
		end


		frame(200);
	end

	gl_dragon_dead = true;

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:dragon_fire                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process dragon_fire(int px,int py, byte pDir,int pDamage)
private
	int r;
	byte dir;
begin

	file = spr_dragon;

	graph=11;
	x=px;
	y=py;
	size=10;
	dir = pDir;

    from r=1 TO 200;        

    	if(collision(type serena))
    		if(Player_vit > 0)
    			Player_vit-=pDamage;
    		end
    		break;
    	end

    	if(dir == 1)
    		x-=7;
    	else
    		x+=7;
    	end

    	size+=1;

        frame;              
	end

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:dragon_picture                                                     //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process dragon_picture()
begin

	file = spr_dragon;
	graph=13;
	x=292;
	y=28;
	frame;

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:dragon_bar                                                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process dragon_bar(int pVit)
begin

	file = spr_dragon;
	graph=12;
	x=227;
	y=22;
	size_x = pVit;
	size_y = 40;
	frame;

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:serena_fire                                                        //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process serena_fire(int px,int py, byte pDir)
private
	int r;
	byte dir;
begin

	file = spr_serena;

	graph=36;
	x=px+180;
	y=py;
	size=100;
	dir = pDir;

    from r=1 TO 7;        

    	if(dir == 1)
    		flags = B_HMIRROR;    		
    		x=px-180;
    	else
    		flags = 0;    		
    		x=px+180;
    	end

        frame;              
	end

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:raven                                                              //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process raven(int pDir, int pVit, int pDamage)
private
	int C;
	int A;
	int m_id;
	int m_dist;
	int m_vit;
	int m_damage;
begin


	file = spr_ogro;
	A=17;
	graph=A;
	z=-3;
	m_vit = pVit;
	m_damage = pDamage;

	if(pDir == 1) //1=LEFT 2=RIGHT
		x = 400;
	else
		x = -400;
	end

	y = rand(80,220);

	m_id = get_id(type serena);

	for(C=0;C<=500;C++)


		//Magic attack of Serena to Raven
		if(collision(type serena_fire))
			m_vit-=Player_power_value;			
		end


		if(Player_winner == true || Player_game_over == true)
			break;
		end


		m_dist = get_dist(m_id);

		if(m_dist < 70)
			m_vit-=Player_damage;
		end

		if(m_vit <= 0)
			play_wav(id_raven_snd,0);
			Player_score+=1;
			break;
		end

		if(collision(type serena))
			if(Player_game_over == false && Player_winner == false)
					Player_vit-=m_damage;			
			end
		end

		if(pDir == 1)
			flags = B_HMIRROR;
			x-=2;
		else
			flags = 0;
			x+=2;
		end

		if(A<22)
			A++;
		else
			A=17;
		end

		graph=A;
		frame;

	end
	
	frame;

end


