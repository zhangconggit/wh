--十点半

	CreateShiDianRoomCtrl = {}
	setbaseclass(CreateShiDianRoomCtrl,{BaseCtrl})

	local roomTenHalfVo 

--启动事件--
function CreateShiDianRoomCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self,obj)
	----十点半
    self:AddOnValueChanged(CreateRoomPanel.shiTog2Inning   , self.OnshiTog2InningClick)
    self:AddOnValueChanged(CreateRoomPanel.shiTog4Inning   , self.OnshiTog4InningClick)
    self:AddOnValueChanged(CreateRoomPanel.shiTog6Inning   , self.OnshiTog6InningClick)

    self:AddOnValueChanged(CreateRoomPanel.shiTogWuHua5   , self.OnshiTogWuHua5Click)
    self:AddOnValueChanged(CreateRoomPanel.shiTogShi5  , self.OnshiTogShi5Click)
    self:AddOnValueChanged(CreateRoomPanel.shiTogWu3  , self.OnshiTogWu3Click)
    self:AddOnValueChanged(CreateRoomPanel.shiTogShi3  , self.OnshiTogShi3Click)

    self:AddOnValueChanged(CreateRoomPanel.shiTogWuWang  , self.OnshiTogWuWangClick)
    self:AddOnValueChanged(CreateRoomPanel.shiTogWang   , self.OnshiTogWangClick)

    self:AddOnValueChanged(CreateRoomPanel.shiTogSuiJi   , self.OnshiTogSuiJiClick)
    self:AddOnValueChanged(CreateRoomPanel.shiTogFangZhu   , self.OnshiTogFangZhuClick)
    self:AddOnValueChanged(CreateRoomPanel.shiTogRobot   , self.OnshiTogRobotClick)

    self:AddClick(CreateRoomPanel.shiBtnCreate , self.OnCreateBtnClick)
    self:AddClick(CreateRoomPanel.shiBtnDownload , self.OnDownloadBtnClick)
	----十点半以上
end

