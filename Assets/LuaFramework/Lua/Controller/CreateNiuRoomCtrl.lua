--牛牛
CreateNiuRoomCtrl = {
}
setbaseclass(CreateNiuRoomCtrl,{BaseCtrl})

local roomNiuVo
--启动事件--
function CreateNiuRoomCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self,obj)
	--按钮配置表
	self.btnTable ={tog10Inning 	= {btnType = 1, name = "niuTog10Inning"	,value = 10		,txt = "10局	(房卡X2)"},
					tog20Inning 	= {btnType = 1, name = "niuTog20Inning"	,value = 20		,txt = "20局 	(房卡X3)"},
					togHave			= {btnType = 2, name = "niuTogHave"		,value = true	,txt = "有花牌"},	   
					togNone			= {btnType = 2, name = "niuTogNone"		,value = false	,txt = "无花牌"},
					togNiuQiang		= {btnType = 3, name = "niuTogQiang"	,value = 1		,txt = "经典抢庄"},	
					togNiuBank		= {btnType = 3, name = "niuTogBank"		,value = 2		,txt = "牛牛坐庄"},
					togNiuLun		= {btnType = 3, name = "niuTogLun"		,value = 3		,txt = "轮流坐庄"},
					togFang			= {btnType = 3, name = "niuTogFang"		,value = 4		,txt = "房主坐庄"},
					togMin5			= {btnType = 4, name = "niuTogMin5"		,value = "17"	,txt = "五小牛"},	   	
					togBoom			= {btnType = 4, name = "niuTogBoom"		,value = "15"	,txt = "炸弹牛"},	   
					togHua5			= {btnType = 4, name = "niuTogHua5"		,value = "12"	,txt = "五花牛"}}
	self.specialList = {togMin5 	= "",
						togBoom  	= "",
					    togHua5 	= ""}
	--添加点击事件
	for k,v in pairs(self.btnTable) do
		self:AddOnValueChanged(CreateRoomPanel[v.name],self.OnNiuNiuTogClick)
	end
	self:AddClick(CreateRoomPanel.niuBtnCreate , self.OnCreateBtnClick)
end

