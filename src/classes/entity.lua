local class = require "../libs/30log/30log"

local Entity = class("Entity")

Entity.x = 0
Entity.y = 0
Entity.glyph = 0

function Entity:init(x,y,glyph)
	self.x = x or 0;
	self.y = y or 0;
	self.glyph = glyph or 0;
end

-- Draw the entity on the screen
function Entity:draw()
	Game.font:drawChar(self.glyph, self.x, self.y)
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



return Entity;