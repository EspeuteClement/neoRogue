local class = require "../libs/30log/30log"

-- Class declaration
local Font = class("Font")

-- Class constants
-- The shift to use on character code in oder to adapt them to the
-- bitmaps
Font.ASCII_SHIFT = 32

-- Class Atributes
-- The bitmap containing all the font glyphs
Font.bitmap = nil

-- The quad containing all the fint info
Font.quads = {}

Font.width = 0

Font.height = 0


-- Class Methods
-- Initialise the font
-- @param bmp the string containing the path to the sprite sheet
-- @param w the width of one charcter
-- @param h the heigth of one character
function Font:init(bmp,w,h)
	self.bitmap 	= love.graphics.newImage(bmp)
	self.width 		= w
	self.height 	= h

	local imgWidth 	= self.bitmap:getWidth()/w
	local imgHeight = self.bitmap:getHeight()/h
	
	for i=0,imgWidth * imgHeight-1 do
		self.quads[i] = love.graphics.newQuad(		i%imgWidth * self.width, -- x
													math.floor(i/imgWidth) * self.height,-- y
													self.width,
													self.height,
													imgWidth * self.width,
													imgHeight * self.height )
	end --for
end --init

function Font:drawChar(code,x,y)
	love.graphics.draw(self.bitmap,self.quads[code],x,y)
end

function Font:drawString(str,x,y )
	
	local pos = 1 -- The position in the string
	local color = {255,255,255} -- The current color of the text
	
	for i = 1, #str do -- For each char in the string
		local c = str:sub(i,i) -- Extract the character

		if c ~= "%" then -- Ignore percents (used for string formating)
	    	local code = string.byte(c,1) - Font.ASCII_SHIFT -- 
	    	self:drawChar(code,x+(pos-1)*self.width,y)
	    	pos = pos + 1
		else -- Manage string formating
			local c = str:sub(i,i)


		end -- if
	end
end

return Font