local updates = require "updates"
local render = require "render"
local ctrl = require "controllers"

function love.load(arg)
    params = {
        canShootTimerMax = 0.1,
        createEnemyTimerMax = 0.4,
        var = {
            debug = true,
            isAlive = true,
            score = 0
        }
    }

    objs = {
        player = {
            x = 100, 
            y = 310, 
            speed = 200, 
            img = love.graphics.newImage('assets/aircraft.png')
        },
        bullet = {
            canShoot = true,
            canShootTimer = params.canShootTimerMax,
            all = {},
            img = love.graphics.newImage('assets/bullet.png')
        },
        enemy = {
            createEnemyTimer = params.createEnemyTimerMax,
            all = {},
            img = love.graphics.newImage('assets/enemy.png')
        }
    }
end

function love.update(dt)
    ctrl.keyboard(love, dt, params, objs)
    updates.bullet(love, dt, params.canShootTimerMax, objs.bullet)
    updates.enemy(love, dt, params.var, params.createEnemyTimerMax,
                  objs.enemy, objs.player, objs.bullet)
end

function love.draw(dt)
    if params.var.isAlive then
        render.play(love, params.var, objs.player, objs.enemy, objs.bullet)
    else
        render.endgame(love)
    end
end