Vect = {}
function Vector(x, y)
	local self = {}
	self.x = x
	self.y = y 
  setmetatable(self, { __index = Vect, __add = Vect.__add, __mul = Vect.__mul })
	return self
end

function Vect:Dist(vec)
	return math.sqrt( (self.x - vec.x)^2 + (self.y - vec.y)^2 )                                                         
end                     

function Vect:Length()
	return math.sqrt((self.x^2) + (self.y^2))
end

function Vect:Normalize()
	local len = self:Length()
	return Vector(self.x/len, self.y/len)
end

function Vect:Normal()
	return self:Normalize()
end

function Vect:Dot(vec)
	return ((self.x*vec.x) + (self.y*vec.y))
end

function Vect:Reflect(normal) -- normal of vector to be reflected against
	local proj = self:Normal()
	local dot = proj:Dot(normal)

  return Vector(2 * (-dot) * normal.x + proj.x, 2 * (-dot) * normal.y + proj.y) * self:Length()                
end                                    

function Vect.__mul( a, b )
  return Vector(a.x * b, a.y * b)
end

function Vect.__add( a, b )
  return Vector( a.x + b.x, a.y + b.y )
end       
