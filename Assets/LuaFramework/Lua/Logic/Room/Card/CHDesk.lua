--公共牌
CHDesk = {}

--初始化
function CHDesk:Init()
	self.library = {}
	self.cType	 = CHdata.CharacterType.Library
	self.cardsNum = #library

end

--索引器
function CHDesk:GetCard(card)
	return self.library[self:GetNum(card)]
end

--获取牌在牌堆中的索引
function CHDesk:GetNum(card)
	for i,v in ipairs(self.library) do
		if card.name = v.name then
			return i
		end
	end
end

--移除牌
function CHDesk:PopCard(card)
	table.remove(self.library,self:GetNum(card))
end

--创建一副牌
function CHDesk:CreateCHDesk()
	for color = 1, 4 do
		for value = 1, 15 do
			local name = self:MakeName(color,value)
			local card = CHData:New(name,value,color,self.cType)
			table.insert(self.library,card)
		end
	end
	--去掉三个2
	local card = {{name = "color_1_02"},{name = "color_2_02"},{name = "color_3_02"}}
	for i,v in ipairs(card) do
		self:PopCard(v)
	end
end

--洗牌
function CHDesk:Shuffle()
	if self.cardsNum == 48 then
		local newLibrary = {}
		local random = Util.Random
		for i,v in ipairs(self.library) do
			table.insert(random:Next(#newLibrary+1),v)
		end
		self.library = {}
		for i,v in ipairs(newLibrary) do
			table.insert(self.library,v)
		end
		newLibrary = {}
	end
end

--发牌
function CHDesk:Deal()
	local ret = self.library[#self.library - 1]
	self:PopCard(ret)
	return ret
end

--向牌库中添加牌
function CHDesk:AddCard(card)
	card.belongTo = self.cType
	table.insert(self.library,card)
end

--string拼接
function CHDesk:MakeName(color,value)
	local strNum    = ''
	if value < 10 then
			strNum = '0' .. tostring(value)
		else
			strNum = tostring(value)
	end
	local name = 'color_'..color..'_'..strNum
	return name
end

--清空桌面
function CHDesk:Clear()
	if #self.library ~= 0 then
		
	end
end