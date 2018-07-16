NiuNiuPlayer = { }

setbaseclass(NiuNiuPlayer, { PlayerObject })

-- 初始化重写
function NiuNiuPlayer:Init(data, obj)
	PlayerObject.Init(self, data, obj)
	self.obj = obj.gameObject
	self.imgHead = BasePanel:GOChild(obj, "Mask/img")
	self.imgOffLine = BasePanel:GOChild(obj, "ImgOffine")
	self.imgOK = BasePanel:GOChild(obj, "imgOK")
	self.imgZhuang = BasePanel:GOChild(obj, "imgZhuang")
	self.imgChat = BasePanel:GOChild(obj, "imgChat")
	self.txtChat = BasePanel:GOChild(obj, "imgChat/txtChat")
	self.imgFaceIcon = BasePanel:GOChild(obj, "imgFaceIcon")
	self.txtName = BasePanel:GOChild(obj, "txtName")
	self.imgWatching = BasePanel:GOChild(obj, "ImgWatching")
	-- 新添加
	self.imgYuanbao = BasePanel:GOChild(obj, "imgYuanbao")
	self.imgJinbi = BasePanel:GOChild(obj, "imgJinbi")

	self.txtScore = BasePanel:GOChild(obj, "ImgScore/txtScore")
	self.txtBet = BasePanel:GOChild(obj, "txtBet")
	self.txtCoin = BasePanel:GOChild(obj, "txtCoin")
	self.imgCard = BasePanel:GOChild(obj, "imgCard")
	self.imgCardType = BasePanel:GOChild(obj, "imgCardNiuType")
	self.imgBet = BasePanel:GOChild(obj, "ImgBet")
	self.imgAnim = BasePanel:GOChild(obj, "imgAnim")
	self.qiangBanker = BasePanel:GOChild(obj, "qiangBanker")
	self.transform = obj.transform
	self.movePos = Vector3.zero
	self.img2 = BasePanel:GOChild(obj, "imgCardNiuType/img2")
	self.img3 = BasePanel:GOChild(obj, "imgCardNiuType/img3")

	if data ~= nil then
		self.index = data.index
		self.sitIndex = NiuNiuRoom:GetRoomIndexByIndex(self.index)
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
		self.isWatch = data.isWatch
		self.isLook = data.isLook
	end

	self.cardFlag = false
	self.isHuan = false
	self.isQiang = false
	self.isBet = false
	self.isShow = false
	self.betScore = 0
	if self.imgHead then
		self.imgHead.name = self.id
		if self.imgHead ~= nil and self.id ~= nil and self.url ~= nil and url ~= "" then
			weChatFunction.SetPic(self.imgHead, self.id, self.url)
		end
	else
		self.imgHead = BasePanel:GOChild(obj, "Mask/" .. self.id)
	end
	if self.id ~= nil then
		if self.imgAnim then
			self.imgAnim.name = self.id .. "imgAnim"
			self.imgAnim.transform:SetParent(self.obj.transform.parent)
			self.imgAnim = BasePanel:GOChild(obj.transform.parent, self.id .. "imgAnim")
		else
			self.imgAnim = BasePanel:GOChild(obj.transform.parent, self.id .. "imgAnim")
		end
	end
	if self.imgHead ~= nil then
		self.headSprite = self.imgHead:GetComponent("Image").sprite
	end

	-- 牌型
	self.cardType = {
		double = BasePanel:GOChild(self.imgCardType,"img2"),
		triple = BasePanel:GOChild(self.imgCardType,"img3"),
	}

	-- 动画坐标
	self.AnimPos = {
		{ Vector3.New(0, 0, 0), Vector3.New(60, 0, 0), Vector3.New(120, 0, 0), Vector3.New(210, 0, 0), Vector3.New(270, 0, 0) },
		{ Vector3.New(-240, 0, 0), Vector3.New(-190, 0, 0), Vector3.New(-140, 0, 0), Vector3.New(-50, 0, 0), Vector3.New(0, 0, 0) },
		{ Vector3.New(-240, 0, 0), Vector3.New(-190, 0, 0), Vector3.New(-140, 0, 0), Vector3.New(-50, 0, 0), Vector3.New(0, 0, 0) },
		{ Vector3.New(-240, 0, 0), Vector3.New(-190, 0, 0), Vector3.New(-140, 0, 0), Vector3.New(-50, 0, 0), Vector3.New(0, 0, 0) },
		{ Vector3.New(0, 0, 0), Vector3.New(50, 0, 0), Vector3.New(100, 0, 0), Vector3.New(190, 0, 0), Vector3.New(240, 0, 0) },
		{ Vector3.New(0, 0, 0), Vector3.New(50, 0, 0), Vector3.New(100, 0, 0), Vector3.New(190, 0, 0), Vector3.New(240, 0, 0) },
	}


	-- 动画坐标
	self.AnimNotNiuPos = {
		{ Vector3.New(0, 0, 0), Vector3.New(60, 0, 0), Vector3.New(120, 0, 0), Vector3.New(180, 0, 0), Vector3.New(240, 0, 0) },
		{ Vector3.New(-200, 0, 0), Vector3.New(-150, 0, 0), Vector3.New(-100, 0, 0), Vector3.New(-50, 0, 0), Vector3.New(0, 0, 0) },
		{ Vector3.New(-200, 0, 0), Vector3.New(-150, 0, 0), Vector3.New(-100, 0, 0), Vector3.New(-50, 0, 0), Vector3.New(0, 0, 0) },
		{ Vector3.New(-200, 0, 0), Vector3.New(-150, 0, 0), Vector3.New(-100, 0, 0), Vector3.New(-50, 0, 0), Vector3.New(0, 0, 0) },
		{ Vector3.New(0, 0, 0), Vector3.New(50, 0, 0), Vector3.New(100, 0, 0), Vector3.New(150, 0, 0), Vector3.New(200, 0, 0) },
		{ Vector3.New(0, 0, 0), Vector3.New(50, 0, 0), Vector3.New(100, 0, 0), Vector3.New(150, 0, 0), Vector3.New(200, 0, 0) },
	}

	-- 断线
	if not self.isOnline then
		self.imgOffLine:SetActive(true)
	else
		self.imgOffLine:SetActive(false)
	end
	self.qiangBanker:SetActive(false)
