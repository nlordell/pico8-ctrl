pico-8 cartridge // http://www.pico-8.com
version 36
__lua__
--controller demo
--by @nlordell

function _init()
	printh"hello from pico-8!"
end

function _update60()
	updatectrl()
end

function _draw()
	cls(1)
	drawctrl()
	
	drawstk{
		addr={
			x=0x9a00,
			y=0x9a02,
			push=0x9a16,
		},
		x=42,
		y=96,
	}
	drawstk{
		addr={
			x=0x9a04,
			y=0x9a06,
			push=0x9a17,
		},
		x=85,
		y=96,
	}
	
	drawshldr{
		name="zl",
		addr=0x9a08,
		x=37,
		y=19,
	}
	drawshldr{
		name="zr",
		addr=0x9a0a,
		x=76,
		y=19,
	}
	
	drawbtn{
		name="a",
		addr=0x9a0c,
		x=94,
		y=69,
	}
	drawbtn{
		name="b",
		addr=0x9a0d,
		x=104,
		y=59,
	}
	drawbtn{
		name="x",
		addr=0x9a0e,
		x=84,
		y=59,
	}
	drawbtn{
		name="y",
		addr=0x9a0f,
		x=94,
		y=49,
	}
	
	drawbtn{
		name="l",
		addr=0x9a10,
		x=27,
		y=19,
	}
	drawbtn{
		name="r",
		addr=0x9a11,
		x=94,
		y=19,
	}
	
	drawbtn{
		name="-",
		addr=0x9a14,
		x=50,
		y=66,
	}
	drawbtn{
		name="+",
		addr=0x9a15,
		x=70,
		y=66,
	}
	
	drawbtn{
		icon=9,
		addr=0x9a18,
		x=27,
		y=49,
	}
	drawbtn{
		icon=10,
		addr=0x9a19,
		x=27,
		y=69,
	}
	drawbtn{
		icon=11,
		addr=0x9a1a,
		x=17,
		y=59,
	}
	drawbtn{
		icon=12,
		addr=0x9a1b,
		x=37,
		y=59,
	}
	
	drawbtn{
		icon=0,
		addr=0x9a1c,
		x=60,
		y=66,
	}
	
	drawdbg()
end

function updatectrl()
	if @0x5f80==0x9a then
		memcpy(0x9a00,0x5f82,30*@0x5f81)
	else
		printh"☉0☉"
		serial(0x804,0x9a00,30)
	end
end

function drawctrl()
	circfill(30,63,25,6)
	circfill(97,63,25,6)
	rectfill(30,38,97,82,6)
	
	circfill(30,22,8,6)
	circfill(97,22,8,6)
	rectfill(30,14,97,30,6)
	
	circfill(42,96,16,6)
	circfill(85,96,16,6)
end

function drawstk(b)
	local x=%(b.addr.x)/0x7fff
	local y=%(b.addr.y)/0x7fff
	local pressed=@(b.addr.push)>0
	local n=pressed and 8 or 7
	local q=atan2(x,y)
	local dx=x*10
	local dy=y*10
	spr(n,b.x+dx-2,b.y+dy-2)
end

function drawshldr(b)
	local val=%(b.addr)
	local pressed=val>=0x7fff
	local n=pressed and 5 or 3
	spr(n,b.x,b.y,2,1)
	local dy=pressed and 2 or 1
	print(b.name,b.x+4,b.y+dy,0)
	if not pressed and val>0 then
		pset(b.x,b.y+1,5)
		local prog=((val>>15)*13)&0xf
		line(b.x+1,b.y,b.x+1+prog,b.y,5)
	end
end

function drawbtn(b)
	local pressed=@(b.addr)>0
	local n=pressed and 2 or 1
	spr(n,b.x,b.y)
	local dy=pressed and 1 or 0
	if b.name then
		print(b.name,b.x+2,b.y+1+dy,0)
	else
		pal(1,0)
		spr(b.icon,b.x,b.y+dy)
		pal()
	end
end

function drawdbg()
	cursor(2,2,9)
	print(""..(stat(1)*100).."%")
