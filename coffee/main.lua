local Player = require("player")
local Clock = require("gameClock")

Game = {
    info = {
        screenWidth = 800,
        screenHeight = 600, 
    }, 

    time = 0
}

function Game:update(dt)
   Player:update(dt)
   Clock:update(dt)
end

function Game:draw()
    -- draw player
    Player:draw()
    love.graphics.print(Clock:getTimeString(), 20, 20)
end
  
function love.load()
    love.window.setTitle("Coffee Game")
    love.window.setMode(Game.info.screenWidth, Game.info.screenHeight, { resizable = false, vsync = true })
end

function love.update(dt)
    Game:update(dt)
end

function love.draw()
    Game:draw()
end
