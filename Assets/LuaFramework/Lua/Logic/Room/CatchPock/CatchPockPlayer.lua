CatchPockPlayer = {
}

setbaseclass(CatchPockPlayer, { PlayerObject })

-- 初始化重写
function CatchPockPlayer:Init(data, obj)
	PlayerObject.Init(self, data, obj)
	self.obj = obj.gameObject
	local clicp = string.sub(obj.gameObject.name, -1)
	self.imgHead = BasePanel:GOChild(obj, "Mask/img")
	self.imgOffLine = BasePanel:GOChild(obj, "ImgOffine")
	self.imgOK = BasePanel:GOChild(obj, "imgOK")
	self.imgZhuang = BasePanel:GOChild(obj, "imgZhuang")
	self.imgChat = BasePanel:GOChild(obj, "imgChat")
	self.txtChat = BasePanel:GOChild(obj, "imgChat/txtChat")
	self.imgFaceIcon = BasePanel:GOChild(obj, "imgFaceIcon")
	self.txtName = BasePanel:GOChild(obj, "txtName")
	self.txtScore = BasePanel:GOChild(obj, "txtScore")
	-- 新添加
	self.imgYuanbao = BasePanel:GOChild(obj, "imgYuanbao")
	self.imgJinbi = BasePanel:GOChild(obj, "imgJinbi")

	self.imgCard = BasePanel:GOChild(obj, "imgCard")
	self.imgDeng = BasePanel:GOChild(obj, "imgDeng")
	self.imgAnim = BasePanel:GOChild(obj, "imgAnim")
	self.imgCur = BasePanel:GOChild(obj, "imgCur")
	self.imgPopCard = BasePanel:GOChild(obj, "imgPopCard")
	self.txtOverNum = BasePanel:GOChild(obj, "txtOverNum")
	self.warning = BasePanel:GOChild(obj, "warning")
	self.imgFeiJiAnim = BasePanel:GOChild(obj, "imgCardType/imgFeiJiAnim")
	self.imgZhaDanAnim = BasePanel:GOChild(obj, "imgCardType/imgZhaDanAnim")

	self.index = data.index
	self.sitIndex = CatchPockRoom:GetRoomIndexByIndex(self.index)
	self.id = tostring(data.roleId)
	self.name = data.name
	self.ip = data.ip
	self.score = tostring(data.jifen)
	self.url = data.headImg
	self.gender = data.gender
	self.diamond = data.diamond

	-- 新添加
	self.goldcoin = data.goldcoin
	self.wing = data.wing

	self.jifen = data.jifen
	self.isOnline = data.isOnline
	print("------------------PlayerName--------------", self.name)
	self.cType = nil
	-- 角色类型
	self.cards = { }
	-- 手牌列表
	self.cardsCount = 16
	-- 手牌数
	self.popList = { }
	-- 出牌列表
	self.soundOne = false
	self.soundTwo = false
	if self.imgHead then
		self.imgHead.name = self.id
		if url ~= "" then
			weChatFunction.SetPic(self.imgHead, self.id, self.url)
		end
	else
		self.imgHead = BasePanel:GOChild(obj, "Mask/" .. self.id)
	end

	if self.imgOK then
		self.imgOK.name = self.id .. "imgOK"
		self.imgOK.transform:SetParent(self.obj.transform.parent)
		self.imgOK = BasePanel:GOChild(obj.transform.parent, self.id .. "imgOK")
	else
		self.imgOK = BasePanel:GOChild(obj.transform.parent, self.id .. "imgOK")
	end

	if self.imgAnim then
		self.imgAnim.name = self.id .. "imgAnim"
		self.imgAnim.transform:SetParent(self.obj.transform.parent)
		self.imgAnim = BasePanel:GOChild(obj.transform.parent, self.id .. "imgAnim")
	else
		self.imgAnim = BasePanel:GOChild(obj.transform.parent, self.id .. "imgAnim")
	end

	-- 断线
	if not self.isOnline then
		self.imgOffLine:SetActive(true)
	else
		self.imgOffLine:SetActive(false)
	end
	self.cardTypeList = {
		{ id = 1, obj = BasePanel:GOChild(obj, "imgCardType/imgBuChu") },-- 不出
		{ id = 9, obj = BasePanel:GOChild(obj, "imgCardType/imgShunZi") },-- 顺子
		{ id = 10, obj = BasePanel:GOChild(obj, "imgCardType/imgLianDui") },-- 连对
		{ id = 11, obj = BasePanel:GOChild(obj, "imgCardType/imgFeiJi") },-- 飞机
		{ id = 2, obj = BasePanel:GOChild(obj, "imgCardType/imgZhaDan") },-- 炸弹
	}
	self.warning:SetActive(false)
	self.imgFeiJiAnim:SetActive(false)
	self.imgZhaDanAnim:SetActive(false)