function CreateShiDianRoomCtrl:InitPanel(userInfo)

	roomTenHalfVo = RoomTenHalfVo:New()
	roomTenHalfVo.id        = 1
	roomTenHalfVo.tenHalfTotal     = 2
	roomTenHalfVo.isTen2    = 1
	roomTenHalfVo.isFive3   = 1
	roomTenHalfVo.isFive5   = 1
	roomTenHalfVo.isTen5 	= 1
    roomTenHalfVo.isWang 	= 1
	roomTenHalfVo.isMaster  = 0
	self:SetText(CreateRoomPanel.shiTxtDiamond ,"x" .. userInfo.diamond)
	if AppConst.getPlayerPrefs("tenHalfTotal") == "" then
		CreateRoomPanel.shiTog2Inning :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.shiTog2InningTxt1  ,"<color=#48BDFF>每人2局[</color>")
		self:SetText(CreateRoomPanel.shiTog2InningTxt2  ,"<color=#48BDFF>       x1]</color>")

		CreateRoomPanel.shiTog4Inning :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.shiTog4InningTxt1 ,"<color=#5D6D6D>每人4局[</color>")
		self:SetText(CreateRoomPanel.shiTog4InningTxt2,"<color=#5D6D6D>       x2]</color>")

		CreateRoomPanel.shiTog6Inning :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.shiTog6InningTxt1 ,"<color=#5D6D6D>每人6局[</color>")
		self:SetText(CreateRoomPanel.shiTog6InningTxt2,"<color=#5D6D6D>       x3]</color>")
	else
		roomTenHalfVo.tenHalfTotal = tonumber(AppConst.getPlayerPrefs("tenHalfTotal"))
		if tonumber(AppConst.getPlayerPrefs("tenHalfTotal")) == 2 then
			CreateRoomPanel.shiTog2Inning :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.shiTog2InningTxt1  ,"<color=#48BDFF>每人2局[</color>")
			self:SetText(CreateRoomPanel.shiTog2InningTxt2  ,"<color=#48BDFF>       x1]</color>")

			CreateRoomPanel.shiTog4Inning :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTog4InningTxt1 ,"<color=#5D6D6D>每人4局[</color>")
			self:SetText(CreateRoomPanel.shiTog4InningTxt2,"<color=#5D6D6D>       x2]</color>")

			CreateRoomPanel.shiTog6Inning :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTog6InningTxt1 ,"<color=#5D6D6D>每人6局[</color>")
			self:SetText(CreateRoomPanel.shiTog6InningTxt2,"<color=#5D6D6D>       x3]</color>")

	    elseif tonumber(AppConst.getPlayerPrefs("tenHalfTotal")) == 4 then
			CreateRoomPanel.shiTog2Inning :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTog2InningTxt1  ,"<color=#5D6D6D>每人2局[</color>")
			self:SetText(CreateRoomPanel.shiTog2InningTxt2  ,"<color=#5D6D6D>       x1]</color>")

			CreateRoomPanel.shiTog4Inning :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.shiTog4InningTxt1 ,"<color=#48BDFF>每人4局[</color>")
			self:SetText(CreateRoomPanel.shiTog4InningTxt2,"<color=#48BDFF>       x2]</color>")

			CreateRoomPanel.shiTog6Inning :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTog6InningTxt1 ,"<color=#5D6D6D>每人6局[</color>")
			self:SetText(CreateRoomPanel.shiTog6InningTxt2,"<color=#5D6D6D>       x3]</color>")

		elseif tonumber(AppConst.getPlayerPrefs("tenHalfTotal")) == 6 then
			CreateRoomPanel.shiTog2Inning :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTog2InningTxt1  ,"<color=#5D6D6D>每人2局[</color>")
			self:SetText(CreateRoomPanel.shiTog2InningTxt2  ,"<color=#5D6D6D>       x1]</color>")

			CreateRoomPanel.shiTog4Inning :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTog4InningTxt1 ,"<color=#5D6D6D>每人4局[</color>")
			self:SetText(CreateRoomPanel.shiTog4InningTxt2,"<color=#5D6D6D>       x2]</color>")

			CreateRoomPanel.shiTog6Inning :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.shiTog6InningTxt1 ,"<color=#48BDFF>每人6局[</color>")
			self:SetText(CreateRoomPanel.shiTog6InningTxt2,"<color=#48BDFF>       x3]</color>")
		end
	end
	
	if AppConst.getPlayerPrefs("isShiWang") == "" then
		CreateRoomPanel.shiTogWuWang :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.shiTogWuWangTxt   ,"<color=#5D6D6D>无王牌（低分场）</color>")

		CreateRoomPanel.shiTogWang :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.shiTogWangTxt  ,"<color=#48BDFF>王牌半点（高分场）</color>")
	else
		roomTenHalfVo.isWang = tonumber(AppConst.getPlayerPrefs("isShiWang"))
		if tonumber(AppConst.getPlayerPrefs("isShiWang")) == 1 then
			CreateRoomPanel.shiTogWuWang :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTogWuWangTxt   ,"<color=#5D6D6D>无王牌（低分场）</color>")

			CreateRoomPanel.shiTogWang :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.shiTogWangTxt  ,"<color=#48BDFF>王牌半点（高分场）</color>")
		else
			CreateRoomPanel.shiTogWuWang :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.shiTogWuWangTxt   ,"<color=#48BDFF>无王牌（低分场）</color>")

			CreateRoomPanel.shiTogWang :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTogWangTxt  ,"<color=#5D6D6D>王牌半点（高分场）</color>")
		end
	end
   

	if AppConst.getPlayerPrefs("isFive5") == "" then
		CreateRoomPanel.shiTogWuHua5  :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.shiTogWuHua5Txt  ,"<color=#48BDFF>五花雷5倍</color>")
	else
		roomTenHalfVo.isFive5 = tonumber(AppConst.getPlayerPrefs("isFive5"))
		if tonumber(AppConst.getPlayerPrefs("isFive5")) == 1 then
			CreateRoomPanel.shiTogWuHua5 :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.shiTogWuHua5Txt ,"<color=#48BDFF>五花雷5倍</color>")
		else
			CreateRoomPanel.shiTogWuHua5 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTogWuHua5Txt ,"<color=#5D6D6D>五花雷5倍</color>")
		end
	end
   

	if AppConst.getPlayerPrefs("isTen5") == "" then
		CreateRoomPanel.shiTogShi5  :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.shiTogShi5Txt  ,"<color=#48BDFF>十点半雷5倍</color>")
	else
		roomTenHalfVo.isTen5 = tonumber(AppConst.getPlayerPrefs("isTen5"))
		if tonumber(AppConst.getPlayerPrefs("isTen5")) == 0 then
			CreateRoomPanel.shiTogShi5  :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTogShi5Txt  ,"<color=#5D6D6D>十点半雷5倍</color>")
		else
			CreateRoomPanel.shiTogShi5  :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.shiTogShi5Txt  ,"<color=#48BDFF>十点半雷5倍</color>")
		end
	end
    
    if AppConst.getPlayerPrefs("isFive3") == "" then
		CreateRoomPanel.shiTogWu3  :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.shiTogWu3Txt  ,"<color=#48BDFF>五雷3倍</color>")
	else
		roomTenHalfVo.isFive3 = tonumber(AppConst.getPlayerPrefs("isFive3"))
		if tonumber(AppConst.getPlayerPrefs("isFive3")) == 0 then
			CreateRoomPanel.shiTogWu3  :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTogWu3Txt  ,"<color=#5D6D6D>五雷3倍</color>")
		else
			CreateRoomPanel.shiTogWu3  :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.shiTogWu3Txt  ,"<color=#48BDFF>五雷3倍</color>")
		end
	end

	if AppConst.getPlayerPrefs("isTen2") == "" then
		CreateRoomPanel.shiTogShi3  :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.shiTogShi3Txt  ,"<color=#48BDFF>十点半2倍</color>")
	else
		roomTenHalfVo.isTen2 =tonumber( AppConst.getPlayerPrefs("isTen2"))
		if tonumber(AppConst.getPlayerPrefs("isTen2")) == 0 then
			CreateRoomPanel.shiTogShi3  :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTogShi3Txt  ,"<color=#5D6D6D>十点半2倍</color>")
		else
			CreateRoomPanel.shiTogShi3  :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.shiTogShi3Txt  ,"<color=#48BDFF>十点半2倍</color>")
		end
	end

	if AppConst.getPlayerPrefs("isShiZhuang") == "" then
		CreateRoomPanel.shiTogSuiJi  :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.shiTogSuiJiTxt  ,"<color=#48BDFF>随机首庄</color>")

		CreateRoomPanel.shiTogFangZhu  :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.shiTogFangZhuTxt ,"<color=#5D6D6D>房主首庄</color>")
	else
		roomTenHalfVo.isShiZhuang = tonumber(AppConst.getPlayerPrefs("isShiZhuang"))
		if tonumber(AppConst.getPlayerPrefs("isShiZhuang")) == 0 then
			CreateRoomPanel.shiTogSuiJi  :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.shiTogSuiJiTxt  ,"<color=#48BDFF>随机首庄</color>")

			CreateRoomPanel.shiTogFangZhu  :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTogFangZhuTxt ,"<color=#5D6D6D>房主首庄</color>")
		else
			CreateRoomPanel.shiTogSuiJi  :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.shiTogSuiJiTxt  ,"<color=#5D6D6D>随机首庄</color>")

			CreateRoomPanel.shiTogFangZhu  :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.shiTogFangZhuTxt ,"<color=#48BDFF>房主首庄</color>")
		end
	end