end

-- 牌型显示
function NiuNiuPlayer:CardType(index, typeName, over, turn, cards)
	self.imgCardType:SetActive(true)
	local imgName = "n" .. typeName
	local voiceNum = typeName
	if typeName >= 11 then
		self.cardType.double:SetActive(false)
		self.cardType.triple:SetActive(true)
		self.cardType.triple:GetComponent("Image").sprite = TH_GameMainCtrl.niuniuList[imgName]
	elseif typeName == -1 then
		self.cardType.double:SetActive(false)
		self.cardType.triple:SetActive(false)
	else
		self.cardType.double:SetActive(true)
		self.cardType.triple:SetActive(false)
		self.cardType.double:GetComponent("Image").sprite = TH_GameMainCtrl.niuniuList[imgName]
	end

	if typeName ~= -1 and typeName ~= 0 then
		self:SetList()
	end

	if typeName == 0 then
		self:SetNotNiuList()
	end
	self:SetText(typeName)
	if voiceNum == -1 then return end
	if not turn then return end
end

function NiuNiuPlayer:PlayEffect(time, obj, pos)

	local img = obj:GetComponent("Image")
	img.rectTransform:DOLocalMove(pos, time, false):OnComplete( function()
		obj:SetActive(false)
	end )
end

-- 牌间隔
function NiuNiuPlayer:SetList()
	local k = self.sitIndex
	for i, v in ipairs(self.AnimPos[k]) do
		if self.cards[i] ~= nil then
			DG.Tweening.DOTween.Sequence():Append(self.cards[i].transform:DOLocalMove(v, 0.3, false))
		end
	end
end

function NiuNiuPlayer:SetNotNiuList()
	local k = self.sitIndex
	for i, v in ipairs(self.AnimNotNiuPos[k]) do
		if self.cards[i] ~= nil then
			DG.Tweening.DOTween.Sequence():Append(self.cards[i].transform:DOLocalMove(v, 0.3, false))
		end
	end
