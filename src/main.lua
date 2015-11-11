require "classes/game"
Font = require "classes/font"
Map  = require "classes/map"
shine = require 'libs/shine/'


function love.load()
	-- Load the font :
	Game:init()

	aFont = Font("res/fonts/font.png",16,16)
	aMap  = Map(1000,1000,aFont)

	local grain = shine.filmgrain()

    -- many effects can be parametrized
    grain.opacity = 0.2

    -- multiple parameters can be set at once
    local vignette = shine.vignette()
    vignette.parameters = {radius = 0.9, opacity = 0.4}

    -- you can also provide parameters on effect construction
    local crt = shine.crt()
    crt:set("outline",{0,0,0})

    local scanLines = shine.scanlines()

    local dmg = shine.dmg()
    -- you can chain multiple effects
    post_effect = scanLines:chain(grain):chain(vignette):chain(crt)

    -- warning - setting parameters affects all chained effects:
    post_effect.opacity = 0.5 -- affects both vignette and film grain
	
	aMap:setChar(1,5,5)
end -- love.load()

glyph = 0
timer = 0

function love.update(dt)
	timer = timer + dt
	Game:handleInput()
	-- if timer > 0.01 then
	-- 	glyph = (glyph + 1)%(16*16)
	-- 	timer = 0
	-- 	--aMap:setChar(glyph,5,5)
	-- 	for i = 0, 100 do
	-- 		for j = 0, 100 do
	-- 			if(love.math.random(20)<2) then
	-- 				aMap:setChar((glyph+love.math.random(0, 112))%112,i,j)
	-- 			end
	-- 		end
	-- 	end
	-- end -- if

end	-- love.update(dt)

function love.draw()
	love.graphics.setColor(0,0,0)
	love.graphics.clear()
	love.graphics.setColor(255,255,255)
	post_effect:draw(function ()
		-- body
		--love.graphics.setColor(55,25,200)
		--aFont:drawChar(glyph,0,0)
		--aFont:drawString("Hello World Hohoh",0,8)
		aMap:draw()
		Game:draw()

	end)
	love.graphics.setColor(255,255,200)
	love.graphics.print("FPS : "..love.timer.getFPS())
end -- love.draw()

function love.keypressed(key, isrepeat)
	if key == 'left' then
		aMap:moveCamera(-2,0)
	end
	if key == 'right' then
		aMap:moveCamera(2,0)
	end
	if key == 'up'then
		aMap:moveCamera(0,-2)
	end
	if key == 'down' then
		aMap:moveCamera(0,2)
	end
end