end

function CreateShiDianRoomCtrl.OnCreateBtnClick(go)
	local self = CreateShiDianRoomCtrl
	CreateRoomCtrl.PlayEffectMusic()
	global.systemVo.TalkSource:Stop() 

	local CreateTenHalfRoom = CreateTenHalfRoom_pb.CreateTenHalfRoomReq()
	CreateTenHalfRoom.everyJushu     		 = roomTenHalfVo.tenHalfTotal	 --开房局数  2、4、6
	CreateTenHalfRoom.tenHalfRateDouble    	 = roomTenHalfVo.isTen2 == 1 and true or false 	 	 --是否十点半2倍  1=是  0=否
	CreateTenHalfRoom.fiveRateThree      	 = roomTenHalfVo.isFive3 == 1 and true or false     	 --是否五雷3倍  1=是  0=否
	CreateTenHalfRoom.fiveHuaRateFive 	 	 = roomTenHalfVo.isFive5 == 1 and true or false      	 --是否五花雷5倍  1=是 0=否
	CreateTenHalfRoom.tenHalfLeiRateFive 	 = roomTenHalfVo.isTen5 == 1 and true or false      	 --是否十点半雷5倍  1=是 0=否
	CreateTenHalfRoom.king        			 = roomTenHalfVo.isWang == 1 and true or false  		 --是否有王牌  1=是 0=否
	CreateTenHalfRoom.leaderZhuang	 	 	 = roomTenHalfVo.isMaster == 1 and true or false  	 	 --是否房主当庄  1=是 0=否

	AppConst.setPlayerPrefs("tenHalfTotal",tostring(roomTenHalfVo.tenHalfTotal))
	AppConst.setPlayerPrefs("isTen2",tostring(roomTenHalfVo.isTen2))
	AppConst.setPlayerPrefs("isFive3",tostring(roomTenHalfVo.isFive3))
	AppConst.setPlayerPrefs("isFive5",tostring(roomTenHalfVo.isFive5))
	AppConst.setPlayerPrefs("isTen5",tostring(roomTenHalfVo.isTen5))
	AppConst.setPlayerPrefs("isShiWang",tostring(roomTenHalfVo.isWang))
	AppConst.setPlayerPrefs("isShiZhuang",tostring(roomTenHalfVo.isMaster))
	AppConst.setPlayerPrefs("createGameType",2)

	local msg = CreateTenHalfRoom:SerializeToString()
	Game.SendProtocal(Protocal.CreateTenHalfRoom, msg)
