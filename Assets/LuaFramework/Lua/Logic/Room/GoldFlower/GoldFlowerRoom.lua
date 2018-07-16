GoldFlowerRoom = {
	RoomMsg = { },
	betObjList = { },
	-- 总下注实体列表
	addObjList = { },
	-- 加倍按钮
	btnObjList = { },
	-- 按钮列表
	lastIndex = 0,
	-- 上一个下注人的索引
	allBet = 0,
	-- 当前房间总注数
	allmenLun = 0,
	-- 当前房间闷轮数
	allbiLun = 0,
	-- 当前房间比轮数
	alltop = 0,
	-- 当前房间封顶轮数
	allJushu = 0,
	-- 总局数
	firstIndex = 0,
	-- 本局先手人的索引，用于计算轮数
	curLunshu = 0,
	-- 当前轮数
	spr_gray = nil,
	-- 灰色图片
	txt_gray = nil,
	-- 灰色文字
	over = false,
	curFen = 0,
}
setbaseclass(GoldFlowerRoom, { RoomObject })

-- 缓存
function GoldFlowerRoom.SaveGameObj(objs, name)
	print("GoldFlowerRoom.SaveGameObj")
	local self = GoldFlowerRoom
	if self.loadObjList[name] then return end
	self.loadObjList[name] = objs[0]
end

-- 加载
function GoldFlowerRoom:LoadGameObj(objs)
	print("GoldFlowerRoom:LoadGameObj")
	local GuiCamera = find('Canvas/GuiCamera')
	self.imgHead = BasePanel:GOChild(obj, "Mask/img")
	-- 获取数据
	GoldFlowerRoom.gameUI = newObject(objs)
	GoldFlowerRoom.gameUI.transform:SetParent(GuiCamera.transform)
	GoldFlowerRoom.gameUI.transform.localScale = Vector3.one
	GoldFlowerRoom.gameUI.transform.localPosition = Vector3.zero
	local table = find("Canvas/GuiCamera/Game(Clone)/Table/JinHuaTable/imgTable")
	local tenHalfTable = find("Canvas/GuiCamera/Game(Clone)/Table/JinHuaTable")
	tenHalfTable:SetActive(true)
	self.playerPanel = find("Canvas/GuiCamera/Game(Clone)/Players")
	self.playerPanel:SetActive(false)
	self.alltop = GoldFlowerRoom.RoomMsg.isTop
	self.allbiLun = GoldFlowerRoom.RoomMsg.isCompare
	self.allmenLun = GoldFlowerRoom.RoomMsg.isGuess
	self.allJushu = GoldFlowerRoom.RoomMsg.jinHuaTotal
	self.txtWanFa = BasePanel:GOChild(table, "imgRoomMessageBG/txtWanFa")
	self.imgJuShu = BasePanel:GOChild(table, "imgJuShu")
	self.txtPlayMathond = BasePanel:GOChild(table, "imgRoomMessageBG/txtPlayMathond")
	self.txtJuShu = BasePanel:GOChild(table, "imgRoomMessageBG/txtJuShu")
	self.txtRoomMessage = BasePanel:GOChild(table, "imgRoomMessageBG/txtRoomMessage")
	self.txtRoomNum = BasePanel:GOChild(table, "imgRoomMessageBG/txtRoomNum")
	self.txtMessage = BasePanel:GOChild(table, "imgRoomMessageBG/txtMessage")
    self.textZhuShu = BasePanel:GOChild(table,"imgRoomMessageBG/textZhuShu") --桌面中间的注数显示
    self.zhu = BasePanel:GOChild(table,"imgRoomMessageBG/zhu")--桌面中间的字
	self.common = BasePanel:GOChild(self.playerPanel, "Common")
	self.empty = BasePanel:GOChild(self.playerPanel, "Empty")
	-- 打开面板
	TH_GameMainCtrl:Open("TH_GameMain", function()
		for i = 1, 5 do
			local obj = self.playerPanel.transform:FindChild("TH_imgHead" .. i).gameObject
			obj:SetActive(false)
		end
		self:ResourceCheckOver()
	end )
	self.isSettlement = true
end

-- 初始化
function GoldFlowerRoom:InitPlayers()
	print("GoldFlowerRoom:InitPlayers")
	self.curJushu = 0

	local player = find("Canvas/GuiCamera/Game(Clone)/Players")
	-- 清理手牌和玩家
	for _, v in ipairs(self.players) do
		if v.obj ~= nil then
			v:Destroy()
		end
	end
	-- 清理筹码
	for _, v in ipairs(self.betObjList) do
		v:Destroy()
	end
	self.players = { }
	self.watchPlayers = { }
	self.betObjList = { }
	self.isSettlement = true
	for i = 1, 5 do
		local obj = player.transform:FindChild("TH_imgHead" .. i).gameObject
		obj:SetActive(false)
	end
	-- 桌面文字显示
	if Room.isStar then
		TH_GameMainCtrl:SetText(GoldFlowerRoom.txtRoomMessage, '观战中····')
	else
		TH_GameMainCtrl:SetText(GoldFlowerRoom.txtRoomMessage, '')
	end
	-- 初始化玩家信息
	for i = 1, self.playerCount do
		local obj = player.transform:FindChild("TH_imgHead" .. self:GetRoomIndexByIndex(i)).gameObject
		local playerObj = GoldFlowerPlayer:New(self.playersData[i], obj)
		table.insert(self.players, playerObj)
		if self.myIndex ~= playerObj.index then
			TH_GameMainCtrl:RemoveClick(playerObj.imgHead)
			TH_GameMainCtrl:AddClick(playerObj.imgHead, TH_GameMainCtrl.OnClickHead)
			TH_GameMainCtrl:RemoveClick(playerObj.imgCompare)
			TH_GameMainCtrl:AddClick(playerObj.imgCompare, playerObj.OnClickBiPai)
			TH_GameMainCtrl:RemoveClick(playerObj.btnLook)
			TH_GameMainCtrl:AddClick(playerObj.btnLook, playerObj.OnLookBtn)
		else
			if not self.isAdd then
				TH_GameMainCtrl:AddClick(playerObj.imgHead, TH_GameMainCtrl.OnClickHead)
				TH_GameMainCtrl:AddClick(playerObj.btnLook, playerObj.OnLookBtn)
				TH_GameMainCtrl:AddClick(playerObj.imgCompare, playerObj.OnClickBiPai)
				self.isAdd = true
			end
		end
		playerObj.obj:SetActive(true)
	end

	for i, v in ipairs(self.players) do
		v.obj:SetActive(true)
		TH_GameMainCtrl:SetText(v.txtName, v.name)
		--TH_GameMainCtrl:SetText(v.txtScore, v.jifen) --这行代码会导致房卡模式积分每次开始游戏都为0
		v.imgZhuang:SetActive(false)
		v.imgChat:SetActive(false)
		v.imgFaceIcon:SetActive(false)
		v.imgCardType:SetActive(true)
		v.imgBet:SetActive(false)
		v.imgCur:SetActive(false)
		v.imgDeng:SetActive(false)
		v.imgAnim:SetActive(false)
		v.imglookType:SetActive(false)
		v.imgGiveupMask:SetActive(false)
		v.imgGiveup:SetActive(false)
		v.imgCompare:SetActive(false)
		v.btnLook:SetActive(false)
		v.imgWatching:SetActive(false)
		-- 新添加
		v.imgYuanbao:SetActive(false)
		v.imgJinbi:SetActive(false)
		if self.RoomMsg.moneyType == RoomMode.goldMode then
			v.imgJinbi:SetActive(true)
			local goldTemp = v.goldcoin
			if goldTemp ~= nil then
				TH_GameMainCtrl:SetText(v.txtScore, formatNumber(goldTemp))
			end
		elseif self.RoomMsg.moneyType == RoomMode.wingMode then
			v.imgYuanbao:SetActive(true)
			TH_GameMainCtrl:SetText(v.txtScore, formatNumber(v.wing))
		end
	end
	if self.myIndex == 1 and #self.players > 1 then
		TH_GameMainPanel.btnGameStart:SetActive(true)
		if self.RoomMsg.moneyType == RoomMode.goldMode then
			TH_GameMainPanel.btnGameStart:SetActive(false)
		elseif self.RoomMsg.moneyType == RoomMode.wingMode then
			TH_GameMainPanel.btnGameStart:SetActive(false)
		end
	else
		TH_GameMainPanel.btnGameStart:SetActive(false)
	end
	player:SetActive(true)
	self.addObjList = {
		{ jifen = 2, btn = TH_GameMainPanel.btnJH2Bei:GetComponent("Button") },
		{ jifen = 3, btn = TH_GameMainPanel.btnJH3Bei:GetComponent("Button") },
		{ jifen = 4, btn = TH_GameMainPanel.btnJH4Bei:GetComponent("Button") },
		{ jifen = 5, btn = TH_GameMainPanel.btnJH5Bei:GetComponent("Button") }
	}
	self.btnObjList = {
		btnQipai =
		{
			btn = TH_GameMainPanel.btnJHQiPai:GetComponent("Button"),
			img = TH_GameMainPanel.btnJHQiPai:GetComponent("Image"),
			txt = BasePanel:GOChild(TH_GameMainPanel.btnJHQiPai,"Text"):GetComponent("Text"),
			spr = nil,
			color = nil
		},
		btnBipai =
		{
			btn = TH_GameMainPanel.btnJHBiPai:GetComponent("Button"),
			img = TH_GameMainPanel.btnJHBiPai:GetComponent("Image"),
			txt = BasePanel:GOChild(TH_GameMainPanel.btnJHBiPai,"Text"):GetComponent("Text"),
			spr = nil,
			color = nil
		},
		btnJiazhu =
		{
			btn = TH_GameMainPanel.btnJHJiaZhu:GetComponent("Button"),
			img = TH_GameMainPanel.btnJHJiaZhu:GetComponent("Image"),
			txt = BasePanel:GOChild(TH_GameMainPanel.btnJHJiaZhu,"Text"):GetComponent("Text"),
			spr = nil,
			color = nil
		},
		btnGenzhu =
		{
			btn = TH_GameMainPanel.btnJHGengZhu:GetComponent("Button"),
			img = TH_GameMainPanel.btnJHGengZhu:GetComponent("Image"),
			txt = BasePanel:GOChild(TH_GameMainPanel.btnJHGengZhu,"Text"):GetComponent("Text"),
			txtObj = BasePanel:GOChild(TH_GameMainPanel.btnJHGengZhu,"Text"),
			spr = nil,
			color = nil
		}
	}
	self.spr_gray = TH_GameMainPanel.btn_gray:GetComponent("Image").sprite
	self.txt_gray = Color.New(0.9, 0.9, 0.9, 0.9)
	self.over = false
	-- self:SetCurJushu(self.curJushu)
	BlockLayerCtrl:CloseSpec()
	self.initPlayerEnd = true

	local txt = '局数：' .. self.curJushu .. '/' .. tostring(self.allJushu) .. '局'
	local co = coroutine.start( function()
		while not TH_GameMainCtrl.isCreate do
			coroutine.step()
		end
		TH_GameMainCtrl:SetText(self.txtJuShu, txt)
		-- 新添加
		local textGoldFlowerBasenum = '底注：' .. tostring(GoldFlowerRoom.RoomMsg.baseNum)
		local textGoldFlowerQualified = tostring(GoldFlowerRoom.RoomMsg.qualified) .. '进' .. tostring(GoldFlowerRoom.RoomMsg.qualified) .. '出'
		if self.RoomMsg.moneyType == RoomMode.goldMode then
			TH_GameMainCtrl:SetText(self.txtJuShu, "")
		elseif self.RoomMsg.moneyType == RoomMode.wingMode then
			TH_GameMainCtrl:SetText(self.txtJuShu, "")
		end
	end )
	table.insert(Network.crts, co)
	self.canReceive = true
	-- 初始化的时候设定可以接收发牌的消息
