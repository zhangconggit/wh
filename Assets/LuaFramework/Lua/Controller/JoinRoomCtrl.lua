JoinRoomCtrl = { }
setbaseclass(JoinRoomCtrl, { BaseCtrl })

function JoinRoomCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)

	self:AddClick(JoinRoomPanel.btnQuit, self.OnQuitBtnClick)
	self:AddClick(JoinRoomPanel.btnNum0, self.OnNum0BtnClick)
	self:AddClick(JoinRoomPanel.btnNum1, self.OnNum1BtnClick)
	self:AddClick(JoinRoomPanel.btnNum2, self.OnNum2BtnClick)
	self:AddClick(JoinRoomPanel.btnNum3, self.OnNum3BtnClick)
	self:AddClick(JoinRoomPanel.btnNum4, self.OnNum4BtnClick)
	self:AddClick(JoinRoomPanel.btnNum5, self.OnNum5BtnClick)
	self:AddClick(JoinRoomPanel.btnNum6, self.OnNum6BtnClick)
	self:AddClick(JoinRoomPanel.btnNum7, self.OnNum7BtnClick)
	self:AddClick(JoinRoomPanel.btnNum8, self.OnNum8BtnClick)
	self:AddClick(JoinRoomPanel.btnNum9, self.OnNum9BtnClick)
	self:AddClick(JoinRoomPanel.btnBackSpace, self.OnBackSpaceBtnClick)
	self:AddClick(JoinRoomPanel.btnClear, self.OnClearBtnClick)
	self:AddClickNoChange(JoinRoomPanel.btnJoinRoomMaskBG, self.OnQuitBtnClick)
	self:InitPanel()
end

function JoinRoomCtrl:InitPanel()
	self:SetText(JoinRoomPanel.txt1, "")
	self:SetText(JoinRoomPanel.txt2, "")
	self:SetText(JoinRoomPanel.txt3, "")
	self:SetText(JoinRoomPanel.txt4, "")
	self:SetText(JoinRoomPanel.txt5, "")
	self:SetText(JoinRoomPanel.txt6, "")
end

function JoinRoomCtrl.OnNum0BtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = JoinRoomCtrl
	self:InputRoomNum('0')
end

function JoinRoomCtrl.OnNum1BtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = JoinRoomCtrl
	self:InputRoomNum('1')
end

function JoinRoomCtrl.OnNum2BtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = JoinRoomCtrl
	self:InputRoomNum('2')
end

function JoinRoomCtrl.OnNum3BtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = JoinRoomCtrl
	self:InputRoomNum('3')
end

function JoinRoomCtrl.OnNum4BtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = JoinRoomCtrl
	self:InputRoomNum('4')
end

function JoinRoomCtrl.OnNum5BtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = JoinRoomCtrl
	self:InputRoomNum('5')
end

function JoinRoomCtrl.OnNum6BtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = JoinRoomCtrl
	self:InputRoomNum('6')
end

function JoinRoomCtrl.OnNum7BtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = JoinRoomCtrl
	self:InputRoomNum('7')
end

function JoinRoomCtrl.OnNum8BtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = JoinRoomCtrl
	self:InputRoomNum('8')
end

function JoinRoomCtrl.OnNum9BtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = JoinRoomCtrl
	self:InputRoomNum('9')
end

function JoinRoomCtrl.OnBackSpaceBtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = JoinRoomCtrl

	local oneText = self:GetText(JoinRoomPanel.txt1)
	local twoText = self:GetText(JoinRoomPanel.txt2)
	local threeText = self:GetText(JoinRoomPanel.txt3)
	local fourText = self:GetText(JoinRoomPanel.txt4)
	local fiveText = self:GetText(JoinRoomPanel.txt5)
	local sixText = self:GetText(JoinRoomPanel.txt6)


	if oneText ~= '' and twoText == '' and threeText == '' and fourText == '' and fiveText == '' and sixText == '' then
		self:SetText(JoinRoomPanel.txt1, "")
	elseif twoText ~= '' and threeText == '' and fourText == '' and fiveText == '' and sixText == '' then
		self:SetText(JoinRoomPanel.txt2, "")
	elseif threeText ~= '' and fourText == '' and fiveText == '' and sixText == '' then
		self:SetText(JoinRoomPanel.txt3, "")
	elseif fourText ~= '' and fiveText == '' and sixText == '' then
		self:SetText(JoinRoomPanel.txt4, "")
	elseif fiveText ~= '' and sixText == '' then
		self:SetText(JoinRoomPanel.txt5, "")
	elseif sixText ~= '' then
		self:SetText(JoinRoomPanel.txt6, "")
	end
end

function JoinRoomCtrl.OnClearBtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = JoinRoomCtrl
	self:SetText(JoinRoomPanel.txt1, "")
	self:SetText(JoinRoomPanel.txt2, "")
	self:SetText(JoinRoomPanel.txt3, "")
	self:SetText(JoinRoomPanel.txt4, "")
	self:SetText(JoinRoomPanel.txt5, "")
	self:SetText(JoinRoomPanel.txt6, "")
end

