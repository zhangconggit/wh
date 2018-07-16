TenharfPlayer = { }

setbaseclass(TenharfPlayer, { PlayerObject })

-- 初始化重写
function TenharfPlayer:Init(data, obj)
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
	-- 新添加
	self.imgYuanbao = BasePanel:GOChild(obj, "imgYuanbao")
	self.imgJinbi = BasePanel:GOChild(obj, "imgJinbi")

	self.txtScore = BasePanel:GOChild(obj, "txtScore")
	self.imgCard = BasePanel:GOChild(obj, "imgCard")
	self.imgCardType = BasePanel:GOChild(obj, "imgCardTenHalfType")
	self.imgCardType:SetActive(true)
	self.imgBet = BasePanel:GOChild(obj, "ImgBet")
	self.imgAnim = BasePanel:GOChild(obj, "imgAnim")
	self.imgCur = BasePanel:GOChild(obj, "imgCur")
	self.imgDeng = BasePanel:GOChild(obj, "imgDeng")
	self.transform = obj.transform
	self.movePos = Vector3.zero

	self.index = data.index
	self.sitIndex = TenharfRoom:GetRoomIndexByIndex(self.index)
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
	self.cardFlag = false
	if self.imgHead then
		self.imgHead.name = self.id
		if url ~= "" then
			weChatFunction.SetPic(self.imgHead, self.id, self.url)
		end
	else
		self.imgHead = BasePanel:GOChild(obj, "Mask/" .. self.id)
	end

	if self.imgAnim then
		self.imgAnim.name = self.id .. "imgAnim"
		self.imgAnim.transform:SetParent(self.obj.transform.parent)
		self.imgAnim = BasePanel:GOChild(obj.transform.parent, self.id .. "imgAnim")
	else
		self.imgAnim = BasePanel:GOChild(obj.transform.parent, self.id .. "imgAnim")
	end

	self.headSprite = self.imgHead:GetComponent("Image").sprite
	print("======PlayerObject====", self.index, self.name, self.obj.name, self.isOnline)
	-- 牌型
	self.cardType = {
		SHIDIANBAN = BasePanel:GOChild(self.imgCardType,"imgShiDianBanBG"),
		SHIDIANBANLEI = BasePanel:GOChild(self.imgCardType,"imgShiDianBanLeiBG"),
		WUHUALEI = BasePanel:GOChild(self.imgCardType,"imgWuHuaLeiBG"),
		WULEI = BasePanel:GOChild(self.imgCardType,"imgWuLeiBG"),
		BUTINGPAI = BasePanel:GOChild(self.imgCardType,"imgBuTingPaiBg"),
		BAOPAI = BasePanel:GOChild(self.imgCardType,"imgBaoPaiBg")
	}
	-- 特效
	self.effectList = {
		BAOPAI = BasePanel:GOChild(self.imgCardType,"th_boom"),
		WULEI = BasePanel:GOChild(self.imgCardType,"th_wulei"),
		SHIDIANBAN = BasePanel:GOChild(self.imgCardType,"th_shidianban"),
	}
	-- 断线
	if not self.isOnline then
		self.imgOffLine:SetActive(true)
	else
		self.imgOffLine:SetActive(false)
	end
end

