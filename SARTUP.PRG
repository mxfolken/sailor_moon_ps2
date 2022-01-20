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
// process:FBI_arcade                                                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process FBI_arcade()
begin

	file = spr_anim_sailors;
	
	put_screen(spr_anim_sailors,11);

	timer[0]=0;

	loop
		if(timer[0] > 700)
			timer[0]=0;
			break;
		end
		frame;
	end

	clear_screen();

	animation_saliors();

end


////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:animation_saliors                                                  //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process animation_saliors()
private 
	int  graphics;	
	byte blit;
	int  img2_x;
	int  img2_y;
	int  img3_x;
	int  img3_y;
	int  img4_x;
	int  img4_y;
	int  img5_x;
	int  img5_y;

begin

	file = spr_anim_sailors;

	graph=1;
	x=160;
	y=120;

	timer[0]=0;
	timer[1]=0;

	graphics=1;
	blit = false;

	//write(0, 10, 10, 0,"GFX:");    
	//write_int(0, 10, 20, 0,&graphics);    

	id_CANAL_track01_snd = play_wav(id_track00_snd,-1);

	img2_x=0;
	img2_y=0;

	img3_x=300;
	img3_y=80;

	img4_x=300;
	img4_y=300;

	img5_x=0;
	img5_y=0;

	//write(0,10,30,0,"x:");   
	//write_int(0, 30, 30, 0,&img4_x);

	//write(0,10,40,0,"y:");     
	//write_int(0, 30, 40, 0,&img4_y);   


	loop

		if(timer[1] > 1500) //1500			
			break;
		end

		if(img2_x < 70) img2_x+=1; end 		
		if(img2_y < 190) img2_y+=3; end		
		picture02(img2_x,img2_y);

		if(img3_x > 60) img3_x-=3; end		
		picture03(img3_x,img3_y);

		if(img4_x > 220) img4_x-=1; end 		
		if(img4_y > 60) img4_y-=3; end		
		picture04(img4_x,img4_y);

		if(img5_x < 240) img5_x+=3; end 		
		if(img5_y < 180) img5_y+=3; end		
		picture05(img5_x,img5_y);

		frame;
	end

	menu();	

end

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
// process:picture02,picture03,picture04,picture05                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

process picture02(int px,int py)
begin

	file = spr_anim_sailors;
	graph=2;
	x=px;
	y=py;
	frame;

end	

process picture03(int px,int py)
begin

	file = spr_anim_sailors;
	graph=3;
	x=px;
	y=py;
	frame;

end	

process picture04(int px,int py)
begin

	file = spr_anim_sailors;
	graph=4;
	x=px;
	y=py;
	frame;

end	

process picture05(int px,int py)
begin

	file = spr_anim_sailors;
	graph=5;
	x=px;
	y=py;
	frame;

end	


