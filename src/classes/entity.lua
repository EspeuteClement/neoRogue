local class = require "../libs/30log/30log"
local Commands = require (CLASSES_FOLDER.."commands")
local Tween = require (CLASSES_FOLDER .. "tween")
local Entity = class("Entity")


Entity.x = 0 -- Position of the Entity on the x grid
Entity.y = 0 -- Position of the Entity on the y grid
Entity.glyph = 0 -- The character that will represent the entity on the screen

Entity.glyphX = 0
Entity.glyphY = 0

Entity.tweenX = nil
Entity.tweenY = nil
Entity.isMoving = false

Entity.isAwaitingInput = true -- True if the Entity can perform a command

Entity.energyMax = 0 -- The maximum energy of the entity

Entity.color = {255,255,0,255};
-- Entity constructor
function Entity:init(x,y,glyph,energyMax,game)
	self.x = x or 0;
	self.y = y or 0;
	self.glyphX = self.x;
	self.glyphY = self.y;
	assert(game, "You must declare a game for this Entity")
	self.game = game


	self.glyph = glyph or 0;

	self.energyMax = energyMax or 10
	self.energyLevel = self.energyMax

	self.isAwaitingInput = true

	self.tweenX = Tween(self.x*FONT_WIDTH,self.x,1,"linear")
	self.tweenY = Tween(self.y*FONT_HEIGHT,self.y,1,"linear")

end

-- Draw the entity on the screen
function Entity:draw()
	local oldColor = {love.graphics.getColor()}
	love.graphics.setColor(self.color)
	Game.font:drawChar(self.glyph, self.tweenX:get(), self.tweenY:get())
	love.graphics.setColor(oldColor)
end

function Entity:update(dt)
	self:onUpdate(dt)
	self:updateMove(dt)
end

function Entity:onUpdate(dt)
	-- body
end

-- Move the entity to the target x and y
function Entity:move(x,y)
	self.x = x or self.x
	self.y = y or self.y
	self:initiateMove()
end

function Entity:initiateMove()
	self.isMoving = true
	self.tweenX = Tween(self.tweenX:get(),self.x*FONT_WIDTH,0.2,"linear")
	self.tweenY = Tween(self.tweenY:get(),self.y*FONT_HEIGHT,0.2,"linear")
end

function Entity:updateMove(dt)
	if self.isMoving then
		self.tweenX:update(dt)
		self.tweenY:update(dt)
		if not self.tweenX.active and not self.tweenY.active then
			self.isMoving = false
		end
	end
end

-- Move the player relatively to it's position
function Entity:nudge(dx,dy)
	self:move(self.x + dx, self.y + dy)
end

-- Set the current entity command
function Entity:setCommand(com)
		if com then
		self.command = com
		self:setAwaitingInput(false)
	end
end

-- Return the current command in the entity.
-- If the entity needs energy, will update it's energy 
-- instead
function Entity:getCommand()
	print("====== Turn for " .. self.name .. " =======")	
	local _return;

	if self.energyLevel < self.energyMax then
		self.energyLevel = self.energyLevel + ENERGY_PER_TURN		
	elseif self.command then
		_return = self.command
		self.command = nil
		self:setAwaitingInput(false)
		self:emptyEnergy()
	end

	if  (self.energyLevel >= self.energyMax) then
		print("Energy of " .. self.name .. " filled")
		self:setAwaitingInput(true)
	end

	print("Energy : " .. self.energyLevel .. "/" .. self.energyMax)
	if (_return) then
		print("Current move : " .. _return.name)
	else
		print("Current move : Wait")

	end

	return _return;
end

-- Put the entity in a state where it can accept commands
function Entity:setAwaitingInput(b)
	self.isAwaitingInput = b;
end

-- Ends the turn of an entity, waiting that the energy
-- replenishes before acting again
function Entity:emptyEnergy()
	self.energyLevel = 0
end

function Entity:getGame()
	return self.game
end

-- DEPRECATED
-- Step a turn waiting for the energy to replenish 
-- function Entity:manageEnergy()
-- 	if self.name == "Hero" then print(self.energyLevel) end
-- 	if self.energyLevel + ENERGY_PER_TURN < self.energyMax then
-- 		self.energyLevel = self.energyLevel + ENERGY_PER_TURN
-- 	else
-- 		self.isAwaitingInput = true
-- 	end
-- end

-- Returns true if command is nil (waiting for an input)
-- and false else.
function Entity:awaitingInput()
	return self.isAwaitingInput
end




return Entity;