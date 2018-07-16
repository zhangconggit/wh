NiuNiuRoom = {
	gameUI = nil,
	RoomMsg = { },
	moveFlag = false,
	rotateFlag = false,
	isAdd = false,
	curJushu = 1,
	operateIndex = 0,
	huanFlag = false,
	cuoFlag = false,
	roomState = 0,
}

setbaseclass(NiuNiuRoom, { RoomObject })

-- 缓存
function NiuNiuRoom.SaveGameObj(objs, name)
	local self = NiuNiuRoom
	if self.loadObjList[name] then return end
	self.loadObjList[name] = objs[0]
end

-- 加载
function NiuNiuRoom:LoadGameObj(objs)
	--Game.MusicBG("bgm3")
	local GuiCamera = find('Canvas/GuiCamera')
	self.imgHead = BasePanel:GOChild(obj, "Mask/img")

	NiuNiuRoom.gameUI = newObject(objs)
	NiuNiuRoom.gameUI.transform:SetParent(GuiCamera.transform)
	NiuNiuRoom.gameUI.transform.localScale = Vector3.one
	NiuNiuRoom.gameUI.transform.localPosition = Vector3.zero
	local table = find("Canvas/GuiCamera/NNGame(Clone)/Table/NiuTable/imgTable")
	local niuTable = find("Canvas/GuiCamera/NNGame(Clone)/Table/NiuTable")
	niuTable:SetActive(true)
	self.playerPanel = find("Canvas/GuiCamera/NNGame(Clone)/Players")
	self.playerPanel:SetActive(false)
	self.txtWanFa = BasePanel:GOChild(table, "imgRoomMessageBG/txtWanFa")
	self.imgJuShu = BasePanel:GOChild(table, "imgJuShu")
	self.txtJuShu = BasePanel:GOChild(table, "imgRoomMessageBG/txtJuShu")
	self.txtRoomMessage = BasePanel:GOChild(table, "imgRoomMessageBG/txtRoomMessage")
	self.txtRoomNum = BasePanel:GOChild(table, "imgRoomMessageBG/txtRoomNum")
	self.txtMessage = BasePanel:GOChild(table, "imgRoomMessageBG/txtMessage")
	self.cardBg = BasePanel:GOChild(self.playerPanel, "CardBg")
	TH_GameMainCtrl:Open("TH_GameMain", function()
		local gamePanel = find("Canvas/GuiCamera/TH_GameMainPanel")
		gamePanel.transform:SetParent(self.playerPanel.transform)
		gamePanel.transform:SetSiblingIndex(10)
		for i = 1, 6 do
			local obj = self.playerPanel.transform:FindChild("TH_imgHead" .. i).gameObject
			obj:SetActive(false)
		end
		self:ResourceCheckOver()
	end )

	self.NiuPos = {
		Vector3.New(50,- 40,0),Vector3.New(50,- 25,0),Vector3.New(65,- 40,0),
		Vector3.New(-30,- 40,0),Vector3.New(-20,- 25,0)
	}

	self.NoPos = {
		Vector3.New(0,- 40,0),Vector3.New(45,- 25,0),Vector3.New(55,- 40,0),
		Vector3.New(-80,- 40,0),Vector3.New(-70,- 25,0)
	}
	if self.RoomMsg.moneyType ~= 0 then
		self.imgJuShu:SetActive(false)
	end
end

function NiuNiuRoom:InitPlayers()
	print("====================NiuNiuRoom:InitPlayers==========================")
	for _, v in ipairs(self.players) do
		if v.obj ~= nil then
			v:Destroy()
		end
	end
	self.isHuan = true
	self.isCuo = true
	self.isJoin = true
	-- 特殊规则

	local strArray = string_split(self.RoomMsg.seniorInfo, "|")
	for i, v in ipairs(strArray) do
		if v == "1" then
			self.isHuan = false
		elseif v == "2" then
			self.isCuo = false
		elseif v == "3" then
			self.isJoin = false
		end
	end

	self.players = { }
	self.watchPlayers = { }
	self.showCardList = { }
	self.retakingCardList = { }
	-- 游戏开始是否已经发过牌
	self.isStatingCard = false
	-- 是否已经补牌
	self.isAllRetaking = false
	-- 是否已经亮牌
	self.isAllShowCard = false
	for i = 1, 6 do
		local obj = self.playerPanel.transform:FindChild("TH_imgHead" .. i).gameObject
		obj:SetActive(false)
	end

	for i = 1, self.playerCount do
		local obj = self.playerPanel.transform:FindChild("TH_imgHead" .. self:GetRoomIndexByIndex(i)).gameObject
		local playerObj = NiuNiuPlayer:New(self.playersData[i], obj)
		table.insert(self.players, playerObj)
		if self.myIndex ~= playerObj.index then
			TH_GameMainCtrl:RemoveClick(playerObj.imgHead)
			TH_GameMainCtrl:AddClick(playerObj.imgHead, TH_GameMainCtrl.OnClickHead)
		else
			if not self.isAdd then
				TH_GameMainCtrl:AddClick(playerObj.imgHead, TH_GameMainCtrl.OnClickHead)
				self.isAdd = true
			end
		end
		playerObj.obj:SetActive(true)
	end

	for i, v in ipairs(self.players) do
		v.obj:SetActive(true)
		TH_GameMainCtrl:SetText(v.txtName, v.name)
		TH_GameMainCtrl:SetText(v.txtScore, v.jifen)
		v.imgZhuang:SetActive(false)
		v.imgChat:SetActive(false)
		v.imgFaceIcon:SetActive(false)
		v.imgCardType:SetActive(false)
		v.imgBet:SetActive(false)
		v.qiangBanker:SetActive(false)
		if v.imgAnim ~= nil then
			v.imgAnim:SetActive(false)
		end
		v.txtBet:SetActive(false)
		v.txtCoin:SetActive(false)
		-- 新添加
		v.imgYuanbao:SetActive(false)
		v.imgJinbi:SetActive(false)
		v.imgWatching:SetActive(false)
		if self.RoomMsg.moneyType == RoomMode.goldMode then
			v.imgJinbi:SetActive(true)
			TH_GameMainCtrl:SetText(v.txtScore, formatNumber(v.goldcoin))
		elseif self.RoomMsg.moneyType == RoomMode.wingMode then
			v.imgYuanbao:SetActive(true)
			TH_GameMainCtrl:SetText(v.txtScore, formatNumber(v.wing))
		end
	end
	if self.RoomMsg.moneyType == 0 then
		if self.myIndex == 1 and #self.players > 1 then
			TH_GameMainPanel.btnGameStart:SetActive(true)
		else
			TH_GameMainPanel.btnGameStart:SetActive(false)
		end
	end
	self.playerPanel:SetActive(true)
	self.curJushu = 1
	self:SetCurJushu(self.curJushu)
	self.btnCheck = 0
	self.popList = { }
	self.curBei = 0
	BlockLayerCtrl:CloseSpec()
	self.initPlayerEnd = true
	local quitPanel = TH_GameMainPanel.imgQuitTips
	local singlePanel = TH_GameMainPanel.imgHTSingleSettlement
	singlePanel.transform:SetParent(self.playerPanel.transform)
	singlePanel.transform:SetAsLastSibling()
	quitPanel.transform:SetParent(self.playerPanel.transform)
	quitPanel.transform:SetAsLastSibling()

	if Room.isStar then
		if NiuNiuRoom.txtRoomMessage.activeSelf == false then
			NiuNiuRoom.txtRoomMessage:SetActive(true)
		end
		TH_GameMainCtrl:SetText(NiuNiuRoom.txtRoomMessage, '观战中····')
	else
		NiuNiuRoom.txtRoomMessage:SetActive(false)
	end
end

