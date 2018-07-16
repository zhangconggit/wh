--炸金花
	CreateJinHuaRoomCtrl = {}
	setbaseclass(CreateJinHuaRoomCtrl,{BaseCtrl})

	local roomJinHuaVo 

--启动事件--
function CreateJinHuaRoomCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self,obj)
	----炸金花
	self:AddOnValueChanged(CreateRoomPanel.jinTog8Inning   , self.OnjinTog8InningClick)
	self:AddOnValueChanged(CreateRoomPanel.jinTog16Inning   , self.OnjinTog16InningClick)

	self:AddOnValueChanged(CreateRoomPanel.jinTogSize   , self.OnjinTogSizeClick)
	self:AddOnValueChanged(CreateRoomPanel.jinTogColor  , self.OnjinTogColorClick)
	self:AddOnValueChanged(CreateRoomPanel.jinTogJin  , self.OnsjinTogJinClick)

	self:AddOnValueChanged(CreateRoomPanel.jinTogLeopard  , self.OnjinTogLeopardClick)
	self:AddOnValueChanged(CreateRoomPanel.jinTogDouble  , self.OnjinTogDoubleClick)

	self:AddOnValueChanged(CreateRoomPanel.jinTogTopRound5  , self.OnjinTogTopRound5Click)
	self:AddOnValueChanged(CreateRoomPanel.jinTogTopRound10   , self.OnjinTogTopRound10Click)
	self:AddOnValueChanged(CreateRoomPanel.jinTogTopRound15  , self.OnjinTogTopRound15Click)

	self:AddOnValueChanged(CreateRoomPanel.jinTogCompareRound1  , self.OnjinTogCompareRound1Click)
	self:AddOnValueChanged(CreateRoomPanel.jinTogCompareRound2  , self.OnjinTogCompareRound2Click)
	self:AddOnValueChanged(CreateRoomPanel.jinTogCompareRound3  , self.OnjinTogCompareRound3Click)

	self:AddOnValueChanged(CreateRoomPanel.jinTogGuessRound1   , self.OnjinTogGuessRound1Click)
	self:AddOnValueChanged(CreateRoomPanel.jinTogGuessRound2   , self.OnjinTogGuessRound2Click)
	self:AddOnValueChanged(CreateRoomPanel.jinTogGuessRound3   , self.OnjinTogGuessRound3Click)

	self:AddClick(CreateRoomPanel.jinBtnCreate , self.OnCreateBtnClick)
	----炸金花以上
end

