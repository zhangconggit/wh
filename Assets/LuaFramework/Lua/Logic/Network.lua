require "Common/define"
require "Common/protocal"
require "Common/functions"
Event = require 'events'


require "3rd/pblua/Version_pb"
require "3rd/pblua/ErrorCode_pb"
require "3rd/pblua/LongTypeReturn_pb"
require "3rd/pblua/ReLoad_pb"
require "3rd/pbc/protobuf"
require "Model/Global"

local sproto = require "3rd/sproto/sproto"
local core = require "sproto.core"
local print_r = require "3rd/sproto/print_r"

Network = { }
local this = Network

local transform
local gameObject
local timer = 20.0
local lastTime = 0
local currentTime = 0
local subTime = 0
local netState = 0
local netType = 0
local msgQueue = Queue:New()

-- 战斗复盘的时候可能会发送的都放这里
local delayKey = {
	[10010] = 1,
	[10020] = 1,
	[10021] = 1,
	[10016] = 1,
	[10017] = 1,
	[10012] = 1,
	[17001] = 1,
	[10011] = 1,
	[11004] = 1,
	[10013] = 1,
	[30004] = 1,
	[30005] = 1,
	[30006] = 1,
	[30008] = 1,
	[30009] = 1,
	[30010] = 1,
	[30011] = 1,
	[30012] = 1,
	[30013] = 1,
	[31003] = 1,
	[31004] = 1,
	[31005] = 1,
	[31006] = 1,
	[31007] = 1,
	[31008] = 1,
	[31009] = 1,

	[32004] = 1,
	[32005] = 1,
	[32007] = 1,
	[32008] = 1,

	[33004] = 1,
	[33005] = 1,
	[33006] = 1,
	[33007] = 1,
	[33008] = 1,
	[33009] = 1,
	[33010] = 1,
	[33011] = 1,
	[33012] = 1,
	[33013] = 1,

	[34002] = 1,
	[34004] = 1,
	[34005] = 1,
	[34006] = 1,
}

 
-- 初始化消息号
local initKey = {
	[10009] = 1,
	[30002] = 1,
	[31002] = 1,
	[32002] = 1,
	[32003] = 1,
	[33003] = 1,
	[34007] = 1,
}

function Network.Start()
	logWarn("Network.Start!!")
	this.canReconnect = os.time()
	this.reconnectCount = 0
	this.connectCount = 0
	-- 用于存储协程		
	this.crts = { }

	-- 心跳处理
	coroutine.start(this.Update)
	coroutine.start(this.SendHeartBeat)
end

-- Socket消息--
function Network.OnSocket(key, data)
	if key ~= 10004 then
		print("Network.OnSocket", key)
	else
		if Network.curTime then
			network_delay = tostring(Util.GetTime() - Network.curTime)
			network_delay = tonumber(network_delay)
			Network.curTime = nil
			TipCtrl:Show("")
			print("=============delay", network_delay)
		end
	end

	msgQueue:Push( { key, data })
	-- this.RealOnSocket(key, data)
end

function Network.Update()
	while true do
		if Network.curTime then
			local delay = tostring(Util.GetTime() - Network.curTime)
			delay = tonumber(delay)
			if delay >= 2000 then
				TipCtrl:Show("无法连接网络，请稍后重试")

				if delay >= 5000 then
					print("==============delay>=5000")
					networkMgr:SocketClose()
					this.NotConnect()
				end
			end
		end
		if not msgQueue:IsEmpty() then
			this.RealOnSocket(unpack(msgQueue:Pop()))
		end
		coroutine.wait(0.1)
	end
end

