CreateCatchRoomCtrl = {}

setbaseclass(CreateCatchRoomCtrl,{BaseCtrl})

local roomCatchVo

--启动事件--
function CreateCatchRoomCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self,obj)
	----捉麻子
	self:AddOnValueChanged(CreateRoomPanel.zhuoTog8Inning, self.OnzhuoTog8InningClick)
	self:AddOnValueChanged(CreateRoomPanel.zhuoTog16Inning, self.OnzhuoTog16InningClick)
	self:AddClick(CreateRoomPanel.zhuoBtnCreate , self.OnCreateBtnClick)
end

function CreateCatchRoomCtrl:InitPanel(userInfo)
	print("CreateCatchRoomCtrl:InitPanel---------------",userInfo.diamond)
	roomCatchVo = RoomCatchVo:New()
	roomCatchVo.catchTotal    		= 8
	self:SetText(CreateRoomPanel.zhuoTxtDiamond ,"x" .. userInfo.diamond)

	if AppConst.getPlayerPrefs("catchTotal") == "" then
		CreateRoomPanel.zhuoTog8Inning :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.zhuoTog8InningTxt1  ,"<color=#48BDFF>8局[每人</color>")
		self:SetText(CreateRoomPanel.zhuoTog8InningTxt2  ,"<color=#48BDFF>       x1]</color>")

		CreateRoomPanel.zhuoTog16Inning :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.zhuoTog16InningTxt1 ,"<color=#5D6D6D>16局[每人</color>")
		self:SetText(CreateRoomPanel.zhuoTog16InningTxt2,"<color=#5D6D6D>       x2]</color>") 
	end
end

function CreateCatchRoomCtrl.OnCreateBtnClick(go)
	local self = CreateCatchRoomCtrl
	CreateRoomCtrl.PlayEffectMusic()
	global.systemVo.TalkSource:Stop() 

	local CreateCatchRoom = CreateCatchPockRoom_pb.CreateCatchPockRoomReq()
	CreateCatchRoom.zhuoMaZiTotal     		 = roomCatchVo.catchTotal

	AppConst.setPlayerPrefs("catchTotal",tostring(roomCatchVo.catchTotal))
	AppConst.setPlayerPrefs("diamondPay",tostring(roomCatchVo.diamondPay))
	AppConst.setPlayerPrefs("createGameType",4)	 

	local msg = CreateCatchRoom:SerializeToString()
	Game.SendProtocal(Protocal.CreateCatchPockRoom, msg)
end

function CreateCatchRoomCtrl.OnCreateCatchRoomRes(buffer)
	print("------------------------------",buffer)
    local self = CreateCatchRoomCtrl
	local data   = buffer:ReadBuffer()
	local msg    = CreateCatchPockRoom_pb.CreateCatchPockRoomRes()	
	msg:ParseFromString(data)
	if msg.moneyType == RoomMode.roomCardMode then	
	   CatchPockRoom.RoomMsg = roomCatchVo
	   CatchPockRoom.RoomMsg.id = msg.roomNum
	   CatchPockRoom.RoomMsg.isFangzhu = 1
	else
	   roomCatchVo = RoomCatchVo:New()
	   CatchPockRoom.RoomMsg = roomCatchVo
	   CatchPockRoom.RoomMsg.id = msg.roomNum
	   CatchPockRoom.RoomMsg.isFangzhu = 1
	   --新添加
	   CatchPockRoom.RoomMsg.baseNum    = msg.baseNum
	   CatchPockRoom.RoomMsg.qualified  = msg.qualified
	   CatchPockRoom.RoomMsg.moneyType  = msg.moneyType
	   CatchPockRoom.RoomMsg.mcreenings = msg.mcreenings
	end

	print("OnCreateCatchRoomRes=======",msg.roomNum)
	-- -- 创建房间的人。加入到数据缓存中
	local joinRoomUserVo     = JoinRoomUserVo:New()
	local userVo = global.userVo
	joinRoomUserVo.index     = 1
	joinRoomUserVo.roleId    = userVo.roleId
	joinRoomUserVo.name      = userVo.name
	joinRoomUserVo.ip        = userVo.roleIp
	joinRoomUserVo.headImg   = userVo.headImg
	joinRoomUserVo.jifen     = 0
	joinRoomUserVo.gender 	 = userVo.gender
	joinRoomUserVo.diamond	 = userVo.diamond
	--新添加
	joinRoomUserVo.goldcoin = userVo.goldcoin --金币数量
	joinRoomUserVo.wing 	= userVo.wing     --元宝数量

	CatchPockRoom.playersData[1] = joinRoomUserVo
	CatchPockRoom.playerCount = 1
	CatchPockRoom.myIndex = 1

	--self:Close()
	MainSenceCtrl:Close()
	Room.gameType = RoomType.CatchPock

	Game.LoadScene("room")
	CreateRoomCtrl.PlayEffectMusic()
end

function CreateCatchRoomCtrl.OnzhuoTog8InningClick(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomCatchVo.catchTotal = 8
		self:SetText(CreateRoomPanel.zhuoTog8InningTxt1  ,"<color=#48BDFF>8局[每人</color>")
		self:SetText(CreateRoomPanel.zhuoTog8InningTxt2  ,"<color=#48BDFF>       x1]</color>")
     else
		self:SetText(CreateRoomPanel.zhuoTog8InningTxt1  ,"<color=#5D6D6D>8局[每人</color>")
		self:SetText(CreateRoomPanel.zhuoTog8InningTxt2  ,"<color=#5D6D6D>       x1]</color>")
     end 
end

function CreateCatchRoomCtrl.OnzhuoTog16InningClick(go,bool)
    local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomCatchVo.catchTotal = 16
		self:SetText(CreateRoomPanel.zhuoTog16InningTxt1 ,"<color=#48BDFF>16局[每人</color>")
		self:SetText(CreateRoomPanel.zhuoTog16InningTxt2,"<color=#48BDFF>       x2]</color>")
     else
		self:SetText(CreateRoomPanel.zhuoTog16InningTxt1 ,"<color=#5D6D6D>16局[每人</color>")
		self:SetText(CreateRoomPanel.zhuoTog16InningTxt2,"<color=#5D6D6D>       x2]</color>")
     end
end