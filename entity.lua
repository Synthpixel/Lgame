require( 'vector.lua' )

Entity = {}      
entity = {}

function entity.Create( pos, class )
	NumEnts = NumEnts + 1
	local self = {}                        
  setmetatable(self, { __index = Entity })   
	self:SetPos( pos )
	self:SetClass( class or "null_entity" )
	self.Spawned = false
	EntList[NumEnts] = self
	return self
end          
    
function Entity:IsSpawned()
	return self.Spawned
end

function Entity:GetPos()
	return self.Pos
end

function Entity:SetPos(vec)
	self.Pos = vec
end             

function Entity:GetClass()
	return self.Class
end             

function Entity:SetClass( class )
	self.Class = class  
	  
	-- Import the calls from the entity's definition.
	
	local foundmetatable = false     
	
	for _,v in ipairs(EntityLookup) do
	
			if v.name == self.Class then
				setmetatable(self, {__index = v })
				foundmetatable = true
			end      
			
	end                                     
	
	if foundmetatable == false then
		print("Error: Could not find entity class: '".. self.Class .."'")
	end
	
end    


function Entity:Spawn()                        
	self.Spawned = true 
	self:Initialize()
end