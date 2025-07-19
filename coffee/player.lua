-- player info

local Player = {
    x = 300, 
    y = 400,
    width = 10,
    speed = 5, 
}

function Player:movement()

    local dx, dy = 0,0

    if love.keyboard.isDown("down") and self.y < 580 then
        dy = dy + 1
    end

    if love.keyboard.isDown("up") and self.y > 10 then
        dy = dy - 1
    end

    if love.keyboard.isDown("right") and self.x < 790 then
        dx = dx + 1
    end

    if love.keyboard.isDown("left") and self.x > 10 then
        dx = dx - 1
    end

    local mag = math.sqrt(dx * dx + dy * dy)
    if mag > 0 then 
        dx = dx / mag
        dy = dy / mag
    end 

    self.x = self.x + dx * self.speed
    self.y = self.y + dy * self.speed
end

function Player:update(dt)
    self:movement()
end 

function Player:draw()
    love.graphics.setColor(1,1,1)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.width)
end

return Player