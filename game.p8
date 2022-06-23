pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
--four past six
--by kgf

function _init() --initialization
	game_over=false
	make_player()
	make_cave()
end

function _update() --every frame
	if (not game_over) then
		move_player()
		update_cave()
		check_hit()
	else
			if (btnp(5)) _init() --restart
	end
end

function _draw() --after update
	cls()
	draw_player()
	draw_cave()
	
--code to be executed when the game is over
	if (game_over) then
		if (player.score > 1000) then
			print("game over! you won!",23,44,14)
		else
			print("game over!",44,44,14)
		end
		print("best education", 35,2,12)
		print("your score:"..player.score,34,54,7)
		print("press ❎ to play again!",18,72,14)
		print("wij lanceren je de toekomst in!",3,120,12)
	else
		print("score:"..player.score,2,2,7)
	end
end
-->8
--player
--all code related to the player character
function make_player()
	player={}
	player.x=24 --x position
	player.y=60 --y position
	player.dy=0 --fall speed
	player.rise=1 --rising sprite
	player.fall=2 -- falling sprite
	player.dead=3 -- game over sprite
	player.speed=2 --fly speed
	player.score=0 -- score
end

function draw_player()
	if (game_over) then
		spr(player.dead,player.x,player.y)
	elseif (player.dy<0) then
		spr(player.rise,player.x,player.y)
	else
		spr(player.fall,player.x,player.y)
	end
end

function move_player()
	gravity=0.2 --gravity strength
	player.dy+=gravity --add gravitiy to fall speed

--jump
if (btnp(2)) then
	player.dy-=5 --jump height
	sfx(0)
end
	
	--move to new position
	player.y+=player.dy

	--update score
	player.score+=player.speed
end

function check_hit() --collision
	for i=player.x,player.x+7 do
		if (cave[i+1].top>player.y
		or cave[i+1].btm<player.y+7) then
			game_over=true
			sfx(1) 
		end
	end
end
-->8
--cave
function make_cave()
	cave={{["top"]=5,["btm"]=119}}
	top=45 --ceiling max y
	btm=85 --floor max y
end
function update_cave()
--remove back off cave
	if (#cave>player.speed) then
		for i=1,player.speed do
		del(cave,cave[1])
		end
	end
	--generate more cave
	while (#cave<128) do
		local col={}
		local up=flr(rnd(7)-3)
		local dwn=flr(rnd(7)-3)
		col.top=mid(3,cave[#cave].top+up,top)
		col.btm=mid(btm,cave[#cave].btm+dwn,124)
		add(cave,col)
	end
end

function draw_cave()
	top_color=4 
	btm_color=4 
	for i=1,#cave do
		line(i-1,0,i-1,cave[i].top,top_color)
		line(i-1,127,i-1,cave[i].btm,btm_color)
	end
end
__gfx__
000000000000088800000000aa000a0a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000888800880000a880aa0a000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
007007000008808808888000a988a889000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0007700000880880088888000990aa88000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000088888000088088000800998000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700098880000008808800888880000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000aa9800000000888808800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000a0000000000088800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000400000b4500d450000000000000000154000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00100000356502265017650166501b64016630146200a000145001105011050110001105011050095000a00011600106001160011600126001360014600187001460015600166000000000000000000000000000
