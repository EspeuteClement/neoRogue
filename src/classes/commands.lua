local class = require "../libs/30log/30log"

local Command = class("Command")

function Command:execute()
end

function Command:init(entity)
	self.entity = entity
end

Commands = {}

Commands.nudge = Command:extend("nudge")
function Commands.nudge:init(entity,dx,dy)
	Command.init(self,entity)
	self.dx = dx or 0;
	self.dy = dy or 0;
end

function Commands.nudge:execute()
	self.entity:nudge(self.dx,self.dy)
end


return Commands