-- 发一轮牌
function NiuNiuRoom:DealCards(index, roleIndex, cardInfo)
	print("==================================NiuNiuRoom:DealCards========================")
	self.hasLoaded = false
	self.isStatingCard = true
	TH_GameMainPanel.imgPublicCard:SetActive(true)
	Room.btnStartClick = false
	if index == self.myIndex then
		local palyer = self:GetPlayer(self.myIndex)
		print("isLook的值为：", palyer.isLook)
		if palyer.isLook then return end
	end
	if self.RoomMsg.moneyType ~= 0 then
		TH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
		TH_GameMainPanel.imgNotGameMainQuitRoom:SetActive(true)
	end
	-- 手牌张数，牌间距
	local k = index
	local num = #self.players
	local state = TenHalfCardState.KouCard
	local co = coroutine.start( function()
		for i = 1, 4 do
			for k, v in ipairs(self.players) do
				local card = { color = "" }
				if v.index == self.myIndex then
					if cardInfo[i] ~= nil then
						v:GetPlayerCards(k, cardInfo[i], TenHalfCardState.FanKaiCard)
					else
						v:GetPlayerCards(k, card, TenHalfCardState.KouCard)
					end
				else
					v:GetPlayerCards(k, card, TenHalfCardState.KouCard)
				end
				coroutine.wait(0.04)
			end
			--Game.MusicEffect(Game.Effect.thfapai)
			coroutine.wait(0.12)
		end
		self.hasLoaded = true
		if self:GetPlayer(self.myIndex).isLook == false then
			TH_GameMainPanel.imgNNGameMain:SetActive(true)
		end
		self:ChangeRoomState(-1)
	end )
	table.insert(Network.crts, co)
end


function NiuNiuRoom:DealRoleIndexCards(roleIndex, cardInfo)
	print("======================NiuNiuRoom:DealRoleIndexCards================================")
	self.hasLoaded = false
	Room.btnStartClick = false
	-- 手牌张数，牌间距
	TH_GameMainPanel.imgPublicCard:SetActive(true)
	local tempRole = self:GetPlayer(roleIndex)
	if tempRole == nil then return end
	local co = coroutine.start( function()
		if roleIndex ~= self.myIndex then
			tempRole:GetPlayerCards(roleIndex, cardInfo, TenHalfCardState.KouCard)
		else
			-- 不处理观战玩家
			if tempRole.isLook == false then
				if cardInfo ~= nil then
					tempRole:GetPlayerCards(roleIndex, cardInfo, TenHalfCardState.FanKaiCard)
				else
					tempRole:GetPlayerCards(roleIndex, cardInfo, TenHalfCardState.KouCard)
				end
			end
		end
		coroutine.wait(0.01)
		--Game.MusicEffect(Game.Effect.thfapai)
		self.hasLoaded = true
		if self:GetPlayer(self.myIndex).isLook == false then
			TH_GameMainPanel.imgNNGameMain:SetActive(true)
		end
		self:ChangeRoomState(-1)
	end )
	table.insert(Network.crts, co)
end


-- 补牌
function NiuNiuRoom.OnNiuNiuBuCardsRes(buffer)
	print("==========================NiuNiuRoom.OnNiuNiuBuCardsRes=========================")
	local self = NiuNiuRoom
	local data = buffer:ReadBuffer()
	local msg = NiuniuBuCard_pb.NiuNiuBuCardRes()
	msg:ParseFromString(data)
	local isBuCard = false
	if self.retakingCardList ~= nil then
		for key, var in ipairs(self.retakingCardList) do
			print("=====补牌==========", var.roleIndex == msg.roleIndex)
			if var.roleIndex == msg.roleIndex then
				isBuCard = true
				break
			end
		end
	end
	if isBuCard == false then
		table.insert(self.retakingCardList, msg)
	end
	if self.isAllRetaking == false then
		if #self.retakingCardList == self.playerCount - 1 then
			self.isAllRetaking = true
			for key, var in ipairs(self.retakingCardList) do
				if #self:GetPlayer(var.roleIndex).cards == 4 then
					-- 默认补一张牌
					self:DealRoleIndexCards(var.roleIndex, var.cardInfo)
				end
			end
		end
	end
end

-- 设置玩家手牌显示
function NiuNiuRoom:SetPlayerCards(index, card, cardType, over, turn)
	print("==============================NiuNiuRoom:SetPlayerCards=========================")
	local state = TenHalfCardState.FanKaiCard
	local curCache = self:GetPlayer(index)
	if curCache ~= nil then
		if over then
			curCache:GetPlayerCards(index, card, state, over)
			curCache:CardType(index, cardType, over)
		else
			curCache:GetPlayerCards(index, card, state)
			curCache:CardType(index, cardType, over, turn, cards)
		end
	end
end

function NiuNiuRoom:Reload(data)
	print("=======================NiuNiuRoom:Reload==========================")
	-- 房间
	self.notVoice = true
	self.hasLoaded = false
	self.initPlayerEnd = false
	local roomVo = RoomNiuVo:New()
	roomVo.id = data.roomNum
	roomVo.niuniuGameType = data.niuniuGameType
	roomVo.maxNum = data.maxNum
	roomVo.baseScore = data.baseScore
	roomVo.special = data.special
	roomVo.maxZhuang = data.maxZhuang
	roomVo.maxPush = data.maxPush
	roomVo.seniorInfo = data.seniorInfo
	roomVo.doubleRule = data.doubleRule
	-- 添加
	roomVo.baseNum = data.baseNum
	roomVo.qualified = data.qualified
	roomVo.moneyType = data.moneyType
	self.RoomMsg = roomVo
	self.RoomMsg.totalJushu = data.totalJushu
	-- 当局
	self.roomState = data.curStatus
	self.alreadyJuShu = data.alreadyJuShu
	self.startGameZhuangIndex = data.zhuang
	-- 玩家
	self.playersData = { }
	self.players = { }
	self.watchPlayers = { }
	self:ClearRoomInfo()
	for i, v in ipairs(data.roles) do
		local joinRoomUserVo = JoinRoomUserVo:New()
		joinRoomUserVo.index = v.roleIndex
		joinRoomUserVo.roleId = v.roleId
		joinRoomUserVo.name = v.name
		joinRoomUserVo.ip = v.ip
		joinRoomUserVo.headImg = v.headImg
		joinRoomUserVo.jifen = v.jifen
		joinRoomUserVo.gender = v.gender
		joinRoomUserVo.diamond = v.diamond
		joinRoomUserVo.isOnline = v.isOnline
		joinRoomUserVo.goldcoin = v.goldcoin
		joinRoomUserVo.wing = v.wing
		joinRoomUserVo.isLook = v.isLook
		self.playersData[v.roleIndex] = joinRoomUserVo
		if v.roleId == global.userVo.roleId then
			self.myIndex = v.roleIndex
		end
	end
	self.playerCount = #self.playersData
	-- 玩家的牌
	local isAllShowCard;
	local co = coroutine.start( function()
		while not self.isPrefabLoaded do
			coroutine.step()
		end

		self:InitPlayers()
		self.curJushu = data.alreadyJuShu

		local cards, betCount
		local zhuangKai = false
		for i, role in ipairs(data.roles) do
			local spInfo = ReLoad_pb.NiuniuRoleSpInfo()
			spInfo:ParseFromString(role.spInfoRes)
			-- 详细信息
			local betCount = spInfo.betCount
			local result = spInfo.result
			local isShowCard = spInfo.isShowCard
			local qiangBei = spInfo.qiangBei
			local tuiBei = spInfo.tuiBei
			isAllShowCard = spInfo.isAllShowCard;
			if #spInfo.roleCard ~= 0 then
				self:SetPlayerCards(i, spInfo.roleCard, result, false)
			end
			if self.startGameZhuangIndex ~= i then
				self:SetPlayerBet(i, betCount)
			else
			end
			if i == self.myIndex then
				betCount = spInfo.betCount
				cards = spInfo.roleCard
			end
			-- 设置自己是否亮牌
			for j, k in ipairs(self.players) do
				local curCache = self:GetPlayer(k.index)
				if i == k.index then
					curCache.isShow = false
					if spInfo.betCount ~= 0 then
						curCache.isBet = true
						zhuangKai = true
					else
						curCache.isBet = false
					end
				end
				if self.startGameZhuangIndex == k.index then
					curCache.imgZhuang:SetActive(true)
					curCache.imgBet:SetActive(false)
					curCache.txtScore:SetActive(false)
				end
				if curCache.isLook ~= nil then
					if curCache.isLook then
						curCache.imgWatching:SetActive(true)
					end
				end
			end
		end
		self:GameStart(1)
		if self:GetPlayer(self.myIndex).isLook == false then
			TH_GameMainPanel.imgNNGameMain:SetActive(true)
		end
		self:ChangeRoomState(data.curStatus)
		self:SetCurJushu(self.curJushu)
		TH_GameMainPanel.imgHTWaitFriends:SetActive(false)
		TH_GameMainPanel.btnPrepareButton:SetActive(false)
		self.notVoice = false
		self.hasLoaded = true
	end )
	table.insert(Network.crts, co)
