Room = { }

local GAME_TYPE = { "", TenharfRoom, GoldFlowerRoom, CatchPockRoom, NiuNiuRoom, WuZiQi, LandlordsRoom, LandlordsRoom, LandlordsRoom }

function Room:Start()
	Util.ClearMemory()
	print("---------Room:Start------", self.gameType)
	self.roomObject = GAME_TYPE[self.gameType]
	print("---------Room:Start------", self.roomObject)
	self.roomObject.isPrefabLoaded = false
	self.roomObject.hasLoaded = false
	self.roomObject:LoadResources(self.gameType)
	TalkCtrl:Open("Talk", function()
		TalkCtrl:Close()
	end )
	if self.reloadData then
		self.roomObject:Reload(self.reloadData)
		self.reloadData = nil
	end
	self.localRoom = nil
	if Room.gameType == RoomType.Tenharf then
		self.localRoom = TenharfRoom
	elseif Room.gameType == RoomType.GoldFlower then
		self.localRoom = GoldFlowerRoom
	elseif Room.gameType == RoomType.CatchPock then
		self.localRoom = CatchPockRoom
	elseif Room.gameType == RoomType.NiuNiu then
		self.localRoom = NiuNiuRoom
	elseif Room.gameType == RoomType.WuZiQi then
		self.localRoom = UI_WuZiQiCtrl
	elseif Room.gameType == RoomType.Landlords then
		self.localRoom = LandlordsRoom
	end
	print("=======Room:Start=======self.localRoom====", self.localRoom)
	NoticeTipsCtrl:Open("NoticeTips")
	self.Normal = true
	self.btnStartClick = false
end

-- 收到服务器退出房间消息
function Room.OnQuitRoomRes(buffer)
	print("==========OnQuitRoomRes=====Room.gameType=====", Room.gameType)
	local data = buffer:ReadBuffer()
	local msg = IntTypeReturn_pb.IntTypeReturnRes()
	msg:ParseFromString(data)
	local intVal = msg.intVal
	if Room.gameType == RoomType.Mahjong then
		Event.Brocast(MsgDefine.Room_Exit)
		GameMainCtrl:Close()
	elseif Room.gameType == RoomType.Tenharf then
		TenharfRoom:ClearRoomInfo()
		TH_GameMainCtrl:Close()
	elseif Room.gameType == RoomType.GoldFlower then
		GoldFlowerRoom:ClearRoomInfo()
		TH_GameMainCtrl:Close()
	elseif Room.gameType == RoomType.CatchPock then
		CatchPockRoom:ClearRoomInfo()
		CH_GameMainCtrl:Close()
	elseif Room.gameType == RoomType.NiuNiu then
		NiuNiuRoom:ClearRoomInfo()
		TH_GameMainCtrl:Close()
		-- elseif UI_WuZiQiPanel and Room.gameType == RoomType.WuZiQi then
	elseif Room.gameType == RoomType.WuZiQi then
		UI_WuZiQiCtrl:ClearRoomInfo()
		UI_WuZiQiCtrl:Close()
		DissolutionRoomTipsCtrl:Close(true)
	elseif Room.gameType == RoomType.Landlords then
		LandlordsRoom:ClearRoomInfo()
		LandlordsRoom:Close()
	end
	-- 房主解散房间把断线重连状态去除
	Game.isReloadBattle = false
	Network.ClearCtrs()
	Game.LoadScene("main")
end

-- 解散房间回调--
function Room.ApplyDisRoomRes(buffer)
	print("------------------ApplyDisRoomRes---------------", buffer)
	local data = buffer:ReadBuffer()
	local msg = ApplyDisRoom_pb.ApplyDisRoomRes()
	msg:ParseFromString(data)
	global.applyDisRoomVo = RoomVo:New()
	log("applyDisRoomName" .. msg.name)
	global.applyDisRoomVo.roleId = msg.roleId
	global.applyDisRoomVo.name = msg.name
	global.applyDisRoomVo.time = msg.ms
	global.applyDisRoomVo.otherInfo = msg.disRoomInfo
	DissolutionRoomCtrl:Open("DissolutionRoom")
	Game.isReloadBattle = false
end

