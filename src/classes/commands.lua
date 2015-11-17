local class = require "../libs/30log/30log"

local Command = class("Command")

function Command:execute()
end

Commands = {}

Commands.nudge = Command:extend("nudge")
function Commands.nudge:init(dx,dy)
	self.dx = dx or 0;
	self.dy = dy or 0;
end

function Commands.nudge:execute(entity)
	entity:nudge(self.dx,self.dy)
end

return Commands