end

-- 按钮变灰
function GoldFlowerRoom:BtnShow(name, bool)
	print("GoldFlowerRoom:BtnShow", name, bool)
	if bool then
		print(self.btnObjList[name].spr == nil)
		if self.btnObjList[name].spr == nil then
			print("543654365465")
			self.btnObjList[name].spr = self.btnObjList[name].img.sprite
			self.btnObjList[name].color = self.btnObjList[name].txt.color
		else
			print("safmgoysafhljbsdflakjn")
			self.btnObjList[name].img.sprite = self.btnObjList[name].spr
			self.btnObjList[name].txt.color = self.btnObjList[name].color
		end
	else
		if self.btnObjList[name].spr == nil then
			print("kasfyohbsfahboi")
			self.btnObjList[name].spr = self.btnObjList[name].img.sprite
			self.btnObjList[name].color = self.btnObjList[name].txt.color
		end
		self.btnObjList[name].img.sprite = self.spr_gray
		self.btnObjList[name].txt.color = self.txt_gray
	end
	self.btnObjList[name].btn.interactable = bool
end

-- 发一轮牌
function GoldFlowerRoom:DealCards(index)
	local self = GoldFlowerRoom
	print("GoldFlowerRoom:DealCards")
	self.isSettlement = false
	if self.RoomMsg.moneyType ~= 0 then
		self:NextGameStart()
	end
	local test_list = { }
	for i = 1, self.common.transform.childCount do
		local obj = self.common.transform:GetChild(i - 1)
		table.insert(test_list, obj)
	end
	for i, v in ipairs(test_list) do
		table.remove(test_list, i)
		v.transform.gameObject:Destroy()
	end
	self.hasLoaded = false
	Room.btnStartClick = false
	if self.RoomMsg.moneyType ~= 0 then
		TH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
	end
	-- 手牌张数，牌间距
	local k = index
	local card = { color = "" }
	local state = TenHalfCardState.KouCard
	local num = #self.players
	local co = coroutine.start( function()
		TH_GameMainPanel.imgPublicCard:SetActive(true)
		for i, v in ipairs(self.players) do
			for j = 1, 3 do
				v:GetPlayerCards(i, card, state)
				coroutine.wait(0.05)
			end
			if self.index == GoldFlowerRoom.myIndex then
				Game.MusicEffect(Game.Effect.thfapai1)
			end
			coroutine.wait(0.05)
		end
		TH_GameMainPanel.imgPublicCard:SetActive(false)
		-- coroutine.wait(0.3)
		for i, v in ipairs(self.players) do
			local targetPos = Vector3.New(Util.Random(-200, 200), Util.Random(20, -20), 0)
			v:BetAnim(1, targetPos)
			self.allBet = self.allBet + v.allbetCount --/*********v.allbetCount为nil***********/--
			coroutine.wait(0.05)
		end
		coroutine.wait(0.1)
		Game.MusicEffect(Game.Effect.chouma)
		self.lastIndex = index
		self.curLunshu = 0
		self.operateIndex = index
		-- 庄家的下一位显示分数面板
		if index >= num then
			index = 1
		else
			index = index + 1
		end
		self.firstIndex = index

		self:GoNextPlayer(self.firstIndex)
		TH_GameMainPanel.imgJHCompareOrBet:SetActive(true)
		self:KuangShow(self.operateIndex)
		self:RefreshWanfa(self.curLunshu, self.myIndex)
		self:SetGenZhuTxt()
		self.hasLoaded = true
	end )
	table.insert(Network.crts, co)
end

-- 下一位
function GoldFlowerRoom:GoNextPlayer(index)
	print("GoldFlowerRoom:GoNextPlayer", self.curLunshu, self.allmenLun, self.allbiLun)
	self.operateIndex = index
	if self.over then print("Error:--------------self.over == true") return end
	self:KuangShow(self.operateIndex)
	self:BtnShow('btnQipai', false)
	self:BtnShow('btnBipai', false)
	self:BtnShow('btnGenzhu', false)
	self:BtnShow('btnJiazhu', false)
	local curPlayer = self:GetPlayer(index)
	if self.operateIndex == self.myIndex then
		-- 当前轮数大于闷牌轮数
		if self.curLunshu > self.allmenLun then
			if curPlayer.isLook then return end
			if curPlayer.kanpaiFlag == false then
				if curPlayer.qipaiFlag == false then
					curPlayer.btnLook:SetActive(true)
					-- 看牌
				end
			end
		end
		-- 当前轮数大于比牌轮数
		if self.curLunshu > self.allbiLun then
			if not curPlayer.qipaiFlag then
				-- 闷牌轮数达到后才能比牌
				if self.curLunshu > self.allmenLun then
					self:BtnShow('btnBipai', true)
					-- 比牌
				end
			end
		end
		self:BtnShow('btnGenzhu', true)
		-- 跟注
		self:BtnShow('btnQipai', true)
		-- 弃牌
		if self.curFen == 5 or self.curFen == 10 or self.curFen == 20 then
			-- 比牌双倍所以有20
			self:BtnShow('btnJiazhu', false)
			-- 加注false
		else
			self:BtnShow('btnJiazhu', true)
			-- 加注true
		end
	end

	local curCache = self:GetPlayer(self.myIndex)
	if curCache.qipaiFlag then
		TH_GameMainPanel.imgJHCompareOrBet:SetActive(false)
	else
		if curCache.isLook == false then
			TH_GameMainPanel.imgJHGameMain:SetActive(true)
			TH_GameMainPanel.imgJHCompareOrBet:SetActive(true)
		else
			TH_GameMainPanel.imgJHGameMain:SetActive(false)
			TH_GameMainPanel.imgJHCompareOrBet:SetActive(false)
		end
	end
	if self.curLunshu > self.allmenLun then
		-- 看牌
		if curCache.kanpaiFlag == false then
			if curCache.qipaiFlag == false then
				curCache.btnLook:SetActive(true)
			end
		end
	end
end

-- 重置当前索引位
function GoldFlowerRoom:ReSetOperate(index)
	print("GoldFlowerRoom:ReSetOperate")
	local curIndex = 0
	if index == 0 then
		curIndex = self.operateIndex + 1
	else
		curIndex = index
	end
	if curIndex > #self.players then
		curIndex = 1
	end
	self.operateIndex = curIndex
end

