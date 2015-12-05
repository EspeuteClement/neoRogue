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

-- Returns false if the command succeded, nil if the command
-- failed and the is no alternative, and a command
-- if there is an alternative !
function Commands.nudge:execute()
	if (self.entity:getGame():getMap():getChar(self.entity.x+self.dx,self.entity.y+self.dy) == 3) then
		return nil
	end	
	self.entity:nudge(self.dx,self.dy)
	return false
end

return Commands