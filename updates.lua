function plr(love, dt, player)
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
end

function bull(love, dt, bullet, player, canShootTimerMax)
    bullet.canShootTimer = bullet.canShootTimer - (1 * dt)
    if bullet.canShootTimer < 0 then
        bullet.canShoot = true
    end

    if love.keyboard.isDown('space', 'rctrl', 'lctrl', 'ctrl') and bullet.canShoot then
        -- Create some bullets
        newBullet = { x = player.x + (player.img:getWidth()/2) -5, y = player.y }
        table.insert(bullet.all, newBullet)
        bullet.canShoot = false
        bullet.canShootTimer = canShootTimerMax
    end

        -- update the positions of bullets
    for i, blt in ipairs(bullet.all) do
        blt.y = blt.y - (700 * dt)

        if blt.y < 0 then -- remove bullets when they pass off the screen
            table.remove(bullet.all, i)
        end
    end
end

function enem(love, dt, enemy, player, bullet, var, createEnemyTimerMax)
    enemy.createEnemyTimer = enemy.createEnemyTimer - (1 * dt)
    if enemy.createEnemyTimer < 0 then
        enemy.createEnemyTimer = createEnemyTimerMax

        -- Create an enemy
        randomNumber = math.random(10, love.graphics.getWidth() - 10)
        newEnemy = { x = randomNumber, y = -10 }
        table.insert(enemy.all, newEnemy)
    end

    -- update the positions of enemies
    for i, en in ipairs(enemy.all) do
        en.y = en.y + (200 * dt)

        if en.y > 850 then -- remove enemies when they pass off the screen
            table.remove(enemy.all, i)
        end
    end

    -- run our collision detection
    -- Since there will be fewer enemies on screen than bullets we'll loop them first
    -- Also, we need to see if the enemies hit our player
    for i, en in ipairs(enemy.all) do
        for j, blt in ipairs(bullet.all) do
            if CheckCollision(en.x, en.y, enemy.img:getWidth(), enemy.img:getHeight(), blt.x, blt.y, bullet.img:getWidth(), bullet.img:getHeight()) then
                table.remove(bullet.all, j)
                table.remove(enemy.all, i)
                var.score = var.score + 1
            end
        end

        if CheckCollision(en.x, en.y, enemy.img:getWidth(), enemy.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight()) 
        and var.isAlive then
            table.remove(enemy.all, i)
            var.isAlive = false
        end
    end
end

function restart(love, bullet, enemy, player)
    if not isAlive and love.keyboard.isDown('r') then
        -- remove all our bullets and enemies from screen
        bullet.all = {}
        enemy.all = {}

        -- reset timers
        bullet.canShootTimer = canShootTimerMax
        enemy.createEnemyTimer = createEnemyTimerMax

        -- move player back to default position
        player.x = 100
        player.y = 310

        -- reset our game state
        var.score = 0
        var.isAlive = true
    end
end

return {
    bullet = bull,
    player = plr,
    enemy = enem,
    restart = restart
}