-- 显示操作框
function GoldFlowerRoom:KuangShow(index, bool)
	local show = true
	if bool then
		show = false
	end
	for i, v in ipairs(self.players) do
		if v.index == index then
			if v.isLook == false then
				print("GoldFlowerRoom:KuangShow", v.isLook)
				v.imgCur:SetActive(show)
				local img = v.imgCur:GetComponent("Image")
				TH_GameMainCtrl:ChangeKuang(img, v.index)
			end
		else
			v.imgCur:SetActive(not show)
		end
	end
end

--断线重连
function GoldFlowerRoom:Reload(data)
	print("GoldFlowerRoom:Reload")
	-- 接收数据
	self.notVoice = true
	self.hasLoaded = false
	self.initPlayerEnd = false
	self.isSettlement = false
	local roomVo = RoomJinHuaVo:New()
	roomVo.id = data.roomNum
	roomVo.jinHuaTotal = data.jinHuaTotal
	roomVo.jinHuaPlayMethond = data.playMethond
	roomVo.isLeopard = data.isLeopard and 1 or 0
	roomVo.isDouble = data.isDouble and 1 or 0
	roomVo.isTop = data.isTop
	roomVo.isCompare = data.isCompare
	roomVo.isGuess = data.isGuess
	-- 添加
	roomVo.baseNum = data.baseNum
	roomVo.qualified = data.qualified
	roomVo.moneyType = data.moneyType
	-- data.zhuang
	self.RoomMsg = roomVo
	self.playersData = { }
	self.players = { }
	self.watchPlayers = { }
	local curEnd = data.curEnd
	self:ClearRoomInfo()
	for i, v in ipairs(data.roles) do
		local joinRoomUserVo = JoinRoomUserVo:New()
		joinRoomUserVo.index = v.roleIndex;
		joinRoomUserVo.roleId = v.roleId;
		joinRoomUserVo.name = v.name;
		joinRoomUserVo.ip = v.ip;
		joinRoomUserVo.headImg = v.headImg;
		joinRoomUserVo.jifen = v.jifen;
		joinRoomUserVo.gender = v.gender;
		joinRoomUserVo.diamond = v.diamond;
		joinRoomUserVo.isOnline = v.isOnline;
		-- 新添加
		joinRoomUserVo.goldcoin = v.goldcoin
		-- 金币数量
		joinRoomUserVo.wing = v.wing
		-- 元宝数量

		local placeMsg = v.locationInfo;
		local strArray
		strArray = string_split(placeMsg, "/")
		global.gpsMsgInfo[tostring(v.roleId)] = { strArray[1], tonumber(strArray[2]), tonumber(strArray[3]) }
		self.playersData[v.roleIndex] = joinRoomUserVo
		if v.roleId == global.userVo.roleId then
			self.myIndex = v.roleIndex
		end
	end
	self.playerCount = #self.playersData
	self.startGameZhuangIndex = data.zhuang

	-- 设置
	local co = coroutine.start( function()
		while not self.isPrefabLoaded do
			coroutine.step()
		end
		-- 设置房间信息
		TH_GameMainPanel.imgHTWaitFriends:SetActive(false)
		--if curCache.isLook == false then --加的观战判定
		--	TH_GameMainPanel.imgJHGameMain:SetActive(true)
		--else
		--	TH_GameMainPanel.imgJHGameMain:SetActive(false)
		--end
		TH_GameMainPanel.btnGameMainQuitRoom:SetActive(true)
		-- 新添加
		if self.RoomMsg.moneyType ~= 0 then
			TH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
		end
		TH_GameMainPanel.btnChat:SetActive(true)
		TH_GameMainPanel.imgSignalBG:SetActive(false)

		self:InitPlayers()
		self.curJushu = data.alreadyJuShu
		self.allJushu = data.jinHuaTotal
		self.alltop = data.isTop
		self.allmenLun = data.isGuess
		self.allbiLun = data.isCompare
		self.allBet = data.allbetCount
		self.curLunshu = data.curLunShu
		self:SetCurJushu(self.curJushu)
		local num = #self.players
		local index = data.curIndex
		local curIndex = data.curIndex
		local zhuangIndex = data.zhuang
		local lastKanpaiFlag = data.upPourFlag
		-- 上一位玩家索引
		self.lastIndex = data.upIndex
		if self.lastIndex == 0 then
			if index <= 1 then
				index = num
			else
				index = index - 1
			end
			self.lastIndex = index
		end
		self:ReSetOperate(self.lastIndex)
		self:GetPlayer(self.lastIndex).betMengFlag = lastKanpaiFlag --上一个玩家是否看牌
		-- 设置玩家信息
		local qipaiNum = 0
		for i, role in ipairs(data.roles) do
			local curCache = self:GetPlayer(i)
			local spInfo = ReLoad_pb.GoldFlowerRoleSpInfo()
			spInfo:ParseFromString(role.spInfoRes)
			curCache.kanpaiFlag = spInfo.isLookCard
			curCache.qipaiFlag = spInfo.isGiveUp
			curCache.mengpaiFlag = spInfo.isLookCard
			curCache.bipaiFlag = spInfo.isCompare
			if curCache.qipaiFlag then
				qipaiNum = qipaiNum + 1
			end
		end
		for i, role in ipairs(data.roles) do
			-- 空牌
			local card = { { id = - 1 }, { id = - 1 }, { id = - 1 } }
			local spInfo = ReLoad_pb.GoldFlowerRoleSpInfo()
			spInfo:ParseFromString(role.spInfoRes)
			-- 设置看牌提示
			local curCache = self:GetPlayer(i)
			-- 弃牌
			if curCache.qipaiFlag then
				if curCache.bipaiFlag then
					if spInfo.roleCard[1].id ~= -1 then
						curCache:CreateListCards(i, spInfo.roleCard, TenHalfCardState.BaoCard)
					else
						curCache:CreateListCards(i, card, TenHalfCardState.KouCard)
					end
					curCache:GiveUp("比牌输")
					curCache:LookAnim()
				else
					curCache:GiveUp("弃牌")
					if curCache.index == self.myIndex then
						if spInfo.roleCard[1].id ~= -1 then
							curCache:CreateListCards(i, spInfo.roleCard, TenHalfCardState.BaoCard, "gray")
						else
							curCache:CreateListCards(i, card, TenHalfCardState.KouCard, "gray")
						end
						if curCache.kanpaiFlag then
							curCache:LookAnim()
						end
					end
				end
			else
				-- 看牌
				if curCache.kanpaiFlag then
					curCache:GiveUp("已看牌")
					if spInfo.roleCard[1].id ~= -1 then
						if qipaiNum == #self.players - 1 then
							curCache:CreateListCards(i, card, TenHalfCardState.KouCard)
						else
							curCache:CreateListCards(i, spInfo.roleCard, TenHalfCardState.FanKaiCard)
						end
					else
						curCache:CreateListCards(i, card, TenHalfCardState.KouCard)
					end
					curCache:LookAnim()
				else
					curCache:CreateListCards(i, card, TenHalfCardState.KouCard)
				end
			end
			curCache:SetCardType(spInfo.result, curCache.index)
			-- 设置筹码
			if not curEnd then
				local betJifen = 0
				for i, v in ipairs(spInfo.bets) do  --玩家下注的集合
					if v > 10 then
						--betJifen = v / 2
						betJifen = v * 0.5
						local targetPos = Vector3.New(Util.Random(-200, 200), Util.Random(20, -20), 0)
						curCache:BetAnim(betJifen, targetPos, true)  --扔的筹码
					else
						local targetPos = Vector3.New(Util.Random(-200, 200), Util.Random(20, -20), 0)
						curCache:BetAnim(v, targetPos, true)    --扔的筹码
					end
					coroutine.wait(0)
				end
			else
				curCache.imgGiveup:SetActive(false)
			end
			-- 庄
			if zhuangIndex == curCache.index then
				curCache.imgZhuang:SetActive(true)
			end
		end
		self.curFen = self:GetPlayer(self.lastIndex).curbetCount
		coroutine.wait(0.1)
		self:RefreshWanfa(self.curLunshu, data.curIndex)
		self:GoNextPlayer(curIndex)
		-- 设置加注按钮显示
		if self.operateIndex == self.myIndex then
			local addJifen = self:GetPlayer(self.lastIndex).curbetCount
			if addJifen > 5 then
				addJifen = addJifen / 2
			end
			for i, v in ipairs(self.addObjList) do
				if addJifen >= v.jifen then
					v.btn.interactable = false
				else
					v.btn.interactable = true
				end
			end
		end
		-- 查找庄的下一位玩家--先手
		local first = zhuangIndex
		if first >= num then
			first = 1
		else
			first = first + 1
		end
		self:SetGenZhuTxt() --上家是否看牌
		self.firstIndex = first
		self.notVoice = false
		self.hasLoaded = true
		if self.RoomMsg.moneyType == 0 then
			Room:SetGps(data.roles)
		end
	end )
	table.insert(Network.crts, co)
end

