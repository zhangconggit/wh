GoldFlowerPlayer = { }

setbaseclass(GoldFlowerPlayer, { PlayerObject })

-- 初始化重写
function GoldFlowerPlayer:Init(data, obj)
	PlayerObject.Init(self, data, obj)
	self.obj = obj.gameObject

	local clicp = string.sub(obj.gameObject.name, -1)
	self.imgHead = BasePanel:GOChild(obj, "Mask/img")
	self.imgOffLine = BasePanel:GOChild(obj, "ImgOffine")
	self.imgOK = BasePanel:GOChild(obj, "imgOK")
	self.imgWatching = BasePanel:GOChild(obj, "ImgWatching")
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
	self.imgCardType = BasePanel:GOChild(obj, "imgCardJinHuaType")
	self.imgGiveupMask = BasePanel:GOChild(obj, "imgCardJinHuaType/imgGiveupMask")
	self.imgGiveup = BasePanel:GOChild(obj, "imgCardJinHuaType/imgGiveup")
	self.txtGiveup = BasePanel:GOChild(obj, "imgCardJinHuaType/imgGiveup/Text")
	self.imglookType = BasePanel:GOChild(obj, "imgCardJinHuaType/imgCardType")
	self.txtCardType = BasePanel:GOChild(obj, "imgCardJinHuaType/imgCardType/txtCardType")
	self.imgCompare = BasePanel:GOChild(obj, "imgCardJinHuaType/imgCompare" .. clicp)
	self.btnLook = BasePanel:GOChild(obj, "imgCardJinHuaType/btnCompare" .. clicp)
	self.imgBet = BasePanel:GOChild(obj, "ImgBet")
	self.imgAnim = BasePanel:GOChild(obj, "imgAnim")
	self.imgCur = BasePanel:GOChild(obj, "imgCur")
	self.imgDeng = BasePanel:GOChild(obj, "imgDeng")

	self.imgCompareLoseCoener = BasePanel:GOChild(obj, "imgCardJinHuaType/imgGiveupMask/imgCompareLose")
	self.imgGiveUpCoener = BasePanel:GOChild(obj, "imgCardJinHuaType/imgGiveupMask/imgGiveUp")
	self.transform = obj.transform
	self.movePos = Vector3.zero

	self.index = data.index
	self.sitIndex = GoldFlowerRoom:GetRoomIndexByIndex(self.index)
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
	self.isLook = data.isLook

	self.jifen = data.jifen
	self.isOnline = data.isOnline
	self.cardFlag = false
	self.curbetCount = 0
	self.allbetCount = 0
	self.qipaiFlag = false
	self.kanpaiFlag = false
	self.mengpaiFlag = false
	self.bipaiFlag = false
	self.betNum = 0
	self.curallBet = 0
	self.uiColor = Color.New(0.1, 0.1, 0.1, 0.6)
	self.qiColor = Color.New(0.8, 0.8, 0.8, 1)
	self.betMengFlag = false
	self.isLook = false
	-- 下注有没有看牌
	if data.whetherWatch then
		self.isWatch = data.whetherWatch
	else
		self.isWatch = false
	end

	if self.imgHead then
		self.imgHead.name = self.id
		self.imgCompare.name = self.index
		if url ~= "" then
			weChatFunction.SetPic(self.imgHead, self.id, self.url)
		end
	else
		self.imgHead = BasePanel:GOChild(obj, "Mask/" .. self.id)
		self.imgCompare = BasePanel:GOChild(obj, "imgCardJinHuaType/" .. self.index)
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
	print("======PlayerObject====", self.index, self.name, self.obj.name)
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
	if self.index == GoldFlowerRoom.myIndex then
		self.btnLook.transform.localPosition = Vector3.New(-35, -4, 0)
	end
	-- 断线
	if not self.isOnline then
		self.imgOffLine:SetActive(true)
	else
		self.imgOffLine:SetActive(false)
	end
	if self.index == GoldFlowerRoom.myIndex then
		self.imgEffect = BasePanel:GOChild(obj, "imgCardJinHuaType/imgEffect")
		self.imgEffect:SetActive(false)
	end
