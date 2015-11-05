Font = require "classes/font"
Map  = require "classes/map"

function love.load()
	-- Load the font :
	aFont = Font("res/fonts/font.png",8,8)
	aMap  = Map(1000,1000,aFont)

	aMap.array[5][5] = 70
	aMap:reDraw()
end -- love.load()

glyph = 0
timer = 0

function love.update(dt)
	timer = timer + dt
	if timer > 0.05 then
		glyph = (glyph + 1)%(16*16)
		timer = 0
	end -- if

end	-- love.update(dt)

function love.draw()
	love.graphics.setColor(55,25,200)
	--aFont:drawChar(glyph,0,0)
	--aFont:drawString("Hello World Hohoh",0,8)

	aMap:draw()
	love.graphics.setColor(255,255,255)
	love.graphics.print(love.timer.getFPS())
end -- love.draw()