function JoinRoomCtrl:InputRoomNum(roomNum)

	local oneText = self:GetText(JoinRoomPanel.txt1)
	local twoText = self:GetText(JoinRoomPanel.txt2)
	local threeText = self:GetText(JoinRoomPanel.txt3)
	local fourText = self:GetText(JoinRoomPanel.txt4)
	local fiveText = self:GetText(JoinRoomPanel.txt5)
	local sixText = self:GetText(JoinRoomPanel.txt6)


	if oneText == '' then
		self:SetText(JoinRoomPanel.txt1, roomNum)
	elseif twoText == '' then
		self:SetText(JoinRoomPanel.txt2, roomNum)
	elseif threeText == '' then
		self:SetText(JoinRoomPanel.txt3, roomNum)
	elseif fourText == '' then
		self:SetText(JoinRoomPanel.txt4, roomNum)
	elseif fiveText == '' then
		self:SetText(JoinRoomPanel.txt5, roomNum)
	elseif sixText == '' then
		self:SetText(JoinRoomPanel.txt6, roomNum)
		sixText = self:GetText(JoinRoomPanel.txt6)
		local roomNUM = oneText .. twoText .. threeText .. fourText .. fiveText .. sixText

		local joinRoom = JoinRoom_pb.JoinRoomReq()
		joinRoom.roomNum = tonumber(roomNUM)
		local msg = joinRoom:SerializeToString()
		Game.SendProtocal(Protocal.JoninRoom, msg)
	end
end

function JoinRoomCtrl.OnQuitBtnClick(go)
	----Game.MusicEffect(Game.Effect.buttonBack)
	local self = JoinRoomCtrl
	self:Close()
end

