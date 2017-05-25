updates = require "updates"

function CheckCollision(x1,y1,w1,h1, x2,y2,w2,h2)
  return x1 < x2+w2 and
         x2 < x1+w1 and
         y1 < y2+h2 and
         y2 < y1+h1
end

function love.load(arg)
    var = {
        debug = true,
        isAlive = true,
        score = 0
    }

    player = {
        x = 100, 
        y = 310, 
        speed = 200, 
        img = love.graphics.newImage('assets/aircraft.png')
    }

    canShootTimerMax = 0.1
    bullet = {
        canShoot = true,
        canShootTimer = canShootTimerMax,
        all = {},
        img = love.graphics.newImage('assets/bullet.png')
    }

    createEnemyTimerMax = 0.4
    enemy = {
        createEnemyTimer = createEnemyTimerMax,
        all = {},
        img = love.graphics.newImage('assets/enemy.png')
    }
end


-- Updating
function love.update(dt)
    -- Time out how far apart our shots can be.
    updates.player(love, dt, player)
    updates.bullet(love, dt, bullet, player, canShootTimerMax)
    updates.enemy(love, dt, enemy, player, bullet, var, createEnemyTimerMax)
    updates.restart(love, bullet, enemy, player, var)
end

function love.draw(dt)
    if var.isAlive then
        love.graphics.print(var.score, 10, 10)
        love.graphics.draw(player.img, player.x, player.y)
        for i, blt in ipairs(bullet.all) do
            love.graphics.draw(bullet.img, blt.x, blt.y)
        end
        for i, en in ipairs(enemy.all) do
            love.graphics.draw(enemy.img, en.x, en.y)
        end
    else
        love.graphics.print("Fim de Jogo!\nPressione 'R' para Reiniciar", love.graphics:getWidth()/2-80, love.graphics:getHeight()/2-10)
    end
end