end
__gfx__
000000000eeeee00000000000eeeeeeeeeeeee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00080000e22222e005555500e2222222222222e00555555555555500000000000000000000000000000000000000000000000000000000000000000000000000
0097f000222222205555555022222222222222205555555555555550000e00000555550000010000001110000001100000110000000000000000000000000000
0a777e0022222220555555502222222222222220555555555555555000e2e0005555555000111000001110000011100000111000000000000000000000000000
00b7d000222222205555555022222222222222205555555555555550000200000555550000111000000100000001100000110000000000000000000000000000
000c0000222222205555555022222222222222205555555555555550000000000000000000000000000000000000000000000000000000000000000000000000
00000000122222105555555012222222222222105555555555555550000000000000000000000000000000000000000000000000000000000000000000000000
00000000011111000555550001111111111111000555555555555500000000000000000000000000000000000000000000000000000000000000000000000000
__label__
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111116666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111111
11111111111111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111
11111111111111111111111116666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111
11111111111111111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111111111111111
11111111111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666611111111111111111111111
1111111111111111111111166666eeeee66666eeeeeeeeeeeee66666666666666666666666666eeeeeeeeeeeee66666eeeee6666611111111111111111111111
111111111111111111111166666e20222e666e2220002022222e666666666666666666666666e2220002000222e666e20002e666661111111111111111111111
11111111111111111111116666622022226662222220202222226666666666666666666666662222220202022226662202022666661111111111111111111111
11111111111111111111116666622022226662222202202222226666666666666666666666662222202200222226662200222666661111111111111111111111
11111111111111111111116666622022226662222022202222226666666666666666666666662222022202022226662202022666661111111111111111111111
11111111111111111111116666622000226662222000200022226666666666666666666666662222000202022226662202022666661111111111111111111111
11111111111111111111111666612222216661222222222222216666666666666666666666661222222222222216661222221666611111111111111111111111
11111111111111111111111666661111166666111111111111166666666666666666666666666111111111111166666111116666611111111111111111111111
11111111111111111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111111111111111
11111111111111111111111116666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111
11111111111111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111
11111111111111111111111111116666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666611111111111111111111111111
11111111111111111111116666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111111111
11111111111111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666666611111111111111111111
11111111111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111111111
11111111111111116666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111111
11111111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111111
11111111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666611111111111111
11111111111116666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111
11111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111
11111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666611111111111
11111111116666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111
1111111116666666666666666666eeeee66666666666666666666666666666666666666666666666666666666666666eeeee6666666666666666666111111111
111111111666666666666666666e22222e666666666666666666666666666666666666666666666666666666666666e20202e666666666666666666111111111
11111111666666666666666666622202226666666666666666666666666666666666666666666666666666666666662202022666666666666666666611111111
11111111666666666666666666622000226666666666666666666666666666666666666666666666666666666666662220222666666666666666666611111111
11111116666666666666666666622000226666666666666666666666666666666666666666666666666666666666662202022666666666666666666661111111
11111116666666666666666666622222226666666666666666666666666666666666666666666666666666666666662202022666666666666666666661111111
11111166666666666666666666612222216666666666666666666666666666666666666666666666666666666666661222221666666666666666666666111111
11111166666666666666666666661111166666666666666666666666666666666666666666666666666666666666666111116666666666666666666666111111
11111166666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111
11111166666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111
111116666666666666eeeee666666666666666eeeee666666666666666666666666666666666666666666eeeee666666666666666eeeee666666666666611111
11111666666666666e22222e6666666666666e22222e6666666666666666666666666666666666666666e20202e6666666666666e20002e66666666666611111
11111666666666666222002266666666666662200222666666666666666666666666666666666666666622020226666666666666220202266666666666611111
11111666666666666220002266666666666662200022666666666666666666666666666666666666666622000226666666666666220002266666666666611111
11111666666666666222002266666666666662200222666666666666666666666666666666666666666622220226666666666666220202266666666666611111
11111666666666666222222266666666666662222222666666666666666666666666666666666666666622000226666666666666220202266666666666611111
11111666666666666122222166666666666661222221666666666666666666666666666666666666666612222216666666666666122222166666666666611111
111116666666666666111116666666666666661111166666666eeeee66666eeeee66666eeeee6666666661111166666666666666611111666666666666611111
11111666666666666666666666666666666666666666666666e22222e666e22822e666e22222e666666666666666666666666666666666666666666666611111
1111116666666666666666666666666666666666666666666622222226662297f226662220222666666666666666666666666666666666666666666666111111
1111116666666666666666666666eeeee6666666666666666622000226662a777e26662200022666666666666666666eeeee6666666666666666666666111111
111111666666666666666666666e22222e6666666666666666222222266622b7d22666222022266666666666666666e20002e666666666666666666666111111
111111666666666666666666666220002266666666666666662222222666222c2226662222222666666666666666662202022666666666666666666666111111
11111116666666666666666666622000226666666666666666122222166612222216661222221666666666666666662200222666666666666666666661111111
11111116666666666666666666622202226666666666666666611111666661111166666111116666666666666666662202022666666666666666666661111111
11111111666666666666666666622222226666666666666666666666666666666666666666666666666666666666662200022666666666666666666611111111
11111111666666666666666666612222216666666666666666666666666666666666666666666666666666666666661222221666666666666666666611111111
11111111166666666666666666661111166666666666666666666666666666666666666666666666666666666666666111116666666666666666666111111111
11111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111
11111111116666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111
11111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666611111111111
11111111111166666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666111111111111
11111111111116666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666661111111111111
11111111111111666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666611111111111111
11111111111111166666666666666666666666666666666666661111111111111111111111116666666666666666666666666666666666666111111111111111
11111111111111116666666666666666666666666666666666666611111111111111111111666666666666666666666666666666666666661111111111111111
11111111111111111166666666666666666666666666666666666661111111111111111116666666666666666666666666666666666666111111111111111111
11111111111111111111666666666666666666666666666666666661111111111111111116666666666666666666666666666666666611111111111111111111
11111111111111111111116666666666666666666666666666666666111111111111111166666666666666666666666666666666661111111111111111111111
11111111111111111111111111666666666666666666666666666666611111111111111666666666666666666666666666666611111111111111111111111111
11111111111111111111111111116666666666666666666666666666611111111111111666666666666666666666666666661111111111111111111111111111
11111111111111111111111111166666666666666666666666666666661111111111116666666666666666666666666666666111111111111111111111111111
11111111111111111111111111166666666666666666666666666666661111111111116666666666666666666666666666666111111111111111111111111111
11111111111111111111111111166666666666666666666666666666661111111111116666666666666666666666666666666111111111111111111111111111
11111111111111111111111111666666666666666666666666666666666111111111166666666666666666666666666666666611111111111111111111111111
11111111111111111111111111666666666666666666666666666666666111111111166666666666666666666666666666666611111111111111111111111111
11111111111111111111111111666666666666666666666666666666666111111111166666666666666666666666666666666611111111111111111111111111
1111111111111111111111111166666666666666666e666666666666666111111111166666666666666666e66666666666666611111111111111111111111111
111111111111111111111111116666666666666666e2e6666666666666611111111116666666666666666e2e6666666666666611111111111111111111111111
11111111111111111111111111666666666666666662666666666666666111111111166666666666666666266666666666666611111111111111111111111111
11111111111111111111111111666666666666666666666666666666666111111111166666666666666666666666666666666611111111111111111111111111
11111111111111111111111111166666666666666666666666666666661111111111116666666666666666666666666666666111111111111111111111111111
11111111111111111111111111166666666666666666666666666666661111111111116666666666666666666666666666666111111111111111111111111111
11111111111111111111111111166666666666666666666666666666661111111111116666666666666666666666666666666111111111111111111111111111
11111111111111111111111111116666666666666666666666666666611111111111111666666666666666666666666666661111111111111111111111111111
11111111111111111111111111116666666666666666666666666666611111111111111666666666666666666666666666661111111111111111111111111111
11111111111111111111111111111666666666666666666666666666111111111111111166666666666666666666666666611111111111111111111111111111
11111111111111111111111111111166666666666666666666666661111111111111111116666666666666666666666666111111111111111111111111111111
11111111111111111111111111111166666666666666666666666661111111111111111116666666666666666666666666111111111111111111111111111111
11111111111111111111111111111116666666666666666666666611111111111111111111666666666666666666666661111111111111111111111111111111
11111111111111111111111111111111166666666666666666661111111111111111111111116666666666666666666111111111111111111111111111111111
11111111111111111111111111111111116666666666666666611111111111111111111111111666666666666666661111111111111111111111111111111111
11111111111111111111111111111111111166666666666661111111111111111111111111111116666666666666111111111111111111111111111111111111
11111111111111111111111111111111111111166666661111111111111111111111111111111111116666666111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111