function GoldFlowerRoom:SetCurJushu(curJushu)
	print("GoldFlowerRoom:SetCurJushu")
	local totalJushu = self.allJushu
	local txt = '局数：' .. curJushu .. '/' .. tostring(totalJushu) .. '局'
	if TH_GameMainCtrl.isCreate then
		TH_GameMainCtrl:SetText(self.txtJuShu, txt)
		-- 新添加
		local textGoldFlowerBasenum = '底注：' .. tostring(GoldFlowerRoom.RoomMsg.baseNum)
		local textGoldFlowerQualified = tostring(GoldFlowerRoom.RoomMsg.qualified) .. '进' .. tostring(GoldFlowerRoom.RoomMsg.qualified) .. '出'
		if self.RoomMsg.moneyType == RoomMode.goldMode then
			TH_GameMainCtrl:SetText(self.txtJuShu, "")
		elseif self.RoomMsg.moneyType == RoomMode.wingMode then
			TH_GameMainCtrl:SetText(self.txtJuShu, "")
		end
	end
end

-- 初始化清理
function GoldFlowerRoom:NextGameStart()
	print("GoldFlowerRoom:NextGameStart")
	self.operateIndex = 0
	self.allBet = 0
	self.lastIndex = 0
	self.firstIndex = 0
	self.curLunshu = 1
	self.betObjList = { }
	self.over = false
	self.curFen = 0
	TH_GameMainCtrl.isCanClick = true
	TH_GameMainPanel.txtCurBet:SetActive(false)
	TH_GameMainPanel.imgFace:SetActive(false)
	TH_GameMainPanel.imgJHCompareOrBet:SetActive(false)
	TH_GameMainCtrl.vsIndex = 0
	TH_GameMainCtrl.lookName = 0
	for i, v in ipairs(self.addObjList) do
		v.btn.interactable = true
	end
	for i, v in ipairs(self.players) do
		v.obj:SetActive(true)
		v.imgOK:SetActive(false)
		v.imgZhuang:SetActive(false)
		v.imgChat:SetActive(false)
		v.imgFaceIcon:SetActive(false)
		-- v.imgCardType:SetActive(false)
		v.imgGiveupMask:SetActive(false)
		v.imglookType:SetActive(false)
		v.imgGiveup:SetActive(false)
		v.imgCompare:SetActive(false)
		v.btnLook:SetActive(false)
		v.imgBet:SetActive(false)
		v.imgCur:SetActive(false)
		v.cardFlag = false
		v.curbetCount = 0
		v.allbetCount = 0
		v.qipaiFlag = false
		v.kanpaiFlag = false
		v.mengpaiFlag = false
		v.bipaiFlag = false
		v.betNum = 0
		v.cardsInfo = nil
		v.betMengFlag = false
		for i, v in ipairs(v.cards) do
			v:Destroy()
		end
		v.cards = { }
	end
end

-- 收到服务器开始游戏消息
function GoldFlowerRoom.OnStartGameRes(buffer)
	print("GoldFlowerRoom.OnStartGameRes")
	TH_GameMainPanel.btnWaitQuitRoom:SetActive(false) --亮色
	TH_GameMainPanel.imgNotWaitQuitRoom:SetActive(true) --灰色
	local self = GoldFlowerRoom
	if self.canReceive == true then
		self.canReceive = false
		-- 优化重复接收消息多发一次牌的情况
		local data = buffer:ReadBuffer()
		local msg = IntTypeReturn_pb.IntTypeReturnRes()
		msg:ParseFromString(data)
		local zhuangIndex = msg.intVal
		self.startGameZhuangIndex = zhuangIndex
		self.operateIndex = zhuangIndex
		TH_GameMainPanel.imgHTWaitFriends:SetActive(false)
		if self:GetPlayer(self.myIndex).isLook then
			TH_GameMainPanel.imgJHGameMain:SetActive(false)
		else
			TH_GameMainPanel.imgJHGameMain:SetActive(true)
		end
		TH_GameMainPanel.btnGameMainQuitRoom:SetActive(true)

		for i, v in ipairs(self.players) do
			v.imgOK:SetActive(false)
		end
		-- 新添加
		if self.RoomMsg.moneyType ~= 0 then
			TH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
		end
		TH_GameMainPanel.btnChat:SetActive(true)
		TH_GameMainPanel.imgSignalBG:SetActive(false)
		self.curJushu = 1
		self:SetCurJushu(self.curJushu)
		self:DealCards(zhuangIndex)
		self:GetPlayer(zhuangIndex).imgZhuang:SetActive(true)
		TH_GameMainCtrl:DisableClock()
	end
end

-- 加注
function GoldFlowerRoom.GoldAddJifenReq(info, flag)
	print("******************GoldAddJifenReq*****************",info)
	print("GoldFlowerRoom.GoldAddJifenReq")
	local self = GoldFlowerRoom
	local data = GoldAddJifen_pb.GoldAddJifenReq()
	if self.lastIndex ~= 0 then
		if flag == "add" then
			local curCache = self:GetPlayer(self.myIndex)
			if curCache.kanpaiFlag then
				data.addJifen = info * 2				
			else
				data.addJifen = info				
			end
			data.gen = 2
		elseif flag == "follow" then
			local lastCache = self:GetPlayer(self.lastIndex)
			local myCache = self:GetPlayer(self.myIndex)
			local lastJifen = 0
			-- lastCache.mengpaiFlag = lastCache.kanpaiFlag
			if myCache.kanpaiFlag then
				if lastCache.betMengFlag then
					data.addJifen = lastCache.curbetCount
					print("******************kanpai**data.addJifen***************",data.addJifen)
				else
					data.addJifen = lastCache.curbetCount * 2
					print("******************notkanpai**data.addJifen***************",data.addJifen)
				end
			else
				if lastCache.betMengFlag then
					data.addJifen = lastCache.curbetCount / 2
				else
					data.addJifen = lastCache.curbetCount
				end
			end
			data.gen = 1
		end
	end

	local msg = data:SerializeToString()
	Game.SendProtocal(Protocal.GoldAddBet, msg)
end

--加注消息返回
function GoldFlowerRoom.GoldAddJifenRes(buffer)
	print("GoldFlowerRoom.GoldAddJifenRes")
	TH_GameMainCtrl.isCanClick = true
	local self = GoldFlowerRoom
	local data = buffer:ReadBuffer()
	local msg = GoldAddJifen_pb.GoldAddJifenRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	local addJifen = msg.addJifen
	local genType = msg.gen
	local nextIndex = msg.nextOpIndex
	local lunShu = msg.lunshu
	self.allBet = self.allBet + addJifen   --得到总注数
	self.curFen = addJifen
	local curCache = self:GetPlayer(roleIndex)
	curCache.betMengFlag = curCache.kanpaiFlag
	if not msg.stoc then  --如果不是服务器主动推送
		self.lastIndex = roleIndex
		local targetPos = Vector3.New(Util.Random(-200, 200), Util.Random(20, -20), 0)
        
        --新添加设置加注不能大于10(2018.1.05)
        if addJifen >10 then
           addJifen = addJifen * 0.5
        end
		curCache:BetAnim(addJifen, targetPos) --扔筹码
		curCache.mengpaiFlag = curCache.kanpaiFlag
		self:RefreshWanfa(self.curLunshu, roleIndex)
		for i, v in ipairs(self.addObjList) do
			if addJifen >= v.jifen then
				if addJifen > 5 then
					if addJifen / 2 >= v.jifen then
						v.btn.interactable = false
					else
						v.btn.interactable = true

					end
				else
					v.btn.interactable = false
				end
			else
				v.btn.interactable = true
			end
		end
		if roleIndex ~= self.myIndex then
			self:SetGenZhuTxt()
		end
		if genType ~= 3 then
			self.curLunshu = lunShu
			self:RefreshWanfa(self.curLunshu)
			self:GoNextPlayer(nextIndex)
		end
	end
	if genType == 1 then  --跟注
		Game.MusicEffect(Game.Effect.genzhu)
	elseif genType == 2 then --加注
		Game.MusicEffect(Game.Effect.jiazhu)
	elseif genType == 3 then --比牌
		Game.MusicEffect(Game.Effect.bipai)
		local betJifen = 0
		if addJifen > 5 then
			betJifen = addJifen / 2
			local targetPos = Vector3.New(Util.Random(-200, 200), Util.Random(20, -20), 0)
			curCache:BetAnim(betJifen, targetPos)
			local targetPos = Vector3.New(Util.Random(-200, 200), Util.Random(20, -20), 0)
			curCache:BetAnim(betJifen, targetPos)
		else
			local targetPos = Vector3.New(Util.Random(-200, 200), Util.Random(20, -20), 0)
			curCache:BetAnim(addJifen, targetPos)
		end
		self:RefreshWanfa(self.curLunshu, roleIndex)
	end
end

-- 设置跟注文本
function GoldFlowerRoom:SetGenZhuTxt()
	print("GoldFlowerRoom:SetGenZhuTxt")
	local genFen = 0
	local lastCache = self:GetPlayer(self.lastIndex)
	local myCache = self:GetPlayer(self.myIndex)
	if myCache.kanpaiFlag then  
		if lastCache.betMengFlag then 
			genFen = lastCache.curbetCount  
		else   
			genFen = lastCache.curbetCount * 2 
		end
	else 
		if lastCache.betMengFlag then
			genFen = lastCache.curbetCount / 2 
		else
			genFen = lastCache.curbetCount   
		end
	end
    
    --新添加跟注数不能大于10(2018.1.05)
    if genFen > 10 then 
       genFen = genFen * 0.5
    end
	TH_GameMainCtrl:SetText(self.btnObjList["btnGenzhu"].txtObj, "跟注 X " .. genFen)
