local utils = require "utils"

function bull(love, dt, canShootTimerMax, bullet)
    bullet.canShootTimer = bullet.canShootTimer - (1 * dt)
    if bullet.canShootTimer < 0 then
        bullet.canShoot = true
    end

    for i, blt in ipairs(bullet.all) do
        blt.y = blt.y - (700 * dt)
        if blt.y < 0 then
            table.remove(bullet.all, i)
        end
    end
end

function enem(love, dt, var, createEnemyTimerMax, enemy, player, bullet)
    enemy.createEnemyTimer = enemy.createEnemyTimer - (1 * dt)
    if enemy.createEnemyTimer < 0 then
        enemy.createEnemyTimer = createEnemyTimerMax

        local randomNumber = math.random(0, (love.graphics.getWidth() - enemy.img:getWidth()))    
        local newEnemy = { x = randomNumber, y = -enemy.img:getHeight() }
        table.insert(enemy.all, newEnemy)
    end

    for i, en in ipairs(enemy.all) do
        en.y = en.y + (200 * dt)

        if en.y > (200 + love.graphics.getHeight()) then
            table.remove(enemy.all, i)
        end
    end

    for i, en in ipairs(enemy.all) do
        for j, blt in ipairs(bullet.all) do
            if utils.CheckCollision(en.x, en.y, enemy.img:getWidth(), enemy.img:getHeight(), blt.x, blt.y, bullet.img:getWidth(), bullet.img:getHeight()) then
                table.remove(bullet.all, j)
                table.remove(enemy.all, i)
                var.score = var.score + 1
            end
        end

        if utils.CheckCollision(en.x, en.y, enemy.img:getWidth(), enemy.img:getHeight(), player.x, player.y, player.img:getWidth(), player.img:getHeight()) 
        and var.isAlive then
            table.remove(enemy.all, i)
            var.isAlive = false
        end
    end
end

return {
    bullet = bull,
    enemy = enem
}