end

-- 牌型显示
function GoldFlowerPlayer:CardType(index, typeName, over)
	local curCache = GoldFlowerRoom:GetPlayer(index);
	local pos = nil
	local width = nil
	local effectPos = nil
	local sitNum = GoldFlowerRoom:GetRoomIndexByIndex(index)
	local cardsNum = tonumber(#curCache.cards)
	if sitNum == 1 then
		width = Vector2.New(50 +(cardsNum * 50), 58)
		pos = Vector2.New(-145 +(cardsNum * 25), -19)
		effectPos = Vector2.New(-145 +(cardsNum * 25), 20)
	elseif sitNum == 2 then
		width = Vector2.New(50 +(cardsNum * 50), 58)
		pos = Vector2.New(150 +(cardsNum * -25), -4)
		effectPos = Vector2.New(150 +(cardsNum * -25), 0)
	elseif sitNum == 3 then
		width = Vector2.New(50 +(cardsNum * 50), 58)
		pos = Vector2.New(165 +(cardsNum * -25), -19)
		effectPos = Vector2.New(165 +(cardsNum * -25), 0)
	elseif sitNum == 4 then
		width = Vector2.New(50 +(cardsNum * 50), 58)
		pos = Vector2.New(-165 +(cardsNum * 25), -19)
		effectPos = Vector2.New(-165 +(cardsNum * 25), 0)
	elseif sitNum == 5 then
		width = Vector2.New(50 +(cardsNum * 50), 58)
		pos = Vector2.New(-150 +(cardsNum * 25), -4)
		effectPos = Vector2.New(-150 +(cardsNum * 25), 0)
	end
	print("<color=#fffc16>-------curCache-------</color>" .. curCache.isLook)
	if curCache.isLook == false then
		self.imgCardType:SetActive(true)
	end

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

function GoldFlowerPlayer:PlayEffect(time, obj, pos)

	local img = obj:GetComponent("Image")
	img.rectTransform:DOLocalMove(pos, time, false):OnComplete( function()
		obj:SetActive(false)
	end )
end

-- 摸牌
function GoldFlowerPlayer:GetOneCard(index, card, state)
	print("===========GetOneCard|--:")
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
	local k = GoldFlowerRoom:GetPlayer(index).sitIndex
	local parent = self.obj.transform.parent
	local parent2 = self.imgCard.transform.localPosition
	local haveCards = #self.cards
	local p = 50
	local co = coroutine.start( function()
		local objUI = CardObject:New(flag, parent, index, state)
		table.insert(self.cards, objUI)
		local cardSprite = objUI.transform:FindChild("jH_cardBG(Clone)").gameObject
		if cardSprite ~= nil then
			cardSprite:GetComponent("Image").sprite = TH_GameMainCtrl.publicCardSprite.jhone
		end
		objUI.transform:SetParent(parent)
		objUI.transform.localScale = Vector3.one
		objUI.transform.localPosition = zeroPos
		objUI.transform:SetParent(self.obj.transform)
		if k == 2 or k == 3 then
			p = -50
		end
		if self.index == GoldFlowerRoom.myIndex then
			p = p * 2
		end
		local sequence = DG.Tweening.DOTween.Sequence()
		-- 动画序列
		local rotateMod = DG.Tweening.RotateMode.FastBeyond360
		-- 旋转模型
		local Ease = DG.Tweening.Ease
		-- 线性
		sequence:Append(objUI.transform:DOLocalRotate(zeroRotate, 1, rotateMod))
		:Insert(0, objUI.transform:DOLocalMove(Vector3.New(parent2.x + haveCards * p, parent2.y, parent2.z), 1, false))
		:OnComplete( function()
			objUI.transform:SetParent(self.imgCard.transform)
			if k == 2 or k == 3 then
				objUI.transform:SetAsFirstSibling()
			end
		end )
	end )
end

-- 翻牌
function GoldFlowerPlayer:TurnCard(card, index, state)
	print("===========TurnCard|--:", index)
	local rotateMod = DG.Tweening.RotateMode.FastBeyond360
	-- 旋转模型
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
		GoldFlowerRoom:ShowCardNum(self.cards)
	end )
