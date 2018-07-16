CardObject = {
	className = "CardObject",
	cardUI = {},
}

setbaseclass(CardObject, {Invoker})

function CardObject:New(data,parent,index,state)
	local newObject = {}
	setmetatable(newObject , { __index = self })
	newObject:Init(data,parent,index,state)
	return newObject
end

--加载卡牌数据
function CardObject.Load(abName)
	local list = CardNameList
	if table_size(CardObject.cardUI) == #list then
		print('CardObject.Load111111111100000000')
		Room.roomObject:ResourceCheckOver()
		return
	end
	for i=1,#list do
	    resMgr:LoadPrefab(abName,{list[i]},
	        function (objs)
	            CardObject.cardUI[list[i]] = objs[0]
	            if i == #list then
	            	print('CardObject.Load1111111111222222222222222')
	                Room.roomObject:ResourceCheckOver()
	            end
	        end)
	end
end

function CardObject:Init(data,parent,index,state)
	local bgName = ""
	local cardName = ""
	local color = nil
	local room = nil
	local cardSize = Vector2.New(100/1.1,144/1.1)
	if  Room.gameType == RoomType.Tenharf then
        room = TenharfRoom
    elseif Room.gameType == RoomType.GoldFlower then
        room = GoldFlowerRoom
    elseif Room.gameType == RoomType.NiuNiu then
    	room = NiuNiuRoom
    	cardSize = Vector2.New(70,94)
    end
	print("CardObject",data.id,data.num,index,state)
	self.id = data.id

	if Room.gameType == RoomType.Tenharf then
		if state == 1 or data.id == -1 then
			bgName = "tf_cardBG"
			self.gameObject = GameObject.New(bgName)
		elseif state == 2 then
		if data.id == -1 then
			bgName = "tf_cardBG"
			self.gameObject = GameObject.New(bgName)
			else
			bgName = "tf_cardFG"
			cardName = self:GetName(data)
			self.gameObject = GameObject.New(cardName)
			self.color = data.color
			self.num = data.num
			end
		elseif state == 3 then
			bgName = "tf_cardLose"
			color = Color.New(0.1,0.1,0.1,0.6)
			cardName = self:GetName(data)
			self.gameObject = GameObject.New(cardName)
			self.color = data.color
			self.num = data.num
		end
	elseif Room.gameType == RoomType.GoldFlower then
		if state == 1 or data.id == -1 then
			bgName = "jH_cardBG"
			self.gameObject = GameObject.New(bgName)
		elseif state == 2 then
		if data.id == -1 then
			bgName = "jH_cardBG"
			self.gameObject = GameObject.New(bgName)
			else
			bgName = "tf_cardFG"
			cardName = self:GetName(data)
			self.gameObject = GameObject.New(cardName)
			self.color = data.color
			self.num = data.num
			end
		elseif state == 3 then
			bgName = "tf_cardLose"
			color = Color.New(0.1,0.1,0.1,0.6)
			cardName = self:GetName(data)
			self.gameObject = GameObject.New(cardName)
			self.color = data.color
			self.num = data.num
		end
	end

	self.transform = self.gameObject.transform


	-- 加入背景
	local bg = newObject(CardObject.cardUI[bgName])
	local fg = nil
	bg.transform:SetParent(self.transform)
	if cardName ~= "" then
		local prefab = CardObject.cardUI[cardName]
		fg = GameObject.Instantiate(prefab)
		fg.transform:SetParent(self.transform)
		if index == room.myIndex then
			fg.transform:GetComponent("RectTransform").sizeDelta = Vector2.New(90,130)
		else
			fg.transform:GetComponent("RectTransform").sizeDelta = cardSize
		end
		if state == 3 then
			fg.transform:GetComponent("Image").color = color
		end
		self.fg = fg:GetComponent("Image")
	end
	if index == room.myIndex then
		bg.transform:GetComponent("RectTransform").sizeDelta = Vector2.New(90,130)
	else
		bg.transform:GetComponent("RectTransform").sizeDelta = cardSize
	end
	self.transform:SetParent(parent)
	self.transform.localScale = Vector3.one
	-- local lo = self.gameObject:GetComponent("LuaObject")
	-- if not lo then
	-- 	lo = self.gameObject:AddComponent(LuaObject.GetClassType())
	-- end
	-- lo.lua = self
	self.bg = bg:GetComponent("Image")
end

--string拼接
function CardObject:GetName(chessInfo)
	local strNum    = ''
	if chessInfo.num < 10 then
			strNum = '0' .. tostring(chessInfo.num)
		else
			strNum = tostring(chessInfo.num)
	end
	local name = 'color_'..  chessInfo.color .. '_' ..strNum
	return name
end

function CardObject:Destroy()
	if not self.gameObject then return end
	self.transform = nil
	-- local lo = self.gameObject:GetComponent("LuaObject")
	destroy(self.gameObject)
	--self.gameObject:Destroy()
	self.gameObject = nil
	-- lo:Destroy()
end