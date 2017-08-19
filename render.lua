function play(love, var, player, enemy, bullet)
    love.graphics.print(var.score, 10, 10)
    love.graphics.draw(player.img, player.x, player.y)
    for i, blt in ipairs(bullet.all) do
        love.graphics.draw(bullet.img, blt.x, blt.y)
    end
    for i, en in ipairs(enemy.all) do
        love.graphics.draw(enemy.img, en.x, en.y)
    end
end

function endgame(love)
    love.graphics.print("Fim de Jogo!\nPressione 'R' para Reiniciar", love.graphics:getWidth()/2-80, love.graphics:getHeight()/2-10)
end

return {
    play = play,
    endgame = endgame
}