function CreateNiuRoomCtrl:InitPanel(userInfo)
	--房间信息表
	roomNiuVo = RoomNiuVo:New()
	self.roomInfo ={{name = "totalJushu", 		value = roomNiuVo.totalJushu},
					{name = "king", 			value = roomNiuVo.king},
					{name = "niuniuGameType", 	value = roomNiuVo.niuniuGameType},
					{name = "special", 			value = roomNiuVo.special}}

	print("=============CreateNiuRoomCtrl=========",#self.roomInfo)
	--读取房间缓存信息
	for i=1,#self.roomInfo do
		local cacheValue = self:GetCacheBtn(self.roomInfo[i].name,i)
		local strArray = ""
		local curTable = {}
		if i == 4 then
			curTable = self.specialList
			strArray = string_split(cacheValue,"|")
		end
		for m,n in pairs(self.btnTable) do
			if i == n.btnType then
				if n.btnType == 2 then cacheValue = tonumber(cacheValue) end
				self:SetColorBtn(n.name,n.txt,false)
				CreateRoomPanel[n.name]:GetComponent('Toggle').isOn = false
				
				if strArray == "" then
					if cacheValue == n.value then
						CreateRoomPanel[n.name]:GetComponent('Toggle').isOn = true
						break
					end
				else
					for a,b in ipairs(strArray) do
						if n.value == b then
							CreateRoomPanel[n.name]:GetComponent('Toggle').isOn = true
							curTable[m] = b
						end
					end
				end
			end
		end
	end
	self:SetText(CreateRoomPanel.niuTxtDiamond ,"x" .. userInfo.diamond)
end

--创建房间请求
function CreateNiuRoomCtrl.OnCreateBtnClick(go)
	local self = CreateNiuRoomCtrl
	--CreateRoomCtrl.PlayEffectMusic()
	global.systemVo.TalkSource:Stop() 
	local CreateNiuRoom = CreateNiuNiuRoom_pb.CreateNiuNiuRoomReq()
	local info = self.roomInfo

	--本地缓存信息
	for m,n in ipairs(info) do
		local msg = ""
		if m == 4 then
			local i = 0
			for k,v in pairs(self.specialList) do
				i = i + 1
				if v ~= "" then
					if i ~= 1 then
						msg = msg.."|"..v
					elseif i == 1 then
						msg = v
					end
				end
			end
		else
			msg = n.value
		end
		n.value = msg
		self:SetCacheBtn(n.name,n.value)
		print("--------value----------",n.value)
	end

	--CreateNiuRoom.leaderZhuang  = false
	--CreateNiuRoom.doubleRule    = 2
	--CreateNiuRoom.maxZhuang     = 4
	--CreateNiuRoom.maxNum     	= 6
	--CreateNiuRoom.baseScore     = ""
	--CreateNiuRoom.maxPush     	= 40
	--CreateNiuRoom.seniorInfo  	= ""

	CreateNiuRoom.totalJushu    = info[1].value
	CreateNiuRoom.king     		= info[2].value
	CreateNiuRoom.niuniuGameType= info[3].value
	CreateNiuRoom.special     	= info[4].value
	

	NiuNiuRoom.RoomMsg.totalJushu    	= info[1].value
	NiuNiuRoom.RoomMsg.king     	 	= info[2].value
	NiuNiuRoom.RoomMsg.niuniuGameType   = info[3].value
	NiuNiuRoom.RoomMsg.special     	 	= info[4].value

	for i,v in ipairs(info) do
		print("===============================创建房间发送的值======================================",i,v.value)
	end
	local msg = CreateNiuRoom:SerializeToString()
	Game.SendProtocal(Protocal.CreateNiuRoom, msg)
end

--创建房间回调
function CreateNiuRoomCtrl.OnCreateNiuRoomRes(buffer)
    local self = CreateNiuRoomCtrl
	local data   = buffer:ReadBuffer()
	local msg    = CreateNiuNiuRoom_pb.CreateNiuNiuRoomRes()	
	msg:ParseFromString(data)
	if msg.moneyType == RoomMode.roomCardMode then
	   NiuNiuRoom.RoomMsg.id = msg.roomNum
	   NiuNiuRoom.RoomMsg.isFangzhu = 1
	   NiuNiuRoom.RoomMsg.moneyType = msg.moneyType
	   NiuNiuRoom.RoomMsg.baseNum = msg.baseNum
	   NiuNiuRoom.RoomMsg.qualified = msg.qualified
	else
	   roomNiuVo = RoomNiuVo:New()
	   NiuNiuRoom.RoomMsg = roomNiuVo
	   NiuNiuRoom.RoomMsg.id = msg.roomNum
	   NiuNiuRoom.RoomMsg.isFangzhu = 1
	   NiuNiuRoom.RoomMsg.moneyType = msg.moneyType
	   NiuNiuRoom.RoomMsg.baseNum = msg.baseNum
	   NiuNiuRoom.RoomMsg.qualified = msg.qualified
	   NiuNiuRoom.RoomMsg.special = msg.special
	   NiuNiuRoom.RoomMsg.mcreenings = msg.mcreenings
	end
	NiuNiuRoom.RoomMsg.baseScore = msg.baseScore;
	-- 创建房间的人。加入到数据缓存中
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

	NiuNiuRoom.playersData[1] = joinRoomUserVo
	NiuNiuRoom.myIndex 	 	 = 1
	NiuNiuRoom.playerCount 	 = 1

	--self:Close(true)
	MainSenceCtrl:Close(true)
	Room.gameType = RoomType.NiuNiu
	Game.LoadScene("room")
	CreateRoomCtrl.PlayEffectMusic()
end

--公共点击方法
function CreateNiuRoomCtrl.OnNiuNiuTogClick(go,bool)
	print("------------公共点击方法--------------")
	local self = CreateNiuRoomCtrl 
	local name = go.name
	local key = self.btnTable[name].btnType
	self:JudgmentBtn(name,key,bool)
end

--判断按钮的方法
function CreateNiuRoomCtrl:JudgmentBtn(name,key,bool)
	--单选类
	if key ~= 4 then
		for m,n in pairs(self.btnTable) do
			--获取同类型按钮
			if key == n.btnType then
				if m == name then
					self:SetColorBtn(n.name,n.txt,true)
					self.roomInfo[key].value = n.value
				else
					self:SetColorBtn(n.name,n.txt,false)
				end
			end
		end
	--多选类
	else
		local curTable = {}
		if key == 4 then
			curTable = self.specialList
		end
		if bool then
			curTable[name] = self.btnTable[name].value
			print("----------",name,curTable[name],self.btnTable[name].value)
		else
			curTable[name] = ""
		end
		self:SetColorBtn(self.btnTable[name].name,self.btnTable[name].txt,bool)
	end
end

--设置缓存的方法
function CreateNiuRoomCtrl:SetCacheBtn(name,value)
	AppConst.setPlayerPrefs(name,tostring(value))
end

--读取缓存的方法
function CreateNiuRoomCtrl:GetCacheBtn(name,key)
	local value = nil
	if key == 1 then
		if AppConst.getPlayerPrefs(name) ~= "" then
			value = tonumber(AppConst.getPlayerPrefs(name))
		else
			value = self.roomInfo[key].value
		end	
	else
		if AppConst.getPlayerPrefs(name) ~= "" then
			value = AppConst.getPlayerPrefs(name)
		else
			value = self.roomInfo[key].value
		end
	end
	return value
end

--设置按钮的方法
function CreateNiuRoomCtrl:SetColorBtn(name,txt,bool)
	if bool then
		self:SetText(CreateRoomPanel[name.."txt"],"<color=#48BDFF>"..txt.."</color>")
	else
		self:SetText(CreateRoomPanel[name.."txt"],"<color=#5D6D6D>"..txt.."</color>")
	end
end
----------------------牛牛以上