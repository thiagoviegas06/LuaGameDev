local Customer = {
    x = 600,
    y = 500,
    moveSpeed = 1,
    destinationX = 200,
    destinationY = 300,
    order = false,
    receivedOrder = false
}

--- path finding algorithm
function Costumer:findPath()
    local dx = self.destinationX - self.x
    local dy = self.destinationY - self.y

    local distance = math.sqrt(dx * dx + dy * dy)

    -- If we're very close, snap to the destination
    if distance < 1 then
        self.x = self.destinationX
        self.y = self.destinationY
        self.arrived = true
        return
    end

    -- Normalize direction vector
    local dirX = dx / distance
    local dirY = dy / distance

    -- Move toward destination
    self.x = self.x + dirX * self.moveSpeed * dt
    self.y = self.y + dirY * self.moveSpeed * dt
end


---- draft of costumer AI
function Costumer:action()
    if self.x != self.destinationX or self.y != self.destinationY then 
        self:findPath()
    elseif !self.order() then
        self:makeOrder()
    else if !self.receivedOrder then
        self:eat()
    else
        self:returnHome()
    end
end


function Costumer:update(dt)
    self:action()
end

function Costumer:draw()
    love.graphics.setColor(0,1,0)
    love.graphics.circle("fill", self.x, self.y, 10)
end