-- 收到别人断线重连消息
function Room.OfflinePushRes(buffer)
	local self = Room
	local data = buffer:ReadBuffer()
	local msg = OfflinePush_pb.OfflinePushRes()
	msg:ParseFromString(data)
	print("=========OfflinePushRes=========len", #msg)
	if Room.gameType == RoomType.Mahjong or Room.gameType == RoomType.BattleMahjong then
		if OB_GameMainPanel.isCreate then
			OB_GameMainPanel.OfflinePush(msg)
		elseif OB_GameMainCtrl.isCreate then
			OB_GameMainCtrl.OfflinePush(msg)
		end
	else
		if self.localRoom ~= nil then
			self.localRoom:OfflinePush(msg)
		end
	end

	if Room.gameType == RoomType.WuZiQi then
		-- 收到别人断线时候，五子棋房间提示信息
		Game.SendProtocal(Protocal.QuitMateRoom)
		local msg = "对方已掉线，您已退出房间！"
		MessageTipsCtrl:ShowInfo(msg)
	end
end

-- 接收GPS消息
function Room.LocationRes(buffer)
	print("-----///////////-------------GPS")
	local data = buffer:ReadBuffer()
	local msg = Location_pb.LocationRes()
	msg:ParseFromString(data)
	-- GPS数据解析
	local self = Room
	if Room.gameType == RoomType.Mahjong or Room.gameType == RoomType.BattleMahjong then
		OB_GameMainPanel.btnGPS:SetActive(false)
		return
	end
	if self.localRoom == nil then return end
	if self.localRoom.RoomMsg.moneyType ~= 0 then return end
	local mainPanel = nil
	if Room.gameType == RoomType.Mahjong then
		mainPanel = OB_GameMainCtrl
	elseif Room.gameType == RoomType.CatchPock then
		mainPanel = CH_GameMainCtrl
	else
		mainPanel = TH_GameMainCtrl
	end
	local co = coroutine.start( function()
		while not mainPanel.isCreate do
			coroutine.step()
		end
		self:SetGps(msg.infos)
	end )
	table.insert(Network.crts, co)
	print("-----///////////-------------GPS2")
end


-- Gps设置
function Room:SetGps(infos)
	print("-------SetGps-------1")

	local curList = { }
	local locationInfos = infos
	for k, v in ipairs(locationInfos) do
		local placeMsg = v.locationInfo
		local strArray
		strArray = string_split(placeMsg, "/")
		curList[tostring(v.roleId)] = { strArray[1], tonumber(strArray[2]), tonumber(strArray[3]) }
	end
	--     --假表--------------------------------------------
	-- global.gpsMsgInfo["1711"] = {"1",36.1001,54.2001}
	-- global.gpsMsgInfo["1723"] = {"1",36.1,54.2}
	-- --------------------------------------------------
	local info = curList
	self.gpsList = { }

	if IS_APP_STORE_CHECK then
		print("-------NoGPSInfo-------1")
	else
		if table_size(info) > 0 then
			-- 解析数据加入本地列表
			for i, v in pairs(info) do
				local curCache = self.localRoom:GetPlayerById(i)
				for j, k in ipairs(self.localRoom.players) do
					if i == k.id then
						if info[i][1] == "0" then
							local gpsInfo = { id = i, ip = curCache.ip, name = curCache.name, index = j, sitNum = curCache.sitIndex, open = false }
							table.insert(self.gpsList, gpsInfo)
						else
							local gpsInfo = { id = i, ip = curCache.ip, name = curCache.name, index = j, sitNum = curCache.sitIndex, open = true, coords = { info[i][2], info[i][3] } }
							table.insert(self.gpsList, gpsInfo)
						end
					end
				end
			end
		else
			print("-------NoGPSInfo-------3")
		end
	end

	table.sort(self.gpsList, function(a, b) return a.sitNum < b.sitNum end)
	global.gpsMsgInfo = curList
	if Room.gameType == RoomType.NiuNiu or Room.gameType == RoomType.Tenharf or Room.gameType == RoomType.GoldFlower then
		TH_GameMainPanel.btnGPS:SetActive(true)
	elseif Room.gameType == RoomType.CatchPock then
		CH_GameMainPanel.btnGPS:SetActive(true)
	elseif Room.gameType == RoomType.Mahjong then
		OB_GameMainPanel.btnGPS:SetActive(true)
	end

	-- 遍历本地列表检测信息
	for i, v in ipairs(self.gpsList) do
		-- 是否开启GPS,有一个未开启就弹出面板
		if not v.open then
			GPSInfoCtrl:Open("GPSInfo", function()
				GPSInfoCtrl:InitPanel(self.gpsList, self.localRoom)
			end )
			self.Normal = false
			break
		end
		-- 是否同IP，有一个相同就弹出面板
		for j, k in ipairs(self.gpsList) do
			print("------open--------", v.open, v.ip, k.open, k.ip)
			if v.id ~= k.id then
				if v.ip == k.ip then
					GPSInfoCtrl:Open("GPSInfo", function()
						GPSInfoCtrl:InitPanel(self.gpsList, self.localRoom)
					end )
					self.Normal = false
					break
				end
			end
		end

		-- 是否是距离过近
		local info = self.gpsList
		for j, k in ipairs(self.gpsList) do
			if i < j and i ~= #info then
				if k.open and info[j].coords[1] ~= nil then
					local length = GetDistance(info[i].coords[1], info[i].coords[2], info[j].coords[1], info[j].coords[2])
					if length <= 0.03 then
						GPSInfoCtrl:Open("GPSInfo", function()
							GPSInfoCtrl:InitPanel(self.gpsList, self.localRoom)
						end )
						self.Normal = false
						break
					end
				end
			end
		end
	end
	print("-------SetGps-------3")
end

-- 玩家退出
function Room.QuitMateRoomRes(buffer)
	local self = Room
	local data = buffer:ReadBuffer()
	local msg = QuitMateRoom_pb.QuitMateRes()
	msg:ParseFromString(data)

	print("=========QuitMateRoomRes======roleId===Room.gameType====", msg.roleId, Room.gameType)
	if Room.gameType == RoomType.Mahjong or Room.gameType == RoomType.BattleMahjong then
		Event.Brocast(MsgDefine.Room_Exit)
		XZ_GameMainCtrl:Close();
	elseif self.localRoom == nil then
		-- 房主解散房间把断线重连状态去除
		print("=========QuitMateRoomRes======self.localRoom is nil=======")
		if Room.gameType == RoomType.WuZiQi then
			UI_WuZiQiCtrl:ClearRoomInfo()
			UI_WuZiQiCtrl:Close()
			DissolutionRoomTipsCtrl:Close(true)
		end
	else
		print("=========QuitMateRoomRes=========", msg.roleId)
		local roleId = msg.roleId
		local mePlayer = self.localRoom:GetPlayer(self.localRoom.myIndex)
		local myId = 0
		if (mePlayer ~= nil) then myId = mePlayer.id end

		print("=========QuitMateRoomRes====money=====", self.localRoom.myIndex, roleId, myId)
		if roleId ~= tonumber(myId) then
			for _, v in ipairs(self.localRoom.players) do
				if v.isLook == true then
					if v.obj ~= nil then
						v.obj:SetActive(false)
						v:Destroy()
					end
				end
			end
			print("=====Room.QuitMateRoomRes=====Game.LoadScene==self.localRoom.players=={}====")
			self.localRoom.players = { }
			print("=========QuitMateRoomRes======close WuZiQi Room=======")
			if Room.gameType == RoomType.WuZiQi then
				UI_WuZiQiCtrl:ClearRoomInfo()
				UI_WuZiQiCtrl:Close()
				DissolutionRoomTipsCtrl:Close(true)
			end
		else
			if Room.gameType == RoomType.Mahjong then
				Event.Brocast(MsgDefine.Room_Exit)
				OB_GameMainCtrl:Close()
			elseif Room.gameType == RoomType.Tenharf then
				TenharfRoom:ClearRoomInfo()
				TH_GameMainCtrl:Close()
			elseif Room.gameType == RoomType.GoldFlower then
				GoldFlowerRoom:ClearRoomInfo()
				TH_GameMainCtrl:Close()
			elseif Room.gameType == RoomType.CatchPock then
				CatchPockRoom:ClearRoomInfo()
				CH_GameMainCtrl:Close()
			elseif Room.gameType == RoomType.NiuNiu then
				NiuNiuRoom:ClearRoomInfo()
				TH_GameMainCtrl:Close()
			elseif Room.gameType == RoomType.WuZiQi then
				UI_WuZiQiCtrl:ClearRoomInfo()
				UI_WuZiQiCtrl:Close()
				DissolutionRoomTipsCtrl:Close(true)
			elseif RoomType.gameType == RoomType.LandlordsRoom then
				LandlordsRoom:ClearRoomInfo()
				LandlordsRoom:Close()
			end
		end
		
	end
	-- 房主解散房间把断线重连状态去除
	Game.isReloadBattle = false
	print("=====Room.QuitMateRoomRes=====Network.ClearCtrs====")
	Network.ClearCtrs()
	-- 清理携程
	print("=====Room.QuitMateRoomRes=====Game.LoadScene==main====")
	Game.LoadScene("main")
end

-- 观战玩家加入
function Room.WatchPlayerRes(buffer)
	local self = Room
	local data = buffer:ReadBuffer()
	local msg = JoinRoom_pb.JoinRoomRes()
	msg:ParseFromString(data)

	local wacthData = { }
	if msg.gameType == 5 then
		datas = JoinRoom_pb.NiuNiuInfo()
		datas:ParseFromString(msg.dataRes)
	elseif msg.gameType == 3 then
		datas = JoinRoom_pb.JinHuaInfo()
		datas:ParseFromString(msg.dataRes)
	elseif msg.gameType == 2 then
		datas = JoinRoom_pb.TenHalfInfo()
		datas:ParseFromString(msg.dataRes)
	end
	local join = false
	wacthData = datas.watchBattleUserInfo
	for i, v in ipairs(wacthData) do
		if v.roleId == global.userVo.roleId then
			join = true
		end
	end
	if join then return end
	if self.localRoom == nil then return end

	if self.localRoom.RoomMsg.moneyType == 3 then return end
	if Room.gameType ~= RoomType.NiuNiu and Room.gameType ~= RoomType.Tenharf and Room.gameType ~= RoomType.GoldFlower then return end
	-- 十点半、扎金花、牛牛
	if wacthData[1] ~= nil then
		if self.localRoom ~= nil then
			self.localRoom:CreateWatchPlayer(wacthData)
		end
	else
		if self.localRoom ~= nil then
			self.localRoom:ClaernWatchPlayer(wacthData)
		end
	end
end