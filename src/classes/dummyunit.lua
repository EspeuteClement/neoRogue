local Entity = require (CLASSES_FOLDER.."entity")
local Commands = require (CLASSES_FOLDER.."commands")
local DummyUnit = Entity:extend("DummyUnit")
local Tween = require (CLASSES_FOLDER .. "tween")

DummyUnit.glyph = 6 -- '&'' symbol

function DummyUnit:init(x,y,game)
	DummyUnit.super.init(self,x,y,self.glyph,5,game)

	self.theCommand = Commands.nudge(self,1,0)
end

function DummyUnit:onUpdate(dt)
	if self:awaitingInput() then
		self:setCommand(self.theCommand)
	end
end

return DummyUnit