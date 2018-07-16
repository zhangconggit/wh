Queue = {}

function Queue:New()
	local newObject = {}
	setmetatable(newObject , { __index = self })
	newObject.begin = 0
	newObject.last = -1
	return newObject
end

function Queue:Push(obj)
	local last = self.last + 1
	self.last = last
	self[last] = obj
end

function Queue:Pop()
	if self:IsEmpty() then return nil end
	local begin = self.begin
	self.begin = begin + 1
	local obj = self[begin]
	self[begin] = nil
	return obj
end

function Queue:GetCount()
	return self.last - self.begin + 1
end

function Queue:IsEmpty()
	return self.last < self.begin
end