end

-- 收到服务器开始游戏
function NiuNiuRoom.OnNiuStartGameRes(buffer)
	print("====================NiuNiuRoom.OnNiuStartGameRes==============================")
	local self = NiuNiuRoom
	local data = buffer:ReadBuffer()
	local msg = NiuNiuDeal_pb.NiuNiuDealRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	local cardInfo = msg.cardInfo
	self.curJushu = msg.currJushu
	print("-- 收到服务器开始游戏", self.curJushu)
	self:SetCurJushu(self.curJushu)
	self:GameStart(self.curJushu)
	TH_GameMainPanel.imgClock:SetActive(false)
	for i, v in ipairs(self.players) do
		if v.imgOK ~= nil then
			v.imgOK:SetActive(false)
		end
	end
	if self.isStatingCard == false then
		self:DealCards(roleIndex, roleIndex, cardInfo)
	end
end

function NiuNiuRoom:NextGame()
	print("==================NiuNiuRoom:NextGame==================")
	self.curPopTips = { }
	self.btnCheck = 0
	self.isStatingCard = false
	for i, v in ipairs(self.players) do
		v.imgCard:SetActive(false)
		v.warning:SetActive(false)
		v.cardsCount = 16
		v.txtOverNum:SetActive(true)
		CH_GameMainCtrl:SetText(v.txtOverNum, "")
		v:PopType(0, 0)
		for j, k in ipairs(v.popList) do
			k:Destroy()
		end
		v.popList = { }
		if v.index == self.myIndex then
			for j, k in ipairs(v.cards) do
				k:Destroy()
			end
		end
		v.cards = { }
		v.soundOne = false
		v.soundTwo = false
	end
end

function NiuNiuRoom:GameStart(jushu)
	print("==============NiuNiuRoom:GameStart===================")
	self.startGame = true
	self.singleSettlementStart = false
	if jushu == 1 then
		TH_GameMainPanel.imgSignalBG:SetActive(false)
		TH_GameMainPanel.imgQuitTips:SetActive(false)
		-- 新添加
	end
	TH_GameMainPanel.btnChat:SetActive(true)
	if self.RoomMsg.moneyType ~= RoomMode.roomCardMode then
		TH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
		TH_GameMainPanel.imgNotGameMainQuitRoom:SetActive(true)
		if self:GetPlayer(self.myIndex) then
			if self:GetPlayer(self.myIndex).isLook then
				TH_GameMainPanel.btnWaitQuitRoom:SetActive(true)
				TH_GameMainPanel.imgNotWaitQuitRoom:SetActive(false)
			else
				TH_GameMainPanel.btnWaitQuitRoom:SetActive(false)
				TH_GameMainPanel.imgNotWaitQuitRoom:SetActive(true)
			end
		end
		TH_GameMainPanel.imgHTWaitFriends:SetActive(false)
		TH_GameMainPanel.btnInvitationWeChat:SetActive(false)
		TH_GameMainPanel.btnPrepareButton:SetActive(false)
	else
		TH_GameMainPanel.btnGameMainQuitRoom:SetActive(true)
		TH_GameMainPanel.imgNotGameMainQuitRoom:SetActive(false)
		TH_GameMainPanel.btnWaitQuitRoom:SetActive(false)
		TH_GameMainPanel.imgNotWaitQuitRoom:SetActive(true)
		TH_GameMainPanel.imgHTWaitFriends:SetActive(false)
		TH_GameMainPanel.btnInvitationWeChat:SetActive(false)
		TH_GameMainPanel.btnPrepareButton:SetActive(false)
	end
end

-- 下注
function NiuNiuRoom.OnNiuNiuBetRes(buffer)
	print("=================NiuNiuRoom.OnNiuNiuBetRes============")
	local self = NiuNiuRoom
	local data = buffer:ReadBuffer()
	local msg = NiuNiuBet_pb.NiuNiuBetRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	local betConut = msg.betConut
	self:SetPlayerBet(roleIndex, betConut)
end

-- 筹码显示
function NiuNiuRoom:SetPlayerBet(index, betConut)
	print("====================NiuNiuRoom:SetPlayerBet====================")
	local curCache = self:GetPlayer(index)
	if index == self.startGameZhuangIndex then
		curCache.isBet = true
		curCache.txtCoin:SetActive(false)
		curCache.qiangBanker:SetActive(false)
	else
		curCache.imgBet:SetActive(false)
		curCache.txtBet:SetActive(false)
		curCache.txtCoin:SetActive(true)
		TH_GameMainCtrl:SetText(curCache.txtCoin, "X " .. betConut .. "")
		curCache.qiangBanker:SetActive(false)
	end
end

-- 换牌消息
function NiuNiuRoom.NiuNiuChangeReq(go)
	print("==================NiuNiuRoom.NiuNiuChangeReq=======================")
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = NiuNiuRoom
	local curCache = self:GetPlayer(self.myIndex)
	if curCache.isHuan then return end
	self.btnCheck = 1
	local popCardInfo = NiuNiuChange_pb.NiuNiuChangeReq()
	local curCache = self:GetPlayer(self.myIndex)
	local strList = ""
	if go.name == "btnHuanPai" then
		for i, v in ipairs(curCache.cards) do
			if v.selectNum == 1 and v.gameObject.transform.localPosition.y == 0 then
				v.selectNum = 0
			end
			if v.selectNum == 1 then
				v:PickUp()
				strList = strList .. v.id .. ","
				table.insert(self.popList, v)
			end
		end
		if strList == "" then
			self.btnCheck = 0
			TH_GameMainCtrl.SetIconTips("您选择的牌不符合规则")
			return
		end
	end
	popCardInfo.roleIndex = self.myIndex
	popCardInfo.changeCard = strList
	local msg = popCardInfo:SerializeToString()
	Game.SendProtocal(Protocal.NiuHuan, msg)
end

-- 换牌消息返回
function NiuNiuRoom.NiuNiuChangeRes(buffer)
	print("===================NiuNiuRoom.NiuNiuChangeRes===============")
	TH_GameMainPanel.imgPublicCard:SetActive(true)
	local self = NiuNiuRoom
	local data = buffer:ReadBuffer()
	local msg = NiuNiuChange_pb.NiuNiuChangeRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	local cardInfo = msg.cardInfo
	local isChange = msg.isChange
	local state = TenHalfCardState.FanKaiCard
	if roleIndex == self.myIndex then
		-- 当前玩家
		local curCache = self:GetPlayer(roleIndex)
		curCache:ChangeCard(roleIndex, cardInfo, state, curCache.cards)
		curCache.isHuan = true
		print("_GameMainPanel.btnHuanPai:SetActive(false)")
		TH_GameMainPanel.btnHuanPai:SetActive(false)
		TH_GameMainPanel.btnBuHuan:SetActive(false)
	end
end

-- 判断除自己外是不是都结算了
function NiuNiuRoom:IsSettlement()
	print("====================NiuNiuRoom:IsSettlement=======================")
	local jiesuan = false
	for i, v in ipairs(self.players) do
		if v.index ~= self.startGameZhuangIndex then
			if not self:GetPlayer(v.index).cardFlag then
				jiesuan = false
				break
			else
				jiesuan = true
			end
		end
	end
	return jiesuan
