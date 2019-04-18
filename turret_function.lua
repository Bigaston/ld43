function init_turret()
	turret_bar = love.graphics.newImage("img/turret/turret_bar.png")
	turret_cursor = {}
	turret_cursor.damage = love.mouse.newCursor(love.image.newImageData("img/turret/mouse_turret1.png"), 15, 15)
	turret_cursor.freeze = love.mouse.newCursor(love.image.newImageData("img/turret/mouse_turret2.png"), 15, 15)
	turret_cursor.delete = love.mouse.newCursor(love.image.newImageData("img/turret/mouse_turret3.png"), 15, 15)
	turret_cursor.long = love.mouse.newCursor(love.image.newImageData("img/turret/mouse_turret4.png"), 15, 15)

	select_tile = {}
	select_tile.normal = love.graphics.newImage("img/turret/select_tile1.png")
	select_tile.error = love.graphics.newImage("img/turret/select_tile2.png")
	turret_select = nil

	turret_draw = {}
	turret_draw.damage = love.graphics.newImage("img/turret/Turret1.png")
	turret_draw.freeze = love.graphics.newImage("img/turret/Turret2.png")
	turret_draw.long = love.graphics.newImage("img/turret/Turret3.png")
	disp_area = false

	laser = {}
end

function update_turret()
	for lin=1, 9 do
		for col=1,16 do
			if type(level[current_level][lin][col]) == "table" and level[current_level][lin][col][2]~=0 then
				level[current_level][lin][col][2] = level[current_level][lin][col][2] - 1
			end

			for en=1, table.getn(object_enemy) do
				if type(level[current_level][lin][col]) == "table" then
					if level[current_level][lin][col][1] == turret_draw.damage and level[current_level][lin][col][2] == 0 then
						if math.sqrt((((col-1)*80+40)-(object_enemy[en].x+40))^2+(((lin-1)*80+40)-(object_enemy[en].y+40))^2) <= 200 then
							object_enemy[en].health = object_enemy[en].health - 25
							level[current_level][lin][col][2] = 60
							table.insert(laser, {ex=object_enemy[en].x+40,ey=object_enemy[en].y+40,tx=(col-1)*80+40,ty=(lin-1)*80+40,tic=30,col={0.2705, 0.0980, 0.1333}})
						end
					end

					if level[current_level][lin][col][1] == turret_draw.freeze and level[current_level][lin][col][2] == 0 then
						if math.sqrt((((col-1)*80+40)-(object_enemy[en].x+40))^2+(((lin-1)*80+40)-(object_enemy[en].y+40))^2) <= 200 then
							if object_enemy[en].speed >=2 then
								object_enemy[en].speed = object_enemy[en].speed/2
								object_enemy[en].freeze_tic = 300
								level[current_level][lin][col][2] = 60
								table.insert(laser, {ex=object_enemy[en].x+40,ey=object_enemy[en].y+40,tx=(col-1)*80+40,ty=(lin-1)*80+40,tic=30,col={0.1215, 0.2509, 0.3803}})
							end
						end
					end

					if level[current_level][lin][col][1] == turret_draw.long and level[current_level][lin][col][2] == 0 then
						if math.sqrt((((col-1)*80+40)-(object_enemy[en].x+40))^2+(((lin-1)*80+40)-(object_enemy[en].y+40))^2) <= 500 then
							if object_enemy[en].speed >=2 then
								object_enemy[en].health = object_enemy[en].health - 10
								level[current_level][lin][col][2] = 60
								table.insert(laser, {ex=object_enemy[en].x+40,ey=object_enemy[en].y+40,tx=(col-1)*80+40,ty=(lin-1)*80+40,tic=30,col={0.3921, 0.3215, 0.1843}})
							end
						end
					end
				end
			end
		end
	end
end

function draw_turret()
	if turret_select ~= nil then
		local x,y = love.mouse.getPosition()
		local dx = math.floor(x/80)
		local dy = math.floor(y/80)

		if level[current_level][dy+1][dx+1] == 1 then
			if turret_select == turret_draw.damage or turret_select == turret_draw.freeze then
				love.graphics.setColor(0.1019, 0.1098, 0.1725, 0.25)
				love.graphics.circle("fill", dx*80+40, dy*80+40, 200)
				love.graphics.setColor(1,1,1,1)
				love.graphics.draw(select_tile.normal, dx*80, dy*80)
			else
				love.graphics.setColor(0.1019, 0.1098, 0.1725, 0.25)
				love.graphics.circle("fill", dx*80+40, dy*80+40, 500)
				love.graphics.setColor(1,1,1,1)
				love.graphics.draw(select_tile.normal, dx*80, dy*80)
			end
		else
			love.graphics.draw(select_tile.error, dx*80, dy*80)
		end
	end	

	if disp_area == true then
		for lin=1,9 do
			for col=1,16 do
				if type(level[current_level][lin][col]) == "table" then
					if level[current_level][lin][col][1] == turret_draw.damage or level[current_level][lin][col][1] == turret_draw.freeze then
						love.graphics.setColor(0.1019, 0.1098, 0.1725, 0.25)
						love.graphics.circle("fill", (col-1)*80+40, (lin-1)*80+40, 200)
						love.graphics.setColor(1,1,1,1)
					else
						love.graphics.setColor(0.1019, 0.1098, 0.1725, 0.25)
						love.graphics.circle("fill", (col-1)*80+40, (lin-1)*80+40, 500)
						love.graphics.setColor(1,1,1,1)
					end
				end
			end
		end
	end
	for lin=1,9 do
		for col=1,16 do
			if type(level[current_level][lin][col]) == "table" then
				love.graphics.draw(level[current_level][lin][col][1], (col-1)*80,(lin-1)*80)
			end
		end
	end

	draw_laser()
end

function draw_laser()
	for i=1, table.getn(laser) do
		love.graphics.setColor(laser[i].col[1], laser[i].col[2], laser[i].col[3], laser[i].tic/30)
		love.graphics.line(laser[i].ex, laser[i].ey, laser[i].tx, laser[i].ty)
		laser[i].tic = laser[i].tic - 1
		love.graphics.setColor(1,1,1,1)

		if laser[i].tic <= 0 then
			table.remove(laser, i)
			break
		end
	end
end