-- 牌型显示
function TenharfPlayer:CardType(index, typeName, over)
	local pos = nil
	local width = nil
	local effectPos = nil
	local sitNum = TenharfRoom:GetRoomIndexByIndex(index)
	local cardsNum = tonumber(#TenharfRoom:GetPlayer(index).cards)
	if sitNum == 1 then
		width = Vector2.New(50 +(cardsNum * 50), 85)
		pos = Vector2.New(-145 +(cardsNum * 25), -19)
		effectPos = Vector2.New(-145 +(cardsNum * 25), 20)
	elseif sitNum == 2 then
		width = Vector2.New(50 +(cardsNum * 50), 65)
		pos = Vector2.New(150 +(cardsNum * -25), -4)
		effectPos = Vector2.New(150 +(cardsNum * -25), 0)
	elseif sitNum == 3 then
		width = Vector2.New(50 +(cardsNum * 50), 65)
		pos = Vector2.New(165 +(cardsNum * -25), -19)
		effectPos = Vector2.New(165 +(cardsNum * -25), 0)
	elseif sitNum == 4 then
		width = Vector2.New(50 +(cardsNum * 50), 65)
		pos = Vector2.New(-165 +(cardsNum * 25), -19)
		effectPos = Vector2.New(-165 +(cardsNum * 25), 0)
	elseif sitNum == 5 then
		width = Vector2.New(50 +(cardsNum * 50), 65)
		pos = Vector2.New(-150 +(cardsNum * 25), -4)
		effectPos = Vector2.New(-150 +(cardsNum * 25), 0)
	end

	self.imgCardType:SetActive(true)

	for k, v in pairs(self.cardType) do
		if typeName == k then
			v:SetActive(true)
			v.transform.localPosition = pos
			v.transform.sizeDelta = width
			if not over then
				v.transform.localScale = Vector3.zero
				self:DoScale(v)
			end
		else
			v:SetActive(false)
		end
	end
	if over == nil then return end
	if not over then
		local time = 0
		if typeName == "SHIDIANBANLEI" or typeName == "SHIDIANBAN" then
			typeName = "SHIDIANBAN"
			time = 1
		elseif typeName == "WUHUALEI" or typeName == "WULEI" then
			typeName = "WULEI"
			time = 1.3
			if index == self.index then
				pos = Vector2.New(-145 +(cardsNum * 25), 50)
			end
		elseif typeName == "BAOPAI" then
			time = 1
		end
		for k, v in pairs(self.effectList) do
			if typeName == k then
				print("================CardType==", over, v.activeSelf)
				v:SetActive(true)
				v.transform.localScale = Vector3.New(2, 2, 2)
				v.transform.localPosition = effectPos
				self:PlayEffect(time, v, effectPos)
			else
				v:SetActive(false)
			end
		end
	else
		for k, v in pairs(self.effectList) do
			v:SetActive(false)
		end
	end
end

function TenharfPlayer:PlayEffect(time, obj, pos)

	local img = obj:GetComponent("Image")
	img.rectTransform:DOLocalMove(pos, time, false):OnComplete( function()
		obj:SetActive(false)
	end )
end

-- 摸牌
function TenharfPlayer:GetOneCard(index, card, state)
	print("===========GetOneCard|--:")
	if TenharfRoom.singleSettlementStart then
		return
	end
	Game.MusicEffect(Game.Effect.thfapai1)
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
	local k = TenharfRoom:GetPlayer(index).sitIndex
	local parent = self.obj.transform.parent
	local parent2 = self.imgCard.transform.localPosition
	local haveCards = #self.cards
	local p = 50
	local objUI = CardObject:New(flag, parent, index, state)
	objUI.transform:SetParent(parent)
	objUI.transform.localScale = Vector3.one
	objUI.transform.localPosition = zeroPos
	objUI.transform:SetParent(self.obj.transform)
	table.insert(self.cards, objUI)
	if k == 2 or k == 3 then
		p = -50
	end
	local sequence = DG.Tweening.DOTween.Sequence()
	-- 动画序列
	local rotateMod = DG.Tweening.RotateMode.FastBeyond360
	-- 旋转模型
	local Ease = DG.Tweening.Ease
	-- 线性
	sequence:Append(objUI.transform:DOLocalRotate(zeroRotate, 0.5, rotateMod))
	:Insert(0, objUI.transform:DOLocalMove(Vector3.New(parent2.x + haveCards * p, parent2.y, parent2.z), 0.5, false))
	:OnComplete( function()
		objUI.transform:SetParent(self.imgCard.transform)
		if k == 2 or k == 3 then
			objUI.transform:SetAsFirstSibling()
		end
		if index == TenharfRoom.myIndex then
			TenharfRoom:ShowCardNum(self.cards)
			if state == 2 or state == 0 then
				TH_GameMainPanel.imgIsBuPai:SetActive(true)
			end
		end
	end )
end

-- 翻牌
function TenharfPlayer:TurnCard(card, index, state)
	print("===========TurnCard|--:", index)
	local rotateMod = DG.Tweening.RotateMode.FastBeyond360
	-- 旋转模型
	local co = coroutine.start( function()
		if TenharfRoom.isBuCardEnd then
			coroutine.wait(0.4)
		end
		if self.cards[1] ~= nil then
			local pos = self.cards[1].transform.position
			local obj = self.cards[1]
			local parent = self.imgCard.transform
			local newObj = nil
			obj.transform:DOLocalRotate(Vector3.New(0, 90, 0), 0.2, rotateMod):OnComplete(
			function()
				obj:Destroy()
				newObj = CardObject:New(card, parent, index, state)
				newObj.localScale = Vector3.one
				newObj.transform.position = pos
				self.cards[1] = newObj
				TenharfRoom:ShowCardNum(self.cards)
			end )
		end
	end )
	table.insert(Network.crts, co)
end

-- 生成一组牌
function TenharfPlayer:CreateListCards(index, card, state)
	print("CreateListCards", index, #card, state)
	for i, v in ipairs(self.cards) do
		v:Destroy()
	end
	self.cards = { }
	local k = TenharfRoom:GetPlayer(index).sitIndex
	local parent = self.obj.transform.parent
	local parent2 = self.imgCard.transform.localPosition
	local p = 50
	for i, v in ipairs(card) do
		local haveCards = #self.cards
		if k == 2 or k == 3 then
			p = -50
		end
		local objUI = CardObject:New(v, parent, index, state)
		objUI.transform:SetParent(self.obj.transform)
		objUI.transform.localPosition = Vector3.New(parent2.x + haveCards * p, parent2.y, parent2.z)
		objUI.transform:SetParent(self.imgCard.transform)
		if k == 2 or k == 3 then
			objUI.transform:SetAsFirstSibling()
		end
		table.insert(self.cards, objUI)
	end
end

function TenharfPlayer:GetPlayerCards(index, card, state, over)
	print("GetPlayerCards==============", index, #card, state, over)
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
function TenharfPlayer:BetShow(sprite)
	if sprite == nil then return end
	self.imgBet:GetComponent("Image").sprite = sprite
	self.imgBet:SetActive(true)
end

-- 清理图片
function TenharfPlayer:ClearnImgLayer()
	self.headSprite = TH_GameMainCtrl.numberList["nil"]
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

function TenharfPlayer:ClearnData()
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
	self.imgCardType = nil
	self.transform = nil
	self.imgBet = nil
	self.imgAnim = nil
	self.imgCur = nil
	self.imgDeng = nil
	-- 新添加
	self.imgYuanbao = nil
	self.imgJinbi = nil
end
function TenharfPlayer:Destroy()
	self:ClearnImgLayer()
	PlayerObject.Destroy(self)
	self:ClearnData()
end