CreateBattleMahjongRoomCtrl = {}
setbaseclass(CreateBattleMahjongRoomCtrl,{BaseCtrl})

local roomBattleMahjongVo 

function CreateBattleMahjongRoomCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self,obj)
	--按钮配置表
	self.mahjongTable ={togBattle4ju    = {togType = 1, name = "battleTog4Inning"			,value = 4		,txt = "4局"},
					togBattle8ju      	= {togType = 1, name = "battleTog8Inning"			,value = 8		,txt = "8局"},
					--[[togBattle1		= {togType = 2, name = "battleTog1"					,value = 1		,txt = "1分"},
					togBattle2			= {togType = 2, name = "battleTog2"					,value = 2		,txt = "2分"},--]]
					--[[togBattle5		= {togType = 2, name = "battleTog5"					,value = 5		,txt = "5分"},  
					togBattle10			= {togType = 2, name = "battleTog10"				,value = 10		,txt = "10分"},--]]	   
					togBattle2Num		= {togType = 2, name = "battleTog2Num"				,value = 2		,txt = "2番"},	   
					togBattle3Num		= {togType = 2, name = "battleTog3Num"				,value = 3		,txt = "3番"},	   
					togBattle4Num		= {togType = 2, name = "battleTog4Num"				,value = 4		,txt = "4番"},	

					togZimojiadi	 	= {togType = 3, name = "battleTogZimojiadi"			,value = 11		,txt = "自摸加底"},	
					togZimojiafan	 	= {togType = 3, name = "battleTogZimojiafan"		,value = 12		,txt = "自摸加番"},

					togDiangangZimo	 	= {togType = 4, name = "battleTogDiangangZimo"		,value = 13		,txt = "点杠花-自摸"},	
					togDiangangDianpao	= {togType = 4, name = "battleTogDiangangDianpao"	,value = 14		,txt = "点杠花-点炮"},
					--togHuansanzhang	 	= {togType = 5, name = "battleTogHuansanzhang"		,value = 1		,txt = "换三张"},
					togBattleR0 		= {togType = 5, name = "battleTogR0"				,value = 15		,txt = "幺九将对"},
					togBattleR1	 		= {togType = 5, name = "battleTogR1"				,value = 16		,txt = "门清中张"},
					togBattleR2	 		= {togType = 5, name = "battleTogR2"				,value = 17		,txt = "天地胡"}}

	--[[self.mahjongSpecialList = {togZimojiadi 	= "",
						togZimojiafan 	= "",
						togDiangangZimo  	= "",
						togDiangangDianpao 	= ""}--]]
	self.mahjongSeniorInfoList = {togBattleR0 = "",togBattleR1 = "",togBattleR2 = ""}

	for k,v in pairs(self.mahjongTable) do
	 	self:AddOnValueChanged(CreateRoomPanel[v.name],self.OnBattleMahjongTogClick)
	end
	self:AddClick(CreateRoomPanel.btnCreateBattleMahjong,self.OnCreateRoomButtonClick)
end

