require( 'vector.lua' )
require( 'globals.lua' )   
require( 'entity.lua' )       

Pylon = {}
setmetatable(Pylon, { __index = Entity } )
Pylon.name = "pylon"    
               
function Pylon:Draw()
  
	local selfpos = self:GetPos()

	love.graphics.setColor( 50, 150, 255, 128 )    
	for k, py in ipairs(EntList) do      
		if py:GetClass() == "pylon" then
			if py:GetPos():Dist(self:GetPos()) < EnergyDist then
				
				local pypos = py:GetPos()
				love.graphics.line( selfpos.x, ScreenH - selfpos.y, pypos.x, ScreenH - pypos.y )
    	end                             
		end
	end

	love.graphics.setColor( 50, 150, 255, 255 )
	love.graphics.circle( "fill" , selfpos.x, ScreenH - selfpos.y, 4, 16 )
	                             
	love.graphics.setColor( 50, 150, 255, 128 )
	for k, tr in ipairs(EntList) do
		if tr:GetClass() == "turret" then
			if tr:GetPos():Dist(self:GetPos()) < EnergyDist then
				local length = (PulseTimer/1) * tr:GetPos():Dist(self:GetPos())
				local angle = math.atan2(tr:GetPos().y - selfpos.y, tr:GetPos().x - selfpos.x)                                  
				local x = (math.cos(angle) * length) + selfpos.x
				local y = (math.sin(angle) * length) + selfpos.y
				love.graphics.circle( "fill" , x, ScreenH - y, 2, 8 )           
			end 
		end
	end
end    

function Pylon:Update(dt)
end
        
function Pylon:Initialize()
end
   
table.insert( EntityLookup, Pylon )            