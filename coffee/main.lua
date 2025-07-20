local Player = require("player")
local Clock = require("gameClock")

Game = {
    info = {
        screenWidth = 800,
        screenHeight = 600, 
    }, 

    state = "start"
}

function Game:update(dt)
    if self.state == "start" then
        if love.keyboard.isDown("1") then self.state = "game" end
        if love.keyboard.isDown("2") then love.event.quit() end
    elseif self.state == "game" then
        Player:update(dt)
        Clock:update(dt)
    end
end

function Game:draw()
    if self.state == "start" then
        love.graphics.setColor(1,1,1)
        love.graphics.print("Press 1 to start", 350, 250)
        love.graphics.setColor(1, 0, 0)
        love.graphics.print("Press 2 to quit", 350, 275)
    elseif self.state == "game" then
        -- draw player
        Player:draw()
        love.graphics.print(Clock:getTimeString(), 20, 20)
        Clock:draw()
    end

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