-- 阻塞消息用的(主要用于暂停，客户端没死的情况下其他人发的消息在正常上线之后按顺序处理)
function Network.RealOnSocket(key, data)
	if delayKey[key] then
		local co = coroutine.start( function()
			if Room.gameType == 1 or Room.gameType == RoomType.BattleMahjong then
				while not gameRoom do
					coroutine.step()
				end
				while not gameRoom.hasReload do
					coroutine.step()
				end
			else
				while not Room.roomObject do
					coroutine.step()
				end
				while not Room.roomObject.hasLoaded do
					coroutine.step()
				end
			end
			-- Event.Brocast(tostring(key), data)
			EventManager.DispatchEvent(tostring(key), data)
		end )
		table.insert(this.crts, co)
	elseif initKey[key] then
		local co = coroutine.start( function()
			if Room.gameType == 1 or Room.gameType == RoomType.BattleMahjong then
				while not gameRoom do
					coroutine.step()
				end
				while not gameRoom.isPrefabLoaded do
					coroutine.step()
				end
			else
				while not Room.roomObject do
					coroutine.step()
				end
				while not Room.roomObject.isPrefabLoaded do
					coroutine.step()
				end
			end
			EventManager.DispatchEvent(tostring(key), data)
		end )
		table.insert(this.crts, co)
	else
		-- Event.Brocast(tostring(key), data)
		EventManager.DispatchEvent(tostring(key), data)
	end
end

-- 当连接建立时--
function Network.OnConnect()
	print("===连接建立=====Network.OnConnect")
	-- 发送握手协议；
	this.reconnectCount = 0
	TipCtrl:Show("")
	this.connectCount = this.connectCount + 1
	local buffer = ByteBuffer.New()
	buffer:WriteInt(Protocal.Version)
	buffer:WriteInt(this.connectCount)
	networkMgr:SendMessage(buffer)
end

-- 无法连接网络
function Network.NotConnect()
	print("====无法连接网络=========Network.NotConnect")
	this.curTime = nil
	TipCtrl:Show("无法连接网络，请稍后重试")
	AppConst.uuuIdKeyBytes = nil
	if AppConst.getNetType() == 0 then
		networkMgr:SocketClose()
	else
		if not this.isServerStop then
			Network.Reconnect()
		end
	end
end

-- 异常断线--
function Network.OnException()
	this.islogging = false
	-- NetManager:SendConnect()
	-- 信息提示面板--
	-- local msg = '异常断线'
	-- MessageTipsCtrl:Open("MessageTips")
	MessageTipsCtrl:ShowInfo('异常断线')
end

-- 连接中断，或者被踢掉--
function Network.OnDisconnect()
	this.islogging = false
	-- 信息提示面板--
	--  local msg = '连接中断'
	-- MessageTipsCtrl:Open("MessageTips")
	MessageTipsCtrl:ShowInfo('连接中断')
end

-- 握手协议--
function Network.OnVersion(buffer)

	local data = buffer:ReadBuffer()
	local msg = Version_pb.VersionRes()

	msg:ParseFromString(data)

	AppConst.uuuIdKey = msg.uuuIdKey
	local version = msg.version
	AppConst.appId = msg.appId
	AppConst.appSecret = msg.appSecret
	print("===========Network.OnVersion", msg.uuuIdKey, version, msg.onlySign, AppConst.version)
	-- 判断版本是否有热更新或者大版本更新
	if AppConst.UpdateMode and version ~= AppConst.version then
		local newVersion = string_split(version, "%.")
		local oldVersion = string_split(AppConst.version, "%.")
		if tonumber(newVersion[1]) * 100 + tonumber(newVersion[2]) > tonumber(oldVersion[1]) * 100 + tonumber(oldVersion[2]) then
			MessageTipsCtrl:ShowInfo("发现新版本，请下载最新版本")
			Game.hasNewVersion = true
			return
		elseif tonumber(newVersion[3]) > tonumber(oldVersion[3]) then
			-- MessageTipsCtrl:ShowInfo("发现新资源，点击确定后更新")
			-- Game.needUpdate = true
			MessageTipsCtrl:ShowInfo("发现新资源，请重新打开客户端，点击确定后退出")
			Game.hasNewVersion = true
			return
		end
		print("============ version ~= AppConst.version")
	end

	print("=========Network.OnVersion count", msg.onlySign, this.connectCount)
	if msg.onlySign ~= this.connectCount then
		return
	end
	Util.InitUUUIdKey()

	global.isSendGPS = false
	print("=========Network.OnVersion isRecon", this.isRecon)
	if this.isRecon then
		print("=========Network.OnVersion userVo", global.userVo)
		if global.userVo then
			local data = ReLoad_pb.ReLoadReq()
			data.pid = AppConst.getCurrentPlatform()
			data.userId = AppConst.getPlayerPrefs('userID')
			data = data:SerializeToString()
			Game.SendProtocal(Protocal.ReLoad, data)
		else
			BlockLayerCtrl:Close()
		end
		-- 发送GPS信息
		if IS_APP_STORE_CHECK == false then
			Input.location:Start(10, 10);
			coroutine.start(MainSenceCtrl.LocationReq)
			print("========SendGPS======Network")
		end
		this.isRecon = false
	else
		BlockLayerCtrl:Close()
	end
