local Entity = require (CLASSES_FOLDER.."entity")

local Hero = Entity:extend("Hero")

Hero.glyph = GLYPH_AT

function Hero:init(x,y,game)
	Hero.super.init(self,x,y,self.glyph,10,game)
end

return Hero;