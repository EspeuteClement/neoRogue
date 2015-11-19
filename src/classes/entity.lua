local class = require "../libs/30log/30log"
local Commands = require (CLASSES_FOLDER.."commands")

local Entity = class("Entity")


Entity.x = 0
Entity.y = 0
Entity.glyph = 0

function Entity:init(x,y,glyph,energyMax)
	self.x = x or 0;
	self.y = y or 0;
	self.glyph = glyph or 0;

	self.energyMax = energyMax or 10
	self.energyLevel = self.energyMax

	self.isAwaitingInput = true

end

-- Draw the entity on the screen
function Entity:draw()
	Game.font:drawChar(self.glyph, self.x, self.y)
end

function Entity:update(dt)
end

-- Move the entity to the target x and y
function Entity:move(x,y)
	self.x = x or self.x
	self.y = y or self.y
end

-- Move the player relatively to it's position
function Entity:nudge(dx,dy)
	self.x = self.x + dx
	self.y = self.y + dy
end

-- Set the current entity command
function Entity:setCommand(com)
		if com then
		self.command = com
		self:setAwaitingInput(false)
	end
end

function Entity:executeCommand(com)
	if	self.command then
		self.command:execute()
		self.command = nil
		self:emptyEnergy()
	end
	if not self:awaitingInput() then
		self:manageEnergy()
	end
end

-- Put the entity in a state where it can accept commands
function Entity:setAwaitingInput(bool)
	self.isAwaitingInput = bool;
end

-- Ends the turn of an entity, waiting that the energy
-- replenishes before acting again
function Entity:emptyEnergy()
	self.energyLevel = 0
end

-- Step a turn waiting for the energy to replenish
function Entity:manageEnergy()
	if self.name == "Hero" then print(self.energyLevel) end
	if self.energyLevel + ENERGY_PER_TURN < self.energyMax then
		self.energyLevel = self.energyLevel + ENERGY_PER_TURN
	else
		
		self.isAwaitingInput = true
	end
end

-- Returns true if command is nil (waiting for an input)
-- and false else.
function Entity:awaitingInput()
	return self.isAwaitingInput
end

Entity.isAwaitingInput = true


return Entity;