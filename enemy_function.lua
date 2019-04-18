function init_enemy()
	object_enemy = {}

	enemy = {}
	enemy.down = love.graphics.newImage("img/enemy/Enemy1.png")
	enemy.right = love.graphics.newImage("img/enemy/Enemy2.png")
	enemy.up = love.graphics.newImage("img/enemy/Enemy3.png")
	enemy.left = love.graphics.newImage("img/enemy/Enemy4.png")

	etic=600
	metic = 300
end

function update_enemy()
	if etic <= 0 then
		start_game = true
		gen_enemy()
		etic = metic
		metic = metic - 0.07*metic
		if metic <= 100 then
			metic = 100
		end
	else
		etic = etic - 1
	end

	for i=1, table.getn(object_enemy) do
		if object_enemy[i].direction == "down" then
			object_enemy[i].y = object_enemy[i].y + object_enemy[i].speed
		elseif object_enemy[i].direction == "up" then
			object_enemy[i].y = object_enemy[i].y - object_enemy[i].speed
		elseif object_enemy[i].direction == "right" then
			object_enemy[i].x = object_enemy[i].x + object_enemy[i].speed
		elseif object_enemy[i].direction == "left" then
			object_enemy[i].x = object_enemy[i].x - object_enemy[i].speed
		end

		if object_enemy[i].direction == "down" or object_enemy[i].direction == "right" then
			object_enemy[i].tx = math.floor(object_enemy[i].x/80) + 1
			object_enemy[i].ty = math.floor(object_enemy[i].y/80) + 1
		else
			object_enemy[i].tx = math.floor((object_enemy[i].x+79)/80) + 1
			object_enemy[i].ty = math.floor((object_enemy[i].y+79)/80) + 1
		end

		enemy_change_direction(object_enemy[i])

		if level[current_level][object_enemy[i].ty][object_enemy[i].tx] == 12 then
			table.remove(object_enemy, i)
			human = human - 10
			break
		end

		if object_enemy[i].freeze_tic ~= 0 then
			object_enemy[i].freeze_tic = object_enemy[i].freeze_tic - 1

			if object_enemy[i].freeze_tic == 0 then
				object_enemy[i].speed = object_enemy[i].speed * 2
			end
		end

		if object_enemy[i].health <= 0 then
			table.remove(object_enemy, i)
			if math.random(100) >= 60 then
				human = human + 1
			end

			break
		end
	end
end

function draw_enemy()
	for i=1, table.getn(object_enemy) do
		love.graphics.draw(object_enemy[i].sprite, object_enemy[i].x, object_enemy[i].y)
	end
end

function gen_enemy()
	for lin=1,9 do
		for col=1,16 do
			if in_array(level[current_level][lin][col], gen_tile)  then
				local e = {}
				e.tx = col
				e.ty = lin
				e.x = (col-1) * 80
				e.y = (lin-1) * 80
				if level[current_level][lin][col] == 11 then
					e.sprite = enemy.down
					e.direction = "down"
				elseif level[current_level][lin][col] == 10 then
					e.sprite = enemy.up
					e.direction = "up"			
				elseif level[current_level][lin][col] == 7 then
					e.sprite = enemy.left
					e.direction = "left"				
				end
				
				e.speed = 2
				e.freeze_tic = 0
				e.health = 100

				table.insert(object_enemy, e)
			end
		end
	end
end

function enemy_change_direction(pE)
	if level[current_level][pE.ty][pE.tx] == 3 and pE.direction == "down" then
		pE.direction = "right"
		pE.sprite = enemy.right
	end

	if level[current_level][pE.ty][pE.tx] == 3 and pE.direction == "left" then
		pE.direction = "up"
		pE.sprite = enemy.up
	end

	if level[current_level][pE.ty][pE.tx] == 2 and pE.direction == "right" then
		pE.direction = "up"
		pE.sprite = enemy.up
	end

	if level[current_level][pE.ty][pE.tx] == 2 and pE.direction == "down" then
		pE.direction = "left"
		pE.sprite = enemy.left
	end

	if level[current_level][pE.ty][pE.tx] == 4 and pE.direction == "up"  then
		pE.direction = "right"
		pE.sprite = enemy.right
	end

	if level[current_level][pE.ty][pE.tx] == 4 and pE.direction == "left" then
		pE.direction = "down"
		pE.sprite = enemy.down
	end

	if level[current_level][pE.ty][pE.tx] == 5 and pE.direction == "right" then
		pE.direction = "down"
		pE.sprite = enemy.down
	end

	if level[current_level][pE.ty][pE.tx] == 5 and pE.direction == "up" then
		pE.direction = "left"
		pE.sprite = enemy.left
	end
end