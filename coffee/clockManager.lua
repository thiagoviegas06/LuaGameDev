local ClockManager = {
    morningStart   = 6,
    costumersStart = 8,
    cleaningStart  = 12,
    closingStart   = 15, 
    currentString = "morning"
}

function ClockManager:new(clock)
    local obj = {
        clock = clock
    }
    setmetatable(obj, self)
    self.__index = self
    return obj
end

function ClockManager:update(dt)
    local hour = self.clock:getHour()

    if (hour < 12 and hour >= 8) then self.currentString = "Customers are coming" 
    elseif (hour < 15) then self.currentString = "Time to clean"
    else self.currentString = "Go home" end

end

function ClockManager:draw()
    love.graphics.print(self.currentString, 600, 30)
end

return ClockManager

