require( 'globals.lua' ) 
require( 'vector.lua' )  
require( 'entity.lua' )  
require( 'pylon.lua' )    
require( 'turret.lua' )     
require( 'projectile.lua' )
                          
function love.load()

end

function love.draw()          
	love.graphics.setColor( 50, 50, 50, 255 )    
	love.graphics.print('Hello World!', 400, 300)  
	
	for k, ent in ipairs(EntList) do 
		if ent:IsSpawned() then
			ent:Draw()
		end
	end      
	
end

function love.mousepressed(x, y, button)
  
	if button == 'l' then     
		local pylon = entity.Create( Vector( x, ScreenH - y ), "pylon" )
		pylon:Spawn()
  elseif button == 'r' then
		local ally = 0 
		if love.keyboard.isDown( 'lshift' ) then
		  ally = 1
	  end 
	            
   	local turret = entity.Create( Vector( x, ScreenH - y ), "turret" )
	  turret:Spawn()
	end
end

function love.update(dt)
   
	GameTimer = GameTimer + dt
	         
	for k, ent in ipairs(EntList) do 
		if ent:IsSpawned() then
			ent:Update(dt)
		end
	end
	
	PulseTimer = PulseTimer + dt
	if PulseTimer >= 1 then PulseTimer = 0 end
	
	-- do updates here

end