end

-- 翻牌
function NiuNiuRoom.OnNiuNiuTurnRes(buffer)
	print("==================NiuNiuRoom.OnNiuNiuTurnRes==================")
	local self = NiuNiuRoom
	local data = buffer:ReadBuffer()
	local msg = NiuNiuTurn_pb.NiuNiuTurnRes()
	local state = TenHalfCardState.FanKaiCard
	msg:ParseFromString(data)
	for i, v in ipairs(msg.infos) do
		local curCache = self:GetPlayer(v.roleIndex)
		print("isLook的值为：", curCache.isLook)
		if curCache.isLook and curCache.roleIndex == self.myIndex then return end
		self:SetPlayerCards(v.roleIndex, v.cardInfo, v.cardType, false, true)
	end
	if msg.infos[1].roleIndex == self.myIndex then
		self:ChangeRoomState(-1)
	end
end

-- 亮牌
function NiuNiuRoom.OnNiuNiuShowCardRes(buffer)
	print("NiuNiuRoom.OnNiuNiuShowCardRes")
	local self = NiuNiuRoom
	local data = buffer:ReadBuffer()
	local msg = NiuNiuShowCard_pb.NiuNiuShowCardRes()
	msg:ParseFromString(data)
	local IsReceived = false
	for key, var in ipairs(self.showCardList) do
		if var.roleIndex == msg.roleIndex then
			IsReceived = true
		end
	end
	TH_GameMainPanel.imgPublicCard:SetActive(false)
	if IsReceived == false then
		table.insert(self.showCardList, msg)
	end
	if msg.roleIndex == self.myIndex then
		self:ShowOnceCard(msg)
	end
	if self.isAllShowCard == false then
		local needShowCardPlayerCount = 0;
		for key, var in ipairs(self.players) do
			if var.isLook == nil or var.isLook == false then
				needShowCardPlayerCount = needShowCardPlayerCount + 1;
			end
			print("--亮牌容错排除观战玩家", var.isLook, needShowCardPlayerCount)
		end
		if #self.showCardList == needShowCardPlayerCount then
			-- 亮牌容错排除观战玩家
			self.isAllShowCard = true
			local co = coroutine.start( function()
				for key, var in ipairs(self.showCardList) do
					if var.roleIndex ~= self.myIndex then
						self:ShowOnceCard(var)
						coroutine.wait(1)
					end
				end
			end );
			table.insert(Network.crts, co)
		end
	end

end

function NiuNiuRoom:ShowOnceCard(args)
	print("====NiuNiuRoom.OnNiuNiuShowCardRes=====ShowCard And HintCard====", args.roleIndex, args.cardInfo, args.cardType)
	local curCache = self:GetPlayer(args.roleIndex)
	if args.roleIndex == self.myIndex then
		TH_GameMainPanel.imgIsBuPai:SetActive(false)
	end
	if curCache == nil then return end
	if curCache.isLook then return end
	if args.isShow then
		curCache.isShow = true
		if args.roleIndex == self.startGameZhuangIndex then
			if self.myIndex ~= args.roleIndex then
				curCache:CardType(args.roleIndex, args.cardType, false, true)
			end
		else
			if args.roleIndex == self.myIndex then
				self:ChangeRoomState(-1)
			end
		end
		self:SetPlayerCards(args.roleIndex, args.cardInfo, args.cardType, false)
	else
		if args.roleIndex == self.startGameZhuangIndex then
			if self.myIndex ~= args.roleIndex then
				curCache:CardType(args.roleIndex, args.cardType, false, false)
			end
		else
			if args.roleIndex == self.myIndex then
				self:ChangeRoomState(-1)
			end
		end
		self:SetPlayerCards(args.roleIndex, args.cardInfo, args.cardType, true)
	end

	local clip = "bull_" .. args.cardType
	--soundMgr:PlayCardSound(global.systemVo.CardSource, "ptaudiocard", Game.CardList.PT[clip])
end

-- 每局结算
function NiuNiuRoom.OnNiuNiuSingleSettlementRes(buffer)
	print("===============NiuNiuRoom.OnNiuNiuSingleSettlementRes===================")
	local self = NiuNiuRoom
	self.singleSettlementStart = true
	local data = buffer:ReadBuffer()
	local msg = NiuNiuSingleSettlement_pb.NiuNiuSingleSettlementRes()
	msg:ParseFromString(data)
	local totalJushu = self.RoomMsg.totalJushu
	if DissolutionRoomCtrl.gameOver then
		-- gameOver
		TH_GameMainPanel.btnSettleStartGame:SetActive(false)
	end
	if self.curJushu == totalJushu then
		-- 总局数打完
		TH_GameMainPanel.btnSettleStartGame:SetActive(false)
	end
	if self.RoomMsg.moneyType ~= 0 then
		-- 0是房卡场
		TH_GameMainPanel.imgHTWaitFriends:SetActive(true)
		TH_GameMainPanel.btnSettleQuitGame:SetActive(true)
		TH_GameMainPanel.btnSettleStartGame:SetActive(true)
		TH_GameMainPanel.btnChat:SetActive(false)
	else
		TH_GameMainPanel.btnSettleQuitGame:SetActive(false)
		TH_GameMainPanel.btnSettleStartGame:SetActive(true)
	end
	TH_GameMainPanel.imgClock:SetActive(false)
	TH_GameMainPanel.imgIsBuPai:SetActive(false)
	TH_GameMainPanel.btnShowPai:SetActive(false)
	TH_GameMainPanel.btnHintCard:SetActive(false)
	TH_GameMainCtrl:FenShow(false)
	TH_GameMainPanel.imgPublicCard:SetActive(false)

	local co = coroutine.start( function()
		------------------找到庄的位置-------------------
		for key, var in ipairs(msg.settlementInfo) do
			if var.roleIndex == msg.zhuangIndex then
				if self.players ~= nil and var.roleIndex ~= nil and self:GetPlayer(var.roleIndex).obj ~= nil and self.players[var.roleIndex].obj.transform ~= nil then
					self.zhuangPosition = self.players[var.roleIndex].obj.transform
				end
			end
		end
		coroutine.wait(0.8 * self.playerCount)
		---------判定开始位置和结束位置并生成金币---------------
		for i, v in ipairs(msg.settlementInfo) do
			if v.roleIndex ~= msg.zhuangIndex then
				if v.curJiFen > 0 then
					self.targetPosition = self.players[v.roleIndex].obj.transform:FindChild("Mask")
					-- 出生点
					self.origionPosition = self.zhuangPosition
				elseif v.curJiFen < 0 then
					self.targetPosition = self.zhuangPosition
					self.origionPosition = self.players[v.roleIndex].obj.transform:FindChild("Mask")
				end

				for i = 1, 8 do
					resMgr:LoadPrefab('animationcoin', { 'flyCoin' }, self.GoldCoinEffect)
					coroutine.wait(0.01)
				end
			end
		end
		if DissolutionRoomCtrl.gameOver then return end
		coroutine.wait(2)
		-- 玩家积分赋值
		for i, v in ipairs(msg.settlementInfo) do
			if self:GetPlayer(v.roleIndex) ~= nil then
				local player = self:GetPlayer(v.roleIndex)
				if self.RoomMsg.moneyType == RoomMode.goldMode then
					player.jifen = formatNumber(player.goldcoin + v.curJiFen)
				elseif self.RoomMsg.moneyType == RoomMode.wingMode then
					player.jifen = formatNumber(player.wing + v.curJiFen)
				else
					player.jifen = v.jiFen
				end
				TH_GameMainCtrl:SetText(player.txtScore, player.jifen)
			end
			if v.roleIndex == self.myIndex then
				if v.curJiFen > 0 then
					--Game.MusicEffect(Game.Effect.niuWin)
					TH_GameMainPanel.imgNiuLose:SetActive(false)
					TH_GameMainPanel.imgNiuWin:SetActive(true)
					TH_GameMainPanel.imgNiuWin.transform.localScale = Vector3.zero
					self:DoScale(TH_GameMainPanel.imgNiuWin)
				else
					--Game.MusicEffect(Game.Effect.niuLose)
					TH_GameMainPanel.imgNiuWin:SetActive(false)
					TH_GameMainPanel.imgNiuLose:SetActive(true)
					TH_GameMainPanel.imgNiuLose.transform.localScale = Vector3.zero
					self:DoScale(TH_GameMainPanel.imgNiuLose)
				end
				TH_GameMainCtrl:NumberShow(v.curJiFen)
			end
		end
		TH_GameMainPanel.imgHTSingleSettlement:SetActive(true)
		--[[if self.myIndex ~= nil then
			if self:GetPlayer(self.myIndex) ~= nil then
				if self:GetPlayer(self.myIndex).isLook == false then
					if self.RoomMsg.moneyType == 0 then
						if self.roomState == 1 then
							-- 观战玩家不弹出结算面板
							TH_GameMainPanel.imgHTSingleSettlement:SetActive(true)
						end
					else
						TH_GameMainPanel.imgHTSingleSettlement:SetActive(true)
					end
				end
			end
		end--]]
		self:NextGameStart()
	end )
	table.insert(Network.crts, co)

	-- 新添加协议向服务端发送
	local co = coroutine.start( function()
		if TH_GameMainPanel.imgHTSingleSettlement then
			while not TH_GameMainPanel.imgHTSingleSettlement.activeSelf do
				coroutine.step()
			end
		end
		local msg = ""
		Game.SendProtocal(Protocal.EndGameShowPai, msg)
	end )
	table.insert(Network.crts, co)
