require( 'vector.lua' )
require( 'globals.lua' )   
require( 'entity.lua' )       

Projectile = {}
setmetatable(Projectile, { __index = Entity } )
Projectile.name = "projectile"    
               
function Projectile:Draw()
  
	local selfpos = self:GetPos()

	love.graphics.setColor( 255, 50, 25, 255 )
	love.graphics.circle( "fill" , selfpos.x, ScreenH - selfpos.y, 2, 8 )
	                             
end                

function Projectile:SetVel( vel )
	self.Vel = vel
end

function Projectile:GetVel()
	return self.Vel
end        

function Projectile:CheckCollisions( dt )
   
	local newpos = self:GetPos() + ( self:GetVel() * dt )
	
	if newpos.x > ScreenW then -- We've hit the right wall.
  	self:SetVel(self:GetVel():Reflect(Vector(-1, 0)))
	elseif newpos.x < 0 then
  	self:SetVel(self:GetVel():Reflect(Vector(1, 0)))
	end                   
	
	if newpos.y > ScreenH then
  	self:SetVel(self:GetVel():Reflect(Vector(0, -1)))
	elseif newpos.y < 0 then       
  	self:SetVel(self:GetVel():Reflect(Vector(0, 1)))
	end

end

function Projectile:Update(dt)   
	
	self:CheckCollisions( dt )
	          
	self:SetPos( self:GetPos() + (self:GetVel() * dt) )
	
end                                            

function Projectile:Initialize()
end
           
table.insert( EntityLookup, Projectile )