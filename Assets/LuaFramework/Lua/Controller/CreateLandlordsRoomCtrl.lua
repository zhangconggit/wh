CreateLandlordsRoomCtrl = {}
setbaseclass(CreateLandlordsRoomCtrl,{BaseCtrl})

--斗地主
function CreateLandlordsRoomCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self,obj)

	self.togTable ={HappyGame       = {togType = 1, name = "togHappyGame"		,value = 1		,txt = "欢乐斗地主"},
					PersonGame      = {togType = 1, name = "togPersonGame"		,value = 2		,txt = "癞子斗地主"},
					FigPerson8		= {togType = 2, name = "togFigPerson8"		,value = 8		,txt = "8人局"},
					FigPerson16		= {togType = 2, name = "togFigPerson16"		,value = 16		,txt = "16人局"},
					FightAA			= {togType = 3, name = "togFightAA"			,value = 1		,txt = "AA"},  
					FightBoss		= {togType = 3, name = "togFightBoss"		,value = 2		,txt = "老板"},	   
					FightRob		= {togType = 4, name = "togFightRob"		,value = 1		,txt = "抢地主"},	   
					FightScore		= {togType = 4, name = "togFightScore"		,value = 2		,txt = "叫分"},	   
					FightAgainst32	= {togType = 5, name = "togFightAgainst32"	,value = 32		,txt = "32倍"},	   
					FightAgainst64	= {togType = 5, name = "togFightAgainst64"	,value = 64		,txt = "64倍"},	
					FightAgainst128	= {togType = 5, name = "togFightAgainst128"	,value = 128	,txt = "128倍"}}

	for k,v in pairs(self.togTable) do
		self:AddOnValueChanged(CreateRoomPanel[v.name],self.OnTogChange)
	end
	self:AddClick(CreateRoomPanel.btnCreateFight,self.OnCreateRoomButtonClick)
end