function CreateJinHuaRoomCtrl:InitPanel(userInfo)
	CreateRoomPanel.jinTogTopRound10.transform.localPosition = Vector3.New(200,0,0)
	CreateRoomPanel.jinTogTopRound15:SetActive(false)
	CreateRoomPanel.jinTogCompareRound2.transform.localPosition = Vector3.New(200,0,0)
	CreateRoomPanel.jinTogCompareRound3:SetActive(false)
	CreateRoomPanel.jinTogGuessRound2.transform.localPosition = Vector3.New(200,0,0)
	CreateRoomPanel.jinTogGuessRound3:SetActive(false)

	roomJinHuaVo = RoomJinHuaVo:New()
	roomJinHuaVo.jinHuaTotal    		= 8
	roomJinHuaVo.jinHuaPlayMethond      = 1
	roomJinHuaVo.isLeopard   			= 0
	roomJinHuaVo.isDouble    			= 1
	roomJinHuaVo.isTop 					= 10
	roomJinHuaVo.isCompare  			= 2
	roomJinHuaVo.isGuess   				= 2
	self:SetText(CreateRoomPanel.jinTxtDiamond ,"x" .. userInfo.diamond)

	if AppConst.getPlayerPrefs("jinHuaTotal") == "" then
		CreateRoomPanel.jinTog8Inning :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.jinTog8InningTxt1  ,"<color=#48BDFF>8局[每人</color>")
		self:SetText(CreateRoomPanel.jinTog8InningTxt2  ,"<color=#48BDFF>    x1]</color>")

		CreateRoomPanel.jinTog16Inning :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.jinTog16InningTxt1 ,"<color=#5D6D6D>16局[每人</color>")
		self:SetText(CreateRoomPanel.jinTog16InningTxt2,"<color=#5D6D6D>        x2]</color>")
	else
		roomJinHuaVo.jinHuaTotal = tonumber(AppConst.getPlayerPrefs("jinHuaTotal"))
		if tonumber(AppConst.getPlayerPrefs("jinHuaTotal")) == 8 then
			CreateRoomPanel.jinTog8Inning :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTog8InningTxt1  ,"<color=#48BDFF>8局[每人</color>")
			self:SetText(CreateRoomPanel.jinTog8InningTxt2  ,"<color=#48BDFF>    x1]</color>")

			CreateRoomPanel.jinTog16Inning :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTog16InningTxt1 ,"<color=#5D6D6D>16局[每人</color>")
			self:SetText(CreateRoomPanel.jinTog16InningTxt2 ,"<color=#5D6D6D>       x2]</color>")

	    elseif tonumber(AppConst.getPlayerPrefs("jinHuaTotal")) == 16 then
			CreateRoomPanel.jinTog8Inning :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTog8InningTxt1  ,"<color=#5D6D6D>8局[每人</color>")
			self:SetText(CreateRoomPanel.jinTog8InningTxt2  ,"<color=#5D6D6D>    x1]</color>")

			CreateRoomPanel.jinTog16Inning :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTog16InningTxt1 ,"<color=#48BDFF>16局[每人</color>")
			self:SetText(CreateRoomPanel.jinTog16InningTxt2 ,"<color=#48BDFF>        x2]</color>")
		end
	end
	
	if AppConst.getPlayerPrefs("jinHuaPlayMethond") == "" then
		CreateRoomPanel.jinTogSize :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.jinTogSizeTxt   ,"<color=#48BDFF>比大小</color>")

		CreateRoomPanel.jinTogColor :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.jinTogColorTxt  ,"<color=#5D6D6D>比花色</color>")

		CreateRoomPanel.jinTogJin :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.jinTogJinTxt  ,"<color=#5D6D6D>全比</color>")
	else
		roomJinHuaVo.jinHuaPlayMethond = tonumber(AppConst.getPlayerPrefs("jinHuaPlayMethond"))
		if tonumber(AppConst.getPlayerPrefs("jinHuaPlayMethond")) == 1 then
			CreateRoomPanel.jinTogSize :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogSizeTxt   ,"<color=#48BDFF>比大小</color>")

			CreateRoomPanel.jinTogColor :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogColorTxt  ,"<color=#5D6D6D>比花色</color>")

			CreateRoomPanel.jinTogJin :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogJinTxt  ,"<color=#5D6D6D>全比</color>")

		elseif tonumber(AppConst.getPlayerPrefs("jinHuaPlayMethond")) == 2 then
			CreateRoomPanel.jinTogSize :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogSizeTxt   ,"<color=#5D6D6D>比大小</color>")

			CreateRoomPanel.jinTogColor :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogColorTxt  ,"<color=#48BDFF>比花色</color>")

			CreateRoomPanel.jinTogJin :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogJinTxt  ,"<color=#5D6D6D>全比</color>")

		elseif tonumber(AppConst.getPlayerPrefs("jinHuaPlayMethond")) == 3 then
			CreateRoomPanel.jinTogSize :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogSizeTxt   ,"<color=#5D6D6D>比大小</color>")

			CreateRoomPanel.jinTogColor :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogColorTxt  ,"<color=#5D6D6D>比花色</color>")

			CreateRoomPanel.jinTogJin :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogJinTxt  ,"<color=#48BDFF>全比</color>")
		end
	end
   
	if AppConst.getPlayerPrefs("isLeopard") == "" then
		CreateRoomPanel.jinTogLeopard  :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.jinTogLeopardTxt  ,"<color=#5D6D6D>豹子额外奖励</color>")
	else
		roomJinHuaVo.isLeopard = tonumber(AppConst.getPlayerPrefs("isLeopard"))
		if tonumber(AppConst.getPlayerPrefs("isLeopard")) == 1 then
			CreateRoomPanel.jinTogLeopard :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogLeopardTxt ,"<color=#48BDFF>豹子额外奖励</color>")
		else
			CreateRoomPanel.jinTogLeopard :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogLeopardTxt ,"<color=#5D6D6D>豹子额外奖励</color>")
		end
	end
   

	if AppConst.getPlayerPrefs("isDouble") == "" then
		CreateRoomPanel.jinTogDouble  :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.jinTogDoubleTxt  ,"<color=#48BDFF>比牌双倍开</color>")
	else
		roomJinHuaVo.isDouble = tonumber(AppConst.getPlayerPrefs("isDouble"))
		if tonumber(AppConst.getPlayerPrefs("isDouble")) == 0 then
			CreateRoomPanel.jinTogDouble  :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogDoubleTxt  ,"<color=#5D6D6D>比牌双倍开</color>")
		else
			CreateRoomPanel.jinTogDouble  :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogDoubleTxt  ,"<color=#48BDFF>比牌双倍开</color>")
		end
	end
    
    if AppConst.getPlayerPrefs("isTop") == "" then
		CreateRoomPanel.jinTogTopRound5 :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.jinTogTopRound5Txt   ,"<color=#5D6D6D>5轮</color>")

		CreateRoomPanel.jinTogTopRound10 :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.jinTogTopRound10Txt  ,"<color=#48BDFF>10轮</color>")

		CreateRoomPanel.jinTogTopRound15 :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.jinTogTopRound15Txt  ,"<color=#5D6D6D>15轮</color>")
	else
		roomJinHuaVo.isTop = tonumber(AppConst.getPlayerPrefs("isTop"))
		if tonumber(AppConst.getPlayerPrefs("isTop")) == 5 then
			CreateRoomPanel.jinTogTopRound5 :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogTopRound5Txt   ,"<color=#48BDFF>5轮</color>")

			CreateRoomPanel.jinTogTopRound10 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogTopRound10Txt  ,"<color=#5D6D6D>10轮</color>")

			CreateRoomPanel.jinTogTopRound15 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogTopRound15Txt  ,"<color=#5D6D6D>15轮</color>")

		elseif tonumber(AppConst.getPlayerPrefs("isTop")) == 10 then
			CreateRoomPanel.jinTogTopRound5 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogTopRound5Txt   ,"<color=#5D6D6D>5轮</color>")

			CreateRoomPanel.jinTogTopRound10 :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogTopRound10Txt  ,"<color=#48BDFF>10轮</color>")

			CreateRoomPanel.jinTogTopRound15 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogTopRound15Txt  ,"<color=#5D6D6D>15轮</color>")
		--这里特殊处理下，去掉15轮封顶，缓存里如果是15轮封顶就重置为10
		elseif tonumber(AppConst.getPlayerPrefs("isTop")) == 15 then
			roomJinHuaVo.isTop = 10
			CreateRoomPanel.jinTogTopRound5 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogTopRound5Txt   ,"<color=#5D6D6D>5轮</color>")

			CreateRoomPanel.jinTogTopRound10 :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogTopRound10Txt  ,"<color=#48BDFF>10轮</color>")

			CreateRoomPanel.jinTogTopRound15 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogTopRound15Txt  ,"<color=#5D6D6D>15轮</color>")
		end
	end

	if AppConst.getPlayerPrefs("isCompare") == "" then
		CreateRoomPanel.jinTogCompareRound1 :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.jinTogCompareRound1Txt   ,"<color=#5D6D6D>1轮</color>")

		CreateRoomPanel.jinTogCompareRound2 :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.jinTogCompareRound2Txt  ,"<color=#48BDFF>2轮</color>")

		CreateRoomPanel.jinTogCompareRound3 :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.jinTogCompareRound3Txt  ,"<color=#5D6D6D>3轮</color>")
	else
		roomJinHuaVo.isCompare = tonumber(AppConst.getPlayerPrefs("isCompare"))
		if tonumber(AppConst.getPlayerPrefs("isCompare")) == 1 then
			CreateRoomPanel.jinTogCompareRound1 :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogCompareRound1Txt   ,"<color=#48BDFF>1轮</color>")

			CreateRoomPanel.jinTogCompareRound2 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogCompareRound2Txt  ,"<color=#5D6D6D>2轮</color>")

			CreateRoomPanel.jinTogCompareRound3 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogCompareRound3Txt  ,"<color=#5D6D6D>3轮</color>")

		elseif tonumber(AppConst.getPlayerPrefs("isCompare")) == 2 then
			CreateRoomPanel.jinTogCompareRound1 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogCompareRound1Txt   ,"<color=#5D6D6D>1轮</color>")

			CreateRoomPanel.jinTogCompareRound2 :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogCompareRound2Txt  ,"<color=#48BDFF>2轮</color>")

			CreateRoomPanel.jinTogCompareRound3 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogCompareRound3Txt  ,"<color=#5D6D6D>3轮</color>")
		--这里特殊处理下，去掉3轮比牌，缓存里如果是3轮比牌就重置为2
		elseif tonumber(AppConst.getPlayerPrefs("isCompare")) == 3 then
			roomJinHuaVo.isCompare = 2
			CreateRoomPanel.jinTogCompareRound1 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogCompareRound1Txt   ,"<color=#5D6D6D>1轮</color>")

			CreateRoomPanel.jinTogCompareRound2 :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogCompareRound2Txt  ,"<color=#48BDFF>2轮</color>")

			CreateRoomPanel.jinTogCompareRound3 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogCompareRound3Txt  ,"<color=#5D6D6D>3轮</color>")
		end
	end

	if AppConst.getPlayerPrefs("isGuess") == "" then
		CreateRoomPanel.jinTogGuessRound1 :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.jinTogGuessRound1Txt   ,"<color=#5D6D6D>1轮</color>")

		CreateRoomPanel.jinTogGuessRound2 :GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.jinTogGuessRound2Txt  ,"<color=#48BDFF>2轮</color>")

		CreateRoomPanel.jinTogGuessRound3 :GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.jinTogGuessRound3Txt  ,"<color=#5D6D6D>3轮</color>")
	else
		roomJinHuaVo.isGuess = tonumber(AppConst.getPlayerPrefs("isGuess"))
		if tonumber(AppConst.getPlayerPrefs("isGuess")) == 0 then
			CreateRoomPanel.jinTogGuessRound1 :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogGuessRound1Txt   ,"<color=#48BDFF>不闷</color>")

			CreateRoomPanel.jinTogGuessRound2 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogGuessRound2Txt  ,"<color=#5D6D6D>2轮</color>")

			CreateRoomPanel.jinTogGuessRound3 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogGuessRound3Txt  ,"<color=#5D6D6D>3轮</color>")

		elseif tonumber(AppConst.getPlayerPrefs("isGuess")) == 2 then
			CreateRoomPanel.jinTogGuessRound1 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogGuessRound1Txt   ,"<color=#5D6D6D>不闷</color>")

			CreateRoomPanel.jinTogGuessRound2 :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogGuessRound2Txt  ,"<color=#48BDFF>2轮</color>")

			CreateRoomPanel.jinTogGuessRound3 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogGuessRound3Txt  ,"<color=#5D6D6D>3轮</color>")
		--这里特殊处理下，去掉3轮闷牌，缓存里如果是3轮闷牌就重置为2
		elseif tonumber(AppConst.getPlayerPrefs("isGuess")) == 3 then
			roomJinHuaVo.isGuess = 2
			CreateRoomPanel.jinTogGuessRound1 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogGuessRound1Txt   ,"<color=#5D6D6D>不闷</color>")

			CreateRoomPanel.jinTogGuessRound2 :GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.jinTogGuessRound2Txt  ,"<color=#48BDFF>2轮</color>")

			CreateRoomPanel.jinTogGuessRound3 :GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.jinTogGuessRound3Txt  ,"<color=#5D6D6D>3轮</color>")
		end
	end