end
-- 弃牌
function GoldFlowerRoom.OnQiPaiRes(buffer)
	print("GoldFlowerRoom.OnQiPaiRes")
	local self = GoldFlowerRoom
	local data = buffer:ReadBuffer()
	local msg = GoldLoseCard_pb.GoldLoseCardRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	local nextIndex = msg.nextOpIndex
	local lunShu = msg.lunshu
	local curCache = self:GetPlayer(roleIndex)
	curCache:GiveUp("弃牌")
	curCache.qipaiFlag = true
	curCache.btnLook:SetActive(false)
	self.curLunshu = lunShu
	self:RefreshWanfa(self.curLunshu)
	self:GoNextPlayer(nextIndex)
	Game.MusicEffect(Game.Effect.qipai)
	-- TH_GameMainPanel.imgFace:SetActive(true)
	local co = coroutine.start( function()
		coroutine.wait(3)
		TH_GameMainPanel.imgFace:SetActive(false)
	end )
	table.insert(Network.crts, co)

end

-- 看牌
function GoldFlowerRoom.GoldLookCard()
	print("GoldFlowerRoom.GoldLookCard")
	local msg = ""
	Game.SendProtocal(Protocal.GoldLookCard, msg)
end

function GoldFlowerRoom.GoldLookCardRes(buffer)
	print("GoldFlowerRoom.GoldLookCardRes")
	local self = GoldFlowerRoom
	local data = buffer:ReadBuffer()
	local msg = GoldLookCard_pb.GoldLookCardRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	local cardInfo = msg.cardInfo
	local cardType = msg.cardType
	local curCache = self:GetPlayer(roleIndex)
    
    print("*********************cardInfo*************************", #cardInfo)
    print("*********************cardInfo*************************", #cardInfo)
    print("*********************cardInfo*************************", #cardInfo)
    if #cardInfo > 3 then
    	return
    end

	if curCache.index == self.myIndex then
		curCache.kanpaiFlag = true
		curCache.btnLook:SetActive(false)
		curCache:GiveUp("已看牌")
		local state = TenHalfCardState.FanKaiCard
		state = TenHalfCardState.FanKaiCard
		curCache:CreateListCards(roleIndex, cardInfo, state) --/******有时会生成6张牌*******/--
		curCache:LookAnim()
	else
		curCache:GiveUp("已看牌")
		curCache.kanpaiFlag = true
		curCache:LookAnim()
	end
	curCache:SetCardType(cardType, roleIndex)
	self:SetGenZhuTxt()  --看牌返回的时候刷新一下跟注
	Game.MusicEffect(Game.Effect.kanpai)
end

-- 比牌
function GoldFlowerRoom.GoldVSCardReq(info)
	print("GoldFlowerRoom.GoldVSCardReq")
	local self = GoldFlowerRoom
	local data = GoldVSCard_pb.GoldVSCardReq()
	data.targetIndex = tonumber(info)
	local msg = data:SerializeToString()
	Game.SendProtocal(Protocal.GoldVSCard, msg)
	for i, v in ipairs(self.players) do
		v.imgCompare:SetActive(false)
	end
	TH_GameMainPanel.btnBack:SetActive(false)
	TH_GameMainPanel.imgJHCompareOrBet:SetActive(false)
end

-- 比牌返回
function GoldFlowerRoom.GoldVSCardRes(buffer)
	print("GoldFlowerRoom.GoldVSCardRes")
	local self = GoldFlowerRoom
	local data = buffer:ReadBuffer()
	local msg = GoldVSCard_pb.GoldVSCardRes()
	msg:ParseFromString(data)
	local winIndex = msg.winIndex
	local loseIndex = msg.loseIndex
	local nextIndex = msg.nextOpIndex
	local biIndex = msg.zhudongRoleIndex
	local lunShu = msg.lunshu
	self.curLunshu = lunShu
	self:RefreshWanfa(self.curLunshu)
	self:VSAnim(winIndex, loseIndex, biIndex, nextIndex)


	self:GoNextPlayer(nextIndex)
	-- 其他玩家比牌后，刷新按钮，显示正确的按钮
end

-- 每局结算
function GoldFlowerRoom.GoldSingleSettlementRes(buffer)
	print("GoldFlowerRoom.GoldSingleSettlementRes")
	local self = GoldFlowerRoom
	self.allBet = 0 --每局结算的时候清理本局加的注数
	self.canReceive = true
	-- 每局结算的时候设定可以接收发牌的消息
	local islookPlayer = self:GetPlayer(self.myIndex);
	if islookPlayer ~= nil then
		if islookPlayer.isLook then return end
	end
	local data = buffer:ReadBuffer()
	local msg = GoldSingleSettlement_pb.GoldSingleSettlementRes()
	msg:ParseFromString(data)
	-- ****************************************************************
	self:RefreshWanfa(0, self.myIndex)
	----新添加，当前轮数重置为0，

	self.over = true
	if self.RoomMsg.moneyType ~= 0 then --0是房卡模式
		TH_GameMainPanel.imgHTWaitFriends:SetActive(true)
		TH_GameMainPanel.btnChat:SetActive(false)
		TH_GameMainPanel.btnSettleQuitGame:SetActive(true)

	end
    
    for k, v in pairs(self.btnObjList) do
	-- 每局结算的时候清理一下按钮spr
		v.img.sprite = v.spr
		v.spr = nil
		v.color = nil
	end

	TH_GameMainPanel.imgJHCompareOrBet:SetActive(false)
	local settlementInfo = msg.settlementInfo
	local endType = msg.endType
	if DissolutionRoomCtrl.gameOver then
		TH_GameMainPanel.btnSettleStartGame:SetActive(false)
	end
	if self.curJushu == self.allJushu then
		TH_GameMainPanel.btnSettleStartGame:SetActive(false)
	end
	TH_GameMainPanel.imgJHCompareOrBet:SetActive(false)
	TH_GameMainPanel.txtCurBet:SetActive(false)
	TH_GameMainPanel.imgLoseAnim:SetActive(false)
	if DissolutionRoomCtrl.gameOver then return end
	local co = coroutine.start( function()
		-- 2人封顶比牌
		local list = { }
		local num = 0
		local qipaiNum = 0
		for i, v in ipairs(self.players) do
			if not v.qipaiFlag then
				num = num + 1
				table.insert(list, v)
			else
				qipaiNum = qipaiNum + 1
			end
		end
		if endType == 3 then
			if num == 2 then
				local winIndex, loseIndex = 0
				if msg.settlementInfo[list[1].index].curJiFen > 0 then
					winIndex = list[1].index
					loseIndex = list[2].index
				else
					winIndex = list[2].index
					loseIndex = list[1].index
				end
				self:VSAnim(winIndex, loseIndex)
				coroutine.wait(1)
			end
		end
		if endType == 1 then
			coroutine.wait(1.3)
		end
		for i, v in ipairs(msg.settlementInfo) do
			local curCache = self:GetPlayer(v.roleIndex)
			if v.curJiFen > 0 then
				curCache:ReciveBetAnim(self.betObjList, curCache.obj)
			end
		end
		-- 每局结算
		for i, v in ipairs(msg.settlementInfo) do
			local curCache = self:GetPlayer(v.roleIndex)
			if curCache.isLook then return end
			curCache.btnLook:SetActive(false)
			curCache:SetCardType(v.cardType)
			if v.curJiFen > 0 then
				if curCache.index == self.myIndex then
					if not curCache.qipaiFlag then
						if not curCache.kanpaiFlag then
							curCache:CreateListCards(v.roleIndex, v.cardInfo, 2)
							curCache:LookAnim()
						end
					end
				else
					if qipaiNum == #self.players - 1 then
						curCache.imglookType:SetActive(false)
					else
						curCache:CreateListCards(v.roleIndex, v.cardInfo, 2)
						curCache:LookAnim()
					end
				end
			else
				if curCache.index == self.myIndex then
					if not curCache.qipaiFlag then
						if not curCache.kanpaiFlag then
							if #v.cardInfo ~= 1 then
								curCache:CreateListCards(v.roleIndex, v.cardInfo, 3)
								curCache:LookAnim()
							end
						end
					end
				else
					if #v.cardInfo == 1 then
						if curCache.index == self.myIndex then
							local card = { { id = - 1 }, { id = - 1 }, { id = - 1 } }
							curCache:CreateListCards(v.roleIndex, card, 1, "gray")
						end
					else
						if curCache.qipaiFlag then
							curCache.imglookType:SetActive(false)
						else
							curCache:CreateListCards(v.roleIndex, v.cardInfo, 3)
							curCache:LookAnim()
						end
					end
				end
			end

			curCache.imgGiveup:SetActive(false)

			-- if #v.cardInfo ~= 1 then
			--     curCache.imglookType:SetActive(true)
			-- else
			--     curCache.imglookType:SetActive(false)
			-- end
		end
		Game.MusicEffect(Game.Effect.chouma)
		if self.RoomMsg.moneyType == 0 then
			coroutine.wait(1)
		end

		-- 玩家积分赋值
		for i, v in ipairs(msg.settlementInfo) do
			local player = self:GetPlayer(v.roleIndex)
			if player.isLook then return end
			if self.RoomMsg.moneyType == RoomMode.goldMode then --金币场
				player.jifen = formatNumber(player.goldcoin + v.curJiFen)
			elseif self.RoomMsg.moneyType == RoomMode.wingMode then --元宝场
				player.jifen = formatNumber(player.wing + v.curJiFen)
			else                                                    --房卡场
				player.jifen = v.jiFen  --头像底下的总积分
			end
			-- player.jifen = v.jiFen
			TH_GameMainCtrl:SetText(player.txtScore, player.jifen)
			if v.roleIndex == self.myIndex then
				if v.curJiFen > 0 then
					Game.MusicEffect(Game.Effect.shengli)
					TH_GameMainPanel.imgSettlementLost:SetActive(false)
					TH_GameMainPanel.imgSettlementWin:SetActive(true)
					TH_GameMainPanel.imgSettlementWin.transform.localScale = Vector3.zero
					self:DoScale(TH_GameMainPanel.imgSettlementWin)
				else
					Game.MusicEffect(Game.Effect.shibai)
					TH_GameMainPanel.imgSettlementWin:SetActive(false)
					TH_GameMainPanel.imgSettlementLost:SetActive(true)
					TH_GameMainPanel.imgSettlementLost.transform.localScale = Vector3.zero
					self:DoScale(TH_GameMainPanel.imgSettlementLost)
				end
				TH_GameMainCtrl:NumberShow(v.curJiFen)
			end
		end
		TH_GameMainPanel.imgHTSingleSettlement:SetActive(true)
		self.isSettlement = true
		coroutine.wait(2)
	end )
	table.insert(Network.crts, co)

	TH_GameMainPanel.btnWaitQuitRoom:SetActive(true) --亮色
	TH_GameMainPanel.imgNotWaitQuitRoom:SetActive(false) --灰色

	--[[local co = coroutine.start( function()
		if TH_GameMainPanel.imgHTSingleSettlement then
			while not TH_GameMainPanel.imgHTSingleSettlement.activeSelf do
				coroutine.step()
			end
			coroutine.wait(2)
			-- 延迟2秒
			local msg = ""
			Game.SendProtocal(Protocal.EndGameShowPai, msg)
			-- 新添加协议向服务端发送清理桌面
		end

	end )
	table.insert(Network.crts, co)]]
	--
end

-- 每局结算开始游戏
function GoldFlowerRoom.GoldSettlementStartGameRes(buffer)
	TH_GameMainPanel.btnChat:SetActive(true)
	-- 每局结算开始游戏显示聊天
	print("GoldFlowerRoom.GoldSettlementStartGameRes")
	local self = GoldFlowerRoom
	local data = buffer:ReadBuffer()
	local msg = GoldSettlementStartGame_pb.GoldSettlementStartGameRes()
	msg:ParseFromString(data)
	local roleIndex = msg.roleIndex
	-- 谁点了开始
	local leaderIndex = msg.leaderIndex
	-- 庄索引
	local allStart = msg.allStart
	-- true为所有人都点了开始
	local readyList = msg.alreadyIndex
	-- 点了准备的玩家索引
	if self.RoomMsg.moneyType ~= 0 then
		if self.hasLoaded then return end
	end
	-- 准备后清理显示
	local curCache = self:GetPlayer(roleIndex)
	curCache.btnLook:SetActive(false)
	curCache.imgGiveupMask:SetActive(false)
	curCache.imgGiveup:SetActive(false)
	for i, v in ipairs(readyList) do
		if v == self.myIndex then
			TH_GameMainPanel.imgHTSingleSettlement:SetActive(false)
			TH_GameMainPanel.imgJHCompareOrBet:SetActive(false)
			TH_GameMainPanel.imgJHBeishu:SetActive(false)
			TH_GameMainPanel.txtCurBet:SetActive(false)
		end
		self:GetPlayer(v).imgOK:SetActive(true)
	end
	if allStart then
		self.curJushu = self.curJushu + 1
		self:SetCurJushu(self.curJushu)
		self:NextGameStart()
		self:ReSetOperate(leaderIndex + 1)
		self:DealCards(leaderIndex)
		for i, v in ipairs(self.betObjList) do
			table.remove(self.betObjList, i)
			v:Destroy()
		end
		self:GetPlayer(leaderIndex).imgZhuang:SetActive(true)
		TH_GameMainCtrl.vsIndex = 0
	end
end

-- 元宝场和金币场准备按钮返回
function GoldFlowerRoom.GoldFlowerSureRes(buffer)
	print("GoldFlowerRoom.GoldFlowerSureRes")
	local self = GoldFlowerRoom
	if self.RoomMsg.moneyType == 0 then return end
	local data = buffer:ReadBuffer()
	local msg = TenHalfSettlementStartGame_pb.TenHalfSettlementStartGameRes()
	msg:ParseFromString(data)
	local readyList = msg.alreadyIndex
	-- 点了准备的玩家的索引
	local allStart = msg.allStart
	for k, v in pairs(readyList) do
		local curCache = self:GetPlayer(v)
		if curCache ~= nil then
			curCache.isReady = true
			if curCache.imgOK.activeSelf == false then
				curCache.imgOK:SetActive(true)
			end
			if v == self.myIndex then
				TH_GameMainPanel.btnPrepareButton:SetActive(false)
			else
			end
			if self:GetPlayer(v) ~= nil then
				self:GetPlayer(v).imgOK:SetActive(true)
			end
		end
	end
	if allStart then
		self:OnReadyGame()
		self:NextGameStart()
	end
end

-- 总结算
function GoldFlowerRoom.GoldTotalSettlementRes(buffer)
	print("GoldFlowerRoom.GoldTotalSettlementRes")
	local self = GoldFlowerRoom
	local data = buffer:ReadBuffer()
	local msg = GoldTotalSettlement_pb.GoldTotalSettlementRes()
	msg:ParseFromString(data)
	local roomNum = msg.roomNum
	local totalJushu = msg.totalJushu
	local totalSettlementInfo = msg.totalSettlementInfo
	TH_RoleInfoCtrl:Close()
	TH_GameMainPanel.imgHTSingleSettlement:SetActive(false)
	if DissolutionRoomCtrl.gameOver then
		TH_TotalSettlementCtrl:Open("TH_TotalSettlement", function()
			-- 生成预制--
			resMgr:LoadPrefab('th_totalsettlement', { 'th_totalplayer' }, function(objs)
				TH_TotalSettlementCtrl:InitPanel(objs, msg)
			end )
		end )
	else
		TH_GameMainPanel.imgHTSingleSettlement.transform:DOScale(Vector3.zero, 0.2):SetDelay(3):OnComplete(
		function()
			TH_TotalSettlementCtrl:Open("TH_TotalSettlement", function()
				-- 生成预制--
				resMgr:LoadPrefab('th_totalsettlement', { 'th_totalplayer' }, function(objs)
					TH_TotalSettlementCtrl:InitPanel(objs, msg)
				end )
			end )
			self:NextGameStart()
		end )
	end
end

-- 收到别人断线重连消息
function GoldFlowerRoom:OfflinePush(msg)
	print("GoldFlowerRoom:OfflinePush")
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

-- 刷新玩法信息
function GoldFlowerRoom:RefreshWanfa(curLunshu, index)
	print("GoldFlowerRoom:RefreshWanfa")
	local txtVS = '<color=#EEEEEE>比牌</color>：' .. curLunshu .. '/' .. tonumber(self.allbiLun)
	local txtGuess = '<color=#EEEEEE>闷牌</color>：' .. curLunshu .. '/' .. tonumber(self.allmenLun)
	if self.allmenLun == 0 then
		txtGuess = '<color=#EEEEEE>不闷</color> '
	end
	--if curLunshu == 0 then
		-- 当轮数为0的时候（代表新开一局），下的码归零
	--	self.allBet = 0
	--end
	local txtTop = '<color=#EEEEEE>封顶</color>：' .. curLunshu .. '/' .. tonumber(self.alltop)
	if curLunshu >= self.allbiLun then
		txtVS = '<color=#EEEEEE>比牌</color>：' .. self.allbiLun .. '/' .. self.allbiLun
	end
	if curLunshu >= self.allmenLun then
		if self.allmenLun == 0 then
			txtGuess = '<color=#EEEEEE>不闷</color> '
		else
			txtGuess = '<color=#EEEEEE>闷牌</color>：' .. self.allmenLun .. '/' .. self.allmenLun
		end
	end
	if curLunshu >= self.alltop then
		txtTop = '<color=#EEEEEE>封顶</color>：' .. self.alltop .. '/' .. self.alltop
	end

	local Ronda = ""
	if GoldFlowerRoom.RoomMsg.mcreenings == 1 then
		Ronda = "新手场"
	elseif GoldFlowerRoom.RoomMsg.mcreenings == 2 then
		Ronda = "初级场"
	elseif GoldFlowerRoom.RoomMsg.mcreenings == 3 then
		Ronda = "中级场"
	elseif GoldFlowerRoom.RoomMsg.mcreenings == 4 then
		Ronda = "高级场"
	elseif GoldFlowerRoom.RoomMsg.mcreenings == 5 then
		Ronda = "土豪场"
	end
	--注数和玩法的显示
	if self.RoomMsg.moneyType == RoomMode.goldMode   then --金币元宝模式
		TH_GameMainCtrl:SetText(GoldFlowerRoom.txtMessage, "金币" .. Ronda .. "\n" .. "玩法：全比" .. "\n" .. "特殊：双倍比牌" .. "\n" .. txtTop .. "\n" .. txtVS .. "\n" .. "底分：" .. GoldFlowerRoom.RoomMsg.baseNum)
		TH_GameMainCtrl:SetText(GoldFlowerRoom.textZhuShu,self.allBet)
	elseif self.RoomMsg.moneyType == RoomMode.wingMode then
           TH_GameMainCtrl:SetText(GoldFlowerRoom.txtMessage, "元宝" .. Ronda .. "\n" .. "玩法：全比" .. "\n" .. "特殊：双倍比牌" .. "\n" .. txtTop .. "\n" .. txtVS .. "\n" .. "底分：" .. GoldFlowerRoom.RoomMsg.baseNum)
		   TH_GameMainCtrl:SetText(GoldFlowerRoom.textZhuShu,self.allBet)
	else
		TH_GameMainCtrl:SetText(self.txtPlayMathond, "总注：" .. self.allBet .. "\n" .. txtTop .. "\n" .. txtGuess .. "\n" .. txtVS)
		TH_GameMainCtrl:SetText(GoldFlowerRoom.textZhuShu,self.allBet)
	end

	if index == self.myIndex then
		TH_GameMainPanel.txtCurBet:SetActive(true)
		TH_GameMainCtrl:SetText(TH_GameMainPanel.txtCurBet, tostring(self:GetPlayer(index).allbetCount))
	end
end

-- 比牌动画
function GoldFlowerRoom:VSAnim(windex, lindex, biIndex, nextIndex)
	print("GoldFlowerRoom:VSAnim")
	local posLeft = Vector3.New(-1200, 90, 0)
	local posRight = Vector3.New(1200, 90, 0)
	local backPosL = Vector3.New(-305, 90, 0)
	local backPosR = Vector3.New(255, 90, 0)
	local objVS = TH_GameMainPanel.imgVsShow
	local objL = TH_GameMainPanel.imgVleft
	local objR = TH_GameMainPanel.imgSright
	local light = TH_GameMainPanel.imgVsLight
	local objList = TH_GameMainCtrl.vsList
	local playerR = nil
	local playerL = nil
	local boomPos = nil
	local loseList = nil
	local winList = nil
	local losePlayer = nil
	if biIndex == windex then
		playerL = self:GetPlayer(windex)
		playerR = self:GetPlayer(lindex)
		boomPos = Vector3.New(358, 75, 0)
		loseList = objList.objR.cardList
		winList = objList.objL.cardList
		losePlayer = playerR
	else
		playerL = self:GetPlayer(lindex)
		playerR = self:GetPlayer(windex)
		boomPos = Vector3.New(-413, 75, 0)
		loseList = objList.objL.cardList
		winList = objList.objR.cardList
		losePlayer = playerL
	end

	-- 信息设置
	objList.objL.head:GetComponent("Image").sprite = playerL.imgHead:GetComponent("Image").sprite
	TH_GameMainCtrl:SetText(objList.objL.score, playerL.jifen)
	TH_GameMainCtrl:SetText(objList.objL.name, playerL.name)
	objList.objR.head:GetComponent("Image").sprite = playerR.imgHead:GetComponent("Image").sprite
	TH_GameMainCtrl:SetText(objList.objR.score, playerR.jifen)
	TH_GameMainCtrl:SetText(objList.objR.name, playerR.name)
	TH_GameMainPanel.imgBoom:SetActive(false)
	-- 动画显示
	light:SetActive(false)
	objL.transform.localPosition = posLeft
	objR.transform.localPosition = posRight
	objVS:SetActive(true)
	for i, v in ipairs(objList.objR.cardList) do
		v.color = Color.New(1, 1, 1, 1)
	end
	objL.transform:DOLocalMove(backPosL, 0.2, false)
	objR.transform:DOLocalMove(backPosR, 0.2, false):OnComplete(
	function()
		light:SetActive(true)
	end )
	light.transform:DOLocalMove(light.transform.localPosition, 1, false):OnComplete(
	function()
		TH_GameMainPanel.imgBoom.transform.localPosition = boomPos
		TH_GameMainPanel.imgBoom:SetActive(true)
		for i, v in ipairs(loseList) do
			v:GetComponent("Image").sprite = TH_GameMainCtrl.publicCardSprite.card_gray
		end
	end )
	light.transform:DOLocalMove(light.transform.localPosition, 2, false):OnComplete(
	function()
		local lifeNum = self:GetLifeNum()
		TH_GameMainPanel.imgBoom:SetActive(false)
		objVS:SetActive(false)
		losePlayer:GiveUp("比牌输")
		losePlayer.bipaiFlag = true
		losePlayer.qipaiFlag = true
		for i, v in ipairs(loseList) do
			v:GetComponent("Image").sprite = TH_GameMainCtrl.publicCardSprite.jhone
		end
		for i, v in ipairs(winList) do
			v:GetComponent("Image").sprite = TH_GameMainCtrl.publicCardSprite.jhone
		end
		if losePlayer.index == self.myIndex then
			TH_GameMainPanel.imgFace:SetActive(false)
			TH_GameMainPanel.imgJHCompareOrBet:SetActive(false)
			losePlayer.imglookType:SetActive(true)
		end
		if lifeNum >= 2 then
			self:GoNextPlayer(nextIndex)
		end

		local co = coroutine.start( function()  
			coroutine.wait(3)
			--if TH_GameMainPanel.imgFace then
			   TH_GameMainPanel.imgFace:SetActive(false)   --3秒后隐藏表情图片老报（已经destory）
			--end
		end )
		table.insert(Network.crts, co)
	end )
end

-- 判断活着的人
function GoldFlowerRoom:GetLifeNum()
	print("GoldFlowerRoom:GetLifeNum")
	local num = 0
	local kanpaiNum = 0
	for i, v in ipairs(self.players) do
		if not v.qipaiFlag then
			num = num + 1
		end
	end
	return num
end

-- 扎金花发表情
function GoldFlowerRoom.SendFaceIcon(go)
	print("GoldFlowerRoom.SendFaceIcon")
	GameChatCtrl.SendChatApplyCard(GoldFlowerRoom, 3, go.name)
	TH_GameMainPanel.imgFace:SetActive(false)
	-- 发过表情后隐藏图片（隐藏之后还会跑出来）
end

-- 清理房间数据
function GoldFlowerRoom:ClearRoomInfo()
	print("GoldFlowerRoom:ClearRoomInfo")
	for _, v in ipairs(self.players) do
		if v.obj ~= nil then
			v:Destroy()
		end
	end
	self.players = { }
end

-- 清理观战玩家数据
function GoldFlowerRoom:ClaernWatchPlayer()
	print("GoldFlowerRoom:ClaernWatchPlayer")
	for _, v in ipairs(self.watchPlayers) do
		if v.obj ~= nil then
			v:ClearnImgLayer()
			v.obj:SetActive(false)
			-- v.ClearnData()
		end
	end
	self.watchPlayers = { }
end

-- 生成观战玩家数据
function GoldFlowerRoom:CreateWatchPlayer(data)
	print("GoldFlowerRoom:CreateWatchPlayer")
	for i, v in ipairs(data) do
		local obj = self.playerPanel.transform:FindChild("TH_imgHead" .. self:GetRoomIndexByIndex(v.index)).gameObject

		local playerObj = GoldFlowerPlayer:New(v, obj)
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
		v.obj:SetActive(true)
		TH_GameMainCtrl:SetText(v.txtName, v.name)
		TH_GameMainCtrl:SetText(v.txtScore, v.jifen)
		v.imgOK:SetActive(false)
		v.imgZhuang:SetActive(false)
		v.imgChat:SetActive(false)
		v.imgFaceIcon:SetActive(false)
		v.imgCardType:SetActive(false)
		v.imgBet:SetActive(false)
		v.imgCur:SetActive(false)
		v.imgDeng:SetActive(false)
		v.imgAnim:SetActive(false)
		v.imglookType:SetActive(false)
		v.imgGiveupMask:SetActive(true)
		v.imgGiveup:SetActive(false)
		v.imgCompare:SetActive(false)
		v.btnLook:SetActive(false)
		v.imgOffLine:SetActive(false)
		v.imgWatching:SetActive(true)
		-- 新添加
		v.imgYuanbao:SetActive(false)
		v.imgJinbi:SetActive(false)
		if self.RoomMsg.moneyType == RoomMode.goldMode then
			v.imgJinbi:SetActive(true)
			TH_GameMainCtrl:SetText(v.txtScore, formatNumber(v.goldcoin))
		elseif self.RoomMsg.moneyType == RoomMode.wingMode then
			v.imgYuanbao:SetActive(true)
			TH_GameMainCtrl:SetText(v.txtScore, formatNumber(v.wing))
		end
	end
end

-- 观战加入
function GoldFlowerRoom:WatchJoinRoom(msg)
	print("GoldFlowerRoom:WatchJoinRoom")
	data = ReLoad_pb.GoldFlowerReload()
	data:ParseFromString(msg.dataResForWait)
	-- 接收数据
	self.notVoice = true
	self.hasLoaded = false
	self.initPlayerEnd = false
	self.isSettlement = false
	local roomVo = RoomJinHuaVo:New()
	roomVo.id = data.roomNum
	-- 房间号
	roomVo.jinHuaTotal = data.jinHuaTotal
	-- 总局数
	roomVo.jinHuaPlayMethond = data.playMethond
	-- 玩法 1比大小 2比花色 3全比
	roomVo.isLeopard = data.isLeopard and 1 or 0
	-- 豹子额外奖励
	roomVo.isDouble = data.isDouble and 1 or 0
	-- 比牌双倍开
	roomVo.isTop = data.isTop
	-- 封顶
	roomVo.isCompare = data.isCompare
	-- 比牌
	roomVo.isGuess = data.isGuess
	-- 添加
	roomVo.baseNum = data.baseNum
	-- 底金
	roomVo.qualified = data.qualified
	-- 几进几出
	roomVo.moneyType = data.moneyType
	-- 1=金币场 2=元宝场 3=房卡
	-- data.zhuang
	self.RoomMsg = roomVo
	self.playersData = { }
	self.players = { }
	self.watchPlayers = { }
	local curEnd = data.curEnd
	self:ClearRoomInfo()
	-- 清理房间数据
	for i, v in ipairs(data.roles) do
		-- 所有玩家的信息列表
		local joinRoomUserVo = JoinRoomUserVo:New()
		joinRoomUserVo.index = v.roleIndex;
		joinRoomUserVo.roleId = v.roleId;
		joinRoomUserVo.name = v.name;
		joinRoomUserVo.ip = v.ip;
		joinRoomUserVo.headImg = v.headImg;
		joinRoomUserVo.jifen = v.jifen;
		joinRoomUserVo.gender = v.gender;
		joinRoomUserVo.diamond = v.diamond;
		joinRoomUserVo.isOnline = v.isOnline;
		-- 新添加
		joinRoomUserVo.goldcoin = v.goldcoin
		-- 金币数量
		joinRoomUserVo.wing = v.wing
		-- 元宝数量
		joinRoomUserVo.isLook = v.isLook
		local placeMsg = v.locationInfo;
		-- 位置信息
		local strArray
		strArray = string_split(placeMsg, "/")
		global.gpsMsgInfo[tostring(v.roleId)] = { strArray[1], tonumber(strArray[2]), tonumber(strArray[3]) }
		self.playersData[v.roleIndex] = joinRoomUserVo
		if v.roleId == global.userVo.roleId then
			self.myIndex = v.roleIndex
		end
	end
	self.playerCount = #self.playersData
	self.startGameZhuangIndex = data.zhuang

	-- 设置
	local co = coroutine.start( function()
		while not self.isPrefabLoaded do
			coroutine.step()
		end
		-- 设置房间信息
		TH_GameMainPanel.imgHTWaitFriends:SetActive(false)
		TH_GameMainPanel.btnWaitQuitRoom:SetActive(true)
		TH_GameMainPanel.btnChat:SetActive(true)
		TH_GameMainPanel.imgSignalBG:SetActive(false)

		self:InitPlayers()
		self.curJushu = data.alreadyJuShu
		self.allJushu = data.jinHuaTotal
		self.alltop = data.isTop
		self.allmenLun = data.isGuess
		self.allbiLun = data.isCompare
		self.allBet = data.allbetCount
		self.curLunshu = data.curLunShu
		self:SetCurJushu(self.curJushu)
		local num = #self.players
		local index = data.curIndex
		local curIndex = data.curIndex
		local zhuangIndex = data.zhuang
		local lastKanpaiFlag = data.upPourFlag
		-- 上一位玩家索引
		self.lastIndex = data.upIndex
		if self.lastIndex == 0 then
			if index <= 1 then
				index = num
			else
				index = index - 1
			end
			self.lastIndex = index
		end
		self:ReSetOperate(self.lastIndex)
		self:GetPlayer(self.lastIndex).betMengFlag = lastKanpaiFlag
		-- 设置玩家信息
		local qipaiNum = 0
		for i, role in ipairs(data.roles) do
			local curCache = self:GetPlayer(i)
			local spInfo = ReLoad_pb.GoldFlowerRoleSpInfo()
			spInfo:ParseFromString(role.spInfoRes)
			curCache.kanpaiFlag = spInfo.isLookCard
			curCache.qipaiFlag = spInfo.isGiveUp
			curCache.mengpaiFlag = spInfo.isLookCard
			curCache.bipaiFlag = spInfo.isCompare
			if curCache.qipaiFlag then
				qipaiNum = qipaiNum + 1
			end
		end
		for i, role in ipairs(data.roles) do
			-- 空牌
			local card = { { id = - 1 }, { id = - 1 }, { id = - 1 } }
			local spInfo = ReLoad_pb.GoldFlowerRoleSpInfo()
			spInfo:ParseFromString(role.spInfoRes)
			-- 设置看牌提示
			local curCache = self:GetPlayer(i)
			if i == self.myIndex then
				curCache.isLook = true
				curCache.imgWatching:SetActive(true)
			else
				if curcache ~= nil then
					curcache.isLook = false
				end
			end
			if i ~= self.myIndex then
				-- 弃牌
				if curCache.qipaiFlag then
					if curCache.bipaiFlag then
						if spInfo.roleCard[1].id ~= -1 then
							curCache:CreateListCards(i, spInfo.roleCard, TenHalfCardState.BaoCard)
						else
							curCache:CreateListCards(i, card, TenHalfCardState.KouCard)
						end
						curCache:GiveUp("比牌输")
						curCache:LookAnim()
					else
						curCache:GiveUp("弃牌")
						if curCache.index == self.myIndex then
							if spInfo.roleCard[1].id ~= -1 then
								curCache:CreateListCards(i, spInfo.roleCard, TenHalfCardState.BaoCard, "gray")
							else
								curCache:CreateListCards(i, card, TenHalfCardState.KouCard, "gray")
							end
							if curCache.kanpaiFlag then
								curCache:LookAnim()
							end
						end
					end
				else
					-- 看牌
					if curCache.kanpaiFlag then
						curCache:GiveUp("已看牌")
						if spInfo.roleCard[1].id ~= -1 then
							if qipaiNum == #self.players - 1 then
								curCache:CreateListCards(i, card, TenHalfCardState.KouCard)
							else
								curCache:CreateListCards(i, spInfo.roleCard, TenHalfCardState.FanKaiCard)
							end
						else
							curCache:CreateListCards(i, card, TenHalfCardState.KouCard)
						end
						curCache:LookAnim()
					else
						curCache:CreateListCards(i, card, TenHalfCardState.KouCard)
					end
				end
				curCache:SetCardType(spInfo.result, curCache.index)
			end
			-- end
			-- 设置筹码的位置
			if not curEnd then
				local betJifen = 0
				for i, v in ipairs(spInfo.bets) do
					if v > 10 then
						betJifen = v / 2
						local targetPos = Vector3.New(Util.Random(-200, 200), Util.Random(20, -20), 0)
						curCache:BetAnim(betJifen, targetPos, true)
					else
						local targetPos = Vector3.New(Util.Random(-200, 200), Util.Random(20, -20), 0)
						curCache:BetAnim(v, targetPos, true)
					end
					coroutine.wait(0)
				end
			else
				curCache.imgGiveup:SetActive(false)
			end
			-- 庄
			if zhuangIndex == curCache.index then
				curCache.imgZhuang:SetActive(true)
			end
		end
		self.curFen = self:GetPlayer(self.lastIndex).curbetCount
		coroutine.wait(0.1)
		self:RefreshWanfa(self.curLunshu, data.curIndex)
		self:GoNextPlayer(curIndex)
		-- 设置加注按钮显示
		if self.operateIndex == self.myIndex then
			local addJifen = self:GetPlayer(self.lastIndex).curbetCount
			if addJifen > 5 then
				addJifen = addJifen / 2
			end
			for i, v in ipairs(self.addObjList) do
				if addJifen >= v.jifen then
					v.btn.interactable = false
				else
					v.btn.interactable = true
				end
			end
		end
		-- 查找庄的下一位玩家--先手
		local first = zhuangIndex
		if first >= num then
			first = 1
		else
			first = first + 1
		end
		self:SetGenZhuTxt(lastKanpaiFlag)
		self.firstIndex = first
		self.notVoice = false
		self.hasLoaded = true
		if self.RoomMsg.moneyType == 0 then
			Room:SetGps(data.roles)
		end
	end )
	table.insert(Network.crts, co)
end