function CreateLandlordsRoomCtrl:InitPanel(userInfo)
	print("=============斗地主===InitPanel=========",tonumber(AppConst.getPlayerPrefs("douDiZhuTotal")),tonumber(AppConst.getPlayerPrefs("wanfaType")),tonumber(AppConst.getPlayerPrefs("modeType")),tonumber(AppConst.getPlayerPrefs("landlord")),tonumber(AppConst.getPlayerPrefs("maxMultiple")))

	if tonumber(AppConst.getPlayerPrefs("douDiZhuTotal")) ~= nil and tonumber(AppConst.getPlayerPrefs("wanfaType")) ~= nil
	and  tonumber(AppConst.getPlayerPrefs("modeType")) ~= nil and tonumber(AppConst.getPlayerPrefs("landlord"))  ~= nil and
	tonumber(AppConst.getPlayerPrefs("maxMultiple")) ~= nil then
		for k,v in pairs(self.togTable) do
			if v.togType == 1 then																		--玩法
				if tonumber(AppConst.getPlayerPrefs("wanfaType")) == v.value then
					CreateRoomPanel[v.name]:GetComponent("Toggle").isOn = true
					self:SetText(CreateRoomPanel[v.name.."Txt"],"<color=#48BDFF>"..v.txt.."</color>")	--红色
				else
					CreateRoomPanel[v.name]:GetComponent("Toggle").isOn = false
					self:SetText(CreateRoomPanel[v.name.."Txt"],"<color=#5D6D6D>"..v.txt.."</color>")
				end
			elseif v.togType == 2 then																	--倍数
				if tonumber(AppConst.getPlayerPrefs("douDiZhuTotal")) == v.value then
					CreateRoomPanel[v.name]:GetComponent("Toggle").isOn = true
					self:SetText(CreateRoomPanel[v.name.."Txt"],"<color=#48BDFF>"..v.txt.."</color>")	--红色
				else
					CreateRoomPanel[v.name]:GetComponent("Toggle").isOn = false
					self:SetText(CreateRoomPanel[v.name.."Txt"],"<color=#5D6D6D>"..v.txt.."</color>")
				end
				if tonumber(AppConst.getPlayerPrefs("douDiZhuTotal")) == 8	then			--8人局
					self:SetText(CreateRoomPanel.FightAARoomNumber,"[			x1]")
					self:SetText(CreateRoomPanel.FigBossRoomNumber,"[			x3]")
				else         																--16人局
					self:SetText(CreateRoomPanel.FightAARoomNumber,"[			x2]")
					self:SetText(CreateRoomPanel.FigBossRoomNumber,"[			x6]")
				end
			elseif v.togType == 3 then 																	--模式
				if tonumber(AppConst.getPlayerPrefs("modeType")) == v.value then
					CreateRoomPanel[v.name]:GetComponent("Toggle").isOn = true
					self:SetText(CreateRoomPanel[v.name.."Txt"],"<color=#48BDFF>"..v.txt.."</color>")	--红色
				else
					CreateRoomPanel[v.name]:GetComponent("Toggle").isOn = false
					self:SetText(CreateRoomPanel[v.name.."Txt"],"<color=#5D6D6D>"..v.txt.."</color>")
				end
				if tonumber(AppConst.getPlayerPrefs("modeType")) == 1 then   --AA模式
					CreateRoomPanel.FightAARoomCard:SetActive(true)
					CreateRoomPanel.FigBossRoomCard:SetActive(false)
				else  			--Boss模式
					CreateRoomPanel.FightAARoomCard:SetActive(false)
					CreateRoomPanel.FigBossRoomCard:SetActive(true)
				end
			elseif v.togType == 4 then  																--确定地主
				if tonumber(AppConst.getPlayerPrefs("landlord")) == v.value then
					CreateRoomPanel[v.name]:GetComponent("Toggle").isOn = true
					self:SetText(CreateRoomPanel[v.name.."Txt"],"<color=#48BDFF>"..v.txt.."</color>")	--红色
				else
					CreateRoomPanel[v.name]:GetComponent("Toggle").isOn = false
					self:SetText(CreateRoomPanel[v.name.."Txt"],"<color=#5D6D6D>"..v.txt.."</color>")
				end
			elseif v.togType == 5 then																	--倍数
				if tonumber(AppConst.getPlayerPrefs("maxMultiple")) == v.value then
					CreateRoomPanel[v.name]:GetComponent("Toggle").isOn = true
					self:SetText(CreateRoomPanel[v.name.."Txt"],"<color=#48BDFF>"..v.txt.."</color>")	--红色
				else
					CreateRoomPanel[v.name]:GetComponent("Toggle").isOn = false
					self:SetText(CreateRoomPanel[v.name.."Txt"],"<color=#5D6D6D>"..v.txt.."</color>")
				end
			end
		end
	else
		AppConst.setPlayerPrefs("douDiZhuTotal",16)
		AppConst.setPlayerPrefs("wanfaType",1)
		AppConst.setPlayerPrefs("modeType",1)
		AppConst.setPlayerPrefs("landlord",1)
		AppConst.setPlayerPrefs("maxMultiple",32)
	end
end

--创建房间
function CreateLandlordsRoomCtrl.OnCreateRoomButtonClick()
	local self = CreateLandlordsRoomCtrl
	CreateRoomCtrl.PlayEffectMusic()
	global.systemVo.TalkSource:Stop()
	local CreateLandRoom = CreateDouDiZhuRoom_pb.CreateDouDiZhuRoomReq()
	CreateLandRoom.douDiZhuTotal = tonumber(AppConst.getPlayerPrefs("douDiZhuTotal"))
	CreateLandRoom.wanfaType = tonumber(AppConst.getPlayerPrefs("wanfaType"))
	CreateLandRoom.modeType = tonumber(AppConst.getPlayerPrefs("modeType"))
	CreateLandRoom.landlord = tonumber(AppConst.getPlayerPrefs("landlord"))
	CreateLandRoom.maxMultiple = tonumber(AppConst.getPlayerPrefs("maxMultiple"))
	
	print("==============斗地主SendProtocal===================")

	local msg = CreateLandRoom:SerializeToString()
	Game.SendProtocal(Protocal.CreateLandRoom, msg)
end