end

-- 获取手牌
--function CatchPockPlayer:GetOneCard(index)
--	return self.cards[index]
--end

-- 摸牌
function CatchPockPlayer:GetOneCard(index, card, state, isPop, isEnd)
	print("===========GetOneCard|--:")
	local flag = { }
	if #card ~= 0 then
		for i, v in ipairs(card) do
			flag = v
		end
	else
		flag = card
	end
	local box = nil
	local cardList = nil
	if isPop then
		box = self.imgPopCard.transform
		cardList = self.popList
	else
		box = self.imgCard.transform
		cardList = self.cards
	end

	local zeroRotate = Vector3.New(0, 0, 720)
	local k = CatchPockRoom:GetPlayer(index).sitIndex
	local parent = self.obj.transform.parent
	local co = coroutine.start( function()
		local objUI = CHCard:New(flag, parent, index, state)
		print("-------------------------objUI", index, objUI.gameObject.name, #cardList * 10)
		---------点牌------------------------------
		--[[		if index == CatchPockRoom.myIndex then
			CH_GameMainCtrl:RemoveClick(objUI.gameObject)
			CH_GameMainCtrl:AddClick(objUI.gameObject,self.OnClickCard)
		end--]]
		-------------------------------------------
		table.insert(cardList, objUI)
		table.insert(CatchPockRoom.NextCardGo, objUI.gameObject)
		objUI.transform:SetParent(parent)
		if isEnd == true then
			objUI.transform.localScale = Vector3.New(0.7, 0.7, 1)
		else
			objUI.transform.localScale = Vector3.one
		end
		objUI.transform:SetParent(box)
		objUI.transform.localPosition = Vector3.New(0, 0,(16 - #cardList) * 10)
		if k == 2 then
			objUI.transform:SetAsFirstSibling()
		end
	end )
end

-- 自己出牌
function CatchPockPlayer:PopCard(obj)
	obj.transform:SetParent(self.imgPopCard.transform)
	obj.transform.localPosition = Vector3.zero
	obj.transform.localScale = Vector3.New(0.82, 0.83, 1)
	table.insert(self.popList, obj)
end

-- 牌型显示
function CatchPockPlayer:PopType(index, cardType, animType)
	print("===========PopType", index, cardType, animType)
	for i, v in ipairs(self.cardTypeList) do
		if cardType == 0 then
			v.obj:SetActive(false)
		else
			if v.id == cardType then
				v.obj:SetActive(true)
				local k = CatchPockRoom:GetPlayer(index).sitIndex
				if animType == 1 then
					if k == 2 then
						v.obj.transform.localPosition = Vector3.New(100, -35, 0)
						local target = Vector3.New(-100, -35, 0)
						v.obj.transform:DOLocalMove(target, 1, false):OnComplete(
						function()
							v.obj:SetActive(false)
						end )
					else
						v.obj.transform.localPosition = Vector3.New(-100, -35, 0)
						local target = Vector3.New(100, -35, 0)
						v.obj.transform:DOLocalMove(target, 1, false):OnComplete(
						function()
							v.obj:SetActive(false)
						end )
					end
				elseif animType == 2 then
					-- 炸弹
					local boom = self.imgZhaDanAnim
					local target = Vector3.zero
					boom:SetActive(true)
					if k == 1 then
						boom.transform.localPosition = Vector3.New(-450, -80, 0)
						target = Vector3.New(0, 20, 0)
					elseif k == 2 then
						boom.transform.localPosition = Vector3.New(210, 60, 0)
						target = Vector3.New(15, -20, 0)
					elseif k == 3 then
						boom.transform.localPosition = Vector3.New(-210, 60, 0)
						target = Vector3.New(0, -30, 0)
					end
					boom.transform:DOLocalMove(target, 1, false):OnComplete(
					function()
						boom:SetActive(false)
					end )
					v.obj:SetActive(true)
					v.obj.transform.localScale = Vector3.zero
					v.obj.transform:DOScale(Vector3.one, 1):SetDelay(1.2):OnComplete(
					function()
						v.obj:SetActive(false)
						boom:SetActive(false)
					end )
				elseif animType == 3 then
					-- 飞机
					local airPlane = self.imgFeiJiAnim
					local target = Vector3.zero
					airPlane:SetActive(true)
					if k == 1 then
						airPlane.transform.localPosition = Vector3.New(300, 0, 0)
						target = Vector3.New(-300, 0, 0)
					elseif k == 2 then
						airPlane.transform.localPosition = Vector3.New(100, 0, 0)
						target = Vector3.New(-400, 0, 0)
					elseif k == 3 then
						airPlane.transform.localPosition = Vector3.New(-100, 0, 0)
						target = Vector3.New(400, 0, 0)
					end
					airPlane:SetActive(true)
					v.obj:SetActive(true)
					airPlane.transform:DOLocalMove(target, 1, false):OnComplete(
					function()
						v.obj:SetActive(false)
						airPlane:SetActive(false)
					end )
				end
			else
				v.obj:SetActive(false)
			end
		end
	end
end
-------------------滑牌------------------------------------------------------
function CatchPockPlayer.OnClickCard(v)
	print("-------OnClickCard------", v.name)
	Game.MusicEffect(Game.Effect.thfapai1)
	local curCache = CatchPockRoom:GetPlayer(CatchPockRoom.myIndex)
	local tips = CatchPockRoom.curPopTips
	if #tips ~= 0 then
		for i = #tips, 1, -1 do
			local len
			if tips[i].cardInfo ~= nil then
				len = #tips[i].cardInfo
				if len ~= 0 then
					if v.id == tips[i].cardInfo[len].id then
						if #tips[i].cardInfo == 1 then return end
						for j, k in ipairs(tips[i].cardInfo) do
							for m, n in pairs(curCache.cards) do
								if k.id == n.id then
									n:PickUp()
									n.selectNum = 1
									if k.id ~= v.id then
										n.pickUp = true
									end
								end
							end
						end
					end
				end
			end
		end
	end
end
----------------------------------------------------------------------------------
--[[function CatchPockPlayer.OnClickCard(go)
	print("-------OnClickCard------",go.name)
	Game.MusicEffect(Game.Effect.thfapai1)
	local curCache = CatchPockRoom:GetPlayer(CatchPockRoom.myIndex)
	for i,v in ipairs(curCache.cards) do
		if go.name == v.cardName then
			if v.selectNum == 0 then
				local tips = CatchPockRoom.curPopTips
				if #tips ~= 0 then
					for i= #tips,1,-1 do
						local len
						if tips[i].cardInfo ~= nil then
							len = #tips[i].cardInfo
							if len ~= 0 then
								if v.id == tips[i].cardInfo[len].id then
									for j,k in ipairs(tips[i].cardInfo) do
										for m,n in pairs(curCache.cards) do
											if k.id == n.id then
												n.selectNum = 1
												n:PickUp()
											end
										end
									end
								else
									v.selectNum = 1
									v:PickUp()
								end
							else
								v.selectNum = 1
								v:PickUp()
							end
						end	
					end
				else
					v.selectNum = 1
					v:PickUp()
				end
			else
				v.selectNum = 0
				v:PickDown()
			end
		break
		end
	end	
end--]]

-- 手牌排序
function CatchPockPlayer:Sort()
	CHData.SortCards(self.cards, false)
end

-- 播放声音
function CatchPockPlayer:PlaySound(cardType, cardInfo)
	print("---------------PlaySound", cardType)
	local clip = nil
	if cardType == 1 then
		clip = "buyao"
	elseif cardType == 2 or cardType == 3 then
		clip = "boom"
	elseif cardType == 4 then
		clip = "three"
	elseif cardType == 5 then
		clip = "three_one"
	elseif cardType == 6 then
		clip = "three_pair"
	elseif cardType == 7 then
		clip = "four_two"
	elseif cardType == 8 then
		clip = "four_pair"
	elseif cardType == 9 then
		clip = "shunzi"
	elseif cardType == 10 then
		clip = "liandui"
	elseif cardType == 11 then
		clip = "air"
	elseif cardType == 12 or cardType == 13 then
		clip = "air_fly"
	elseif cardType == 14 then
		if #cardInfo == 0 then return end
		clip = cardInfo[1].num .. cardInfo[2].num
	elseif cardType == 15 then
		if #cardInfo == 0 then return end
		clip = tostring(cardInfo[1].num)
	elseif cardType == 0 then
		return
	elseif cardType == "one" then
		if self.soundOne == false then
			clip = "left_one"
			self.soundOne = true
		else
			clip = "buyao"
		end
	elseif cardType == "two" then
		if self.soundTwo == false then
			clip = "left_two"
			self.soundTwo = true
		else
			clip = "buyao"
		end
	end
	Game.PockCardTalk(clip)
end

-- Small
function CatchPockPlayer:EndSmall(index)
	local k = CatchPockRoom:GetPlayer(index).sitIndex
	if #self.popList ~= 0 then
		for i, v in ipairs(self.popList) do
			v.transform.localScale = Vector3.New(0.7, 0.7, 1)
		end
	end
	if k == 3 then
		self.imgPopCard.transform.localPosition = Vector3.New(220, 35, 0)
	elseif k == 2 then
		self.imgPopCard.transform.localPosition = Vector3.New(-220, 35, 0)
	end
end

-- Big
function CatchPockPlayer:EndBig(index)
	local k = CatchPockRoom:GetPlayer(index).sitIndex
	if k == 3 then
		self.imgPopCard.transform.localPosition = Vector3.New(300, 0, 0)
	elseif k == 2 then
		self.imgPopCard.transform.localPosition = Vector3.New(-300, 0, 0)
	end
end

-- 清理图片
function CatchPockPlayer:ClearnImgLayer()
	if self.obj then
		if self.imgOK ~= nil and self.obj ~= nil then
			self.imgOK.transform:SetParent(self.obj.transform)
			self.imgOK.name = "imgOK"
			self.imgAnim.transform:SetParent(self.obj.transform)
			self.imgAnim.name = "imgAnim"
			self.imgHead.name = "img"
		end
	end
end

function CatchPockPlayer:Destroy()
	self:ClearnImgLayer()
	PlayerObject.Destroy(self)
	self.obj = nil
	self.imgHead = nil
	self.imgOffLine = nil
	self.imgOK = nil
	self.imgZhuang = nil
	self.imgChat = nil
	self.txtChat = nil
	self.imgFaceIcon = nil
	self.txtName = nil
	self.txtScore = nil
	self.imgCard = nil
	self.imgDeng = nil
	self.imgAnim = nil
	self.imgCur = nil
	self.imgPopCard = nil
	self.txtOverNum = nil
	self.warning = nil
	self.imgFeiJiAnim = nil
	self.imgZhaDanAnim = nil

	-- 新添加
	self.imgYuanbao = nil
	self.imgJinbi = nil
end