end

-- 看牌动画
function GoldFlowerPlayer:LookAnim()
	local rotateMod = DG.Tweening.RotateMode.Fast
	-- 旋转模型
	local euler = nil
	local dis = 70
	local angle = 15
	for k, v in pairs(self.cards) do
		if k == 1 then
			euler = Vector3.New(0, 0, angle)
		elseif k == 2 then
			euler = Vector3.zero
		elseif k == 3 then
			euler = Vector3.New(0, 0, - angle)
		end
		if self.index == GoldFlowerRoom.myIndex then
			v.transform:DOLocalRotate(euler, 0.5, rotateMod)
			if k == 2 then
				v.transform:DOLocalMove(Vector3.New(dis, 10, 0), 0.5, false)
			elseif k == 3 then
				v.transform:DOLocalMove(Vector3.New(dis * 2, 0, 0), 0.5, false)
			end
		else
			if self.sitIndex == 2 or self.sitIndex == 3 then
				v.transform:DOLocalRotate(- euler, 0.5, rotateMod)
			else
				v.transform:DOLocalRotate(euler, 0.5, rotateMod)
			end
			if k == 2 then
				v.transform:DOLocalMove(Vector3.New(v.transform.localPosition.x, 7, 0), 0.5, false)
			end
		end
	end
	-- for k,v in pairs(self.cards) do
	-- 	v.transform:DOLocalRotate(Vector3.New(0,0,10),0.5,rotateMod)
	-- end
end

