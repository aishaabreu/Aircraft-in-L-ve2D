
debug = true

function love.load(arg)
    player = {
        x = 100, 
        y = 310, 
        speed = 200, 
        img = love.graphics.newImage('assets/aircraft.png')
    }

    bullet = {
        canShoot = true,
        canShootTimer = 0.1,
        canShootTimerMax = 0.1,
        all = {},
        img = love.graphics.newImage('assets/bullet.png')
    }
end


-- Updating
function love.update(dt)
	-- I always start with an easy way to exit the game
	if love.keyboard.isDown('escape') then
		love.event.push('quit')
	end

    if love.keyboard.isDown('left','a') then
        if player.x > 0 then -- binds us to the map
            player.x = player.x - (player.speed*dt)
        end
    elseif love.keyboard.isDown('right','d') then
        if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
            player.x = player.x + (player.speed*dt)
        end
    end

    if love.keyboard.isDown('up','d') then
        if player.y > 0 then
            player.y = player.y - (player.speed*dt)
        end
    elseif love.keyboard.isDown('down','d') then
        if player.y < (love.graphics.getHeight() - player.img:getHeight()) then
            player.y = player.y + (player.speed*dt)
        end
    end

        -- Time out how far apart our shots can be.
    bullet.canShootTimer = bullet.canShootTimer - (1 * dt)
    if bullet.canShootTimer < 0 then
        bullet.canShoot = true
    end

    if love.keyboard.isDown('space', 'rctrl', 'lctrl', 'ctrl') and bullet.canShoot then
        -- Create some bullets
        newBullet = { x = player.x + (player.img:getWidth()/2) -5, y = player.y, img = bullet.img }
        table.insert(bullet.all, newBullet)
        bullet.canShoot = false
        bullet.canShootTimer = bullet.canShootTimerMax
    end

        -- update the positions of bullets
    for i, blt in ipairs(bullet.all) do
        blt.y = blt.y - (700 * dt)

        if blt.y < 0 then -- remove bullets when they pass off the screen
            table.remove(bullet.all, i)
        end
    end
end

function love.draw(dt)
    love.graphics.draw(player.img, player.x, player.y)
    for i, blt in ipairs(bullet.all) do
        love.graphics.draw(blt.img, blt.x, blt.y)
    end
end