end

-- 登录返回--
function Network.OnErrorRes(buffer)
	--[[
	    for _,v in ipairs(decode.phone) do
			print("\t"..v.number, v.type)
		end
	----------------------------------------------------
    local ctrl = CtrlManager.GetCtrl(CtrlNames.Message)
    if ctrl ~= nil then
    ctrl:Awake()
    end--]]
	local data = buffer:ReadBuffer()
	local msg = ErrorCode_pb.ErrorCodeRes()
	msg:ParseFromString(data)
	logWarn('Server Result Error-------->>>' .. msg.errorCode)
	-- 信息提示面板--
	-- MessageTipsCtrl:Open("MessageTips")
	local info = errorCode[msg.errorCode] or msg.errorCode
	-- 回放时不弹出提示窗口
	if GradeDetailCtrl.isPlayBackTiShi then
		GradeDetailCtrl.isPlayBackTiShi = false
	else
		if msg.errorCode == 1040 or msg.errorCode == 1018 then
			this.isServerStop = true
		end
		if msg.errorCode == 1091 or msg.errorCode == 1092 or msg.errorCode == 1093 or
			msg.errorCode == 1107 or msg.errorCode == 1094 then
			CatchPockRoom:ErrorCodeShow(msg.errorCode)
			return
		end
		MessageTipsCtrl:ShowInfo(info)
		BlockLayerCtrl:Close()
	end
end

function Network.SendHeartBeat()
	while true do
		coroutine.wait(10)
		print("============Network.SendHeartBeat")
		Game.SendProtocal(Protocal.HeartBeat)
	end
end

function Network.OnHeartBeatRes(buffer)

	local data = buffer:ReadBuffer()
	local msg = LongTypeReturn_pb.LongTypeReturnRes()
	msg:ParseFromString(data)
	local nowTime = msg.nowTime
	-- long型时间戳
	timer = 20.0
end

-- --发送重连请求
-- function Network.OnReLoadReq()
-- 	local buffer = ByteBuffer.New()
--     	buffer:WriteInt(tonumber(Protocal.ReLoad))
--     	networkMgr:SendMessage(buffer)		
-- end

