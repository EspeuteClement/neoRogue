local class = require "../libs/30log/30log"

-- Class initialisation
local Map = class("Map")

-- === Map proprerties ===
-- The width of the map
Map.width = 0

-- The height of the map
Map.height = 0

-- A 2D array that contains the tiles in the map
Map.array = {}

Map.camera = {x = 0, y = 0}
-- The spritebatch responsible for the character drawing
Map.spriteBatch = {}
Map.spriteBatchIds = {}

-- Set to true if the map needs to be redrawn
Map.dirty = true

-- === Map Methods
function Map:init(w,h,font)
	self.width 	= w
	self.height = h

	self.font = font

	self.spriteBatch = love.graphics.newSpriteBatch(self.font.bitmap, math.ceil(love.window.getWidth()/self.font.width+1) * math.ceil(love.window.getHeight()/self.font.height+1))
	self.spriteBatch:clear()
	
	-- Init the array with an empty map
	self:clear()
end -- init

function Map:resizeSpriteBatch()

end

function Map:setChar(id,x,y)
	self.dirty = true
	self.array[x][y] = id
end

function Map:moveCamera(x,y)
	self.dirty = true
	local x = x or 0
	local y = y or 0
	if (self.camera.x + x >= 0 and self.camera.x < self.width) then
		self.camera.x = self.camera.x + x
	end
	if (self.camera.y + y >= 0 and self.camera.y < self.height) then
		self.camera.y = self.camera.y + y
	end
end

function Map:clear()
	for i=0,self.width-1 do
		self.array[i] = {}
		for j=0,self.height-1 do
			self.array[i][j] = 0
		end
	end
	self:reDraw()
end -- clear

function Map:draw()
	if self.dirty then
		self:reDraw()
		self.dirty = false
	end

	love.graphics.draw(self.spriteBatch,-(self.camera.x%self.font.width),-(self.camera.y%self.font.height))
end

function Map:reDraw()
	self.spriteBatch:clear()
	local xOffset = math.floor(self.camera.x/self.font.width)
	local yOffset = math.floor(self.camera.y/self.font.height)

	for i=0,math.floor(love.window.getWidth()/self.font.width)+1 do
		for j=0,math.floor(love.window.getHeight()/self.font.height+1) do
			self.spriteBatch:add(	self.font.quads[self.array[i+xOffset][j+yOffset]],
									i*self.font.width,
									j*self.font.height)
		end
	end
end
--End of class
return Map