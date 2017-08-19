function left(player, dt)
    if player.x > 0 then -- binds us to the map
        player.x = player.x - (player.speed*dt)
    end
end

function right(player, dt)
    if player.x < (love.graphics.getWidth() - player.img:getWidth()) then
        player.x = player.x + (player.speed*dt)
    end
end

function up(player, dt)
    if player.y > 0 then
        player.y = player.y - (player.speed*dt)
    end
end

function down(player, dt)
    if player.y < (love.graphics.getHeight() - player.img:getHeight()) then
        player.y = player.y + (player.speed*dt)
    end
end

function shoot(player, bullet, canShootTimerMax)
    if bullet.canShoot then
        newBullet = { x = player.x + (player.img:getWidth()/2) -5, y = player.y }
        table.insert(bullet.all, newBullet)
        bullet.canShoot = false
        bullet.canShootTimer = canShootTimerMax
    end
end

function restart(love, player, enemy, bullet, var, canShootTimerMax, createEnemyTimerMax)
    if not var.isAlive then
        bullet.all = {}
        enemy.all = {}

        bullet.canShootTimer = canShootTimerMax
        enemy.createEnemyTimer = createEnemyTimerMax

        player.x = player.initial.x
        player.y = player.initial.y

        var.score = 0
        var.isAlive = true
    end
end

return {
    left = left,
    right = right,
    up = up,
    down = down,
    shoot = shoot,
    restart = restart
}