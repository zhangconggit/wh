Invoker = {}

function Invoker:Invoke(funName, delay, ...)
	if not self[funName] then return end
	if self:IsInvoking(funName) then return end
	self.corts = self.corts or {}
	local args = {...}
	self.corts[funName] = coroutine.start(function()
		coroutine.wait(delay)
		self[funName](self, unpack(args))
		self.corts[funName] = nil
	end)
end

function Invoker:IsInvoking(funName)
	self.corts = self.corts or {}
	if funName then
		return self.corts[funName]
	else
		return table_size(self.corts) > 0
	end
end

function Invoker:CancelInvoke(funName)
	self.corts = self.corts or {}
	if funName then
		if self:IsInvoking(funName) then
			coroutine.stop(self.corts[funName])
			self.corts[funName] = nil
		end
	else
		for k, v in pairs(self.corts) do
			coroutine.stop(v)
			self.corts[k] = nil
		end
	end
end

function Invoker:InvokeRepeat(funName, delay, count, ...)
	if not self[funName] then return end
	if self:IsInvoking(funName) then return end
	self.corts = self.corts or {}
	local args = {...}
	self.corts[funName] = coroutine.start(function()
		for i = 1, count do
			coroutine.wait(delay)
			self[funName](self, unpack(args))
			if not self:IsInvoking(funName) then
				return
			end
		end
		self.corts[funName] = nil
	end)
end