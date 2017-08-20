local cmd = require "commands"

function keyboard(love, dt, params, objs)
    local move = objs.player.speed * dt

    if love.keyboard.isDown('left','a') then
        cmd.left(objs.player, move)
    elseif love.keyboard.isDown('right','d') then
        cmd.right(objs.player, move)
    end

    if love.keyboard.isDown('up','d') then
        cmd.up(objs.player, move)
    elseif love.keyboard.isDown('down','d') then
        cmd.down(objs.player, move)
    end

    if love.keyboard.isDown('escape') then
        love.event.push('quit')
    end

    if love.keyboard.isDown('space', 'rctrl', 'lctrl', 'ctrl') then
        cmd.shoot(objs.player, objs.bullet, params.canShootTimerMax)
    end

    if love.keyboard.isDown('r') then
        cmd.restart(love, objs.player, objs.enemy, objs.bullet, params.var,
                    params.canShootTimerMax, params.createEnemyTimerMax)
    end
end

function get_move(move, max)
    if move < max then
        return move
    end
    return max
end

function touch(love, dt, params, objs)
    local touches = love.touch.getTouches()
 
    if table.getn(touches) > 0 then
        cmd.restart(love, objs.player, objs.enemy, objs.bullet, params.var,
                    params.canShootTimerMax, params.createEnemyTimerMax)
        cmd.shoot(objs.player, objs.bullet, params.canShootTimerMax)

        local touch_x, touch_y = love.touch.getPosition(touches[0] or touches[1])
        local player_x = objs.player.x + (objs.player.img:getWidth() / 2)
        local player_y = objs.player.y + (objs.player.img:getHeight() / 2)
        local move_max = objs.player.speed * dt

        if player_x > touch_x then
            local move = get_move((player_x - touch_x), move_max)
            cmd.left(objs.player, move)
        elseif player_x < touch_x then
            local move = get_move((touch_x - player_x), move_max)
            cmd.right(objs.player, move)
        end
        if player_y > touch_y then
            local move = get_move((player_y - touch_y), move_max)
            cmd.up(objs.player, move)
        elseif player_y < touch_y then
            local move = get_move((touch_y - player_y), move_max)
            cmd.down(objs.player, move)
        end
    end
end

return {
    keyboard = keyboard,
    touch = touch
}