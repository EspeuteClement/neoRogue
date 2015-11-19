local Entity = require (CLASSES_FOLDER.."entity")

local Hero = Entity:extend("Hero")

Hero.glyph = GLYPH_AT

function Hero:init(x,y)
	Hero.super.init(self,x,y,self.glyph,20)
end


return Hero;