end

-- 设置金币效果相关信息
function NiuNiuRoom.GoldCoinEffect(objs)
	local self = NiuNiuRoom
	local go = newObject(objs[0])
	go.transform:SetParent(self.playerPanel.transform)
	if self.origionPosition ~= nil and go.transform ~= nil then
		go.transform.position = self.origionPosition.position
	end
	go.transform.localScale = Vector3.one
	self:GoldCoinAnimation(go)
	-- 播放动画	
end

-- 金币动画 
function NiuNiuRoom:GoldCoinAnimation(obj)
	--Game.MusicEffect(Game.Effect.goldCoinSound)
	-- 金币的声音
	local self = NiuNiuRoom
	local zeroRotate = Vector3.New(0, 0, 720)
	local sequence = DG.Tweening.DOTween.Sequence()
	-- 动画序列
	local rotateMod = DG.Tweening.RotateMode.FastBeyond360
	-- 旋转模型
	local Ease = DG.Tweening.Ease

	if self.targetPosition ~= nil then
		local x = Util.Random(self.targetPosition.position.x - 0.3, self.targetPosition.position.x + 0.3)
		local y = Util.Random(self.targetPosition.position.y - 0.3, self.targetPosition.position.y + 0.3)
		local z = self.targetPosition.position.z
		local position = Vector3.New(x, y, z)
		-- 线性
		-- sequence:Append(obj.transform:DOLocalRotate(zeroRotate, 1, rotateMod))
		-- :Insert(0, obj.transform:DOMove(position,0.6, false))
		sequence:Append(obj.transform:DOMove(position, 0.6, false))
		-- 从自身的位置移动到某个地方,延迟0.3秒后消失
		:OnComplete( function()
			local co = coroutine.start( function()
				coroutine.wait(0.3)
				obj:Destroy()
			end )
			table.insert(Network.crts, co)
		end )
	end
end

-- 元宝场和金币场准备按钮返回
function NiuNiuRoom.OnNiuNiuNotRoomCatPrepareRes(buffer)
	print("=====================NiuNiuRoom.OnNiuNiuSingleSettlementRes=======================")
	local self = NiuNiuRoom
	if self.RoomMsg.moneyType == 0 then return end
	local data = buffer:ReadBuffer()
	local msg = NiuNiuSettlementStartGame_pb.NiuNiuSettlementStartGameRes()
	msg:ParseFromString(data)
	local readyList = msg.alreadyIndex
	-- 点了准备的玩家索引
	local allStart = msg.allStart
	for k, v in ipairs(readyList) do
		local curCache = self:GetPlayer(v)
		if curCache ~= nil then
			curCache.isReady = true
			if curCache.imgOK ~= nil then
				curCache.imgOK:SetActive(true)
			end
		end

		if self:GetPlayer(v) ~= nil then
			if self:GetPlayer(v).imgOK ~= nil then
				self:GetPlayer(v).imgOK:SetActive(true)
			end
		end
	end
	self.singleSettlementStart = false
	if allStart then
		self:OnReadyGame()
		self:NextGameStart()
	end
end

-- 每局结算之后开始游戏2
function NiuNiuRoom.OnNiuNiuSettlementStartGameRes(buffer)
	print("===============NiuNiuRoom.OnNiuNiuSettlementStartGameRes===============")
	local self = NiuNiuRoom
	if self.RoomMsg.moneyType ~= 0 then
		if self.hasLoaded then return end
	end
	if self.RoomMsg.moneyType ~= 0 then return end

	local data = buffer:ReadBuffer()
	local msg = NiuNiuSettlementStartGame_pb.NiuNiuSettlementStartGameRes()
	msg:ParseFromString(data)

	local roleIndex = msg.roleIndex
	-- 谁点了开始	
	local leaderIndex = msg.leaderIndex
	-- 庄索引
	local readyList = msg.alreadyIndex
	-- 点了准备的玩家索引
	self.startGameZhuangIndex = leaderIndex
	local allStart = msg.allStart
	-- true为所有人都点了开始

	if roleIndex == self.myIndex then
		TH_GameMainPanel.imgHTSingleSettlement:SetActive(false)
		-- 如果自己点了开始按钮，关闭界面（根据服务器返回消息）

		TH_GameMainCtrl:FenShow(false)
		self:ChangeRoomState(-1)
		self:GetPlayer(roleIndex).isReady = true
	end

	for i, v in ipairs(readyList) do
		if self.RoomMsg.moneyType == 0 then
			if self:GetPlayer(v) ~= nil then
				self:GetPlayer(v).imgOK:SetActive(true)
			end
		else
			self:OnReadyGame()
		end
	end
	self.singleSettlementStart = false
	if allStart then
		self:GetPlayer(NiuNiuRoom.myIndex).isReady = false
		self:NextGameStart()
	end
end

-- 设置游戏局数
function NiuNiuRoom:SetCurJushu(curJushu)
	print("=================NiuNiuRoom:SetCurJushu======================", curJushu, totalJushu)
	local self = NiuNiuRoom
	if self.RoomMsg.moneyType == 0 then
		if self.txtJuShu.activeSelf == false then
			self.txtJuShu:SetActive(true)
		end
		setRoomInfo(TH_GameMainCtrl, self.txtJuShu, "局数：" .. curJushu .. '/' .. self.RoomMsg.totalJushu)
		-- TH_GameMainCtrl:SetText(self.txtJuShu, "局数：" .. curJushu .. '/' .. self.RoomMsg.totalJushu)
	else
		if self.txtJuShu.activeSelf then
			self.txtJuShu:SetActive(false)
		end
	end
end

-- 初始化
function NiuNiuRoom:NextGameStart()
	print("==============NiuNiuRoom:NextGameStart================")
	self.operateIndex = 0
	self.btnCheck = 0
	self.roomState = 0
	self.showCardList = { }
	self.retakingCardList = { }
	self.isStatingCard = false
	-- 是否已经补牌
	self.isAllRetaking = false
	-- 是否已经亮牌
	self.isAllShowCard = false
	self.popList = { }
	for i, v in ipairs(self.players) do
		v.obj:SetActive(true)
		v.imgZhuang:SetActive(false)
		v.imgChat:SetActive(false)
		v.imgFaceIcon:SetActive(false)
		v.imgCardType:SetActive(false)
		v.imgBet:SetActive(false)
		v.qiangBanker:SetActive(false)
		v.txtBet:SetActive(false)
		v.txtCoin:SetActive(false)
		v.cardFlag = false
		v.isShow = false
		v.isBet = false
		v.isQiang = false
		v.isHuan = false
		for i, v in ipairs(v.cards) do
			v:Destroy()
		end
		v.cards = { }
	end
