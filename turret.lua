require( 'vector.lua' )
require( 'globals.lua' )   
require( 'entity.lua' )       

Turret = {}	-- Inherit the entity class.
setmetatable(Turret, { __index = Entity } )
Turret.name = "turret"   
                  
function Turret:Draw()
  
	local selfpos = self:GetPos()

	love.graphics.setColor( 255, 50, 25, 128 )    
	-- Draw lines to pylons.
	for k, py in ipairs(EntList) do      
		if py:GetClass() == "pylon" then
			if py:GetPos():Dist(self:GetPos()) < EnergyDist then
				local pypos = py:GetPos()
				love.graphics.line( selfpos.x, ScreenH - selfpos.y, pypos.x, ScreenH - pypos.y )
    	end                             
		end
	end

	love.graphics.setColor( 255, 50, 25, 255 )
	love.graphics.circle( "fill" , selfpos.x, ScreenH - selfpos.y, 4, 16 )
	                             
end                         

function Turret:NumPylons()
	local i = 0
	for k, py in ipairs(EntList) do      
		if py:GetClass() == "pylon" then
			if py:GetPos():Dist(self:GetPos()) < EnergyDist then
		 		i = i + 1
			end
		end
	end
	return i
end

function Turret:Update(dt)
	
	local numpylons = self:NumPylons()

  if numpylons > 0 then 
		if GameTimer >= self.NextShot then
			local bullet = entity.Create( self:GetPos(), 'projectile')
			local dir = Vector(love.mouse.getX()-self:GetPos().x, ScreenH - love.mouse.getY()-self:GetPos().y):Normal()
			bullet:SetVel( dir * 100 )
			bullet:Spawn()                    
			self.NextShot = self.NextShot + 1/numpylons
		end
	end
end

function Turret:Initialize()
	self.NextShot = GameTimer
end                                  

table.insert( EntityLookup, Turret )