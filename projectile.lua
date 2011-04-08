require( 'vector.lua' )
--require( 'globals.lua' )          

Projectile = {} 

function Projectile:New(position, speed, angle)
  local self = {}
  self.x = position.x
  self.y = position.y   
	self.speed = speed or 0
	self.angle = angle or 0
	self.class = "Projectile"
  setmetatable(self, { __index = Projectile })
  return self
end       
                  
function Projectile:GetPos()
	return Vector( self.x, self.y )
end

function Projectile:SetPos(vec)
	self.x = vec.x
	self.y = vec.y
end          

function Projectile:Draw()
                                                        
	love.graphics.setColor( 255, 50, 25, 255 )
	love.graphics.circle( "fill" , self.x, ScreenH - self.y, 2, 16 )

end

function Projectile:Bounce(normal)
	local proj = Vector(math.cos(self.angle), math.sin(self.angle))
	local dot = proj:Dot(normal)

  local vec = Vector(2 * (-dot) * normal.x + proj.x, 2 * (-dot) * normal.y + proj.y)                
	self.angle = math.atan2(vec.y, vec.x)

end
        
function Projectile:FixCollisions()                     

	local x = self.x + (self.speed * math.cos(self.angle) )
  local y = self.y + (self.speed * math.sin(self.angle) )
  
 
	if x > ScreenW then -- We've hit the right wall.
  	self:Bounce(Vector(-1, 0))
	elseif x < 0 then
		self:Bounce(Vector(1, 0))
	end                   
	
	if y > ScreenH then
		self:Bounce(Vector(0, -1))
	elseif y < 0 then       
		self:Bounce(Vector(0, 1))
	end
	
end

function Projectile:Update()                             
            
	self:FixCollisions()

 	local x = self.x + (self.speed * math.cos(self.angle) )
	local y = self.y + (self.speed * math.sin(self.angle) )
	          
	self:SetPos( Vector(x, y) )
	
end