end

-- 抢庄
function NiuNiuRoom.OnNiuNiuIsQiangBankerRes(buffer)
	print("=================NiuNiuRoom.OnNiuNiuIsQiangBankerRes=================")
	local self = NiuNiuRoom
	local data = buffer:ReadBuffer()
	msg = NiuNiuIsQiangBanker_pb.NiuNiuIsQiangBankerRes()
	msg:ParseFromString(data)
	local isRandom = msg.isRand
	local roleIndex = msg.roleIndex
	local zhuangIndex = msg.zhuangIndex
	-- 最终的庄索引
	local score = msg.score
	local betScore = msg.betScore
	local bankIndex = msg.bankIndex
	print("===========NiuNiuRoom.OnNiuNiuIsQiangBankerRes===", isRandom,roleIndex,zhuangIndex,score,betScore,#bankIndex)
	if isRandom then
		local co = coroutine.start( function()
			for i, v in ipairs(bankIndex) do
				local curCache = self:GetPlayer(v)
				curCache.qiangBanker:SetActive(true)
			end
			--Game.MusicEffect(Game.Effect.qiangBanker)
			coroutine.wait(1)
			for i, v in ipairs(bankIndex) do
				local curCache = self:GetPlayer(v)
				curCache.qiangBanker:SetActive(false)
			end
			local curCache = self:GetPlayer(roleIndex)
			if curCache == nil then return end
			curCache.betScore = betScore
			curCache.txtBet:SetActive(true)
			curCache.isQiang = true
			if score ~= 0 then
				TH_GameMainCtrl:SetText(curCache.txtBet, score .. "倍")
			else
				TH_GameMainCtrl:SetText(curCache.txtBet, "不抢")
			end
			if zhuangIndex ~= 0 then
				self:GetPlayer(zhuangIndex).imgZhuang:SetActive(true)
				self.startGameZhuangIndex = zhuangIndex
				TH_GameMainCtrl.SetIconTips("等待其他人抢庄", false)
				self:GetPlayer(zhuangIndex).isBet = true
				for i, v in ipairs(self.players) do
					v.txtBet:SetActive(v.index == zhuangIndex)
				end
				if self.myIndex == self.startGameZhuangIndex then
					-- 如果是观战模式直接返回
					TH_GameMainPanel.imgBeiShu:SetActive(false)
					TH_GameMainPanel.btnBet:SetActive(false)
				else
					-- 如果是观战模式直接返回
					print("isLook的值为：", self:GetPlayer(self.myIndex).isLook)
					if self:GetPlayer(self.myIndex).isLook == false then
						TH_GameMainPanel.imgBeiShu:SetActive(true)
						TH_GameMainPanel.btnBet:SetActive(true)
					end
				end
			end
			if roleIndex == self.myIndex then
				print("isLook的值为：", curCache.isLook)
				if curCache.isLook and self.myIndex == roleIndex then return end
				-- 如果是观战玩家直接返回
				if betScore > 0 then
					TH_GameMainCtrl:SetText(TH_GameMainPanel.btn5txt, betScore .. " 倍")
					TH_GameMainPanel.btn5:SetActive(true)
				else
					TH_GameMainPanel.btn5:SetActive(false)
				end
			end
		end )
		table.insert(Network.crts, co)
	else
		local curCache = self:GetPlayer(roleIndex)
		curCache.betScore = betScore
		curCache.txtBet:SetActive(true)
		curCache.isQiang = true
		if score ~= 0 then
			TH_GameMainCtrl:SetText(curCache.txtBet, score .. "倍")
		else
			TH_GameMainCtrl:SetText(curCache.txtBet, "不抢")
		end
		if zhuangIndex ~= 0 then
			self:GetPlayer(zhuangIndex).imgZhuang:SetActive(true)
			self.startGameZhuangIndex = zhuangIndex
			TH_GameMainCtrl.SetIconTips("等待其他人抢庄", false)
			self:GetPlayer(zhuangIndex).isBet = true
			for i, v in ipairs(self.players) do
				v.txtBet:SetActive(v.index == zhuangIndex)
			end
			if self.myIndex == self.startGameZhuangIndex then
				print("isLook的值为：", self:GetPlayer(self.myIndex).isLook)
				if self:GetPlayer(self.myIndex).isLook then return end
				-- 如果是观战模式直接返回
				TH_GameMainPanel.imgBeiShu:SetActive(false)
				TH_GameMainPanel.btnBet:SetActive(false)
				print("=====================zhuang按钮==false===========================")
			else
				print("isLook的值为：", self:GetPlayer(self.myIndex).isLook)
				if self:GetPlayer(self.myIndex).isLook == false then
					-- 如果是观战模式直接返回
					print("TH_GameMainPanel.imgBeiShu:SetActive(true)")
					TH_GameMainPanel.imgBeiShu:SetActive(true)
					TH_GameMainPanel.btnBet:SetActive(true)
					print("=====================zhuang按钮=====true========================")
				end
			end
		end
		if roleIndex == self.myIndex then
			if curCache.isLook and self.myIndex == roleIndex then return end
			-- 如果是观战玩家直接返回
			if betScore > 0 then
				TH_GameMainCtrl:SetText(TH_GameMainPanel.btn5txt, betScore .. " 倍")
				TH_GameMainPanel.btn5:SetActive(true)
			else
				TH_GameMainPanel.btn5:SetActive(false)
			end
		end
	end
end
-- 总结算
function NiuNiuRoom.OnNiuNiuTotalSettlementRes(buffer)
	print("====================NiuNiuRoom.OnNiuNiuTotalSettlementRes===================")
	local self = NiuNiuRoom
	local data = buffer:ReadBuffer()
	local msg = NiuNiuTotalSettlement_pb.NiuNiuTotalSettlementRes()
	msg:ParseFromString(data)
	TH_RoleInfoCtrl:Close()
	TH_GameMainPanel.imgHTSingleSettlement:SetActive(false)
	print("TH_GameMainPanel.imgHTSingleSettlement:SetActive(false)")
	if DissolutionRoomCtrl.gameOver then
		TH_TotalSettlementCtrl:Open("TH_TotalSettlement", function()
			-- 生成预制--
			resMgr:LoadPrefab('ui_niuniu', { 'nn_totalplayer' }, function(objs)
				TH_TotalSettlementCtrl:InitPanel(objs, msg)
			end )
		end )
	else
		TH_GameMainPanel.imgHTSingleSettlement.transform:DOScale(Vector3.zero, 0.2):SetDelay(3):OnComplete(
		function()
			TH_TotalSettlementCtrl:Open("TH_TotalSettlement", function()
				-- 生成预制--
				resMgr:LoadPrefab('ui_niuniu', { 'nn_totalplayer' }, function(objs)
					TH_TotalSettlementCtrl:InitPanel(objs, msg)
				end )
			end )
		end )
	end
end

-- 下注
function NiuNiuRoom.NiuNiuBetReq(info)
	print("===============NiuNiuRoom.NiuNiuBetReq===================", info)
	local self = NiuNiuRoom
	local curCache = self:GetPlayer(self.myIndex)
	if curCache.isBet then return end
	local data = NiuNiuBet_pb.NiuNiuBetReq()
	data.betConut = info
	local msg = data:SerializeToString()
	Game.SendProtocal(Protocal.NiuBet, msg)
end

-- 抢庄
function NiuNiuRoom.NiuNiuIsQiangBankerReq(info)
	print("==================NiuNiuRoom.NiuNiuIsQiangBankerReq=======================")
	local self = NiuNiuRoom
	local curCache = self:GetPlayer(self.myIndex)
	if curCache.isQiang then return end
	TH_GameMainCtrl.SetIconTips("等待其他人抢庄", true)
	local data = NiuNiuIsQiangBanker_pb.NiuNiuIsQiangBankerReq()
	data.score = info
	local msg = data:SerializeToString()
	Game.SendProtocal(Protocal.NiuIsQiangBanker, msg)
	TH_GameMainPanel.imgBeiShu:SetActive(false)
end

-- 计时器
function NiuNiuRoom.OnNiuNiuClockRes(buffer)
	print("=======================NiuNiuRoom.OnNiuNiuClockRes=====================================")
	local self = NiuNiuRoom
	local data = buffer:ReadBuffer()
	local msg = NiuNiuStatusChange_pb.NiuNiuStatusChangeRes()
	msg:ParseFromString(data)
	TH_GameMainCtrl:CountDown(msg.time, msg.status)
	self.roomState = msg.status
	print("=======================NiuNiuRoom.OnNiuNiuClockRes=====================================",self.roomState,msg.time,msg.status)
	if msg.time ~= 0 then
		self:ChangeRoomState(msg.status)
	end
end

function NiuNiuRoom:ChangeRoomState(state)
	print("=======================NiuNiuRoom:ChangeRoomState=========================", state)
	-- 准备状态
	local curCache = self:GetPlayer(self.myIndex)
	-- 如果是观战玩家直接返回
	if self:GetPlayer(self.myIndex).isLook == false then
		TH_GameMainPanel.imgNNGameMain:SetActive(true)
	end
	if curCache.isLook == false then
		if state == 1 then
			TH_GameMainPanel.imgBeiShu:SetActive(false)
			TH_GameMainPanel.imgIsBuPai:SetActive(false)
			TH_GameMainPanel.btnTitle:SetActive(false)
			TH_GameMainPanel.btnBet:SetActive(false)
			TH_GameMainPanel.btnHuanPai:SetActive(false)
			TH_GameMainPanel.btnBuHuan:SetActive(false)
			TH_GameMainCtrl:SetText(TH_GameMainPanel.txtRoomChange, "等待开始...")
			-- 换牌状态
		elseif state == 2 then
			TH_GameMainPanel.btnBet:SetActive(false)
			TH_GameMainPanel.imgIsBuPai:SetActive(true)
			TH_GameMainPanel.btnHuanPai:SetActive(true)
			TH_GameMainPanel.btnBuHuan:SetActive(true)
			TH_GameMainPanel.btnShowPai:SetActive(false)
			TH_GameMainPanel.btnHintCard:SetActive(false)
			TH_GameMainPanel.btnPrepareButton:SetActive(false)
			TH_GameMainCtrl:SetText(TH_GameMainPanel.txtRoomChange, "等待换牌...")
			-- 抢庄状态
		elseif state == 3 then
			print("TH_GameMainPanel.imgBeiShu:SetActive(true)")
			TH_GameMainPanel.imgBeiShu:SetActive(true)
			TH_GameMainPanel.imgIsBuPai:SetActive(false)
			TH_GameMainPanel.btnTitle:SetActive(true)
			TH_GameMainPanel.btnBet:SetActive(false)
			TH_GameMainPanel.btnPrepareButton:SetActive(false)
			TH_GameMainCtrl:SetText(TH_GameMainPanel.txtRoomChange, "等待抢庄...")
			-- 下注状态
		elseif state == 4 then
			TH_GameMainPanel.imgIsBuPai:SetActive(false)
			TH_GameMainPanel.btnTitle:SetActive(false)
			TH_GameMainPanel.btnBet:SetActive(true)
			TH_GameMainCtrl:SetText(TH_GameMainPanel.txtRoomChange, "等待下注...")
			-- 亮牌状态
		elseif state == 5 then
			TH_GameMainPanel.btnBet:SetActive(false)
			TH_GameMainPanel.imgIsBuPai:SetActive(true)
			TH_GameMainPanel.imgBeiShu:SetActive(false)
			TH_GameMainPanel.btnHuanPai:SetActive(false)
			TH_GameMainPanel.btnBuHuan:SetActive(false)
			TH_GameMainPanel.btnShowPai:SetActive(true)
			TH_GameMainPanel.btnHintCard:SetActive(false)
			TH_GameMainPanel.btnPrepareButton:SetActive(false)
			TH_GameMainCtrl:SetText(TH_GameMainPanel.txtShowPai, "亮 牌")
			TH_GameMainCtrl:SetText(TH_GameMainPanel.txtRoomChange, "等待开牌...")
		elseif state == -1 then
			TH_GameMainPanel.imgClock:SetActive(false)
			TH_GameMainPanel.imgBeiShu:SetActive(false)
			TH_GameMainPanel.imgIsBuPai:SetActive(false)
			TH_GameMainPanel.btnTitle:SetActive(false)
			TH_GameMainPanel.btnBet:SetActive(false)
			TH_GameMainPanel.btnHuanPai:SetActive(false)
			TH_GameMainPanel.btnBuHuan:SetActive(false)
			TH_GameMainPanel.btnPrepareButton:SetActive(false)
			TH_GameMainCtrl:SetText(TH_GameMainPanel.txtRoomChange, "")
		end
		if state ~= 2 then
			for _, var in ipairs(curCache.cards) do
				if var.transform.localPosition.y >= 0 then
					var:PickDown()
				end
			end
		end
	else
		TH_GameMainPanel.btnWaitQuitRoom:SetActive(true)
	end
end

-- 收到断线重连消息
function NiuNiuRoom:OfflinePush(msg)
	print("===========NiuNiuRoom:OfflinePush========================")
	if not TH_GameMainCtrl.isCreate then return end
	local roleId = msg.roleId
	-- 断线（重连）roleId
	local state = msg.state
	-- true=上线  false=离线
	for i, v in ipairs(self.players) do
		if v.id == roleId then
			v.imgOffLine:SetActive(not state)
			break
		end
	end
end

-- 清理房间数据
function NiuNiuRoom:ClearRoomInfo()
	print("=====================NiuNiuRoom:ClearRoomInfo========================")
	for _, v in ipairs(self.players) do
		if v ~= nil then
			if v.obj ~= nil then
				v:Destroy()
			end
		end
	end
	self.players = { }
	for _, var in ipairs(self.watchPlayers) do
		if v ~= nil then
			if v.obj ~= nil then
				v:Destroy()
			end
		end
	end
	self.watchPlayers = { }
end

-- 清理观战玩家数据
function NiuNiuRoom:ClaernWatchPlayer(data)
	print("======================NiuNiuRoom:ClaernWatchPlayer=========================")
	for _, v in ipairs(data) do
		if v.obj ~= nil then
			v:ClearnImgLayer()
			v.obj:SetActive(false)
			v.imgWatching:SetActive(false)
			-- v.ClearnData()
		end
	end
	for i, v in ipairs(self.watchPlayers) do
		if (v ~= nil and v.obj ~= nil) then
			v.obj:SetActive(false)
		end
	end
	self.watchPlayers = { }
end

-- 生成观战玩家数据
function NiuNiuRoom:CreateWatchPlayer(data)
	print("=============================NiuNiuRoom:CreateWatchPlayer========================")
	for i, v in ipairs(data) do
		local obj = self.playerPanel.transform:FindChild("TH_imgHead" .. self:GetRoomIndexByIndex(v.index)).gameObject

		local playerObj = NiuNiuPlayer:New(v, obj)
		table.insert(self.watchPlayers, playerObj)
		if self.myIndex ~= playerObj.index then
			TH_GameMainCtrl:RemoveClick(playerObj.imgHead)
			TH_GameMainCtrl:AddClick(playerObj.imgHead, TH_GameMainCtrl.OnClickHead)
		else
			if not self.isAdd then
				TH_GameMainCtrl:AddClick(playerObj.imgHead, TH_GameMainCtrl.OnClickHead)
				self.isAdd = true
			end
		end
		playerObj.obj:SetActive(true)
	end
	for i, v in ipairs(self.watchPlayers) do
		if (v ~= nil and v.obj ~= nil) then
			v.obj:SetActive(true)
			TH_GameMainCtrl:SetText(v.txtName, v.name)
			TH_GameMainCtrl:SetText(v.txtScore, v.jifen)
			if v.imgOK ~= nil then
				v.imgOK:SetActive(false)
			end
			v.imgZhuang:SetActive(false)
			v.imgChat:SetActive(false)
			v.imgFaceIcon:SetActive(false)
			v.imgCardType:SetActive(false)
			v.imgBet:SetActive(false)
			if v.qiangBanker ~= nil then
				v.qiangBanker:SetActive(false)
			end
			if v.imgAnim ~= nil then
				v.imgAnim:SetActive(false)
			end
			if v.imgHead then
				v.imgHead.name = v.id
				if v.imgHead ~= nil and v.id ~= nil and v.url ~= nil and url ~= "" then
					weChatFunction.SetPic(v.imgHead, v.id, v.url)
				end
			else
				v.imgHead = BasePanel:GOChild(obj, "Mask/" .. v.id)
			end
			v.txtBet:SetActive(false)
			v.txtCoin:SetActive(false)
			v.imgOffLine:SetActive(false)
			-- 新添加
			v.imgYuanbao:SetActive(false)
			v.imgJinbi:SetActive(false)
			v.imgWatching:SetActive(true)
			TH_GameMainCtrl:SetText(v.txtBet, "观战")
			TH_GameMainPanel.btnWaitQuitRoom:SetActive(false)
			if self.RoomMsg.moneyType == RoomMode.goldMode then
				v.imgJinbi:SetActive(true)
				TH_GameMainCtrl:SetText(v.txtScore, v.goldcoin)
			elseif self.RoomMsg.moneyType == RoomMode.wingMode then
				v.imgYuanbao:SetActive(true)
				TH_GameMainCtrl:SetText(v.txtScore, v.wing)
			end
		end
	end
end

function NiuNiuRoom:OnReadyGame()
	print("=====================NiuNiuRoom:OnReadyGame====================")
	if TH_GameMainPanel.btnInvitationWeChat ~= nil then
		TH_GameMainPanel.btnInvitationWeChat:SetActive(false)
	end
	TH_GameMainPanel.btnGameStart:SetActive(false)
	TH_GameMainPanel.imgSettlementLost:SetActive(false)
	TH_GameMainPanel.imgSettlementWin:SetActive(false)
	TH_GameMainPanel.imgBeiShu:SetActive(false)
	TH_GameMainPanel.txtCurBet:SetActive(false)
	TH_GameMainPanel.btnChat:SetActive(false)
	TH_GameMainPanel.niuniuTip:SetActive(true)
	TH_GameMainPanel.btnHuanPai:SetActive(false)
	TH_GameMainPanel.btnShowPai:SetActive(false)
	TH_GameMainPanel.btnHintCard:SetActive(false)
	TH_GameMainPanel.btnBuHuan:SetActive(false)
	TH_GameMainPanel.imgHTWaitFriends:SetActive(true)
end

-- 观战玩家加入房间初始化房间信息
function NiuNiuRoom:WatchJoinRoom(msg)
	print("============================NiuNiuRoom:WatchJoinRoom===========================================")
	-- 房间
	data = ReLoad_pb.NiuniuReload()
	data:ParseFromString(msg.dataResForWait)
	dataRoomInfo = JoinRoom_pb.NiuNiuInfo()
	dataRoomInfo:ParseFromString(msg.dataRes)

	self.notVoice = true
	self.hasLoaded = false
	self.initPlayerEnd = false
	local roomVo = RoomNiuVo:New()
	roomVo.id = dataRoomInfo.roomNum
	roomVo.niuniuGameType = dataRoomInfo.niuniuGameType
	roomVo.maxNum = dataRoomInfo.maxNum
	roomVo.baseScore = dataRoomInfo.baseScore
	roomVo.special = dataRoomInfo.special
	roomVo.maxZhuang = dataRoomInfo.maxZhuang
	roomVo.maxPush = dataRoomInfo.maxPush
	roomVo.seniorInfo = dataRoomInfo.seniorInfo
	roomVo.doubleRule = dataRoomInfo.doubleRule
	-- 添加
	roomVo.baseNum = msg.baseNum
	roomVo.qualified = msg.qualified
	roomVo.moneyType = msg.moneyType
	self.RoomMsg = roomVo
	self.RoomMsg.totalJushu = dataRoomInfo.totalJushu

	NiuNiuRoom.RoomMsg.star = msg.star
	NiuNiuRoom.RoomMsg.costMoney = msg.costMoney
	NiuNiuRoom.RoomMsg.mcreenings = msg.mcreenings
	-- 当局
	self.roomState = data.curStatus
	self.alreadyJuShu = data.alreadyJuShu
	self.startGameZhuangIndex = data.zhuang
	-- 玩家
	self.playersData = { }
	self.players = { }
	-- self:ClearRoomInfo()
	for i, v in ipairs(data.roles) do
		local joinRoomUserVo = JoinRoomUserVo:New()
		joinRoomUserVo.index = v.roleIndex
		joinRoomUserVo.roleId = v.roleId
		joinRoomUserVo.name = v.name
		joinRoomUserVo.ip = v.ip
		joinRoomUserVo.headImg = v.headImg
		joinRoomUserVo.jifen = v.jifen
		joinRoomUserVo.gender = v.gender
		joinRoomUserVo.diamond = v.diamond
		joinRoomUserVo.isOnline = v.isOnline
		joinRoomUserVo.goldcoin = v.goldcoin
		joinRoomUserVo.wing = v.wing
		joinRoomUserVo.isLook = v.isLook

		self.playersData[v.roleIndex] = joinRoomUserVo
		if v.roleId == global.userVo.roleId then
			self.myIndex = v.roleIndex
		end
	end
	self.playerCount = #self.playersData
	-- 玩家的牌
	local co = coroutine.start( function()
		while not self.isPrefabLoaded do
			coroutine.step()
		end

		self:InitPlayers()
		self.curJushu = data.alreadyJuShu

		local cards, betCount
		local zhuangKai = false
		for i, role in ipairs(data.roles) do
			local spInfoa = ReLoad_pb.NiuniuRoleSpInfo()
			spInfoa:ParseFromString(role.spInfoRes)
			-- 详细信息
			local betCount = spInfoa.betCount
			local result = spInfoa.result
			local isShowCard = spInfoa.isShowCard
			local qiangBei = spInfoa.qiangBei
			local tuiBei = spInfoa.tuiBei

			if #spInfoa.roleCard ~= 0 then
				self:SetPlayerCards(i, spInfoa.roleCard, result, false)
			end
			if betCount > 0 then
				if self.startGameZhuangIndex ~= i then
					self:SetPlayerBet(i, betCount)
				end
				if i == self.myIndex then
					betCount = spInfoa.betCount
					cards = spInfoa.roleCard
				end
			end
		end
		self:GameStart(1)
		-- self:ChangeRoomState(data.curStatus)
		self:SetCurJushu(self.alreadyJuShu)
		-- 设置自己是否亮牌
		for j, k in ipairs(self.players) do
			local curCache = self:GetPlayer(k.index)
			if i == k.index then
				curCache.isShow = isShowCard
				if spInfo.betCount ~= 0 then
					curCache.isBet = true
					zhuangKai = true
				else
					curCache.isBet = false
				end
			end
			if self.startGameZhuangIndex == k.index then
				curCache.imgZhuang:SetActive(true)
				curCache.imgBet:SetActive(false)
				curCache.txtScore:SetActive(false)
			end
			if curCache.isLook ~= nil then
				if curCache.isLook then
					curCache.imgWatching:SetActive(true)
				end
			end
		end
		for _, v in ipairs(self.players) do
			if v.isLook then
				v.url = data.headImg
				if v.imgHead then
					v.imgHead.name = v.id
					if v.imgHead ~= nil and v.id ~= nil and v.url ~= nil and url ~= "" then
						weChatFunction.SetPic(v.imgHead, v.id, v.url)
					end
				else
					v.imgHead = BasePanel:GOChild(obj, "Mask/" .. v.id)
				end
			end
		end

		self.notVoice = false
		self.hasLoaded = true
	end )
	table.insert(Network.crts, co)
end