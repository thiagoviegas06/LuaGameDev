-- clock handler
local TaskGenerator = require("taskGenerator")

local Clock = {
    hour = 8,
    minutes = 0,
    day = 1,
    timeAccumulator = 0 
}

function Clock:update(dt)
    self.timeAccumulator = self.timeAccumulator + dt

    -- Every 1 real second, increment 1 in-game minute
    while self.timeAccumulator >= 0.5 do
        self.timeAccumulator = self.timeAccumulator - 1
        self:incrementMinute()
    end
end

function Clock:incrementMinute()
    self.minutes = self.minutes + 1

    if self.minutes >= 60 then
        self.minutes = 0
        self:incrementHour()
    end

    -- decrement how long
    TaskGenerator:decrementTime()

    if TaskGenerator:isTimeToNextTask() then
        TaskGenerator:generateTask()
        TaskGenerator:setTimeForNextTask()
    end
end

function Clock:incrementHour()
    self.hour = self.hour + 1

    if self.hour >= 24 then
        self.hour = 0
        self.day = self.day + 1
    end
end


function Clock:draw()
    TaskGenerator:draw()
end

function Clock:getTimeString()
    return string.format("Day %d - %02d:%02d", self.day, self.hour, self.minutes)
end

return Clock
