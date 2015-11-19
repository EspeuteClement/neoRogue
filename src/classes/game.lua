-- Singleton class handeling all the game stuff
Game = {}
require "paths"
require "constants"

local Commands = require (CLASSES_FOLDER.."commands")
local Font = require (CLASSES_FOLDER.."font")
local Entity = require (CLASSES_FOLDER.."entity")
local Hero = require (CLASSES_FOLDER.."hero")

local DummyUnit = require (CLASSES_FOLDER.."dummyunit")

local Actors = {}
-- Load all the ressources
function Game:init()
	self.font = Font(MAIN_FONT,FONT_WIDTH,FONT_HEIGHT)


	-- debug stuff
	machin = Hero(150,150);
	dummy = DummyUnit(100,100);
	table.insert(Actors,machin)
	table.insert(Actors,dummy)

	self.inputs = {}
	
	self:registerInput("kp4", Commands.nudge(machin,-16,0))
	self:registerInput("kp6", Commands.nudge(machin,16,0))
	self:registerInput("kp8", Commands.nudge(machin,0,-16))
	self:registerInput("kp2", Commands.nudge(machin,0,16))
	
end

--local Game.inputs = {}
function Game:registerInput(key, command)
	self.inputs[key] = {['command'] = command, ['active'] = false}

end

function Game:update(dt)
	for _,actor in pairs(Actors) do
		actor:update(dt);
	end

	if not machin:awaitingInput() then
		for _,actor in pairs(Actors) do
			actor:executeCommand();
		end
	end
end

function Game:draw()
	for _,actor in pairs(Actors) do
		actor:draw();
	end
end

function Game:handleInput()
	for key,input in pairs(self.inputs) do
		if (love.keyboard.isDown(key)) and not input.active then
			machin:setCommand(input.command)
			input.active = true
		elseif not love.keyboard.isDown(key) and input.active then
			input.active = false
		end
	end
end