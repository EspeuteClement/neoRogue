local class = require "../libs/30log/30log"

local Tween = class("Tween")

local functions = {
	linear = function(tstart,tend,length,time)
		return tstart + (tend - tstart) * time / length
	end,
}

function Tween:init(tstart,tend,length,type)
	self.start = tstart or 0
	self.tend = tend or 0
	self.length = length or 0
	self.currentTime = 0
	self.type = type
	self.active = true
	assert(functions[self.type], "Error, " .. type .. " is not a valid tween type")
end


function Tween:update(dt)
	if self.active then
		self.currentTime = self.currentTime + dt
		if self.currentTime > self.length then
			self.currentTime = self.length
			self.active = false
		end
	end
	return self:get()

end

function Tween:get()
	return functions[self.type](self.start,self.tend,self.length,self.currentTime)
end

return Tween