function JoinRoomCtrl.OnJoinRoomRes(buffer)
	print("=========OnJoinRoomRes")
	local data = buffer:ReadBuffer()
	local msg = JoinRoom_pb.JoinRoomRes()
	msg:ParseFromString(data)
	Room.gameType = msg.gameType
	Room.isStar = msg.star
	print("=========OnJoinRoomRes", msg.gameType)
	if msg.gameType == 1 then
		data = JoinRoom_pb.MahjongInfo()
		data:ParseFromString(msg.dataRes)

		global.roomVo = RoomVo:New()
		global.roomVo.isFangzhu = 2
		global.roomVo.id = data.roomNum
		global.roomVo.total = data.jushu
		global.roomVo.isPlayNum = data.roleNum
		global.roomVo.modeType = data.modeType


		-- 新添加
		global.roomVo.baseNum = msg.baseNum
		global.roomVo.mcreenings = msg.mcreenings
		global.roomVo.qualified = msg.qualified
		global.roomVo.moneyType = msg.moneyType
		print('global.roomVo.baseNum = msg.baseNum=========', msg.baseNum, msg.moneyType, data.roleNum)

		if data.zimohu == true then
			global.roomVo.isSelf = 1
		elseif data.zimohu == false then
			global.roomVo.isSelf = 2
		end

		if data.feng == true then
			global.roomVo.isFeng = 1
		elseif data.feng == false then
			global.roomVo.isFeng = 2
		end

		if data.hongzhong == true then
			global.roomVo.isRed = 1
		elseif data.hongzhong == false then
			global.roomVo.isRed = 2
		end

		if data.bihu == true then
			global.roomVo.isBihu = 1
		elseif data.bihu == false then
			global.roomVo.isBihu = 2
		end

		global.roomVo.isFishNum = data.yu


		local userInfos = data.joinRoomUserInfo
		local text4, text3, text2, text1, text5

		if global.roomVo.modeType == 1 then
			text5 = 'AA模式'
		else
			text5 = '老板模式'
		end

		if global.roomVo.moneyType == RoomMode.goldMode then
			text5 = ''
		elseif global.roomVo.moneyType == RoomMode.wingMode then
			text5 = ''
		end

		if global.roomVo.isFishNum == 0 then
			text4 = '不下鱼'
		else
			text4 = global.roomVo.isFishNum .. "条鱼"
		end

		if global.roomVo.isSelf == 1 then
			text3 = "自摸胡"
		else
			text3 = '点炮胡'
		end

		if global.roomVo.isBihu == 1 then
			text3 = "点炮必胡"
		end

		if global.roomVo.isFeng == 1 then
			text2 = "无风牌"
		else
			text2 = '有风牌'
		end

		if global.roomVo.isRed == 1 then
			text1 = '红中麻将'
		else
			text1 = "推倒胡"
		end

		global.roomVo.playMethod = text1 .. "  " .. text2 .. "  " .. text3 .. "  " .. text4 .. "  " .. text5

		global.joinRoomUserVos = { }
		for _, v in ipairs(userInfos) do
			local joinRoomUserVo = JoinRoomUserVo:New()
			joinRoomUserVo.index = v.index
			joinRoomUserVo.roleId = v.roleId
			joinRoomUserVo.name = v.name
			joinRoomUserVo.ip = v.ip
			joinRoomUserVo.headImg = v.headImg
			joinRoomUserVo.jifen = 1000
			joinRoomUserVo.diamond = v.diamond
			joinRoomUserVo.gender = v.gender
			joinRoomUserVo.goldcoin = v.goldcoin
			joinRoomUserVo.wing = v.wing

			global.joinRoomUserVos[v.index] = joinRoomUserVo
			global.setPosition[v.index] = joinRoomUserVo
			MahjongRoom.playersData[v.index] = joinRoomUserVo
			if v.roleId == global.userVo.roleId then
				MahjongRoom.myIndex = v.index
			end
			MahjongRoom.playerCount = #MahjongRoom.playersData
			print("global.joinRoomUserVo=jifen===", joinRoomUserVo.jifen)
		end
		local self = JoinRoomCtrl
		self:OnJoinRoomInfoShow()
		--Game.MusicEffect(Game.Effect.joinRoom)

		local co = coroutine.start( function()
			while not OB_GameMainCtrl.isCreate do
				coroutine.step()
			end
			OB_GameMainCtrl:InitPlayer()
		end )
		table.insert(Network.crts, co)
		Game.LoadScene("mahjong")
	elseif msg.gameType == 2 then
		data = JoinRoom_pb.TenHalfInfo()
		data:ParseFromString(msg.dataRes)

		global.roomVo = RoomVo:New()

		TenharfRoom.RoomMsg.id = data.roomNum
		TenharfRoom.RoomMsg.tenHalfTotal = data.everyJushu
		-- 新添加
		TenharfRoom.RoomMsg.baseNum = msg.baseNum
		TenharfRoom.RoomMsg.mcreenings = msg.mcreenings
		TenharfRoom.RoomMsg.qualified = msg.qualified
		TenharfRoom.RoomMsg.moneyType = msg.moneyType

		if data.tenHalfRateDouble == true then
			TenharfRoom.RoomMsg.isTen2 = 1
		else
			TenharfRoom.RoomMsg.isTen2 = 0
		end

		if data.fiveRateThree == true then
			TenharfRoom.RoomMsg.isFive3 = 1
		else
			TenharfRoom.RoomMsg.isFive3 = 0
		end

		if data.fiveHuaRateFive == true then
			TenharfRoom.RoomMsg.isFive5 = 1
		else
			TenharfRoom.RoomMsg.isFive5 = 0
		end

		if data.tenHalfLeiRateFive == true then
			TenharfRoom.RoomMsg.isTen5 = 1
		else
			TenharfRoom.RoomMsg.isTen5 = 0
		end

		if data.king == true then
			TenharfRoom.RoomMsg.isWang = 1
		else
			TenharfRoom.RoomMsg.isWang = 0
		end

		if data.leaderZhuang == true then
			TenharfRoom.RoomMsg.isMaster = 1
		else
			TenharfRoom.RoomMsg.isMaster = 0
		end

		TenharfRoom.RoomMsg.isFangzhu = 2
		TenharfRoom.playersData = { }
		local userInfos = data.joinRoomUserInfo
		if msg.moneyType == RoomMode.roomCardMode then
			for i, v in ipairs(userInfos) do
				local joinRoomUserVo = JoinRoomUserVo:New()
				joinRoomUserVo.index = v.index
				joinRoomUserVo.roleId = v.roleId
				joinRoomUserVo.name = v.name
				joinRoomUserVo.ip = v.ip
				joinRoomUserVo.headImg = v.headImg
				joinRoomUserVo.jifen = 0
				joinRoomUserVo.gender = v.gender
				joinRoomUserVo.diamond = v.diamond
				joinRoomUserVo.goldcoin = v.goldcoin
				joinRoomUserVo.wing = v.wing
				joinRoomUserVo.isReady = v.isReady
				TenharfRoom.playersData[v.index] = joinRoomUserVo
				if v.roleId == global.userVo.roleId then
					TenharfRoom.myIndex = v.index
				end
			end
			TenharfRoom.playerCount = #TenharfRoom.playersData
			local self = JoinRoomCtrl
			--Game.MusicEffect(Game.Effect.joinRoom)

			self:Close()
			MainSenceCtrl:Close()
			Game.LoadScene("room")
			CreateRoomCtrl.PlayEffectMusic()
			local co = coroutine.start( function()
				while not TH_GameMainCtrl.isCreate do
					coroutine.step()
				end
				if msg.star == true then
					-- 游戏开始进入房间统一算为观战玩家
					TenharfRoom:WatchJoinRoom(msg)
				else
					TenharfRoom:InitPlayers()
				end
			end )
			table.insert(Network.crts, co)
		else
			for i, v in ipairs(userInfos) do
				local joinRoomUserVo = JoinRoomUserVo:New()
				joinRoomUserVo.index = v.index
				joinRoomUserVo.roleId = v.roleId
				joinRoomUserVo.name = v.name
				joinRoomUserVo.ip = v.ip
				joinRoomUserVo.headImg = v.headImg
				joinRoomUserVo.jifen = 0
				joinRoomUserVo.gender = v.gender
				joinRoomUserVo.diamond = v.diamond
				joinRoomUserVo.goldcoin = v.goldcoin
				joinRoomUserVo.wing = v.wing
				joinRoomUserVo.isReady = v.isReady
				TenharfRoom.playersData[v.index] = joinRoomUserVo
				if v.roleId == global.userVo.roleId then
					TenharfRoom.myIndex = v.index
				end
			end
			TenharfRoom.playerCount = #TenharfRoom.playersData
			local self = JoinRoomCtrl
			--Game.MusicEffect(Game.Effect.joinRoom)

			self:Close()
			MainSenceCtrl:Close()
			Game.LoadScene("room")
			CreateRoomCtrl.PlayEffectMusic()
			local co = coroutine.start( function()
				while not TH_GameMainCtrl.isCreate do
					coroutine.step()
				end
				if msg.star == true then
					-- 游戏开始进入房间统一算为观战玩家
					TenharfRoom:WatchJoinRoom(msg)
				else
					TenharfRoom:InitPlayers()
				end
			end )
			table.insert(Network.crts, co)
		end
	elseif msg.gameType == 3 then
		data = JoinRoom_pb.JinHuaInfo()
		data:ParseFromString(msg.dataRes)
		global.roomVo = RoomVo:New()

		GoldFlowerRoom.RoomMsg.id = data.roomNum
		GoldFlowerRoom.RoomMsg.jinHuaTotal = data.jushu

		-- 新添加
		GoldFlowerRoom.RoomMsg.baseNum = msg.baseNum
		GoldFlowerRoom.RoomMsg.mcreenings = msg.mcreenings
		GoldFlowerRoom.RoomMsg.qualified = msg.qualified
		GoldFlowerRoom.RoomMsg.moneyType = msg.moneyType

		if data.wanfaType == 1 then
			GoldFlowerRoom.RoomMsg.jinHuaPlayMethond = 1
		elseif data.wanfaType == 2 then
			GoldFlowerRoom.RoomMsg.jinHuaPlayMethond = 2
		elseif data.wanfaType == 3 then
			GoldFlowerRoom.RoomMsg.jinHuaPlayMethond = 3
		end

		if data.baoziReward == true then
			GoldFlowerRoom.RoomMsg.isLeopard = 1
		else
			GoldFlowerRoom.RoomMsg.isLeopard = 0
		end

		if data.compareDouble == true then
			GoldFlowerRoom.RoomMsg.isDouble = 1
		else
			GoldFlowerRoom.RoomMsg.isDouble = 0
		end

		print('GoldFlowerRoom.RoomMsg.isTop111111111111111111111', data.compareRound, data.menRound)
		GoldFlowerRoom.RoomMsg.isTop = data.maxOpen
		GoldFlowerRoom.RoomMsg.isCompare = data.compareRound
		GoldFlowerRoom.RoomMsg.isGuess = data.menRound

		GoldFlowerRoom.playersData = { }
		local userInfos = data.joinRoomUserInfo

		if msg.moneyType == RoomMode.roomCardMode then
			for i, v in ipairs(userInfos) do
				local joinRoomUserVo = JoinRoomUserVo:New()
				joinRoomUserVo.index = v.index
				joinRoomUserVo.roleId = v.roleId
				joinRoomUserVo.name = v.name
				joinRoomUserVo.ip = v.ip
				joinRoomUserVo.headImg = v.headImg
				joinRoomUserVo.jifen = 0
				joinRoomUserVo.gender = v.gender
				joinRoomUserVo.diamond = v.diamond
				joinRoomUserVo.goldcoin = v.goldcoin
				joinRoomUserVo.wing = v.wing
				GoldFlowerRoom.playersData[v.index] = joinRoomUserVo
				if v.roleId == global.userVo.roleId then
					GoldFlowerRoom.myIndex = v.index
				end
			end
			GoldFlowerRoom.playerCount = #GoldFlowerRoom.playersData
			local self = JoinRoomCtrl
			--Game.MusicEffect(Game.Effect.joinRoom)

			self:Close()
			MainSenceCtrl:Close()
			Game.LoadScene("room")
			CreateRoomCtrl.PlayEffectMusic()
			local co = coroutine.start( function()
				while not TH_GameMainCtrl.isCreate do
					coroutine.step()
				end
				if msg.star == true then
					-- 游戏开始进入房间统一算为观战玩家
					GoldFlowerRoom:WatchJoinRoom(msg)
				else
					GoldFlowerRoom:InitPlayers()
				end
			end )
			table.insert(Network.crts, co)
		else
			for i, v in ipairs(userInfos) do
				local joinRoomUserVo = JoinRoomUserVo:New()
				joinRoomUserVo.index = v.index
				joinRoomUserVo.roleId = v.roleId
				joinRoomUserVo.name = v.name
				joinRoomUserVo.ip = v.ip
				joinRoomUserVo.headImg = v.headImg
				joinRoomUserVo.jifen = 0
				joinRoomUserVo.gender = v.gender
				joinRoomUserVo.diamond = v.diamond
				joinRoomUserVo.goldcoin = v.goldcoin
				joinRoomUserVo.wing = v.wing
				GoldFlowerRoom.playersData[v.index] = joinRoomUserVo
				if v.roleId == global.userVo.roleId then
					GoldFlowerRoom.myIndex = v.index
				end
			end
			GoldFlowerRoom.playerCount = #GoldFlowerRoom.playersData
			local self = JoinRoomCtrl
			--Game.MusicEffect(Game.Effect.joinRoom)
			self:Close()
			MainSenceCtrl:Close()
			Game.LoadScene("room")
			CreateRoomCtrl.PlayEffectMusic()
			local co = coroutine.start( function()
				while not TH_GameMainCtrl.isCreate do
					coroutine.step()
				end
				while not GoldFlowerRoom.isSettlement do
					coroutine.step()
				end
				if msg.star == true then
					-- 游戏开始进入房间统一算为观战玩家
					GoldFlowerRoom:WatchJoinRoom(msg)
				else
					GoldFlowerRoom:InitPlayers()
				end
			end )
			table.insert(Network.crts, co)
		end
	elseif msg.gameType == 4 then
		print("JoinRoom--------------", msg.gameType)
		data = JoinRoom_pb.CatchPockInfo()
		data:ParseFromString(msg.dataRes)
		global.roomVo = RoomVo:New()
		CatchPockRoom.RoomMsg.id = data.roomNum
		CatchPockRoom.RoomMsg.catchTotal = data.jushu

		-- 新添加
		CatchPockRoom.RoomMsg.baseNum = msg.baseNum
		CatchPockRoom.RoomMsg.mcreenings = msg.mcreenings
		CatchPockRoom.RoomMsg.qualified = msg.qualified
		CatchPockRoom.RoomMsg.moneyType = msg.moneyType

		CatchPockRoom.RoomMsg.readyIndex = data.readyRoleIds
		CatchPockRoom.playersData = { }
		local userInfos = data.joinRoomUserInfo
		if msg.moneyType == RoomMode.roomCardMode then
			for i, v in ipairs(userInfos) do
				local joinRoomUserVo = JoinRoomUserVo:New()
				joinRoomUserVo.index = v.index
				joinRoomUserVo.roleId = v.roleId
				joinRoomUserVo.name = v.name
				joinRoomUserVo.ip = v.ip
				joinRoomUserVo.headImg = v.headImg
				joinRoomUserVo.jifen = 0
				joinRoomUserVo.gender = v.gender
				joinRoomUserVo.diamond = v.diamond
				joinRoomUserVo.goldcoin = v.goldcoin
				joinRoomUserVo.wing = v.wing

				CatchPockRoom.playersData[v.index] = joinRoomUserVo
				if v.roleId == global.userVo.roleId then
					CatchPockRoom.myIndex = v.index
				end
			end
			CatchPockRoom.playerCount = #CatchPockRoom.playersData
			print("JoinRoom-------------", #userInfos)
			local self = JoinRoomCtrl
			--Game.MusicEffect(Game.Effect.joinRoom)
			self:Close()
			MainSenceCtrl:Close()
			Game.LoadScene("room")
			CreateRoomCtrl.PlayEffectMusic()
			local co = coroutine.start( function()
				while not CH_GameMainCtrl.isCreate do
					coroutine.step()
				end
				CatchPockRoom:InitPlayers()
			end )
		else
			for i, v in ipairs(userInfos) do
				local joinRoomUserVo = JoinRoomUserVo:New()
				joinRoomUserVo.index = v.index
				joinRoomUserVo.roleId = v.roleId
				joinRoomUserVo.name = v.name
				joinRoomUserVo.ip = v.ip
				joinRoomUserVo.headImg = v.headImg
				joinRoomUserVo.jifen = 0
				joinRoomUserVo.gender = v.gender
				joinRoomUserVo.diamond = v.diamond
				joinRoomUserVo.goldcoin = v.goldcoin
				joinRoomUserVo.wing = v.wing
				CatchPockRoom.playersData[v.index] = joinRoomUserVo
				if v.roleId == global.userVo.roleId then
					CatchPockRoom.myIndex = v.index
				end
			end
			CatchPockRoom.playerCount = #CatchPockRoom.playersData
			local self = JoinRoomCtrl
			--Game.MusicEffect(Game.Effect.joinRoom)
			self:Close()
			MainSenceCtrl:Close()
			Game.LoadScene("room")
			CreateRoomCtrl.PlayEffectMusic()
			local co = coroutine.start( function()
				while not CH_GameMainCtrl.isCreate do
					coroutine.step()
				end
				CatchPockRoom:InitPlayers()
			end )
			table.insert(Network.crts, co)
		end
	elseif msg.gameType == 5 then
		data = JoinRoom_pb.NiuNiuInfo()
		data:ParseFromString(msg.dataRes)
		print("=====================Print niuniu JoninRoom info: ================")
		-- 游戏开始进入房间同意算观战玩家
		global.roomVo = RoomVo:New()
		NiuNiuRoom.RoomMsg.id = data.roomNum
		NiuNiuRoom.RoomMsg.totalJushu = data.totalJushu
		NiuNiuRoom.RoomMsg.maxNum = data.maxNum
		NiuNiuRoom.RoomMsg.baseScore = data.baseScore
		NiuNiuRoom.RoomMsg.special = data.special
		NiuNiuRoom.RoomMsg.maxPush = data.maxPush
		NiuNiuRoom.RoomMsg.seniorInfo = data.seniorInfo
		NiuNiuRoom.RoomMsg.moneyType = msg.moneyType
		NiuNiuRoom.RoomMsg.baseNum = msg.baseNum
		NiuNiuRoom.RoomMsg.qualified = msg.qualified
		NiuNiuRoom.RoomMsg.star = msg.star
		NiuNiuRoom.RoomMsg.costMoney = msg.costMoney
		NiuNiuRoom.RoomMsg.mcreenings = msg.mcreenings
		print("-----------JoinRoom-----------", msg.moneyType, NiuNiuRoom.RoomMsg.costMoney, msg.costMoney)
		NiuNiuRoom.playersData = { }
		local userInfos = data.joinRoomUserInfo
		for i, v in ipairs(userInfos) do
			local joinRoomUserVo = JoinRoomUserVo:New()
			joinRoomUserVo.index = v.index
			joinRoomUserVo.roleId = v.roleId
			joinRoomUserVo.name = v.name
			joinRoomUserVo.ip = v.ip
			joinRoomUserVo.headImg = v.headImg
			joinRoomUserVo.gender = v.gender
			joinRoomUserVo.diamond = v.diamond
			joinRoomUserVo.goldcoin = v.goldcoin
			joinRoomUserVo.wing = v.wing
			joinRoomUserVo.jifen = v.jifen
			joinRoomUserVo.isLook = v.isLook

			NiuNiuRoom.playersData[v.index] = joinRoomUserVo
			print("--------myIndex--------->>>>>>>>>", v.roleId, global.userVo.roleId, v.ready)
			if v.roleId == global.userVo.roleId then
				NiuNiuRoom.myIndex = v.index
				print("--------myIndex--------->>>>>>>>>", NiuNiuRoom.myIndex)
			end
			NiuNiuRoom.playerCount = #NiuNiuRoom.playersData
		end
		local self = JoinRoomCtrl
		--Game.MusicEffect(Game.Effect.joinRoom)
		self:Close()
		MainSenceCtrl:Close()
		Game.LoadScene("room")
		CreateRoomCtrl.PlayEffectMusic()
		local co = coroutine.start( function()
			while not TH_GameMainCtrl.isCreate do
				coroutine.step()
			end
			if msg.star == true then
				-- 游戏开始进入房间统一算为观战玩家
				print("-- 游戏开始进入房间统一算为观战玩家", msg.star)
				NiuNiuRoom:WatchJoinRoom(msg)
			else
				print("-- 游戏开始进入房间不能算为观战玩家", msg.star)
				NiuNiuRoom:InitPlayers()
			end
		end )
		table.insert(Network.crts, co)
	elseif msg.gameType == 6 then
		data = JoinRoom_pb.WuziqiInfo()
		data:ParseFromString(msg.dataRes)
		print("--------------->>>", data.roomNum, #data.joinRoomUserInfo)
		global.roomVo = RoomVo:New()
		UI_WuZiQiCtrl.RoomMsg.id = data.roomNum
		UI_WuZiQiCtrl.RoomMsg.bet = data.bet
		UI_WuZiQiCtrl.RoomMsg.jushu = data.jushu
		UI_WuZiQiCtrl.RoomMsg.roleNum = data.roleNum
		UI_WuZiQiCtrl.playersData = { }
		local userInfos = data.joinRoomUserInfo
		for i, v in ipairs(userInfos) do
			local joinRoomUserVo = JoinRoomUserVo:New()
			joinRoomUserVo.index = v.index
			joinRoomUserVo.roleId = v.roleId
			joinRoomUserVo.name = v.name
			joinRoomUserVo.ip = v.ip
			joinRoomUserVo.headImg = v.headImg
			joinRoomUserVo.jifen = 0
			joinRoomUserVo.gender = v.gender
			joinRoomUserVo.diamond = v.diamond
			joinRoomUserVo.goldcoin = v.goldcoin
			joinRoomUserVo.wing = v.wing
			UI_WuZiQiCtrl.playersData[v.index] = joinRoomUserVo
			if v.roleId == global.userVo.roleId then
				UI_WuZiQiCtrl.myIndex = v.index
			end
			print("=========OnJoinRoomRes6", v.index, v, name)
		end

		print("============UI_WuZiQiCtrl.RoomMsg.bet==================", UI_WuZiQiCtrl.RoomMsg.bet)
		UI_WuZiQiCtrl.playerCount = #UI_WuZiQiCtrl.playersData
		print("=========OnJoinRoomRes6", UI_WuZiQiCtrl.playerCount)
		local self = JoinRoomCtrl
		--Game.MusicEffect(Game.Effect.joinRoom)
		self:Close()
		MainSenceCtrl:Close()
		CreateRoomCtrl.PlayEffectMusic()
		UI_WuZiQiCtrl:Open("UI_WuZiQi", function()
			UI_WuZiQiPanel.AimgPlayer:SetActive(false)
			UI_WuZiQiPanel.BimgPlayer:SetActive(false)
			UI_WuZiQiCtrl:PlayerJoin()
			UI_WuZiQiPanel.btnSetting:SetActive(false)
			-- 输入学费按钮隐藏
			UI_WuZiQiPanel.btnSubmit:SetActive(false)
			-- 认输按钮隐藏
			self:SetText(UI_WuZiQiPanel.txtTuition, "学费: " .. UI_WuZiQiCtrl.RoomMsg.bet)
			-- 显示学费
		end )
		table.insert(Network.crts, co)
	elseif msg.gameType == 7 then
		data = JoinRoom_pb.MahjongInfo()
		data:ParseFromString(msg.dataRes)

		global.roomVo = RoomVo:New()
		global.roomVo.isFangzhu = 2
		global.roomVo.id = data.roomNum
		global.roomVo.total = data.jushu
		global.roomVo.isPlayNum = data.roleNum
		global.roomVo.modeType = data.modeType

		-- 新添加
		global.roomVo.baseNum = msg.baseNum
		global.roomVo.mcreenings = msg.mcreenings
		global.roomVo.qualified = msg.qualified
		global.roomVo.moneyType = msg.moneyType
		print('global.roomVo.baseNum = msg.baseNum=========', msg.baseNum, global.roomVo.baseNum)

		if data.zimohu == true then
			global.roomVo.isSelf = 1
		elseif data.zimohu == false then
			global.roomVo.isSelf = 2
		end

		if data.feng == true then
			global.roomVo.isFeng = 1
		elseif data.feng == false then
			global.roomVo.isFeng = 2
		end

		if data.hongzhong == true then
			global.roomVo.isRed = 1
		elseif data.hongzhong == false then
			global.roomVo.isRed = 2
		end

		if data.bihu == true then
			global.roomVo.isBihu = 1
		elseif data.bihu == false then
			global.roomVo.isBihu = 2
		end

		global.roomVo.isFishNum = data.yu


		local userInfos = data.joinRoomUserInfo
		print('data.watchBattleUserInfo===========', data.watchBattleUserInfo)
		local text4, text3, text2, text1, text5

		if global.roomVo.modeType == 1 then
			text5 = 'AA模式'
		else
			text5 = '老板模式'
		end

		if global.roomVo.moneyType == RoomMode.goldMode then
			text5 = ''
		elseif global.roomVo.moneyType == RoomMode.wingMode then
			text5 = ''
		end

		if global.roomVo.isFishNum == 0 then
			text4 = '不下鱼'
		else
			text4 = global.roomVo.isFishNum .. "条鱼"
		end

		if global.roomVo.isSelf == 1 then
			text3 = "自摸胡"
		else
			text3 = '点炮胡'
		end

		if global.roomVo.isBihu == 1 then
			text3 = "点炮必胡"
		end

		if global.roomVo.isFeng == 1 then
			text2 = "无风牌"
		else
			text2 = '有风牌'
		end

		if global.roomVo.isRed == 1 then
			text1 = '红中麻将'
		else
			text1 = "推倒胡"
		end
		global.roomVo.playMethod = text1 .. "  " .. text2 .. "  " .. text3 .. "  " .. text4 .. "  " .. text5
		global.joinRoomUserVos = { }
		for _, v in ipairs(userInfos) do
			local joinRoomUserVo = JoinRoomUserVo:New()
			joinRoomUserVo.index = v.index
			joinRoomUserVo.roleId = v.roleId
			joinRoomUserVo.name = v.name
			joinRoomUserVo.ip = v.ip
			joinRoomUserVo.headImg = v.headImg
			joinRoomUserVo.jifen = 1000
			joinRoomUserVo.diamond = v.diamond
			joinRoomUserVo.gender = v.gender
			joinRoomUserVo.goldcoin = v.goldcoin
			joinRoomUserVo.wing = v.wing

			global.joinRoomUserVos[v.index] = joinRoomUserVo
			global.setPosition[v.index] = joinRoomUserVo
			MahjongRoom.playersData[v.index] = joinRoomUserVo
			if v.roleId == global.userVo.roleId then
				MahjongRoom.myIndex = v.index
			end
			MahjongRoom.playerCount = #MahjongRoom.playersData
			print("global.joinRoomUserVo=jifen===", joinRoomUserVo.jifen)
		end
		local self = JoinRoomCtrl
		self:OnJoinRoomInfoShow()
		--Game.MusicEffect(Game.Effect.joinRoom)

		local co = coroutine.start( function()
			while not RM_GameMainCtrl.isCreate do
				coroutine.step()
			end
			RM_GameMainCtrl:headAndjifenShow()
		end )
		table.insert(Network.crts, co)
		Game.LoadScene("mahjong")
	elseif msg.gameType == 8 then
		data = JoinRoom_pb.DouDiZhuInfo()
		data:ParseFromString(msg.dataRes)
		global.roomVo = RoomVo:New()
		LandlordsRoom.RoomMsg.id = data.roomNum
		LandlordsRoom.RoomMsg.catchTotal = data.jushu
		-- 新添加
		LandlordsRoom.RoomMsg.baseNum = msg.baseNum
		LandlordsRoom.RoomMsg.mcreenings = msg.mcreenings
		LandlordsRoom.RoomMsg.qualified = msg.qualified
		LandlordsRoom.RoomMsg.moneyType = msg.moneyType
		LandlordsRoom.RoomMsg.readyIndex = data.readyRoleIds
		if data.laiZiGou == true then
			LandlordsRoom.RoomMsg.wanfaType = 1
		else
			LandlordsRoom.RoomMsg.wanfaType = 2
		end
		LandlordsRoom.RoomMsg.modeType = data.modeType
		LandlordsRoom.RoomMsg.maxMultiple = data.maxMultiple
		LandlordsRoom.playersData = { }
		local userInfos = data.joinRoomUserInfo
		if msg.moneyType == RoomMode.roomCardMode then
			for i, v in ipairs(userInfos) do
				local joinRoomUserVo = JoinRoomUserVo:New()
				joinRoomUserVo.index = v.index
				joinRoomUserVo.roleId = v.roleId
				joinRoomUserVo.name = v.name
				joinRoomUserVo.ip = v.ip
				joinRoomUserVo.headImg = v.headImg
				joinRoomUserVo.jifen = 0
				joinRoomUserVo.gender = v.gender
				joinRoomUserVo.diamond = v.diamond
				joinRoomUserVo.goldcoin = v.goldcoin
				joinRoomUserVo.wing = v.wing

				LandlordsRoom.playersData[v.index] = joinRoomUserVo
				if v.roleId == global.userVo.roleId then
					LandlordsRoom.myIndex = v.index
				end
			end
			LandlordsRoom.playerCount = #LandlordsRoom.playersData
			local self = JoinRoomCtrl
			--Game.MusicEffect(Game.Effect.joinRoom)
			self:Close()
			MainSenceCtrl:Close()
			Game.LoadScene("room")
			local co = coroutine.start( function()
				while not Ll_GameMainCtrl.isCreate do
					coroutine.step()
				end
				LandlordsRoom:InitPlayers()
			end )
		else
			for i, v in ipairs(userInfos) do
				local joinRoomUserVo = JoinRoomUserVo:New()
				joinRoomUserVo.index = v.index
				joinRoomUserVo.roleId = v.roleId
				joinRoomUserVo.name = v.name
				joinRoomUserVo.ip = v.ip
				joinRoomUserVo.headImg = v.headImg
				joinRoomUserVo.jifen = 0
				joinRoomUserVo.gender = v.gender
				joinRoomUserVo.diamond = v.diamond
				joinRoomUserVo.goldcoin = v.goldcoin
				joinRoomUserVo.wing = v.wing
				LandlordsRoom.playersData[v.index] = joinRoomUserVo
				if v.roleId == global.userVo.roleId then
					LandlordsRoom.myIndex = v.index
				end
			end
			LandlordsRoom.playerCount = #LandlordsRoom.playersData
			local self = JoinRoomCtrl
			--Game.MusicEffect(Game.Effect.joinRoom)
			self:Close()
			MainSenceCtrl:Close()
			Game.LoadScene("room")
			CreateRoomCtrl.PlayEffectMusic()
			local co = coroutine.start( function()
				while not Ll_GameMainCtrl.isCreate do
					coroutine.step()
				end
				LandlordsRoom:InitPlayers()
			end )
			table.insert(Network.crts, co)
		end
	elseif msg.gameType == 9 then
		data = JoinRoom_pb.BloodFightInfo()
		data:ParseFromString(msg.dataRes)

		global.roomVo = RoomVo:New()
		global.roomVo.isFangzhu = 2
		global.roomVo.id = data.roomNum
		global.roomVo.total = data.jushu
		global.roomVo.baseScore = data.baseScore
		global.roomVo.fanshu = data.fanshu
		global.roomVo.PlayMethodZimo = data.PlayMethodZimo
		global.roomVo.PlayMethodDiangang = data.PlayMethodDiangang
		global.roomVo.replaceCard = data.replaceCard
		global.roomVo.cardType = data.cardType
		global.roomVo.isPlayNum = 4

		-- 新添加
		global.roomVo.baseNum = msg.baseNum
		global.roomVo.mcreenings = msg.mcreenings
		global.roomVo.qualified = msg.qualified
		global.roomVo.moneyType = msg.moneyType
		print('global.roomVo.baseNum = msg.baseNum=========', msg.baseNum, msg.moneyType, data.roleNum)



		local userInfos = data.joinRoomUserInfo
		print('data.watchBattleUserInfo===========', data.watchBattleUserInfo)
		local text1
		if global.roomVo.replaceCard == 0 then
			text1 = '血战麻将'
		else
			text1 = '血战换三张'
		end

		global.roomVo.playMethod = text1
		-- global.roomVo.playMethod = text1.."  "..text2.."  "..text3.."\n".."\t\t      "..text4.."  "..text5
		-- global.roomVo.playMethod = text1.."  "..text2.."  "..text3.."\n"..text4.."     "..text5.." 带跟庄".."\n".."漏胡        荒庄加倍"

		global.joinRoomUserVos = { }
		if msg.moneyType == RoomMode.roomCardMode then
			for _, v in ipairs(userInfos) do
				local joinRoomUserVo = JoinRoomUserVo:New()
				joinRoomUserVo.index = v.index
				joinRoomUserVo.roleId = v.roleId
				joinRoomUserVo.name = v.name
				joinRoomUserVo.ip = v.ip
				joinRoomUserVo.headImg = v.headImg
				joinRoomUserVo.jifen = 1000
				joinRoomUserVo.diamond = v.diamond
				joinRoomUserVo.gender = v.gender
				joinRoomUserVo.goldcoin = v.goldcoin
				joinRoomUserVo.wing = v.wing

				global.joinRoomUserVos[v.index] = joinRoomUserVo
				global.setPosition[v.index] = joinRoomUserVo
				MahjongRoom.playersData[v.index] = joinRoomUserVo
				if v.roleId == global.userVo.roleId then
					MahjongRoom.myIndex = v.index
				end
				MahjongRoom.playerCount = #MahjongRoom.playersData
				print("global.joinRoomUserVo=jifen===", joinRoomUserVo.jifen, joinRoomUserVo.roleId, joinRoomUserVo.index, MahjongRoom.playerCount)
			end
			local self = JoinRoomCtrl
			self:OnJoinRoomInfoShow()
			--Game.MusicEffect(Game.Effect.joinRoom)

			local co = coroutine.start( function()
			while not XZ_GameMainCtrl.isCreate do
				coroutine.step()
			end
			--XZ_GameMainCtrl:headAndjifenShow()
			end )
			table.insert(Network.crts, co)
			Game.LoadScene("mahjong")
		else
			for _, v in ipairs(userInfos) do
				local joinRoomUserVo = JoinRoomUserVo:New()
				joinRoomUserVo.index = v.index
				joinRoomUserVo.roleId = v.roleId
				joinRoomUserVo.name = v.name
				joinRoomUserVo.ip = v.ip
				joinRoomUserVo.headImg = v.headImg
				joinRoomUserVo.jifen = 1000
				joinRoomUserVo.diamond = v.diamond
				joinRoomUserVo.gender = v.gender
				joinRoomUserVo.goldcoin = v.goldcoin
				joinRoomUserVo.wing = v.wing
				global.joinRoomUserVos[v.index] = joinRoomUserVo
				global.setPosition[v.index] = joinRoomUserVo
				MahjongRoom.playersData[v.index] = joinRoomUserVo
				if v.roleId == global.userVo.roleId then
					MahjongRoom.myIndex = v.index
				end
				MahjongRoom.playerCount = #MahjongRoom.playersData
				print("global.joinRoomUserVo=jifen===", joinRoomUserVo.jifen)
			end
			local self = JoinRoomCtrl
			self:OnJoinRoomInfoShow()
			--Game.MusicEffect(Game.Effect.joinRoom)
			local co = coroutine.start( function()
			while not XZ_GameMainCtrl.isCreate do
				coroutine.step()
			end
			XZ_GameMainCtrl:headAndjifenShow()
			end )
			table.insert(Network.crts, co)
			Game.LoadScene("mahjong")
		end
	end
end

function JoinRoomCtrl:OnJoinRoomInfoShow()
	if Game.GetSceneName() == "main" then
		self:Close()
		MainSenceCtrl:Close()
		RoleInfoCtrl:Close()
		Game.LoadScene("mahjong")
	end
	local isPlayNum = global.roomVo.isPlayNum
	if #global.joinRoomUserVos == isPlayNum then
		if global.joinRoomUserVos[isPlayNum].roleId == global.userVo.roleId then
			Mahjong.isLastJoin = true
		end
	end
end