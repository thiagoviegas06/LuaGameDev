
--  Game state & methods
Game = {
    score     = 0,
    lives     = 1,
    dead      = false,
    ballSpeed = -2.5,
    screenWidth = 800,
    screenHeight = 600, 

    player = { x = 200, y = 200, w = 10, h = 40 },
    wall   = { x = 785, y =   0, w = 10, h = 600 },
    ball   = { x = 400, y = 300, r = 7.5 },
    death  = { x =   0, y =   0, w = 50, h = 800 },
}

--  Convenience helpers
function Game:reset()
    self.score     = 0
    self.lives     = 1
    self.dead      = false
    self.ball.x    = 400
    self.ball.y    = 300
    self.ballSpeed = -2.5
    self.player.y  = 200
end

function Game:handleBallCollision()
    -- hits right-hand wall
    if self.ball.x + self.ball.r >= self.wall.x then
        self.ballSpeed = -self.ballSpeed
        self.score     = self.score + 1
    end

    -- hits player paddle
    if self.ball.x - self.ball.r <= self.player.x + self.player.w
       and self.ball.y >= self.player.y
       and self.ball.y <= self.player.y + self.player.h then
        self.ballSpeed = -self.ballSpeed
    end

    -- enters death zone
    if self.ball.x - self.ball.r <= self.death.x + self.death.w then
        self.lives = self.lives - 1
        if self.lives <= 0 then
            self.dead = true
        else
            self.ball.x, self.ball.y = 400, 300
            self.ballSpeed           = -2.5
        end
    end
end

function Game:update(dt)
    if self.dead then
        if love.keyboard.isDown("r") then self:reset() end
        if love.keyboard.isDown("q") then love.event.quit() end
        return
    end

    -- ball movement & collisions
    self.ball.x = self.ball.x + self.ballSpeed
    self:handleBallCollision()

    -- paddle control
    if love.keyboard.isDown("down") and self.player.y < 560 then
        self.player.y = self.player.y + 5
    elseif love.keyboard.isDown("up") and self.player.y > 0 then
        self.player.y = self.player.y - 5
    end
end

function Game:draw()
    -- paddle, wall, ball
    love.graphics.setColor(1, 1, 1)                            -- white
    love.graphics.rectangle("fill",
        self.player.x, self.player.y, self.player.w, self.player.h)
    love.graphics.rectangle("fill",
        self.wall.x, self.wall.y, self.wall.w, self.wall.h)
    love.graphics.circle("fill", self.ball.x, self.ball.y, self.ball.r)

    -- HUD
    love.graphics.print("Score: " .. self.score, 20, 20)
    love.graphics.print("Lives: " .. self.lives, 20, 40)

    -- death screen
    if self.dead then
        love.graphics.printf("YOU ARE DEAD!", 0, 280, 800, "center")
        love.graphics.setColor(1, 1, 0) 
        love.graphics.printf("Press R to restart", 0, 300, 800, "center")
        love.graphics.setColor(1, 0, 0) 
        love.graphics.printf("Press Q to quit", 0, 320, 800, "center")
    end
end

--  LÖVE callbacks

function love.load()
    love.window.setTitle("Lua Game Example")
    love.window.setMode(Game.screenWidth, Game.screenHeight, { resizable = false, vsync = true })
end

function love.update(dt)
    Game:update(dt)
end

function love.draw()
    Game:draw()
end