-- 重连回调
function Network.OnReLoadRes(buffer)
	Util.ClearMemory()
	print("=====Network.OnReLoadRes====begin=====")
	local data = buffer:ReadBuffer()
	local msg = ReLoad_pb.ReLoadRes()
	msg:ParseFromString(data)
	print("=====Network.OnReLoadRes====msg.type=====", msg.type)
	MainSenceCtrl.SendLocation()
	print("=====Network.OnReLoadRes====finished MainSenceCtrl.SendLocation=====")
	BlockLayerCtrl:Close()
	LoginCtrl.isFormLogin = false
	if msg.type == 1 then
		Room.gameType = msg.type
		data = ReLoad_pb.MahjongReload()
		data:ParseFromString(msg.dataRes)
		Mahjong.reloadData = data
		-- GameRoom里的Reload里用的到
		if Game.GetSceneName() == "mahjong" then
			Game.isReloadBattle = true
			CtrlManager.RemoveAll()
			gameRoom.hasReload = false
			SceneManager.LoadScene("mahjong")
		else
			Game.LoadScene("mahjong")
		end
		return
	elseif msg.type == 2 then
		Room.gameType = msg.type
		data = ReLoad_pb.TenhalfReload()
		data:ParseFromString(msg.dataRes)
	elseif msg.type == 3 then
		Room.gameType = msg.type
		data = ReLoad_pb.GoldFlowerReload()
		data:ParseFromString(msg.dataRes)
	elseif msg.type == 4 then
		Room.gameType = msg.type
		data = ReLoad_pb.CatchPockReload()
		data:ParseFromString(msg.dataRes)
	elseif msg.type == 5 then
		Room.gameType = msg.type
		data = ReLoad_pb.NiuniuReload()
		data:ParseFromString(msg.dataRes)
	elseif msg.type == 6 then
		Room.gameType = msg.type
		-----------------------------------------------**************************************
		MainSenceCtrl:Open("MainSence")
		if UI_WuZiQiCtrl then
			UI_WuZiQiCtrl:Close(true)
		end
	elseif msg.type == 101 then
		print("============= msg.type55555", msg.type)
		print("=====Network.OnReLoadRes====GradeDetailCtrl.isPlayBackReload=====", GradeDetailCtrl.isPlayBackReload)
		print("=====Network.OnReLoadRes====Room.gameType=====", Room.gameType)
		if GradeDetailCtrl.isPlayBackReload then
			GameMainCtrl:OnPlayBackQuit()
		else
			-- 服务器断掉或者被踢的情况下要清理数据以及表现层
			if Room.gameType == RoomType.Tenharf then
				TenharfRoom:ClearRoomInfo()
			elseif Room.gameType == RoomType.GoldFlower then
				GoldFlowerRoom:ClearRoomInfo()
			elseif Room.gameType == RoomType.NiuNiu then
				NiuNiuRoom:ClearRoomInfo()
			end
			if GameMatchCtrl.isCreate then
				GameMatchCtrl:Close()
			end
			if GameRoomCardMatchCtrl.isCreate then
				GameRoomCardMatchCtrl:Close(true)
			end
			if ActivityCtrl.isCreate then
				ActivityCtrl:Close(true)
			end
			GameRoomCardMatchCtrl.joinOK = false
			Game.LoadScene("main")
		end
		return
	else
		print("ErrorGameType!!")
		return
	end
	if Room.gameType == 6 then
		Game.LoadScene("main")
		return
	end
	-- 十点半、扎金花重连
	print("TH、GF------------1")
	Room.reloadData = data
	if Game.GetSceneName() == "room" then
		-- 房间等待界面 服务器会推送加入房间消息
		Game.isReloadBattle = true
		CtrlManager.RemoveAll()
		Game.hasLoaded = false
		print("battleReload-------begin-----2")
		-- Game.isTenHarfPrefabLoaded = false
		SceneManager.LoadScene("room")
		print("battleReload------end------2")
	else
		print("LoginReload-------beging-----1")
		Game.LoadScene("room")
		print("LoginReload------end------1")
	end

	isPlayerReload = true
	-- 收到重连消息的时候设置一个断线重连的状态
end

function Network.Reconnect()
	if this.reconnectCount > 3 then
		print("===========Network.Reconnect reconnectCount > 3")
		MessageTipsCtrl:ShowInfo("无法连接网络，请稍后重试")
		return
	end
	local time = os.time()
	if time >= this.canReconnect then
		this.canReconnect = time + 5
		this.reconnectCount = this.reconnectCount + 1
		this.ClearCtrs()
		BlockLayerCtrl:UsualOpen("BlockLayer")
		networkMgr:SendConnect()
		if Game.GetSceneName() ~= "login" then
			this.isRecon = true
		end
	end
end

-- 清理携程数据，防止冗余数据过多
function Network.ClearCtrs()
	for _, v in ipairs(this.crts) do
		coroutine.stop(v)
	end
	this.crts = { }
end

-- 卸载网络监听--
function Network.Unload()
	--    Event.RemoveListener(Protocal.Connect)
	--    Event.RemoveListener(Protocal.Exception)
	--    Event.RemoveListener(Protocal.Disconnect)
	-- Event.RemoveListener(Protocal.Version)
	-- Event.RemoveListener(Protocal.ServerError)
	-- Event.RemoveListener(Protocal.HeartBeat)
	-- Event.RemoveListener(Protocal.ReLoad)
end