end

function CreateJinHuaRoomCtrl.OnCreateBtnClick(go)
	local self = CreateJinHuaRoomCtrl
	CreateRoomCtrl.PlayEffectMusic()
	global.systemVo.TalkSource:Stop() 

	local CreateJinHuaRoom = CreateGoldFlowerRoom_pb.CreateGoldFlowerRoomReq()
	CreateJinHuaRoom.jinHuaTotal     		 = roomJinHuaVo.jinHuaTotal	 							 --开房局数  8、16 
	CreateJinHuaRoom.jinHuaPlayMethond    	 = roomJinHuaVo.jinHuaPlayMethond  	 	 				 --比牌方式  1=大小  2=花色	 3=全比
	CreateJinHuaRoom.isLeopard      	 	 = roomJinHuaVo.isLeopard == 1 and true or false     	 --是否豹子额外  1=是  0=否
	CreateJinHuaRoom.isDouble 	 	 		 = roomJinHuaVo.isDouble == 1 and true or false      	 --是否双倍开  1=是 0=否
	CreateJinHuaRoom.isTop 	 				 = roomJinHuaVo.isTop       	 	 					 --封顶局数  5、10、15
	CreateJinHuaRoom.isCompare        		 = roomJinHuaVo.isCompare   		 					 --比牌局数  1、2、3
	CreateJinHuaRoom.isGuess	 	 	 	 = roomJinHuaVo.isGuess  	 	 						 --闷牌局数  1、2、3

	AppConst.setPlayerPrefs("jinHuaTotal",tostring(roomJinHuaVo.jinHuaTotal))
	AppConst.setPlayerPrefs("jinHuaPlayMethond",tostring(roomJinHuaVo.jinHuaPlayMethond))
	AppConst.setPlayerPrefs("isLeopard",tostring(roomJinHuaVo.isLeopard))
	AppConst.setPlayerPrefs("isDouble",tostring(roomJinHuaVo.isDouble))
	AppConst.setPlayerPrefs("isTop",tostring(roomJinHuaVo.isTop))
	AppConst.setPlayerPrefs("isCompare",tostring(roomJinHuaVo.isCompare))
	AppConst.setPlayerPrefs("isGuess",tostring(roomJinHuaVo.isGuess))
	AppConst.setPlayerPrefs("diamondPay",tostring(roomJinHuaVo.diamondPay))
	AppConst.setPlayerPrefs("createGameType",3)
	print("============================333",CreateJinHuaRoom.isTop)
	local msg = CreateJinHuaRoom:SerializeToString()
	Game.SendProtocal(Protocal.CreateGoldFlowerRoom, msg)
