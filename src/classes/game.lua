-- Singleton class handeling all the game stuff
Game = {}
require "paths"
require "constants"

local Commands = require 	(CLASSES_FOLDER.."commands")
local Font = require		(CLASSES_FOLDER.."font")
local Entity = require 		(CLASSES_FOLDER.."entity")
local Hero = require 		(CLASSES_FOLDER.."hero")
local Tween = require 		(CLASSES_FOLDER .. "tween")
local DummyUnit = require 	(CLASSES_FOLDER.."dummyunit")
local Map  = require 		(CLASSES_FOLDER.."map")

local Actors = {}
-- Load all the ressources
function Game:init()
	self.font = Font(MAIN_FONT,FONT_WIDTH,FONT_HEIGHT)

	-- Map stuff
	self.gameMap = Map(500,500,self.font);



	-- debug stuff
	hero = Hero(10,10,self);
	dummy =  DummyUnit(5,5,self);
	self.Actors = {}
	table.insert(self.Actors,hero)
	table.insert(self.Actors,dummy)
	for i=1,25 do
		print(i)
		self.gameMap:setChar(3,i,1)
		self.gameMap:setChar(3,i,25)
		self.gameMap:setChar(3,1,i)
	end


	self.inputs = {}
	
	self:registerInput("kp4", Commands.nudge(hero,-1,0))
	self:registerInput("kp6", Commands.nudge(hero,1,0))
	self:registerInput("kp8", Commands.nudge(hero,0,-1))
	self:registerInput("kp2", Commands.nudge(hero,0,1))
	
end

function Game:getMap()
	return self.gameMap
end

--local Game.inputs = {}
function Game:registerInput(key, command)
	self.inputs[key] = {['command'] = command, ['active'] = false}

end

function Game:update(dt)
	for _,actor in pairs(self.Actors) do
		actor:update(dt);
	end

	if not hero:awaitingInput() then
		for _,actor in pairs(self.Actors) do
			command = actor:getCommand();
			while (true) do
				-- Try to execute command if we can, use fallbacks if necesary !
				if command then
					command = command:execute()
				else
					break
				end
			end
			
		end
	end
end

function Game:draw()
	love.graphics.setColor(255,255,255)
	self.gameMap:draw();

	for _,actor in pairs(self.Actors) do
		actor:draw();
	end

end

function Game:handleInput()
	for key,input in pairs(self.inputs) do
		if (love.keyboard.isDown(key)) and not input.active then
			hero:setCommand(input.command)
			input.active = true
		elseif not love.keyboard.isDown(key) and input.active then
			input.active = false
		end
	end
end