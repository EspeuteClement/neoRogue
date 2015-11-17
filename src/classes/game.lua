-- Singleton class handeling all the game stuff
Game = {}
require "paths"
require "constants"

local Commands = require 'commands'
local Font = require (CLASSES_FOLDER.."font")
local Entity = require (CLASSES_FOLDER.."entity")
local Hero = require (CLASSES_FOLDER.."hero")

local Actors = {}
-- Load all the ressources
function Game:init()
	self.font = Font(MAIN_FONT,FONT_WIDTH,FONT_HEIGHT)


	-- debug stuff
	machin = Hero(150,150,16);
	table.insert(Actors,machin)
end

function Game:draw()
	for _,actor in pairs(Actors) do
		actor:draw();
	end
end

Inputs = {
	["kp4"] = Commands.nudge(-16,0),
	["kp6"] = Commands.nudge(16,0),
	["kp8"] = Commands.nudge(0,-16),
	["kp2"] = Commands.nudge(0,16)
}
function Game:handleInput()
	for key,command in pairs(Inputs) do
		if (love.keyboard.isDown(key)) then
			command:execute(machin)
		end
	end
end