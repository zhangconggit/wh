CHCard = {}

setbaseclass(CHCard, {CardObject})

function CHCard:New(data,parent,index,state)
	local newObject = {}
	setmetatable(newObject , { __index = self })
	newObject:Init(data,parent,index,state)
	return newObject
end

--加载卡牌数据
function CHCard.Load(abName)
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

function CHCard:Init(data,parent,index,state)
	self.id  		= data.id
	self.weight		= data.num
	self.color 		= data.color
	local bgName = ""
	local cardName = ""
	local color = nil
	local room = nil
	local cardTab = {my = Vector2.New(100,144),other = Vector2.New(100/1.25,144/1.25)}
	if  Room.gameType == RoomType.CatchPock then
        room = CatchPockRoom
    elseif Room.gameType == RoomType.NiuNiu then
    	room = NiuNiuRoom
    	cardTab = {my = Vector2.New(100,144),other = Vector2.New(80,100)}
    elseif Room.gameType == RoomType.Landlords then
    	room = LandlordsRoom
    end
	self.id = data.id
	print("生成卡牌1======================",state,data.id)
	if state == 1 or data.id == -1 then
		bgName = "tf_cardBG"
		self.gameObject = newObject(room.cardBg)
		self.name = "tf_cardBG"
	elseif state == 2 then
		if data.id == -1 then
			bgName = "tf_cardBG"
			self.gameObject = newObject(room.cardBg)
			self.name = "tf_cardBG"
		else
			bgName = "tf_cardFG"
			cardName = self:GetName(data)
			self.gameObject = newObject(room.cardBg)
			self.color = data.color
			self.num = data.num
			self.name = "tf_cardFG"
			self.cardName = cardName
			self.gameObject.name = cardName
			self.selectNum = 0
			self.pickUp = false
			self.gray = false
		end
	elseif state == 3 then
		bgName = "tf_cardLose"
		color = Color.New(0.1,0.1,0.1,0.6)
		cardName = self:GetName(data)
		self.gameObject = newObject(room.cardBg)
		self.name = "tf_cardLose"
		self.color = data.color
		self.num = data.num
	end

	self.transform = self.gameObject.transform

	-- 加入背景
	local bg = newObject(CardObject.cardUI[bgName])
	local fg = nil
	bg.transform:SetParent(self.transform)
	if cardName ~= "" then
		local prefab = CardObject.cardUI[cardName]
		if prefab ~= nil then
			fg = GameObject.Instantiate(prefab)
			fg.transform:SetParent(self.transform)
		end
		if index == room.myIndex then
			fg.transform:GetComponent("RectTransform").sizeDelta = cardTab.my
		else
			fg.transform:GetComponent("RectTransform").sizeDelta = cardTab.other
		end
		if state == 3 then
			fg.transform:GetComponent("Image").color = color
		end
		self.fg = fg:GetComponent("Image")
	end
	if index == room.myIndex then
		bg.transform:GetComponent("RectTransform").sizeDelta = cardTab.my
	else
		bg.transform:GetComponent("RectTransform").sizeDelta = cardTab.other
	end
	self.transform:SetParent(parent)
	self.transform.localScale = Vector3.one
	self.bg = bg:GetComponent("Image")
end

--string拼接
function CHCard:GetName(chessInfo)
	local strNum    = ''
	if chessInfo.num < 10 then
			strNum = '0' .. tostring(chessInfo.num)
		else
			strNum = tostring(chessInfo.num)
	end
	local name = 'color_'..  chessInfo.color .. '_' ..strNum
	return name
end
--------------------框选事件----------------------------------------------------
function CHCard:PickUp()
	self.gameObject.transform.localPosition = Vector3.New(self.gameObject.transform.localPosition.x,50,self.gameObject.transform.localPosition.z)
end

function CHCard:PickDown()
	self.gameObject.transform.localPosition = Vector3.New(self.gameObject.transform.localPosition.x,0,self.gameObject.transform.localPosition.z)
end

function CHCard:Gray()
	self.fg.color = Color.New(0.7,0.7,0.7,1)
    self.bg.color = Color.New(0.7,0.7,0.7,1)
end

function CHCard:White()
	self.fg.color = Color.white
    self.bg.color = Color.white
end

function CHCard:Destroy()
	if not self.gameObject then return end
	self.transform = nil
	-- local lo = self.gameObject:GetComponent("LuaObject")
	destroy(self.gameObject)
	--self.gameObject:Destroy()
	self.gameObject = nil
	-- lo:Destroy()
end
CHCard.cardList = 
{
	roleIndex = 1,
	cardInfo  = {{id = 1,num = 2,color = 3},{id = 2,num = 3,color = 2},{id = 3,num = 5,color = 4},{id = 5,num = 6,color = 3},{id = 6,num = 7,color = 2},{id = 7,num = 14,color = 4},},
	firstIndex = 1
}