end

function CreateJinHuaRoomCtrl.OnCreateJinHuaRoomRes(buffer)
    local self = CreateJinHuaRoomCtrl
	local data   = buffer:ReadBuffer()
	local msg    = CreateGoldFlowerRoom_pb.CreateGoldFlowerRoomRes()	
	msg:ParseFromString(data)
	if msg.moneyType == RoomMode.roomCardMode then	
	   GoldFlowerRoom.RoomMsg = roomJinHuaVo
	   GoldFlowerRoom.RoomMsg.id = msg.roomNum
	   GoldFlowerRoom.RoomMsg.isFangzhu = 1
	else
	   roomJinHuaVo = RoomJinHuaVo:New()
	   GoldFlowerRoom.RoomMsg = roomJinHuaVo
	   GoldFlowerRoom.RoomMsg.id = msg.roomNum
	   GoldFlowerRoom.RoomMsg.isFangzhu = 1
	   --新添加
	   GoldFlowerRoom.RoomMsg.baseNum    = msg.baseNum
	   GoldFlowerRoom.RoomMsg.qualified  = msg.qualified
	   GoldFlowerRoom.RoomMsg.moneyType  = msg.moneyType
	   GoldFlowerRoom.RoomMsg.mcreenings = msg.mcreenings

	   GoldFlowerRoom.RoomMsg.jinHuaPlayMethond = 3
	   GoldFlowerRoom.RoomMsg.isDouble = 1
	   GoldFlowerRoom.RoomMsg.isTop = 10
	   GoldFlowerRoom.RoomMsg.isCompare = 2
	   GoldFlowerRoom.RoomMsg.isGuess = 0
	end

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
	
	GoldFlowerRoom.playersData[1] = joinRoomUserVo
	GoldFlowerRoom.playerCount = 1
	GoldFlowerRoom.myIndex = 1

	--self:Close()
	MainSenceCtrl:Close()
	Room.gameType = RoomType.GoldFlower

	Game.LoadScene("room")
	CreateRoomCtrl.PlayEffectMusic()