end

-- 字间隔
function NiuNiuPlayer:SetText(typeName)
	local k = self.sitIndex
end

-- 摸牌
function NiuNiuPlayer:GetOneCard(index, card, state)
	local flag = { }
	if #card ~= 0 then
		for i, v in ipairs(card) do
			flag = v
		end
	else
		flag = card
	end
	local zeroPos = Vector3.zero
	local zeroRotate = Vector3.New(0, 0, 720)
	local k = NiuNiuRoom:GetPlayer(index).sitIndex
	local parent = self.obj.transform.parent
	local parent2 = self.imgCard.transform.localPosition
	local haveCards = #self.cards
	local p = 35
	local cardList = nil
	cardList = self.cards
	if #cardList <= 4 then
		local co = coroutine.start( function()
			local objUI = CHCard:New(flag, parent, index, state)
			table.insert(self.cards, objUI)
			---------点牌------------------------------
			if index == NiuNiuRoom.myIndex then
				TH_GameMainCtrl:RemoveClick(objUI.gameObject)
				TH_GameMainCtrl:AddClick(objUI.gameObject, self.OnClickCard)
			end
			-------------------------------------------
			if flag.color == "" or flag.id == -1 then
				local cardSprite = objUI.transform:FindChild("tf_cardBG(Clone)").gameObject
				if cardSprite ~= nil then
					cardSprite:GetComponent("Image").sprite = TH_GameMainCtrl.publicCardSprite.nnone
				end
			end

			objUI.transform:SetParent(parent)
			objUI.transform.localScale = Vector3.one
			objUI.transform.localPosition = zeroPos
			objUI.transform:SetParent(self.obj.transform)
			if k == 2 or k == 3 or k == 4 then
				p = -35
			end
			if self.index == NiuNiuRoom.myIndex then
				p = 110
			end
			local sequence = DG.Tweening.DOTween.Sequence()
			-- 动画序列
			local rotateMod = DG.Tweening.RotateMode.FastBeyond360
			-- 旋转模型
			local Ease = DG.Tweening.Ease
			-- 线性
			-- print("生成的卡牌的位置=========== pos", parent2.x + haveCards * p)
			sequence:Append(objUI.transform:DOLocalRotate(zeroRotate, 1, rotateMod))
			:Insert(0, objUI.transform:DOLocalMove(Vector3.New(parent2.x + haveCards * p, parent2.y,(5 - #cardList) * 10), 1, false))
			:OnComplete( function()
				objUI.transform:SetParent(self.imgCard.transform)
				if k == 2 or k == 3 or k == 4 then
					objUI.transform:SetAsFirstSibling()
				end
			end )
		end )
		table.insert(Network.crts, co)
	end
end


-- 换牌
function NiuNiuPlayer:ChangeCard(index, cardinfo, state)
	local curList = { }
	local posList = { }
	local coinfo = coroutine.start( function()
		for i, v in ipairs(NiuNiuRoom.popList) do
			curList[v.id] = true
		end
		for i = #self.cards, 1, -1 do
			local n = self.cards[i]
			-- n:GetComponent("Button").interactable = false
			if curList[n.id] ~= nil then
				if curList[n.id] then
					table.insert(posList, n.transform.localPosition)
					table.remove(self.cards, i)
					n.transform:SetParent(self.obj.transform.parent)
					n.transform:DOLocalMove(Vector3.zero, 0.5, false):OnComplete( function()
						n:Destroy()
					end )
				end
			end
		end
		coroutine.wait(0.6)
		for i, card in ipairs(cardinfo) do
			local flag = { }
			if #card ~= 0 then
				for i, v in ipairs(card) do
					flag = v
				end
			else
				flag = card
			end
			local zeroPos = Vector3.zero
			local zeroRotate = Vector3.New(0, 0, 720)
			local k = NiuNiuRoom:GetPlayer(index).sitIndex
			local parent = self.obj.transform.parent
			local parent2 = self.imgCard.transform.localPosition
			local haveCards = #self.cards
			local p = 35
			local cardList = nil
			cardList = self.cards
			local co = coroutine.start( function()
				local objUI = CHCard:New(flag, parent, index, state)
				table.insert(self.cards, objUI)
				---------点牌------------------------------
				if index == NiuNiuRoom.myIndex then
					TH_GameMainCtrl:RemoveClick(objUI.gameObject)
					TH_GameMainCtrl:AddClick(objUI.gameObject, self.OnClickCard)
				end
				-------------------------------------------
				if flag.color == "" or flag.id == -1 then
					local cardSprite = objUI.transform:FindChild("tf_cardBG(Clone)").gameObject
					if cardSprite ~= nil then
						cardSprite:GetComponent("Image").sprite = TH_GameMainCtrl.publicCardSprite.nnone
					end
				end

				objUI.transform:SetParent(parent)
				objUI.transform.localScale = Vector3.one
				objUI.transform.localPosition = zeroPos
				objUI.transform:SetParent(self.obj.transform)
				if k == 2 or k == 3 or k == 4 then
					p = -35
				end
				if self.index == NiuNiuRoom.myIndex then
					p = 100
				end
				local sequence = DG.Tweening.DOTween.Sequence()
				-- 动画序列
				local rotateMod = DG.Tweening.RotateMode.FastBeyond360
				-- 旋转模型
				local Ease = DG.Tweening.Ease
				-- 线性
				objUI.transform:SetParent(self.imgCard.transform)
				sequence:Append(objUI.transform:DOLocalRotate(zeroRotate, 1, rotateMod))
				:Insert(0, objUI.transform:DOLocalMove(Vector3.New(posList[i].x, 0, posList[i].z), 1, false))
				:OnComplete( function()
					if k == 2 or k == 3 or k == 4 then
						objUI.transform:SetAsFirstSibling()
					end
				end )
			end )
			table.insert(Network.crts, co)
		end
	end )
	table.insert(Network.crts, coinfo)
end
-- 翻牌
function NiuNiuPlayer:TurnCard(card, index, state)
	print("===========TurnCard|--:", index)
	local rotateMod = DG.Tweening.RotateMode.FastBeyond360
	-- 旋转模型
	local co = coroutine.start( function()
		if NiuNiuRoom.isBuCardEnd then
			coroutine.wait(0.4)
		end
		for i, v in ipairs(card) do
			local n = 3 + i
			if self.cards[n] ~= nil then
				local pos = self.cards[n].transform.position
				local obj = self.cards[n]
				local parent = self.imgCard.transform
				local newObj = nil
				obj.transform:DOLocalRotate(Vector3.New(0, 90, 0), 0.2, rotateMod):OnComplete(
				function()
					obj:Destroy()
					newObj = CHCard:New(v, parent, index, state)
					newObj.localScale = Vector3.one
					newObj.transform.position = pos
					self.cards[n] = newObj
					NiuNiuRoom:ShowCardNum(self.cards)
				end )
			end
		end
	end )
	table.insert(Network.crts, co)
end

-- 生成一组牌
function NiuNiuPlayer:CreateListCards(index, card, state)
	print("CreateListCards", index, #card, state)
	for i, v in ipairs(self.cards) do
		v:Destroy()
	end

	self.cards = { }
	local k = NiuNiuRoom:GetPlayer(index).sitIndex
	local parent = self.obj.transform.parent
	local parent2 = self.imgCard.transform.localPosition
	local p = 35
	for i, v in ipairs(card) do
		local haveCards = #self.cards
		if k == 2 or k == 3 or k == 4 then
			p = -35
		end
		if self.index == NiuNiuRoom.myIndex then
			p = 110
		end
		local objUI = CHCard:New(v, parent, index, state)
		objUI.transform:SetParent(self.obj.transform)
		objUI.transform.localPosition = Vector3.New(parent2.x + haveCards * p, parent2.y, parent2.z)
		objUI.transform:SetParent(self.imgCard.transform)
		if k == 2 or k == 3 or k == 4 then
			objUI.transform:SetAsLastSibling()
		end
		table.insert(self.cards, objUI)
		---------点牌------------------------------
		if index == NiuNiuRoom.myIndex then
			TH_GameMainCtrl:RemoveClick(objUI.gameObject)
			TH_GameMainCtrl:AddClick(objUI.gameObject, self.OnClickCard)
		end
		-------------------------------------------
		if v.color == "" or v.id == -1 then
			local cardSprite = objUI.transform:FindChild("tf_cardBG(Clone)").gameObject
			if cardSprite ~= nil then
				cardSprite:GetComponent("Image").sprite = TH_GameMainCtrl.publicCardSprite.nnone
			end
			if index == NiuNiuRoom.myIndex then
				objUI.transform:SetSiblingIndex(0)
			end
		end
	end
end

function NiuNiuPlayer:GetPlayerCards(index, card, state, over)
	print("生成卡牌-1======================", state, card.id)
	if #card == 1 or #card == 0 then
		if over then
			self:CreateListCards(index, card, state)
		else
			self:GetOneCard(index, card, state)
		end
	else
		self:CreateListCards(index, card, state)
	end
end

-- 筹码显示
function NiuNiuPlayer:BetShow(sprite)
	if sprite == nil then return end
	self.imgBet:GetComponent("Image").sprite = sprite
	self.imgBet:SetActive(true)
	self.isBet = true
end

function NiuNiuPlayer:SettingCardDis()
	for i, v in ipairs(self.cards) do
		-- v.name
	end
end

-- 清理图片
function NiuNiuPlayer:ClearnImgLayer()
	self.headSprite = TH_GameMainCtrl.numberList["nil"]
	if self ~= nil then
		if self.imgAnim ~= nil then
			self.imgAnim.transform:SetParent(self.obj.transform)
			self.imgAnim.name = "imgAnim"
		end
		if self.imgHead ~= nil then
			self.imgHead.name = "img"
		end
	end
end

function NiuNiuPlayer.OnClickCard(go)
	print("-------OnClickCard------", go.name, NiuNiuRoom.roomState)
	if NiuNiuRoom.roomState ~= 2 then return end
	--Game.MusicEffect(Game.Effect.thfapai1)
	local curCache = NiuNiuRoom:GetPlayer(NiuNiuRoom.myIndex)
	for i, v in ipairs(curCache.cards) do
		if go.name == v.cardName then
			if v.selectNum == 0 then
				v.selectNum = 1
				v:PickUp()
			else
				v.selectNum = 0
				v:PickDown()
			end
			break
		end
	end
end

function NiuNiuPlayer:ClearnData()
	if self.obj ~= nil then
		self.obj = nil
	end
	if self.imgHead ~= nil then
		self.imgHead = nil
	end
	if self.imgOffLine ~= nil then
		self.imgOffLine = nil
	end
	if self.imgOK ~= nil then
		self.imgOK = nil
	end
	if self.imgZhuang ~= nil then
		self.imgZhuang = nil
	end
	if self.imgChat ~= nil then
		self.imgChat = nil
	end
	if self.txtChat ~= nil then
		self.txtChat = nil
	end
	if self.imgFaceIcon ~= nil then
		self.imgFaceIcon = nil
	end
	if self.txtName ~= nil then
		self.txtName = nil
	end
	if self.txtName ~= nil then
		self.imgBet = nil
	end
	if self.transform ~= nil then
		self.transform = nil
	end
	if self.imgCardType ~= nil then
		self.imgCardType = nil
	end
	if self.imgCard ~= nil then
		self.imgCard = nil
	end
	if self.txtScore ~= nil then
		self.txtScore = nil
	end
	if self.imgAnim ~= nil then
		self.imgAnim = nil
	end
	if self.imgDeng ~= nil then
		self.imgDeng = nil
	end
	if self.imgYuanbao ~= nil then
		self.imgYuanbao = nil
	end
	if self.imgJinbi ~= nil then
		self.imgJinbi = nil
	end
end

function NiuNiuPlayer:Destroy()
	self:ClearnImgLayer()
	PlayerObject.Destroy(self)
	self:ClearnData()
end