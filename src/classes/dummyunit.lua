local Entity = require (CLASSES_FOLDER.."entity")
local Commands = require (CLASSES_FOLDER.."commands")
local DummyUnit = Entity:extend("DummyUnit")

DummyUnit.glyph = 6 -- '&'' symbol

function DummyUnit:init(x,y)
	DummyUnit.super.init(self,x,y,self.glyph,10)

	self.theCommand = Commands.nudge(self,16,0)
end

function DummyUnit:update(dt)
	if self:awaitingInput() then
		self:setCommand(self.theCommand)
	end
end

return DummyUnit