end

----------------------炸金花
 function CreateJinHuaRoomCtrl.OnjinTog8InningClick(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.jinHuaTotal = 8
		self:SetText(CreateRoomPanel.jinTog8InningTxt1  ,"<color=#48BDFF>8局[每人</color>")
		self:SetText(CreateRoomPanel.jinTog8InningTxt2  ,"<color=#48BDFF>     x1]</color>")
     else
		self:SetText(CreateRoomPanel.jinTog8InningTxt1  ,"<color=#5D6D6D>8局[每人</color>")
		self:SetText(CreateRoomPanel.jinTog8InningTxt2  ,"<color=#5D6D6D>     x1]</color>")
     end 
end

function CreateJinHuaRoomCtrl.OnjinTog16InningClick(go,bool)
    local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.jinHuaTotal = 16
		self:SetText(CreateRoomPanel.jinTog16InningTxt1 ,"<color=#48BDFF>16局[每人</color>")
		self:SetText(CreateRoomPanel.jinTog16InningTxt2,"<color=#48BDFF>         x2]</color>")
     else
		self:SetText(CreateRoomPanel.jinTog16InningTxt1 ,"<color=#5D6D6D>16局[每人</color>")
		self:SetText(CreateRoomPanel.jinTog16InningTxt2,"<color=#5D6D6D>         x2]</color>")
     end 
end

function CreateJinHuaRoomCtrl.OnjinTogSizeClick(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.jinHuaPlayMethond = 1
		self:SetText(CreateRoomPanel.jinTogSizeTxt   ,"<color=#48BDFF>比大小</color>")
	else
		self:SetText(CreateRoomPanel.jinTogSizeTxt   ,"<color=#5D6D6D>比大小</color>")
	end 
end

function CreateJinHuaRoomCtrl.OnjinTogColorClick(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.jinHuaPlayMethond = 2
		self:SetText(CreateRoomPanel.jinTogColorTxt  ,"<color=#48BDFF>比花色</color>")
	else
		self:SetText(CreateRoomPanel.jinTogColorTxt  ,"<color=#5D6D6D>比花色</color>")
	end 
end

function CreateJinHuaRoomCtrl.OnsjinTogJinClick(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.jinHuaPlayMethond = 3
		self:SetText(CreateRoomPanel.jinTogJinTxt  ,"<color=#48BDFF>全比</color>")
	else
		self:SetText(CreateRoomPanel.jinTogJinTxt  ,"<color=#5D6D6D>全比</color>")
	end 
end

function CreateJinHuaRoomCtrl.OnjinTogLeopardClick(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.isLeopard = 1
     	self:SetText(CreateRoomPanel.jinTogLeopardTxt  ,"<color=#48BDFF>豹子额外奖励</color>")
     else
     	CreateRoomCtrl.PlayEffectMusic()
     	roomJinHuaVo.isLeopard = 0
     	self:SetText(CreateRoomPanel.jinTogLeopardTxt  ,"<color=#5D6D6D>豹子额外奖励</color>")
     end 
end

function CreateJinHuaRoomCtrl.OnjinTogDoubleClick(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.isDouble = 1
     	self:SetText(CreateRoomPanel.jinTogDoubleTxt  ,"<color=#48BDFF>比牌双倍开</color>")
     else
     	CreateRoomCtrl.PlayEffectMusic()
     	roomJinHuaVo.isDouble = 0
     	self:SetText(CreateRoomPanel.jinTogDoubleTxt  ,"<color=#5D6D6D>比牌双倍开</color>")
     end 
end

function CreateJinHuaRoomCtrl.OnjinTogTopRound5Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.isTop = 5
		self:SetText(CreateRoomPanel.jinTogTopRound5Txt   ,"<color=#48BDFF>5轮</color>")
	else
		self:SetText(CreateRoomPanel.jinTogTopRound5Txt   ,"<color=#5D6D6D>5轮</color>")
	end 
end

function CreateJinHuaRoomCtrl.OnjinTogTopRound10Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.isTop = 10
		self:SetText(CreateRoomPanel.jinTogTopRound10Txt  ,"<color=#48BDFF>10轮</color>")
	else
		self:SetText(CreateRoomPanel.jinTogTopRound10Txt  ,"<color=#5D6D6D>10轮</color>")
	end 
end

function CreateJinHuaRoomCtrl.OnjinTogTopRound15Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.isTop = 15
		self:SetText(CreateRoomPanel.jinTogTopRound15Txt  ,"<color=#48BDFF>15轮</color>")
	else
		self:SetText(CreateRoomPanel.jinTogTopRound15Txt  ,"<color=#5D6D6D>15轮</color>")
	end 
end

function CreateJinHuaRoomCtrl.OnjinTogCompareRound1Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.isCompare = 1
		self:SetText(CreateRoomPanel.jinTogCompareRound1Txt   ,"<color=#48BDFF>1轮</color>")
	else
		self:SetText(CreateRoomPanel.jinTogCompareRound1Txt   ,"<color=#5D6D6D>1轮</color>")
	end 
end

function CreateJinHuaRoomCtrl.OnjinTogCompareRound2Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.isCompare = 2
		self:SetText(CreateRoomPanel.jinTogCompareRound2Txt  ,"<color=#48BDFF>2轮</color>")
	else
		self:SetText(CreateRoomPanel.jinTogCompareRound2Txt  ,"<color=#5D6D6D>2轮</color>")
	end 
end

function CreateJinHuaRoomCtrl.OnjinTogCompareRound3Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.isCompare = 3
		self:SetText(CreateRoomPanel.jinTogCompareRound3Txt  ,"<color=#48BDFF>3轮</color>")
	else
		self:SetText(CreateRoomPanel.jinTogCompareRound3Txt  ,"<color=#5D6D6D>3轮</color>")
	end 
end

function CreateJinHuaRoomCtrl.OnjinTogGuessRound1Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.isGuess = 0
		self:SetText(CreateRoomPanel.jinTogGuessRound1Txt   ,"<color=#48BDFF>不闷</color>")
	else
		self:SetText(CreateRoomPanel.jinTogGuessRound1Txt   ,"<color=#5D6D6D>不闷</color>")
	end 
end

function CreateJinHuaRoomCtrl.OnjinTogGuessRound2Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.isGuess = 2
		self:SetText(CreateRoomPanel.jinTogGuessRound2Txt  ,"<color=#48BDFF>2轮</color>")
	else
		self:SetText(CreateRoomPanel.jinTogGuessRound2Txt  ,"<color=#5D6D6D>2轮</color>")
	end 
end

function CreateJinHuaRoomCtrl.OnjinTogGuessRound3Click(go,bool)
	local self = CreateRoomCtrl 
	if bool  then
		CreateRoomCtrl.PlayEffectMusic()
		roomJinHuaVo.isGuess = 3
		self:SetText(CreateRoomPanel.jinTogGuessRound3Txt  ,"<color=#48BDFF>3轮</color>")
	else
		self:SetText(CreateRoomPanel.jinTogGuessRound3Txt  ,"<color=#5D6D6D>3轮</color>")
	end 
end

function CreateJinHuaRoomCtrl.ShowMathond(obj)
	if obj.name == "btnSize" then
		CreateRoomPanel.imgSizeMathond:SetActive(true)
	end
	if obj.name == "btnColor" then
		CreateRoomPanel.imgColorMathond:SetActive(true)
	end
	if obj.name == "btnJin" then
		CreateRoomPanel.imgJinMathond:SetActive(true)
	end
end

function CreateJinHuaRoomCtrl.HideMathond(obj)
	if obj.name == "btnSize" then
		CreateRoomPanel.imgSizeMathond:SetActive(false)
	end
	if obj.name == "btnColor" then
		CreateRoomPanel.imgColorMathond:SetActive(false)
	end
	if obj.name == "btnJin" then
		CreateRoomPanel.imgJinMathond:SetActive(false)
	end
end
----------------------炸金花以上
