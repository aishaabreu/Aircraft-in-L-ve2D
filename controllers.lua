local cmd = require "commands"

function keyboard(love, dt, params, objs)
    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    if love.keyboard.isDown('left','a') then
        cmd.left(objs.player, dt)
    elseif love.keyboard.isDown('right','d') then
        cmd.right(objs.player, dt)
    end

    if love.keyboard.isDown('up','d') then
        cmd.up(objs.player, dt)
    elseif love.keyboard.isDown('down','d') then
        cmd.down(objs.player, dt)
    end

    if love.keyboard.isDown('space', 'rctrl', 'lctrl', 'ctrl') then
        cmd.shoot(objs.player, objs.bullet, params.canShootTimerMax)
    end

    if love.keyboard.isDown('r') then
        cmd.restart(love, objs.player, objs.enemy, objs.bullet, params.var,
                    params.canShootTimerMax, params.createEnemyTimerMax)
    end
end

return {
    keyboard = keyboard
}