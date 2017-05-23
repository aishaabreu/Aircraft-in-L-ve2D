-- Configuration
function love.conf(t)
	t.title = "Love Initial Game" -- The title of the window the game is in (string)
	-- t.version = "0.01"         -- The LÖVE version this game was made for (string)
	t.window.width = 300        -- we want our game to be long and thin.
	t.window.height = 480

	-- For Windows debugging
	t.console = true
end