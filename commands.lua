function left(player, move)
    local to = player.x - move
    if to >= 0 then
        player.x = to
    end
end

function right(player, move)
    local to = player.x + move
    if to <= (love.graphics.getWidth() - player.img:getWidth()) then
        player.x = to
    end
end

function up(player, move)
    local to = player.y - move
    if to >= 0 then
        player.y = to
    end
end

function down(player, move)
    local to = player.y + move
    if to <= (love.graphics.getHeight() - player.img:getHeight()) then
        player.y = to
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