end


function CreateShiDianRoomCtrl.OnCreateTenHalfRoomRes(buffer)
    local self = CreateShiDianRoomCtrl
	local data   = buffer:ReadBuffer()
	local msg    = CreateTenHalfRoom_pb.CreateTenHalfRoomRes()	
	msg:ParseFromString(data)
	if msg.moneyType == RoomMode.roomCardMode then
		TenharfRoom.RoomMsg = roomTenHalfVo
		TenharfRoom.RoomMsg.id = msg.roomNum
		TenharfRoom.RoomMsg.isFangzhu = 1
	else
		roomTenHalfVo = RoomTenHalfVo:New()
		TenharfRoom.RoomMsg = roomTenHalfVo
		TenharfRoom.RoomMsg.id = msg.roomNum
		TenharfRoom.RoomMsg.isFangzhu = 1
		--新添加
		TenharfRoom.RoomMsg.baseNum    = msg.baseNum
		TenharfRoom.RoomMsg.qualified  = msg.qualified
		TenharfRoom.RoomMsg.moneyType  = msg.moneyType
		TenharfRoom.RoomMsg.mcreenings = msg.mcreenings
	end


	-- 创建房间的人。加入到数据缓存中
	local joinRoomUserVo     = JoinRoomUserVo:New()
	local userVo = global.userVo
	joinRoomUserVo.index     = 1
	joinRoomUserVo.roleId    = userVo.roleId
	joinRoomUserVo.name      = userVo.name
	joinRoomUserVo.ip        = userVo.roleIp
	joinRoomUserVo.headImg   = userVo.headImg
	joinRoomUserVo.jifen     = 0;
	joinRoomUserVo.gender 	 = userVo.gender
	joinRoomUserVo.diamond	 = userVo.diamond
	--新添加
	joinRoomUserVo.goldcoin = userVo.goldcoin --金币数量
	joinRoomUserVo.wing 	= userVo.wing     --元宝数量

	TenharfRoom.playersData[1] = joinRoomUserVo
	TenharfRoom.playerCount = 1
	TenharfRoom.myIndex = 1

	--self:Close()
	MainSenceCtrl:Close() 
	Room.gameType = RoomType.Tenharf

	Game.LoadScene("room")
	CreateRoomCtrl.PlayEffectMusic()
end