--房间回调
function CreateLandlordsRoomCtrl.OnCreateLandlandsRoomRes(buffer)
	local self = CreateLandlordsRoomCtrl
	local data = buffer:ReadBuffer()
	local msg = CreateDouDiZhuRoom_pb.CreateDouDiZhuRoomRes()
	msg:ParseFromString(data)

	print("斗地主Res------------->>>",LandlordsRoom.RoomMsg)

	if MainSenceCtrl.RoomType == RoomMode.roomCardMode then
		--LandlordsRoom.RoomMsg = RoomLandlordsVo
		LandlordsRoom.RoomMsg.id = msg.roomNum
		LandlordsRoom.RoomMsg.isFangzhu = 1

		LandlordsRoom.RoomMsg.baseNum = msg.baseNum
		LandlordsRoom.RoomMsg.qualified = msg.qualified
		LandlordsRoom.RoomMsg.moneyType = msg.moneyType
		LandlordsRoom.RoomMsg.mcreenings = msg.mcreenings
	else
		roomLandlordsVo = RoomLandlordsVo:New()
		LandlordsRoom.RoomMsg = roomLandlordsVo
		LandlordsRoom.RoomMsg.id = msg.roomNum
		LandlordsRoom.RoomMsg.isFangzhu = 1
	end

	LandlordsRoom.RoomMsg.catchTotal = tonumber(AppConst.getPlayerPrefs("douDiZhuTotal"))
	LandlordsRoom.RoomMsg.wanfaType = tonumber(AppConst.getPlayerPrefs("wanfaType"))
	LandlordsRoom.RoomMsg.modeType = tonumber(AppConst.getPlayerPrefs("modeType"))
	LandlordsRoom.RoomMsg.maxMultiple = tonumber(AppConst.getPlayerPrefs("maxMultiple"))

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

	LandlordsRoom.playersData[1] = joinRoomUserVo
	LandlordsRoom.myIndex 	 	 = 1
	LandlordsRoom.playerCount 	 = 1

	--self:Close(true)
	MainSenceCtrl:Close(true)
	Room.gameType = RoomType.Landlords;
	Game.LoadScene("room")
	CreateRoomCtrl.PlayEffectMusic()
end


function CreateLandlordsRoomCtrl.OnTogChange( go ,bool )
	CreateRoomCtrl.PlayEffectMusic()
	local self = CreateLandlordsRoomCtrl
	for k,v in pairs(self.togTable) do
		if v.name == go.name then
			if bool then
				self:SetText(CreateRoomPanel[v.name.."Txt"],"<color=#48BDFF>"..v.txt.."</color>")
			else
				self:SetText(CreateRoomPanel[v.name.."Txt"],"<color=#5D6D6D>"..v.txt.."</color>")
			end
			self:SetGameRoomCard(v)
			if bool then
				if v.togType == 1 then
					AppConst.setPlayerPrefs("wanfaType",v.value)
				end
				if v.togType == 2 then
					AppConst.setPlayerPrefs("douDiZhuTotal",v.value)
				end
				if v.togType == 3 then
					AppConst.setPlayerPrefs("modeType",v.value)
				end
				if v.togType == 4 then
					AppConst.setPlayerPrefs("landlord",v.value)
				end
				if v.togType == 5 then
					AppConst.setPlayerPrefs("maxMultiple",v.value)
				end
			end
		end
	end
end

function CreateLandlordsRoomCtrl:SetGameRoomCard(info)
	if info.togType == 2 then
		if info.value == 8 then
			self:SetText(CreateRoomPanel.FightAARoomNumber,"[			x1]")
			self:SetText(CreateRoomPanel.FigBossRoomNumber,"[			x3]")
		elseif info.value == 16 then
			self:SetText(CreateRoomPanel.FightAARoomNumber,"[			x2]")
			self:SetText(CreateRoomPanel.FigBossRoomNumber,"[			x6]")
		end
	end
	if info.togType == 3 then
		if info.value == 1 then
			CreateRoomPanel.FightAARoomCard:SetActive(true)
			CreateRoomPanel.FigBossRoomCard:SetActive(false)
		elseif info.value == 2 then
			CreateRoomPanel.FightAARoomCard:SetActive(false)
			CreateRoomPanel.FigBossRoomCard:SetActive(true)
		end
	end
end