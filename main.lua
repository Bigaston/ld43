require("level_function")
require("enemy_function")
require("utils_function")
require("turret_function")
require("discord_function")
discordRPC = require("lib/discordRPC")

function love.load()
	pico8 = love.graphics.newFont("font/PICO-8.ttf", 16)
	love.graphics.setFont(pico8)

	init_level()
	init_enemy()
	init_turret()

	init_discord()

	start_game = false

	human = 100
	t = 60
	tic = 0
	human_bar = love.graphics.newImage("img/human.png")
	time_bar = love.graphics.newImage("img/time.png")
end

function love.update()
	update_enemy()
	update_turret()
	update_discord()

	if start_game == true then
		tic = tic + 1

		if tic == 60 then
			tic = 0
			t = t - 1

			if t == 0 then
				t = 60
				current_level = current_level + 1
				start_game = false
				object_enemy = {}
				etic=600
				metic = 300
				turret_select = nil
			end
		end
	end

	--[[x,y = love.mouse.getPosition()
	print(x.."|"..y)]]
end

function love.draw()
	draw_level()
	draw_enemy()
	draw_turret()

	love.graphics.draw(human_bar, 0, 660)
	love.graphics.draw(turret_bar, 960, 660)
	love.graphics.draw(time_bar, 0, 20)
	love.graphics.print({{0.1019,0.1098,0.1725,1},human}, 30, 670)
	love.graphics.print({{0.1019,0.1098,0.1725,1},t}, 40, 30)
end

function love.mousepressed(x, y, button, istouch, presses)
	if button == 2 then
		want_delete = false
		love.mouse.setCursor(love.mouse.getSystemCursor("arrow"))
		turret_select = nil
	else
		if want_delete == true then
			local x,y = love.mouse.getPosition()
			local dx = math.floor(x/80)
			local dy = math.floor(y/80)

			if type(level[current_level][dy+1][dx+1]) == "table" then
				if level[current_level][dy+1][dx+1][1] == turret_draw.damage then human = human + 5 end
				if level[current_level][dy+1][dx+1][1] == turret_draw.freeze then human = human + 3 end
				if level[current_level][dy+1][dx+1][1] == turret_draw.long then human = human + 4 end
				level[current_level][dy+1][dx+1] = 1
				
			end

			want_delete = false
			love.mouse.setCursor(love.mouse.getSystemCursor("arrow"))
		elseif turret_select == nil then
			if y >= 665 and y <= 695 then
				if x >= 970 and x <= 1000 then
					love.mouse.setCursor(turret_cursor.damage)
					turret_select = turret_draw.damage
				elseif x >= 1010 and x <= 1040 then
					love.mouse.setCursor(turret_cursor.freeze)
					turret_select = turret_draw.freeze
				elseif x >= 1050 and x <= 1080 then
					love.mouse.setCursor(turret_cursor.long)
					turret_select = turret_draw.long
				elseif x >= 1170 and x <= 1195 then
					human = human - 50
					object_enemy = {}
				elseif x >= 1204 and x <= 1240 then
					love.mouse.setCursor(turret_cursor.delete)
					want_delete = true
				elseif x >= 1245 and x <= 1275 then
					disp_area = toggle(disp_area)
				end
			end
		else
			local x,y = love.mouse.getPosition()
			local dx = math.floor(x/80)
			local dy = math.floor(y/80)

			if level[current_level][dy+1][dx+1] == 1 then
				level[current_level][dy+1][dx+1] = {turret_select, 0}
				if turret_select == turret_draw.damage then	human = human - 10 end
				if turret_select == turret_draw.freeze then	human = human - 5 end
				if turret_select == turret_draw.long then human = human - 7 end
				turret_select = nil
				love.mouse.setCursor(love.mouse.getSystemCursor("arrow"))
			end
		end
	end
end