----------------------十点半
 function CreateShiDianRoomCtrl.OnshiTog2InningClick(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		 CreateRoomCtrl.PlayEffectMusic()
		 roomTenHalfVo.tenHalfTotal = 2
	     self:SetText(CreateRoomPanel.shiTog2InningTxt1  ,"<color=#48BDFF>每人2局[</color>")
	     self:SetText(CreateRoomPanel.shiTog2InningTxt2  ,"<color=#48BDFF>       x1]</color>")
     else
	     self:SetText(CreateRoomPanel.shiTog2InningTxt1  ,"<color=#5D6D6D>每人2局[</color>")
	     self:SetText(CreateRoomPanel.shiTog2InningTxt2  ,"<color=#5D6D6D>       x1]</color>")
     end 
end

function CreateShiDianRoomCtrl.OnshiTog4InningClick(go,bool)
    local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomTenHalfVo.tenHalfTotal = 4
	     self:SetText(CreateRoomPanel.shiTog4InningTxt1 ,"<color=#48BDFF>每人4局[</color>")
	     self:SetText(CreateRoomPanel.shiTog4InningTxt2,"<color=#48BDFF>       x2]</color>")
     else
	     self:SetText(CreateRoomPanel.shiTog4InningTxt1 ,"<color=#5D6D6D>每人4局[</color>")
	     self:SetText(CreateRoomPanel.shiTog4InningTxt2,"<color=#5D6D6D>       x2]</color>")
     end 
end

function CreateShiDianRoomCtrl.OnshiTog6InningClick(go,bool)
    local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomTenHalfVo.tenHalfTotal = 6
	     self:SetText(CreateRoomPanel.shiTog6InningTxt1 ,"<color=#48BDFF>每人6局[</color>")
	     self:SetText(CreateRoomPanel.shiTog6InningTxt2,"<color=#48BDFF>       x3]</color>")
     else
	     self:SetText(CreateRoomPanel.shiTog6InningTxt1 ,"<color=#5D6D6D>每人6局[</color>")
	     self:SetText(CreateRoomPanel.shiTog6InningTxt2,"<color=#5D6D6D>       x3]</color>")
     end 
end

function CreateShiDianRoomCtrl.OnshiTogWuHua5Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomTenHalfVo.isFive5 = 1
		self:SetText(CreateRoomPanel.shiTogWuHua5Txt  ,"<color=#48BDFF>五花雷5倍</color>")
	else
		CreateRoomCtrl.PlayEffectMusic()
		roomTenHalfVo.isFive5 = 0
		self:SetText(CreateRoomPanel.shiTogWuHua5Txt  ,"<color=#5D6D6D>五花雷5倍</color>")
	end 
end

function CreateShiDianRoomCtrl.OnshiTogShi5Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomTenHalfVo.isTen5 = 1
     	self:SetText(CreateRoomPanel.shiTogShi5Txt  ,"<color=#48BDFF>十点半雷5倍</color>")
     else
     	CreateRoomCtrl.PlayEffectMusic()
     	roomTenHalfVo.isTen5 = 0
     	self:SetText(CreateRoomPanel.shiTogShi5Txt  ,"<color=#5D6D6D>十点半雷5倍</color>")
     end 
end

function CreateShiDianRoomCtrl.OnshiTogWu3Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomTenHalfVo.isFive3 = 1
     	self:SetText(CreateRoomPanel.shiTogWu3Txt  ,"<color=#48BDFF>五雷3倍</color>")
     else
     	CreateRoomCtrl.PlayEffectMusic()
     	roomTenHalfVo.isFive3 = 0
     	self:SetText(CreateRoomPanel.shiTogWu3Txt  ,"<color=#5D6D6D>五雷3倍</color>")
     end 
end

function CreateShiDianRoomCtrl.OnshiTogShi3Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomTenHalfVo.isTen2 = 1
     	self:SetText(CreateRoomPanel.shiTogShi3Txt  ,"<color=#48BDFF>十点半2倍</color>")
     else
     	CreateRoomCtrl.PlayEffectMusic()
     	roomTenHalfVo.isTen2 = 0
     	self:SetText(CreateRoomPanel.shiTogShi3Txt  ,"<color=#5D6D6D>十点半2倍</color>")
     end 
end

function CreateShiDianRoomCtrl.OnshiTogWuWangClick(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomTenHalfVo.isWang = 0
		self:SetText(CreateRoomPanel.shiTogWuWangTxt   ,"<color=#48BDFF>无王牌（低分场）</color>")
	else
		self:SetText(CreateRoomPanel.shiTogWuWangTxt   ,"<color=#5D6D6D>无王牌（低分场）</color>")
	end 
end

function CreateShiDianRoomCtrl.OnshiTogWangClick(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomTenHalfVo.isWang = 1
		self:SetText(CreateRoomPanel.shiTogWangTxt  ,"<color=#48BDFF>王牌半点（高分场）</color>")
	else
		self:SetText(CreateRoomPanel.shiTogWangTxt  ,"<color=#5D6D6D>王牌半点（高分场）</color>")
	end 
end



function CreateShiDianRoomCtrl.OnshiTogSuiJiClick(go,bool)
	local self = CreateRoomCtrl 
	if bool   then
		CreateRoomCtrl.PlayEffectMusic()
		roomTenHalfVo.isMaster = 0
	     self:SetText(CreateRoomPanel.shiTogSuiJiTxt  ,"<color=#48BDFF>随机首庄</color>")
     else
    	 self:SetText(CreateRoomPanel.shiTogSuiJiTxt  ,"<color=#5D6D6D>随机首庄</color>")
     end 
end

function CreateShiDianRoomCtrl.OnshiTogFangZhuClick(go,bool)
	local self = CreateRoomCtrl 
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomTenHalfVo.isMaster = 1
	     self:SetText(CreateRoomPanel.shiTogFangZhuTxt ,"<color=#48BDFF>房主首庄</color>")
     else
     	self:SetText(CreateRoomPanel.shiTogFangZhuTxt ,"<color=#5D6D6D>房主首庄</color>")
     end 
end
----------------------十点半以上
function CreateShiDianRoomCtrl.ShowMathond(obj)
	CreateRoomPanel.imgShiMathondTips:SetActive(true)
end

function CreateShiDianRoomCtrl.HideMathond(obj)
	CreateRoomPanel.imgShiMathondTips:SetActive(false)
end