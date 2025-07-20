---- creates cutomers

local TaskGenerator = {
    nextTask = 10,
    active = false,
    taskMessage = ""
}

function TaskGenerator:generateTask()
    self.active = true
end

function TaskGenerator:decrementTime()
    self.nextTask = self.nextTask - 1
end

function TaskGenerator:isTimeToNextTask()
    return self.nextTask == 0
end

function TaskGenerator:setTimeForNextTask()
    local randomNum = math.random(5,15)
    local string = "Time for next task " .. randomNum .. " minutes"

    self.taskMessage = string
end

function TaskGenerator:draw()
    if self.active then
        love.graphics.setColor(0,1,0)
        love.graphics.circle("fill", 100, 50, 10)
        love.graphics.setColor(0,1,1)
        love.graphics.print(self.taskMessage, 100, 30)
    end
end




return TaskGenerator

