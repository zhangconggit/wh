BasePanel = {}

--启动事件--
function BasePanel:Awake(obj)
	self.gameObject = obj;
	self.transform = obj.transform;
	self.lua = self.gameObject:GetComponent('LuaBehaviour')
	self:InitPanel();
end

--初始化面板--
function BasePanel:InitPanel()
	
end

-- 设置UI变量，isTree为true时支持多层结构
function BasePanel:SetVars(names, isTree)
	for _, v in ipairs(names) do
		if isTree then
			local vars = string_split(v, "/")
			if #vars == 1 then
				self[v] = self:Child(v)
			else
				local t = self
				for i, var in ipairs(vars) do
					if i < #vars then
						t[var] = t[var] or {}
						t = t[var]
					else
						t[var] = self:Child(v)
					end
				end
			end
		else
			self[v] = self:Child(v)
		end
	end
end

function BasePanel:Child(chName)
	return Util.Child(self.transform,chName)
end

function BasePanel:GOChild(go,chName)
	if go == nil then
		return
	end
	return Util.Child(go.transform,chName)
end