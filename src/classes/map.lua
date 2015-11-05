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


-- === Map Methods
function Map:init(w,h,font)
	self.width 	= w
	self.height = h

	self.font = font

	self.spriteBatch = love.graphics.newSpriteBatch(self.font.bitmap, math.ceil(love.window.getWidth()/self.font.width) * math.ceil(love.window.getHeight()/self.font.height))
	self.spriteBatch:clear()
	
	-- Init the array with an empty map
	self:clear()
end -- init

function Map:clear()
	for i=0,self.width-1 do
		self.array[i] = {}
		for j=0,self.height-1 do
			self.array[i][j] = 50
		end
	end
	self:reDraw()
end -- clear

function Map:draw()
	love.graphics.draw(self.spriteBatch)
end

function Map:reDraw()
	self.spriteBatch:clear()
	for i=0,math.ceil(love.window.getWidth()/self.font.width) do
		for j=0,math.ceil(love.window.getHeight()/self.font.height) do
			self.spriteBatch:add(	self.font.quads[self.array[i][j]],
									i*self.font.width,
									j*self.font.height)
		end
	end
end
--End of class
return Map