-- 生成一组牌
function GoldFlowerPlayer:CreateListCards(index, card, state, gray)
	print("CreateListCards", index, #card, state)
	for i, v in ipairs(self.cards) do
		v:Destroy()
	end
	self.cards = { }
	self.cardsInfo = card
	local k = GoldFlowerRoom:GetPlayer(index).sitIndex
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
		if self.index == GoldFlowerRoom.myIndex then
			if not self.kanpaiFlag then
				objUI.transform.localPosition = Vector3.New(parent2.x + haveCards * p * 2, parent2.y, parent2.z)
			else
				objUI.transform.localPosition = Vector3.New(parent2.x + haveCards * p, parent2.y, parent2.z)
			end
		else
			objUI.transform.localPosition = Vector3.New(parent2.x + haveCards * p, parent2.y, parent2.z)
		end
		objUI.transform:SetParent(self.imgCard.transform)
		if state == 1 then
			local cardSprite = objUI.transform:FindChild("jH_cardBG(Clone)").gameObject
			if cardSprite ~= nil then
				if gray ~= nil then
					cardSprite:GetComponent("Image").sprite = TH_GameMainCtrl.publicCardSprite.card_gray
				else
					cardSprite:GetComponent("Image").sprite = TH_GameMainCtrl.publicCardSprite.jhone
				end
			end
		end
		if k == 2 or k == 3 then
			objUI.transform:SetAsFirstSibling()
		end
		table.insert(self.cards, objUI)
	end
end

function GoldFlowerPlayer:GetPlayerCards(index, card, state, over)
	print("GetPlayerCards==============", index, #card, state)
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
function GoldFlowerPlayer:BetShow(sprite)
	if sprite == nil then return end
	self.imgBet:GetComponent("Image").sprite = sprite
	self.imgBet:SetActive(true)
end

-- 清理图片
function GoldFlowerPlayer:ClearnImgLayer()
	if self.obj then
		if self.imgOK ~= nil and self.obj ~= nil then
			self.imgOK.transform:SetParent(self.obj.transform)
			self.imgOK.name = "imgOK"
			self.imgAnim.transform:SetParent(self.obj.transform)
			self.imgAnim.name = "imgAnim"
			self.imgHead.name = "img"
			self.imgCompare.name = "imgCompare" .. string.sub(self.obj.gameObject.name, -1)
		end
	end
end

function GoldFlowerPlayer:ClearnData()
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

function GoldFlowerPlayer:Destroy()
	self:ClearnImgLayer()
	PlayerObject.Destroy(self)
	self:ClearnData()
end

-- 下注动画
function GoldFlowerPlayer:BetAnim(betCount, targetPos, isReload)
	local ease = DG.Tweening.Ease
	local parent = GoldFlowerRoom.common.transform
	local time = 0.4
	if isReload then
		time = 0
	end
	local imgBetClone = newObject(self.imgBet)
	imgBetClone.transform:SetParent(self.obj.transform)
	imgBetClone.transform.localScale = Vector3.one
	imgBetClone.transform.localPosition = self.imgBet.transform.localPosition
	self.betNum = self.betNum + 1
	imgBetClone:GetComponent("Image").sprite = self:GetBetSprite(betCount)
	local backPos = imgBetClone.transform.localPosition
	imgBetClone.transform:SetParent(parent)
	local clone = newObject(GoldFlowerRoom.empty)
	clone.name = self.id .. self.betNum
	clone.transform:SetParent(parent)
	clone.transform.localScale = Vector3.one
	-- hahahahaahahaahah/*****************/
	clone.transform.localPosition = imgBetClone.transform.localPosition
	imgBetClone.transform:SetParent(clone.transform)
	imgBetClone.transform.localScale = Vector3.one * 1.3
	imgBetClone:SetActive(true)
	table.insert(GoldFlowerRoom.betObjList, clone)
	clone.transform:DOLocalMove(targetPos, time, false):SetEase(ease.OutQuart)
	self.allbetCount = self.allbetCount + betCount
	self.curbetCount = betCount
	print("==============XIaZhu=----", self.index, self.betNum, self.curbetCount, #GoldFlowerRoom.betObjList)
	-- local targetPos = lt -200 45 ld -200 -60
	--  rt 200 45  rd 200 -60
end

-- 收筹码动画
function GoldFlowerPlayer:ReciveBetAnim(list, obj)
	print("----------ReciveBetAnim-----------", #list, obj)
	local ease = DG.Tweening.Ease
	local backPos = obj.transform.position
	local co = coroutine.start( function()
		for i, v in ipairs(list) do
			v.transform:DOMove(backPos, 0.5, false):SetEase(ease.OutQuart):OnComplete(
			function()
				table.remove(list, i)
				v:Destroy()
			end )
		end
	end )
	table.insert(Network.crts, co)
end

function GoldFlowerPlayer:GetBetSprite(betCount)
	local sprite = nil
	if betCount == 1 then
		sprite = TH_GameMainCtrl.spriteList.bet1
	elseif betCount == 2 then
		sprite = TH_GameMainCtrl.spriteList.bet2
	elseif betCount == 3 then
		sprite = TH_GameMainCtrl.spriteList.bet3
	elseif betCount == 4 then
		sprite = TH_GameMainCtrl.spriteList.bet4
	elseif betCount == 5 then
		sprite = TH_GameMainCtrl.spriteList.bet5
	elseif betCount == 6 then
		sprite = TH_GameMainCtrl.spriteList.bet6
	elseif betCount == 8 then
		sprite = TH_GameMainCtrl.spriteList.bet7
	elseif betCount == 10 then
		sprite = TH_GameMainCtrl.spriteList.bet8
	end
	return sprite
end

-- 比牌按钮
function GoldFlowerPlayer.OnClickBiPai(go)
	TH_GameMainCtrl:SendVSReq(go.name)
end

-- 看牌按钮
function GoldFlowerPlayer.OnLookBtn(go)
	TH_GameMainCtrl:SendLookReq(GoldFlowerRoom.myIndex)
	print("*****************************************************")
end

-- 弃牌
function GoldFlowerPlayer:GiveUp(info)
	if info == "弃牌" then
		self.imgGiveupMask:SetActive(true)
		self.imgGiveUpCoener:SetActive(true)
		self.imgCompareLoseCoener:SetActive(false)
		self.imgGiveup:SetActive(false)

		if self.index == GoldFlowerRoom.myIndex then
			for i, v in ipairs(self.cards) do
				if self.kanpaiFlag then
					v.bg.color = self.qiColor
					v.fg.color = self.uiColor
				else
					v.bg.sprite = TH_GameMainCtrl.publicCardSprite.card_gray
				end
			end
		else
			self.imglookType:SetActive(false)
			for i = 1, #self.cards do
				self:GiveUpAnim(self.cards[i])
			end
			self.cards = { }
		end
	elseif info == "已看牌" then
		self.imgGiveup:SetActive(self.index ~= GoldFlowerRoom.myIndex)
	elseif info == "比牌输" then
		self.imgGiveupMask:SetActive(true)
		self.imgGiveUpCoener:SetActive(false)
		self.imgCompareLoseCoener:SetActive(true)
		self.imgGiveup:SetActive(false)
		if GoldFlowerRoom.over then
			TH_GameMainCtrl:SetText(self.txtGiveup, info)
			return
		end
		if self.cardsInfo ~= nil then
			if self.index == GoldFlowerRoom.myIndex then
				self:CreateListCards(self.index, self.cardsInfo, 3)
				self.imglookType:SetActive(true)
			else
				self:CreateListCards(self.index, self.cardsInfo, 1, "gray")
			end
			self:LookAnim()
		else
			local card = { { id = - 1 }, { id = - 1 }, { id = - 1 } }
			if self.index ~= GoldFlowerRoom.myIndex then
				self:CreateListCards(self.index, card, 1, "gray")
				self:LookAnim()
			end
		end
	end
	TH_GameMainCtrl:SetText(self.txtGiveup, info)
end

-- 弃牌动画
function GoldFlowerPlayer:GiveUpAnim(obj)
	local zeroRotate = Vector3.New(0, 0, 720)
	local sequence = DG.Tweening.DOTween.Sequence()
	-- 动画序列
	local rotateMod = DG.Tweening.RotateMode.FastBeyond360
	-- 旋转模型
	local Ease = DG.Tweening.Ease
	-- 线性
	sequence:Append(obj.transform:DOLocalRotate(zeroRotate, 0.3, rotateMod))
	:Insert(0, obj.transform:DOMove(Vector3.zero, 0.3, false))
	:OnComplete( function()
		obj:Destroy()
	end )
end

function GoldFlowerPlayer:SetCardType(cardType, index)
	if cardType == 0 then
		self.imglookType:SetActive(false)
		return
	end
	local sprite = nil

	local txt = ""
	self.imglookType:SetActive(true)
	if cardType == 1 then
		txt = "高牌"
	elseif cardType == 2 then
		txt = "对子"
	elseif cardType == 3 then
		txt = "顺子"
		sprite = TH_GameMainCtrl.jinhuaList.shunzi
	elseif cardType == 4 then
		txt = "金花"
		sprite = TH_GameMainCtrl.jinhuaList.jinhua
	elseif cardType == 5 then
		txt = "顺金"
		sprite = TH_GameMainCtrl.jinhuaList.shunjin
	elseif cardType == 6 then
		txt = "豹子"
		sprite = TH_GameMainCtrl.jinhuaList.baozi
	elseif cardType == 7 then
		txt = "特殊"
	end
	TH_GameMainCtrl:SetText(self.txtCardType, txt)
	if index ~= nil then
		if index == GoldFlowerRoom.myIndex then
			if sprite ~= nil then
				self.imgEffect:SetActive(true)
				self.imgEffect:GetComponent("Image").sprite = sprite
				self.imgEffect.transform:DOScale(Vector3.New(2, 2, 2), 0.8):OnComplete( function()
					self.imgEffect:SetActive(false)
					self.imgEffect.transform.localScale = Vector3.one
				end )
			end
		end
	end
end