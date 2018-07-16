EventManager = { }

local callbacks = { }
local isDispath = true

-- 抛出事件(事件名，相应数据)
function EventManager.DispatchEvent(eventName, ...)
	if not isDispath then
		return
	end
	if not callbacks[eventName] then
		return
	end
	for k, v in pairs(callbacks[eventName]) do
		if v then
			v(...)
		end
	end
end

-- 是否包含事件监听
function EventManager.HasEventListener(eventName, callback)
	if not callbacks[eventName] then
		return false
	end
	local ix = array_find(callbacks[eventName], callback)
	return ix ~= -1
end

-- 添加事件监听(事件名，回调函数)
function EventManager.AddEventListener(eventName, callback)
	if not callbacks[eventName] then
		callbacks[eventName] = { }
	end
	local ix = array_find(callbacks[eventName], callback)
	if ix == -1 then
		table.insert(callbacks[eventName], callback)
	end
end

-- 移除事件监听(事件名，回调函数)
function EventManager.RemoveEventListener(eventName, callback)
	if not callbacks[eventName] then
		return
	end
	if not callback then
		callbacks[eventName] = nil
		return
	end
	local ix = array_find(callbacks[eventName], callback)
	if ix ~= -1 then
		table.remove(callbacks[eventName], ix)
	end
end