function CreateBattleMahjongRoomCtrl:InitPanel(userInfo)
	--房间信息表
	roomBattleMahjongVo = RoomVo:New()
	self.mahjongRoomInfo ={{name = "jushu", 	  			value = roomBattleMahjongVo.jushu},
						   {name = "baseScore",   			value = roomBattleMahjongVo.baseScore},
						   {name = "fanshu",      			value = roomBattleMahjongVo.fanshu},
						   {name = "PlayMethodZimo",  		value = roomBattleMahjongVo.PlayMethodZimo},
						   {name = "PlayMethodDiangang", 	value = roomBattleMahjongVo.PlayMethodDiangang},
						   {name = "replaceCard", 			value = roomBattleMahjongVo.replaceCard},
						   {name = "cardType",    			value = roomBattleMahjongVo.cardType}}

	print("=============CreateBattleMahjongRoomCtrl=========",#self.mahjongRoomInfo)
	--读取房间缓存信息
	for i=1,#self.mahjongRoomInfo do
		local cacheValue = self:GetCacheBtn(self.mahjongRoomInfo[i].name,i)
		local strArray = ""
		local curTable = {}

		if i == 5 then
			curTable = self.mahjongSeniorInfoList
		end
		strArray = string_split(cacheValue,",")	

		for m,n in pairs(self.mahjongTable) do
			if i == n.togType then
				--[[if n.togType == 2 then cacheValue = tonumber(cacheValue) end
				self:SetColorBtn(n.name,n.txt,false)
				CreateRoomPanel[n.name]:GetComponent('Toggle').isOn = false--]]
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
end

--公共点击方法
function CreateBattleMahjongRoomCtrl.OnBattleMahjongTogClick(go,bool)
	CreateRoomCtrl.PlayEffectMusic()
	local self = CreateBattleMahjongRoomCtrl 
	local name = go.name
	local key = self.mahjongTable[name].togType
	self:JudgmentBtn(name,key,bool)
end

--判断按钮的方法
function CreateBattleMahjongRoomCtrl:JudgmentBtn(name,key,bool)
	--单选类
	if key ~= 5 then
		for m,n in pairs(self.mahjongTable) do
			--获取同类型按钮
			if key == n.togType then
				if m == name then
					self:SetColorBtn(n.name,n.txt,true)
					self.mahjongRoomInfo[key].value = n.value
				else
					self:SetColorBtn(n.name,n.txt,false)
				end
			end
		end
	--多选类
	else
		local curTable = {}
		if key == 5 then
			curTable = self.mahjongSeniorInfoList
		end
		if bool then
			curTable[name] = self.mahjongTable[name].value
			print("----------",name,curTable[name],self.mahjongTable[name].value)
		else
			curTable[name] = ""
		end
		self:SetColorBtn(self.mahjongTable[name].name,self.mahjongTable[name].txt,bool)
	end
end

--设置缓存的方法
function CreateBattleMahjongRoomCtrl:SetCacheBtn(name,value)
	AppConst.setPlayerPrefs(name,tostring(value))
end

--读取缓存的方法
function CreateBattleMahjongRoomCtrl:GetCacheBtn(name,key)
	local value = nil
	if key == 1 then
		if AppConst.getPlayerPrefs(name) ~= "" then
			value = tonumber(AppConst.getPlayerPrefs(name))
		else
			value = self.mahjongRoomInfo[key].value
		end	
	else
		if AppConst.getPlayerPrefs(name) ~= "" then
			value = AppConst.getPlayerPrefs(name)
		else
			value = self.mahjongRoomInfo[key].value
		end
	end
	return value
end

--设置按钮的方法
function CreateBattleMahjongRoomCtrl:SetColorBtn(name,txt,bool)
	if bool then
		self:SetText(CreateRoomPanel[name.."txt"],"<color=#48BDFF>"..txt.."</color>")
	else
		self:SetText(CreateRoomPanel[name.."txt"],"<color=#5D6D6D>"..txt.."</color>")
	end
end

--创建房间
function CreateBattleMahjongRoomCtrl.OnCreateRoomButtonClick()
	print("-----------------------------点击创建麻将房间---------------------------------")
	local self = CreateBattleMahjongRoomCtrl
	CreateRoomCtrl.PlayEffectMusic()
	global.systemVo.TalkSource:Stop() 
	local CreateBloodFightRoom = CreateBloodFightRoom_pb.CreateBloodFightRoomReq()
	local info = self.mahjongRoomInfo

	--本地缓存信息
	for m,n in ipairs(info) do
		local msg = ""
		--[[if m == 3 then
			local i = 0
			for k,v in pairs(self.mahjongSpecialList) do
				i = i + 1
				if v ~= "" then
					if i ~= 1 then
						msg = msg..","..v
					elseif i == 1 then
						msg = v
					end
				end
			end
		else--]]
		if m == 5 then
			local i = 0
			for k,v in pairs(self.mahjongSeniorInfoList) do
				print(v)
				i = i + 1
				if v ~= "" then
					if i ~= 1 then
						msg = msg..","..v
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

	CreateBloodFightRoom.baseScore = 1
	CreateBloodFightRoom.replaceCard = 1

	CreateBloodFightRoom.jushu = info[1].value
	CreateBloodFightRoom.fanshu = info[2].value
	CreateBloodFightRoom.PlayMethodZimo = info[3].value
	CreateBloodFightRoom.PlayMethodDiangang = info[4].value
	CreateBloodFightRoom.cardType = info[5].value
	print("--------value2222222222222222222222----------",CreateBloodFightRoom.jushu,CreateBloodFightRoom.baseScore
		,CreateBloodFightRoom.fanshu,CreateBloodFightRoom.PlayMethodZimo,CreateBloodFightRoom.PlayMethodDiangang,
		CreateBloodFightRoom.replaceCard,CreateBloodFightRoom.cardType)

	local msg = CreateBloodFightRoom:SerializeToString()
	Game.SendProtocal(Protocal.CreateBloodFightRoom, msg)
end

--房间回调
function CreateBattleMahjongRoomCtrl.OnCreateBloodFightRoomRes(buffer)
	print("-----------------------------创建麻将房间回调---------------------------------")
    local self = CreateBattleMahjongRoomCtrl
	local data   = buffer:ReadBuffer()
	print('4444444444444444444444444444444444444--初始化牌回调',data)
	print('66666666666666666666666666666666666666666--初始化牌回调',buffer)
	print('66666666666666666666666666666666666666666--初始化牌回调',buffer:ReadBuffer())
	local msg    = CreateBloodFightRoom_pb.CreateBloodFightRoomRes()	
	msg:ParseFromString(data)

	print('CreateBattleMahjongRoomCtrl.OnCreateBloodFightRoomRes1111',msg.roomNum,msg.moneyType)
	--房卡模式
	if msg.moneyType == RoomMode.roomCardMode then
		global.roomVo = RoomVo:New()
		global.roomVo.id = msg.roomNum
		global.roomVo.isFangzhu = 1
	else
		local roomVo     = RoomVo:New()
		roomVo.id 		 = msg.roomNum
		--新添加
		roomVo.baseNum    = msg.baseNum
		roomVo.qualified  = msg.qualified
		roomVo.moneyType  = msg.moneyType

		roomVo.isFangzhu = 1
		global.roomVo    = roomVo
	end

	-- 创建房间的人。加入到数据缓存中
	local joinRoomUserVo     = JoinRoomUserVo:New()
	local userVo = global.userVo
	joinRoomUserVo.index     = 1
	joinRoomUserVo.roleId    = userVo.roleId
	joinRoomUserVo.name      = userVo.name
	joinRoomUserVo.ip        = userVo.roleIp
	joinRoomUserVo.headImg   = userVo.headImg
	joinRoomUserVo.diamond	 = userVo.diamond
	joinRoomUserVo.gender 	 = userVo.gender
	--新添加
	joinRoomUserVo.goldcoin = userVo.goldcoin --金币数量
	--joinRoomUserVo.wing = userVo.wing         --元宝数量

	global.joinRoomUserVos[1] = joinRoomUserVo
	self:Close()
	MainSenceCtrl:Close()
	Room.gameType = RoomType.BattleMahjong
	Game.LoadScene("mahjong")
	--CreateRoomCtrl.PlayEffectMusic()
end
