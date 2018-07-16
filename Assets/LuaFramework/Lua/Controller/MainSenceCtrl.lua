 --文件：主界面逻辑
MainSenceCtrl = {}
setbaseclass(MainSenceCtrl, {BaseCtrl})

local huaban						--花瓣特效
local shuye						    --树叶特效
local playTime = 0					--播放时间
local stopTime = 0					--暂停时间
local clickNum = 0
local isCanClick = true

--启动事件--
function MainSenceCtrl:OnCreate(obj)
    BaseCtrl.OnCreate(self, obj)
    print('MainSenceCtrl.GetShareStateRes===========finished BaseCtrl.OnCreate=====')
	--self:AddClick(MainSencePanel.btnHelp,self.OnHelpClick)
	self:AddClick(MainSencePanel.btnSystemSet,self.OnSystemSetClick)

	self:AddClick(MainSencePanel.btnHeadImg,self.OnHeadImgClick)           --点击头像按钮
	self:AddClick(MainSencePanel.btnGrade,self.OnGradeClick)
	self:AddClick(MainSencePanel.btnCommitInfo,self.OnCommitClick)
	self:AddClick(MainSencePanel.btnActivity,self.OnActivityClick)
	--self:AddClick(MainSencePanel.btnDiamondPay,self.OnDiamondPayClick)
	self:AddClick(MainSencePanel.btnXiaoXi,self.OnXiaoXiClick)
	self:AddClick(MainSencePanel.btnJuLeBu,self.OnJuLeBuClick)

    self:AddClick(MainSencePanel.btnQXTuiChu,self.OnQXTuiChuBtnClick)
    self:AddClick(MainSencePanel.btnQXFanKui,self.OnQXFanKuiBtnClick)
    self:AddClickNoChange(MainSencePanel.btnQXTuiChuMask,self.OnQXTuiChuBtnClick)

	self:AddClick(MainSencePanel.imgWomanClick,self.OnWomanClick)
	self:AddClick(MainSencePanel.btnConfirm,self.DiamondConfirm)
	self:AddClick(MainSencePanel.btnClose,self.DiamondClose)
	self:AddClick(MainSencePanel.btnSendDiamond,self.DiamondOpen)
	--新添加
	self:AddClick(MainSencePanel.btnRankList,self.OnRankListBtnClick)       --排行榜
	--self:AddClick(MainSencePanel.btnFriends,self.OnFriendsClick)
	--self:AddClick(MainSencePanel.btnGoldPay,self.OnDiamondPayClick)
	self:AddClick(MainSencePanel.btnMatchRoom,self.OnMatchRoomBtnClick)
	--新添加大厅功能
	self:AddClick(MainSencePanel.btnGameCerateRoom,self.OnGameCerateRoomClick)
	self:AddClick(MainSencePanel.btnJoinRoom,self.OnJoinRoomClick)
	self:AddClick(MainSencePanel.btnMahjongRoom,self.OnGameRoomClick)
	self:AddClick(MainSencePanel.btnNiuniuRoom,self.OnGameRoomClick)
	self:AddClick(MainSencePanel.btnRedDragonRoom,self.OnGameRoomClick)
	self:AddOnScrollValueChange(MainSencePanel.gameMainScrollbar,self.OnGameMainScrollbar)
	--self:AddOnScrollValueChange(MainSencePanel.ActiveScrollbar,self.OnActiveScrollbar)

	--[[self:AddClick(MainSencePanel.btnChuji,self.OnRoomBtnClick)
	self:AddClick(MainSencePanel.btnZhongji,self.OnRoomBtnClick)
	self:AddClick(MainSencePanel.btnGaoJi,self.OnRoomBtnClick)
	self:AddClick(MainSencePanel.btnHaoHua,self.OnRoomBtnClick)
	self:AddClick(MainSencePanel.btnDaHaoHua,self.OnRoomBtnClick)--]]


	self:AddClick(MainSencePanel.goldMode,self.OnPlaceBtnClick)
	--self:AddClick(MainSencePanel.wingMode,self.OnPlaceBtnClick)
	self:AddClick(MainSencePanel.roomCardMode,self.OnPlaceBtnClick)
	self:AddClick(MainSencePanel.btnBack,self.OnBackBtnClick)                --返回

	self:AddClick(MainSencePanel.btnHelpNew,self.OnHelpNewBtnClick)          --帮助
	self:AddClick(MainSencePanel.btnExit,self.OnExitBtnClick)                --显示退出菜单
	self:AddClick(MainSencePanel.btnQuit,self.OnQuitClick)         		 	 --退出游戏

    self:AddClick(MainSencePanel.btnCertification, self.OnCertification)  		--实名认证菜单
    self:AddClick(MainSencePanel.btnCertificationShow,self.OnCertificationShow) --关闭
    self:AddClick(MainSencePanel.btnCertificationSure,self.OnCertificationSure) --确认提交

    self:AddClick(MainSencePanel.btnMall,self.OnMallBtnClick)                --商城
    self:AddClick(MainSencePanel.btnKefu,self.OnBtnKefuClick) 				 --客服

    self:AddClick(MainSencePanel.btnJinBiPay,self.OnTitlePayBtnClick) 
    --self:AddClick(MainSencePanel.btnYuanBaoPay,self.OnTitlePayBtnClick)
    self:AddClick(MainSencePanel.btnFangKaPay,self.OnTitlePayBtnClick)

    self.bool = false
    print('MainSenceCtrl.GetShareStateRes===========begin InitPanel=====')
	self:InitPanel(global.userVo)
end

--初始化面板--
function MainSenceCtrl:InitPanel(userInfo)
	print('MainSenceCtrl.GetShareStateRes===========InitPanel=====')

    if IS_APP_STORE_CHECK then
    	MainSencePanel.btnDiamondPay:SetActive(false)
    	MainSencePanel.btnCommitInfo:SetActive(false)
    	MainSencePanel.btnActivity:SetActive(false)
    	MainSencePanel.btnHelp.transform.localPosition = Vector3.New(-358,-306,0);
		MainSencePanel.btnSystemSet.transform.localPosition = Vector3.New(11,-306,0);
		MainSencePanel.btnGrade.transform.localPosition = Vector3.New(370,-306,0);
    end
    MainSencePanel.ChooseRoom:SetActive(false)
    MainSencePanel.imgsJinBi:SetActive(true)
    MainSencePanel.imgsYuanBo:SetActive(false)
    
	print('MainSenceCtrl.GetShareStateRes===========Open-NoticeTips=====')
    NoticeTipsCtrl:Open("NoticeTips")
	-- global.systemVo.BGSource.volume = 0.5
	self = MainSenceCtrl
	self.RoomType = RoomMode.goldcoin                        --进入界面默认yuanbao模式
--[[	if global.isUserType >= 2 and global.isUserType ~= 6 then
		MainSencePanel.btnSendDiamond:SetActive(true)
		MainSencePanel.panelSendDiamond:SetActive(false)
	else
		MainSencePanel.btnSendDiamond:SetActive(false)
		MainSencePanel.panelSendDiamond:SetActive(false)
	end--]]
	print('MainSenceCtrl.GetShareStateRes===========huaban=====')
	huaban = MainSencePanel.effecthuaban:GetComponent('ParticleSystem')
	print('MainSenceCtrl.GetShareStateRes===========shuye=====')
	shuye  = MainSencePanel.effectshuye:GetComponent('ParticleSystem')
	local img = MainSencePanel.imgHeadIcon
	if(AppConst.getCurrentPlatform() == "PC") then
		local url = "http://imgsrc.baidu.com/forum/w%3D580/sign=10e8ddc5067b02080cc93fe952d8f25f/b2c424e636d12f2ec7d65b0043c2d562843568ad.jpg"
		weChatFunction.SetPic(img,global.userVo.roleId,url)
	else
		weChatFunction.SetPic(img,global.userVo.roleId,global.userVo.headImg)
	end
	local gameObject = MainSencePanel.btnActivity
	local sequence = DG.Tweening.DOTween.Sequence()
	local rotateMod = DG.Tweening.RotateMode.Fast
	--Game.MusicBG("bgm1")
	--金币隐藏
	--MainSencePanel.:SetActive(false)
	print('MainSenceCtrl.GetShareStateRes===========RefreshPanel=====')
	self:RefreshPanel(userInfo,"InitPanel")
	print('MainSenceCtrl.GetShareStateRes===========InvokeRepeat=====')
	self:InvokeRepeat("EffectPlay",1,30000000)

	local sequence = DG.Tweening.DOTween.Sequence()	--动画序列
	local rotateMod = DG.Tweening.RotateMode.FastBeyond360		--旋转模型
	local zeroRotate = Vector3.New(0,0,1800000)
	print('MainSenceCtrl.GetShareStateRes===========sequence:Appen=====')
	sequence:Append(MainSencePanel.imgDuoBaoGuang.transform:DORotate(zeroRotate,60000.5,rotateMod))

	self.roomNum = 0
	print('MainSenceCtrl.GetShareStateRes===========self:setWeb()=====')
	--self:setWeb()
	print('MainSenceCtrl.GetShareStateRes===========self:batteryShow()=====')
	--self:batteryShow()
	print('MainSenceCtrl.GetShareStateRes===========self:singShow()=====')
	--self:singShow()
	--self:CreateSpine()
end

----------------------------------------------------------------------------------------------------

function MainSenceCtrl.SendLocation()
	if global.userVo and global.isSendGPS == false then
		local Location = Location_pb.LocationReq()
		Location.locationInfo = global.gpsMsgLocation 
		local msg = Location:SerializeToString()
		Game.SendProtocal(Protocal.Location,msg)
		global.isSendGPS = true
	end
end


--发送GPS信息
function MainSenceCtrl.LocationReq()
	if AppConst.getCurrentPlatform() == 'PC' then
		global.gpsMsgLocation = "0" .. "/" .. "0" .. "/" .. "0"
	else
		if Input.location.isEnabledByUser then 
			while  true do
				if Input.location.status ~= LocationServiceStatus.Failed and 
					Input.location.status ~= LocationServiceStatus.Initializing and Input.location.status ~= LocationServiceStatus.Stopped then 

					break
				end
				coroutine.step()
			end

			if AppConst.getPlayerPrefs('isGPSOn') == '1' then
				isGPSOn = "1"
			else
				isGPSOn = "0"
			end
			global.gpsMsgLocation = isGPSOn  .. "/" .. tostring(Input.location.lastData.latitude) .. "/" .. tostring(Input.location.lastData.longitude)
		else
			if AppConst.getPlayerPrefs('isGPSOn') == '1' then
				MessageTipsCtrl:ShowInfo("为了更好的游戏体验，请在<color=#b41818>设备系统设置</color>中开启GPS定位")
			end
			global.gpsMsgLocation = "0" .. "/" .. "0" .. "/" .. "0"
		end
	end
	MainSenceCtrl.SendLocation()
	Input.location:Stop();
end

function MainSenceCtrl.OnJoinRoomClick(go)
    --Game.MusicEffect(Game.Effect.joinRoom)
    print("OnJoinRoomClick")
	JoinRoomCtrl:Open('JoinRoom')
end

function MainSenceCtrl.OnGameCerateRoomClick(go)
	print("------点击创建房间按钮-------")
	local self = MainSenceCtrl
	self.RoomType = RoomMode.roomCardMode
	AppConst.setPlayerPrefs("createGameType",9)
    --[[CreateRoomCtrl:Open('CreateRoom',function ()
		CreateRoomCtrl:RoomInfoShow(
			self.roomNum = 5
	end)--]]
	CreateRoomCtrl:Open('CreateRoom')
end

function MainSenceCtrl.OnQXTuiChuBtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	MainSencePanel.panelExitGame:SetActive(false)
end

function MainSenceCtrl.OnQXFanKuiBtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	NoticeTipsCtrl:Open('NoticeTips')
	MainSencePanel.panelFanKui:SetActive(false)
end

function MainSenceCtrl.OnSystemSetClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	SetSystemCtrl:GetInfo(global.userVo.name,global.userVo.roleId,global.userVo.roleIp,MainSencePanel.imgHeadIcon)
	SetSystemCtrl:Open('SetSystem')
end	

function MainSenceCtrl.OnQuitClick(go)
	if global.userVo.banben == 1 then
      weChatFunction.QuitGame()
    else 
      	global.systemVo.TalkSource:Stop()
	    --Game.MusicEffect(Game.Effect.buttonBack)
	    AppConst.DeleteKey('userID')
	    local self = MainSenceCtrl
	    self:Close()
	    Game.LoadScene("login")
	    log(tostring(networkMgr.isConnect))
	end
end
-------------------------------------------------点击头像显示个人信息---------------------------------------
--点击头像
function MainSenceCtrl.OnHeadImgClick()
	local roleInfo = {}
	--Game.MusicEffect(Game.Effect.joinRoom)
	--RoleInfoCtrl:GetInfo(global.userVo.name,global.userVo.roleId,global.userVo.roleIp,
	 --            MainSencePanel.imgHeadIcon,global.userVo.wing,global.userVo.goldcoin,global.userVo.diamond)
	roleInfo = {name = global.userVo.name,roleId = global.userVo.roleId, roleIp = global.userVo.roleIp,
	            image = MainSencePanel.imgHeadIcon,goldcoin = global.userVo.goldcoin,diamond = global.userVo.diamond}
	RoleInfoCtrl:Open("RoleInfo",function()
		RoleInfoCtrl:InitPanel(roleInfo)
	end)	 
end

function MainSenceCtrl.OnGradeClick()
	--Game.MusicEffect(Game.Effect.joinRoom)
	MessageTipsCtrl:ShowInfo("暂未开放，敬请期待！")
	--GradeCtrl:Open("Grade")
	--MainSencePanel.fartherOfMainSence:SetActive(false)  --隐藏一级界面部分内容
	--MainSencePanel.ChooseRoom:SetActive(false)
	--CreateRoomCtrl:Close('CreateRoom')
end


function MainSenceCtrl.OnXiaoXiClick()
	MessageTipsCtrl:ShowInfo("研发部正在加班研发中！")
end


function MainSenceCtrl.OnJuLeBuClick()
	MessageTipsCtrl:ShowInfo("研发部正在加班研发中！")
end


--[[function MainSenceCtrl.OnUI_WuZiQiRoomClick()
	--Game.MusicEffect(Game.Effect.joinRoom)
	UI_WuZiQiCtrl.CreateRoom()
end--]]

--五子棋回调
function MainSenceCtrl.UI_WuZiQiRoomRes(buffer)
    local self = MainSenceCtrl
	local data   = buffer:ReadBuffer()
	local msg    = CreateWuziqiRoot_pb.CreateWuziqiRoomRes()

	msg:ParseFromString(data)
	print("======MainSenceCtrl.UI_WuZiQiRoomRes====msg.roomNum==",msg.roomNum)
	if MainSenceCtrl.RoomType == RoomMode.roomCardMode then	
	   	UI_WuZiQiCtrl.RoomMsg = roomWuZiQiVo
	   	UI_WuZiQiCtrl.RoomMsg.id = msg.roomNum
	   	UI_WuZiQiCtrl.RoomMsg.isFangzhu = 1
	else
		UI_WuZiQiCtrl.RoomMsg = roomWuZiQiVo
	   	UI_WuZiQiCtrl.RoomMsg.id = msg.roomNum
	   	UI_WuZiQiCtrl.RoomMsg.isFangzhu = 1
	end
	
	
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
	--joinRoomUserVo.wing	 	 = userVo.wing
	UI_WuZiQiCtrl.playersData[1] = joinRoomUserVo
	UI_WuZiQiCtrl.playerCount = 1
	UI_WuZiQiCtrl.myIndex = 1

	self:Close()
	Room.gameType = RoomType.WuZiQi
	CreateRoomCtrl.PlayEffectMusic()
	UI_WuZiQiCtrl:Open("UI_WuZiQi")
end

function MainSenceCtrl.OnBiSaiClick()
	--Game.MusicEffect(Game.Effect.joinRoom)
	local msg = "暂未开放，敬请期待！"
	MessageTipsCtrl:ShowInfo(msg)
end

-------------------------------------判定点击的游戏类型-----------------------------------------------
function MainSenceCtrl.OnGameRoomClick(go)
	--[[local self = MainSenceCtrl
	MainSencePanel.fartherOfMainSence:SetActive(false)
	MainSencePanel.imgsJinBi:SetActive(false)
	MainSencePanel.imgsYuanBo:SetActive(true)
	MainSencePanel.spineHudie:SetActive(false)
	--Game.MusicEffect(Game.Effect.joinRoom)

	if go.name == "btnRedDragonRoom" then
		self.GameType = RoomType.RedDragon
		self.roomNum = 1
	elseif go.name == "btnNiuniuRoom" then
		self.GameType = RoomType.NiuNiu
		self.roomNum = ２
	elseif go.name == "btnMahjongRoom" then 
		self.GameType = RoomType.Mahjong
		self.roomNum = 3
	end
	AppConst.setPlayerPrefs("createGameType",tostring(self.roomNum))
	MainSencePanel.ChooseRoom:SetActive(true)
	NoticeTipsCtrl:Close(true)
	self:ResetButton()    --每次打开ChooseRoom的时候初始化一下按钮
    --MainSencePanel.farBtns:SetActive(false)
    --self:ShowIcons()      --显示游戏的Icon-
    
    if self.RoomType ~= 0 and self.GameType ~= 0 then
       local data = SecondLevel_pb.SecondLevelReq()
       data.moneyType = self.RoomType
       data.gameType =  self.GameType
       local msg = data:SerializeToString()
       Game.SendProtocal(Protocal.SecondLevel, msg)
    end--]]
    MessageTipsCtrl:ShowInfo("暂未开放，敬请期待！")
end

-----------------创建房间,游戏类型(麻将...),房间类型(金币,元宝,房卡),场次类型(初级,中级,高级...)--------------------
function MainSenceCtrl.OnRoomBtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local autoMateRoom = AutoMateRoom_pb.AutoMateRoomReq()
	autoMateRoom.gameType = self.GameType                    --麻将炸金花十点半...
	autoMateRoom.roomType = self.RoomType                    --金币元宝房卡

	if go.name == "btnChuji" then
		autoMateRoom.placeType = placeType.Chuji             --初级场
	elseif go.name == "btnZhongji" then
		autoMateRoom.placeType = placeType.Zhongji           --中级场
	elseif go.name == "btnGaoJi" then
		autoMateRoom.placeType = placeType.GaoJi             --高级场
	elseif go.name == "btnHaoHua" then
		autoMateRoom.placeType = placeType.HaoHua            --豪华场
	elseif go.name == "btnDaHaoHua" then
		autoMateRoom.placeType = placeType.DaHaoHua          --大豪华场
	end
	print('MainSenceCtrl.OnRoomBtnClick=============',autoMateRoom.gameType,autoMateRoom.roomType,autoMateRoom.placeType)
	if autoMateRoom.placeType ~= 0 then
	   local msg = autoMateRoom:SerializeToString()
       Game.SendProtocal(Protocal.AutoMateRoom, msg)		
	end
end

------------------------------------------金币模式,元宝模式,房卡模式----------------------------------------
function MainSenceCtrl.OnPlaceBtnClick(go)
	local self = MainSenceCtrl
	--Game.MusicEffect(Game.Effect.joinRoom)
	if go.name == "goldMode" then
		MainSencePanel.imgJinBi:SetActive(true)
		MainSencePanel.imgYuanBao:SetActive(false)
		MainSencePanel.imgFriend:SetActive(false)
        MainSencePanel.btnS:SetActive(true)
		MainSencePanel.imgsYuanBo:SetActive(false)
	    MainSencePanel.imgsJinBi:SetActive(true)
		CreateRoomCtrl:Close()
		self.RoomType = RoomMode.goldMode
        global.userVo.modes = 1
        local data = SecondLevel_pb.SecondLevelReq()
    	data.moneyType = self.RoomType
    	data.gameType =  self.GameType
    	local msg = data:SerializeToString()
    	Game.SendProtocal(Protocal.SecondLevel, msg)

--[[	elseif go.name == "wingMode" then
		MainSencePanel.imgJinBi:SetActive(false)
		MainSencePanel.imgYuanBao:SetActive(true)
		MainSencePanel.imgFriend:SetActive(false)
        MainSencePanel.btnS:SetActive(true)
		MainSencePanel.imgsYuanBo:SetActive(true)
	    MainSencePanel.imgsJinBi:SetActive(false)
		CreateRoomCtrl:Close()
		self.RoomType = RoomMode.wingMode
        global.userVo.modes = 2
        local data = SecondLevel_pb.SecondLevelReq()
    	data.moneyType = self.RoomType
    	data.gameType =  self.GameType
    	local msg = data:SerializeToString()
    	Game.SendProtocal(Protocal.SecondLevel, msg)	--]]

--[[	elseif go.name == "roomCardMode" then
		MainSencePanel.imgJinBi:SetActive(false)
		MainSencePanel.imgYuanBao:SetActive(false)
		MainSencePanel.imgFriend:SetActive(true)
		MainSencePanel.btnS:SetActive(false)
		self.RoomType = RoomMode.roomCardMode
        global.userVo.modes = 0

		CreateRoomCtrl:Open('CreateRoom',function ()     --打开CreateRoom界面
			CreateRoomCtrl:RoomInfoShow(self.roomNum)
		end)--]]
	end
end

----------------------------------------获取底注等信息的返回------------------------------
function MainSenceCtrl.SecondLevelRes(buffer)
	local self = MainSenceCtrl
	local data   = buffer:ReadBuffer()
	local msg    = SecondLevel_pb.SecondLevelRes()
	msg:ParseFromString(data)
	
	for k,v in ipairs(msg.secondLevelInfo) do

		print("========================显示为流畅==========",v.state,v.playType)
		local typeface = ''
		if tonumber(v.state) == 1 then
			typeface = '<color=#00FF00>流畅</color>'
		end
		if tonumber(v.state) == 2 then
			typeface = '<color=#FFFF85>火热</color>'
		end
		if tonumber(v.state) == 3 then
			typeface = '<color=#FFD44B>拥挤</color>'
		end
		if tonumber(v.state) == 4 then
			typeface = '<color=#FF0000>爆满</color>'
		end
		if tonumber(v.playType) == 1 then
			self:SetText(MainSencePanel.txtScoreChuJi,v.baseNumber)
			self:SetText(MainSencePanel.txtJOne,formatNumbers(v.qualifications) .."-".. formatNumbers(v.qualifications))
			self:SetText(MainSencePanel.txtPerNumChuJi,typeface)
		elseif tonumber(v.playType) == 2 then
			self:SetText(MainSencePanel.txtScoreZhongJi,v.baseNumber)
			self:SetText(MainSencePanel.txtJTwo,formatNumbers(v.qualifications) .."-".. formatNumbers(v.qualifications))
			self:SetText(MainSencePanel.txtPerNumZhongJi,typeface)
		elseif tonumber(v.playType) == 3 then
			self:SetText(MainSencePanel.txtScoreGaoJi,v.baseNumber)
			self:SetText(MainSencePanel.txtJThree,formatNumbers(v.qualifications) .."-".. formatNumbers(v.qualifications))
			self:SetText(MainSencePanel.txtPerNumGaoJi,typeface)
		elseif tonumber(v.playType) == 4 then
			self:SetText(MainSencePanel.txtScoreHaoHua,v.baseNumber)
			self:SetText(MainSencePanel.txtJFour,formatNumbers(v.qualifications) .."-".. formatNumbers(v.qualifications))
			self:SetText(MainSencePanel.txtPerNumHaoHua,typeface)
		elseif tonumber(v.playType) == 5 then
			self:SetText(MainSencePanel.txtScoreDaHaoHua,v.baseNumber)
			self:SetText(MainSencePanel.txtJFive,formatNumbers(v.qualifications) .."-".. formatNumbers(v.qualifications))
			self:SetText(MainSencePanel.txtPerNumDaHaoHua,typeface)
		end
	end
end

----------------------------------------点击大厅的返回按钮-------------------------------
function MainSenceCtrl.OnBackBtnClick()
	--Game.MusicEffect(Game.Effect.buttonBack)
	MainSencePanel.btnS:SetActive(true)                  --打开几级房间的进入按钮
	MainSencePanel.ChooseRoom:SetActive(false)           --关闭大厅二级界面
	MainSencePanel.fartherOfMainSence:SetActive(true)    --打开大厅一级界面
	MainSencePanel.spineHudie:SetActive(true)
	CreateRoomCtrl:Close()
	NoticeTipsCtrl:Open('NoticeTips')
end

------------------------------------------排行榜---------------------------------------------------------
function MainSenceCtrl.OnRankListBtnClick()
	--Game.MusicEffect(Game.Effect.joinRoom)
	roleInfo = {image = MainSencePanel.imgHeadIcon,--[[wing = global.userVo.wing,--]]
	            goldcoin = global.userVo.goldcoin,name = global.userVo.name,roleId = global.userVo.roleId}
	RankListCtrl:Open("RankList",function()
		RankListCtrl:InitPanel(roleInfo)
	end)	
end


---------------------------------------------点击商城按钮---------------------------------------------------
function MainSenceCtrl.OnMallBtnClick()
	--Game.MusicEffect(Game.Effect.joinRoom) 
	ShopMallCtrl:Open("ShopMall")                       --打开商城
	NoticeTipsCtrl:Close('NoticeTips')                  --关闭消息提示
	MainSencePanel.fartherOfMainSence:SetActive(false)  --隐藏一级界面部分内容
	MainSencePanel.ChooseRoom:SetActive(false)
	CreateRoomCtrl:Close('CreateRoom')

	local roleId  = global.userVo.roleId
    local unionID = AppConst.getPlayerPrefs('unionID')
    local openID  = AppConst.getPlayerPrefs('userID')
    local diamond = global.userVo.diamond
    local urlInfo = tostring(roleId)..'_'..tostring(unionID)..'_'..tostring(openID)..'_'..tostring(diamond)
    print('urlInfo=================',urlInfo)
    --weChatFunction.openWeChat('http://www.leyouhudong.com/',urlInfo)
end


--[[function MainSenceCtrl.OnFriendsClick()
	--Game.MusicEffect(Game.Effect.joinRoom)
	local msg = "暂未开放，敬请期待！"
	MessageTipsCtrl:ShowInfo(msg)
end--]]

function MainSenceCtrl.OnMatchRoomBtnClick()
	--Game.MusicEffect(Game.Effect.joinRoom)
	GameMatchCtrl:Open("GameMatch")
end

function MainSenceCtrl.OnCommitClick()
	--Game.MusicEffect(Game.Effect.joinRoom)
	--MessageTipsCtrl:ShowInfo("暂未开放，敬请期待！")
	ShareCtrl:Open("Share")
end

function MainSenceCtrl.OnActivityClick()
	--Game.MusicEffect(Game.Effect.joinRoom)
	--MessageTipsCtrl:ShowInfo("暂未开放，敬请期待！")
	    DalyCheckCtrl:Open('DalyCheck')	
	--ActivityCtrl:Open("Activity")
end

function MainSenceCtrl.OnDiamondPayClick()
	--Game.MusicEffect(Game.Effect.joinRoom)
	DiamondPayCtrl:Open("DiamondPay")
end

function MainSenceCtrl.OnWomanClick()
	local co = coroutine.start(function ()
		if not isCanClick then return end
		clickNum = clickNum + 1
		local num = clickNum%2
		if num == 0 then 
			Game.Sing("womanClick1")
		else
			Game.Sing("womanClick2")
		end
		isCanClick = false
		coroutine.wait(3)
		isCanClick = true
	end)
end
local R = 0
local G = 1
local B = 0
local K = 1
local refreshTime = 58
--特效轮播--
function MainSenceCtrl.EffectPlay()
	self = MainSenceCtrl
	if not self.isCreate then return 
	else
		playTime = 2+ playTime
		stopTime = 2 + stopTime
		if playTime > 2 then
			shuye:Stop()
		end
		if playTime >8 then
			shuye:Play()
			playTime = 0
		end

		if stopTime > 3 then
			huaban:Stop()
		end
		if stopTime > 13 then
			huaban:Play()
			stopTime = 0
		end		
	end
	--30秒刷新信息
	refreshTime = refreshTime + 1
	if refreshTime > 30 then
		self:batteryShow()
		self:singShow()
		refreshTime = 0 
	end
	--系统设置音乐按钮只控制背景音乐，所有别的声音都用音效按钮控制
	if global.systemVo.isMusicEffectOn == '0' then
		global.systemVo.EffectSource.volume = 0
		global.systemVo.CardSource.volume = 0
		global.systemVo.TalkSource.volume = 0
	else
		global.systemVo.EffectSource.volume = 1
		global.systemVo.CardSource.volume = 1
		global.systemVo.TalkSource.volume = 1
	end	
	
	if global.systemVo.isMusicOn == '0' then
		global.systemVo.BGSource.volume = 0
		-- global.systemVo.CardSource.volume = 0
		-- global.systemVo.TalkSource.volume = 0
	else
		global.systemVo.BGSource.volume = 0.5
		-- global.systemVo.CardSource.volume = 1
		-- global.systemVo.TalkSource.volume = 1
	end
end

function MainSenceCtrl.CurrencyChangeRes(buffer)
	local data   = buffer:ReadBuffer()
	local msg    = CurrencyChange_pb.CurrencyChangeRes()
	msg:ParseFromString(data)
	global.userVo.diamond = msg.currencyVal
	if MainSenceCtrl.isCreate then
		MainSenceCtrl:RefreshPanel(global.userVo,"CurrencyChangeRes")
	end
end

function MainSenceCtrl.GoldcoinChangeRes(buffer)
	local data   = buffer:ReadBuffer()
	local msg    = GoldcoinChange_pb.GoldcoinChangeRes()
	msg:ParseFromString(data)
	global.userVo.goldcoin = msg.GoldcoinVal
	if MainSenceCtrl.isCreate then
		MainSenceCtrl:RefreshPanel(global.userVo,"GoldcoinChangeRes")
	end
end

--[[function MainSenceCtrl.WingChangeRes(buffer)
	local data   = buffer:ReadBuffer()
	local msg    = WingChange_pb.WingChangeRes()
	msg:ParseFromString(data)
	global.userVo.wing = msg.WingVal
	if MainSenceCtrl.isCreate then
		MainSenceCtrl:RefreshPanel(global.userVo,"WingChangeRes")
	end
end--]]

--刷新信息
function MainSenceCtrl:RefreshPanel(userInfo,name)
	print("===============RefreshPanel==========",name)
	self = MainSenceCtrl
	self:SetText(MainSencePanel.roleId, userInfo.roleId)
	self:SetText(MainSencePanel.name,userInfo.name)
	self:SetText(MainSencePanel.diamond,formatNumber(userInfo.diamond))
	self:SetText(MainSencePanel.txtGoldNum,formatNumber(userInfo.goldcoin))
	--self:SetText(MainSencePanel.txtCoinNum,formatNumber(userInfo.wing))
end

--送房卡确认按钮
function MainSenceCtrl.DiamondConfirm(go)
	self = MainSenceCtrl
	local sendID = self:GetInputText(MainSencePanel.inputRoleID)
	local sendNum = self:GetInputText(MainSencePanel.inputDiamond)
	--验证
	if sendID == global.userVo.roleId then
		MessageTipsCtrl:ShowInfo("不能给自己赠送！")
		self.DiamondClose()
		return
	end

	if sendNum == "" then
		MessageTipsCtrl:ShowInfo("请输入房卡数！")
		self.DiamondClose()
		return
	end

	if tonumber(sendNum) <= 0 then
		MessageTipsCtrl:ShowInfo("输入的房卡数必须大于零！")
		self.DiamondClose()
		return
	end

	
	if tonumber(sendNum) > tonumber(global.userVo.diamond) then
		MessageTipsCtrl:ShowInfo("你没有那么多房卡！")
		self.DiamondClose()
		return
	end

	local signInfo = FriendGift_pb.FriendGiftReq()
	signInfo.targerRoleId = sendID
	signInfo.diamondCount = tonumber(sendNum)
	local msg = signInfo:SerializeToString()
	Game.SendProtocal(Protocal.FriendGift,msg)
end
--送房卡回调
function MainSenceCtrl.DiamondRes(buffer)
	local data   = buffer:ReadBuffer()
	local msg    = IntTypeReturn_pb.IntTypeReturnRes()	
	msg:ParseFromString(data)
	local intVal = msg.intVal
	if intVal == 0 then
	end
	if intVal == 1 then
		self = MainSenceCtrl
		self:RefreshPanel(global.userVo,"DiamondRes")
		self:DiamondClose()
		MessageTipsCtrl:ShowInfo("赠送成功")
	end
end

--送房卡面板关闭
function MainSenceCtrl.DiamondClose(go)
	MainSencePanel.panelSendDiamond:SetActive(false)
end

--送房卡面板打开
function MainSenceCtrl.DiamondOpen(go)
	MainSencePanel.panelSendDiamond:SetActive(true)
end

--获取分享状态回调
function MainSenceCtrl.GetShareStateRes(buffer)
	local self = MainSenceCtrl
	local data   = buffer:ReadBuffer()
	local msg    = IntTypeReturn_pb.IntTypeReturnRes()
	msg:ParseFromString(data)
	--0不显示 >=1显示
	local isShowShare = msg.intVal
	print('MainSenceCtrl.GetShareStateRes===========',isShowShare)
	if isShowShare == 0 then
	elseif isShowShare >= 1 then
		local co = coroutine.start(function ()
			print('MainSenceCtrl.GetShareStateRes==========MainSenceCtrl.isCreate=====',MainSenceCtrl.isCreate)
			while not MainSenceCtrl.isCreate do
				coroutine.step()
			end
			print('MainSenceCtrl.GetShareStateRes===========MainSenceCtrl.isCreate=====',MainSenceCtrl.isCreate)
			print('MainSenceCtrl.GetShareStateRes===========global.isregiste=====',global.isregiste)
			if global.isregister then
				MessageTipsCtrl:ShowInfo("欢迎您来到大厅，首次登陆送房卡"..global.userVo.diamond.."张，祝您玩的愉快！ ")
			    global.isregister = false
			else
				print('MainSenceCtrl.GetShareStateRes===========LoginCtrl.isFormLogin=====',LoginCtrl.isFormLogin)
				if LoginCtrl.isFormLogin then
					if GameRoomCardMatchCtrl.joinOK then
					else
						print('MainSenceCtrl.GetShareStateRes===========will open share pannel=====')
						ShareCtrl:Open("Share")
						LoginCtrl.isFormLogin = false
						print("****************************************************")
						print(global.userVo.isSign)
						print("****************************************************")
						print('MainSenceCtrl.GetShareStateRes===========global.userVo.isSign=====',global.userVo.isSign)
						if global.userVo.isSign == false then
							print('MainSenceCtrl.GetShareStateRes===========will open DalyCheck pannel=====')
		                   DalyCheckCtrl:Open('DalyCheck')
	                    end							
					end
				end
			end
		end)
		print('MainSenceCtrl.GetShareStateRes===========table.insert(Network.crts, co)=====')
		table.insert(Network.crts, co)
	end
end

function MainSenceCtrl:setWeb()
	local roleId  = global.userVo.roleId
    local unionID = AppConst.getPlayerPrefs('unionID')
    local openID  = AppConst.getPlayerPrefs('userID')
    local diamond = global.userVo.diamondCount
    local urlInfo = 'roleId='..tostring(roleId)..'&unionId='..tostring(unionID)..'&openId='..tostring(openID)..'&diamond='..tostring(diamond)
    local key = '&key=4UOEcp1qR1'
    self.url = 'http://lymwx.leyohudong.com/mallController/mallIndex?'
    AppConst.setPlayerPrefs("webUrl",tostring(self.url)); 
    AppConst.setPlayerPrefs("urlInfo",tostring(urlInfo)); 
    AppConst.setPlayerPrefs("key",tostring(key)); 
end

function MainSenceCtrl.WebOpen()
	--MainSencePanel.webClose:SetActive(true)
	print('urlInfo=================',self.url)
end

function MainSenceCtrl.WebClose(obj)
	--MainSencePanel.webClose:SetActive(false)
end

--实名认证
function MainSenceCtrl.OnCertification(go)
	MainSencePanel.CertificationPanel:SetActive(true)
	NoticeTipsCtrl:Close('NoticeTips')
end

--关闭实名认证菜单
function MainSenceCtrl.OnCertificationShow(go)
	local self = MainSenceCtrl
	MainSencePanel.CertificationPanel:SetActive(false)
	NoticeTipsCtrl:Open("NoticeTips")
end

function MainSenceCtrl.OnCertificationSure(go)
	local self = MainSenceCtrl
	
	local data 	= RealName_pb.RealNameReq()
    data.name  	= self:GetText(MainSencePanel.txtCertification3)
    data.idNo  	= self:GetText(MainSencePanel.txtCertification7)
    --data.mobile = ""
    local msg 	= data:SerializeToString()
    Game.SendProtocal(Protocal.RealName, msg)	
end

function MainSenceCtrl.RealNameRes(buffer)
	local self = MainSenceCtrl
	local data   = buffer:ReadBuffer()
	local msg    = RealName_pb.RealNameRes()
	msg:ParseFromString(data)

	if msg.successStatus == 1 then
		self:SetText(MainSencePanel.txtCertificationTip,"认证成功")
		self:CertificationTip()
		MainSencePanel.btnCertificationSure:SetActive(false)
		MainSencePanel.txtCertification3:SetActive(false)
		MainSencePanel.txtCertification7:SetActive(false)
		local co = coroutine.start(function()
        coroutine.wait(1.5)
		MainSencePanel.CertificationPanel:SetActive(false)
		MainSencePanel.farBtn:SetActive(false)
    	end)
	elseif msg.successStatus == 2 then
		self:SetText(MainSencePanel.txtCertificationTip,"参数不全")
		self:CertificationTip()
	elseif msg.successStatus == 3 then
		self:SetText(MainSencePanel.txtCertificationTip,"身份证或姓名不匹配")
		self:CertificationTip()
	elseif msg.successStatus == 4 then
		self:SetText(MainSencePanel.txtCertificationTip,"电话号码不正确")
		self:CertificationTip()
	end
end

function MainSenceCtrl.CertificationTip(go)
	MainSencePanel.imgCertificationTip:SetActive(true)
	local co = coroutine.start(function()
        coroutine.wait(3)
		MainSencePanel.imgCertificationTip:SetActive(false)
    end)
    table.insert(Network.crts, co)
end

--重置金币元宝好友同玩的按钮
function MainSenceCtrl.ResetButton()
	MainSencePanel.imgJinBi:SetActive(false)
	MainSencePanel.imgYuanBao:SetActive(true)
	MainSencePanel.imgFriend:SetActive(false)
end

--点击标题栏的"更多"按钮
--[[function MainSenceCtrl.OnMoreBtnClick(go)
	local self = MainSenceCtrl  
	--Game.MusicEffect(Game.Effect.joinRoom)
	if self.bool == false then
		MainSencePanel.farBtns:SetActive(true)
		self.bool = true	
	else 
		MainSencePanel.farBtns:SetActive(false)
		self.bool = false
    end
end--]]

--点击标题栏的三个加号,弹出对应的商品框
function MainSenceCtrl.OnTitlePayBtnClick(go)
	----Game.MusicEffect(Game.Effect.joinRoom)
	--[[MainSencePanel.fartherOfMainSence:SetActive(false)  --关闭大厅主界面部分内容
	NoticeTipsCtrl:Close('NoticeTips')                  --关闭消息提示
	MainSencePanel.ChooseRoom:SetActive(false)          --关闭选择房间的按钮
	CreateRoomCtrl:Close() 
	ShopMallCtrl:Open("ShopMall",function()                    --关闭好友同玩创建 房间
		if go.name == "btnYuanBaoPay" then
		   ShopMallPanel.buyJinBi:SetActive(false)
		   ShopMallPanel.buyFangKa:SetActive(false)
		   ShopMallPanel.buyYuanBao:SetActive(true)
		   ShopMallPanel.imgJinBi:SetActive(false)
		   ShopMallPanel.imgYuanBao:SetActive(true)
		   ShopMallPanel.imgFangKa:SetActive(false)         --以上六行控制元宝购买界面显隐
		   mainSceneBtnAddMode = btnYuanBaoPayMode          --用于记录玩家上一次打开商城的购买界面
		end
		if go.name == "btnJinBiPay" then
	   	   ShopMallPanel.buyJinBi:SetActive(true)
		   ShopMallPanel.buyFangKa:SetActive(false)
		   ShopMallPanel.buyYuanBao:SetActive(false)
		   ShopMallPanel.imgJinBi:SetActive(true)
		   ShopMallPanel.imgYuanBao:SetActive(false)
		   ShopMallPanel.imgFangKa:SetActive(false)         --以上六行控制金币购买界面显隐
		   mainSceneBtnAddMode = btnJinBiPayMode            --用于记录玩家上一次打开商城的购买界面
		end
		if go.name == "btnFangKaPay" then
		   ShopMallPanel.buyJinBi:SetActive(false)
		   ShopMallPanel.buyFangKa:SetActive(true)
		   ShopMallPanel.buyYuanBao:SetActive(false)
		   ShopMallPanel.imgJinBi:SetActive(false)
		   ShopMallPanel.imgYuanBao:SetActive(false)
		   ShopMallPanel.imgFangKa:SetActive(true)          --以上六行控制房卡购买界面显隐
		   mainSceneBtnAddMode = btnFangKaPayMode           --用于记录玩家上一次打开商城的购买界面
		end
	end)--]]
	DiamondPayCtrl:Open('DiamondPay')
end

--显示房间的类型(牛牛.炸金花.推倒胡.捉麻子等等)
function MainSenceCtrl.ShowIcons()
	local self = MainSenceCtrl
	self.tableIcon = {MainSencePanel.imgNiuIcon,MainSencePanel.imgHuaShuiIcon,MainSencePanel.imgHongZhongIcon,
                      MainSencePanel.imgZhaJinHuaIcon,MainSencePanel.imgZhuoMaZiIcon,MainSencePanel.imgShiDianBanIcon,
                      MainSencePanel.imaLandlordsIcon,MainSencePanel.imgBattleMahjongIcon}
    for k,v in pairs(self.tableIcon) do
    	v:SetActive(false)
    end

    if self.GameType == RoomType.Mahjong then
    	self.tableIcon[2]:SetActive(true)
    elseif self.GameType == RoomType.Tenharf then
    	self.tableIcon[6]:SetActive(true)
    elseif self.GameType == RoomType.GoldFlower then
    	self.tableIcon[4]:SetActive(true)
    elseif self.GameType == RoomType.CatchPock then
    	self.tableIcon[5]:SetActive(true)
    elseif self.GameType == RoomType.NiuNiu then
    	self.tableIcon[1]:SetActive(true)
    elseif self.GameType == RoomType.RedDragon then
    	self.tableIcon[3]:SetActive(true)
    elseif self.GameType == RoomType.Landlords then
    	self.tableIcon[7]:SetActive(true)
    elseif self.GameType == RoomType.BattleMahjong then
    	self.tableIcon[8]:SetActive(true)
    end
end

--客服界面
function MainSenceCtrl.OnBtnKefuClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	DiamondPayCtrl:Open('DiamondPay')
end

--帮助界面显示
function MainSenceCtrl.OnHelpNewBtnClick(go)
	print("===========>>>>帮助界面")
	--Game.MusicEffect(Game.Effect.joinRoom)
    PlayMethodCtrl:Open('PlayMethod')
end

--显示退出游戏界面
function MainSenceCtrl.OnExitBtnClick(go)
	 --Game.MusicEffect(Game.Effect.joinRoom)
     MainSencePanel.panelExitGame:SetActive(true)
end

--退出
function MainSenceCtrl.OnExitGameBtnClick()
	--weChatFunction.QuitGame()
	print("************退出游戏啦!!!!!!!!************************************")
end

function MainSenceCtrl.OnGameMainScrollbar(go,value)
	--print("MainSenceCtrl.OnGameMainScrollbar value:",value)
	MainSencePanel.imgNightBg.transform.localPosition = Vector3.New(310 - value*620, 0, 1)
end

function MainSenceCtrl.OnActiveScrollbar(go,value)

end
--WIFI显示
function MainSenceCtrl.batteryShow()
	if AppConst.getNetType() == 0 then
		MainSencePanel.imgSign1:SetActive(true)
	elseif AppConst.getNetType() == 1 then
		local level = network_delay
    	if level >0 and level <= 100 then
        	MainSencePanel.imgSignWifi1:SetActive(false)
        	MainSencePanel.imgSignWifi2:SetActive(false)
        	MainSencePanel.imgSignWifi3:SetActive(true)
    	elseif level > 100 and level <= 200 then
    		MainSencePanel.imgSignWifi1:SetActive(false)
        	MainSencePanel.imgSignWifi2:SetActive(true)
        	MainSencePanel.imgSignWifi3:SetActive(false)
    	else
    		MainSencePanel.imgSignWifi1:SetActive(true)
        	MainSencePanel.imgSignWifi2:SetActive(false)
        	MainSencePanel.imgSignWifi3:SetActive(false)
    	end
	elseif AppConst.getNetType() == 2 then
		local level = network_delay
    	if level > 0 and level <= 100 then
        	MainSencePanel.imgSign2:SetActive(false)
        	MainSencePanel.imgSign3:SetActive(false)
        	MainSencePanel.imgSign4:SetActive(true)
    	elseif level > 100 and level <= 200 then
    		MainSencePanel.imgSign2:SetActive(false)
        	MainSencePanel.imgSign3:SetActive(true)
        	MainSencePanel.imgSign4:SetActive(false)
    	else
    		MainSencePanel.imgSign2:SetActive(true)
        	MainSencePanel.imgSign3:SetActive(false)
        	MainSencePanel.imgSign4:SetActive(false)
    	end
	end
end

--电量显示
function MainSenceCtrl.singShow()
	if AppConst.GetBatteryLevel() <= 20 then
		MainSencePanel.imgBattery20:SetActive(true)
		MainSencePanel.imgBattery80:SetActive(false)
		MainSencePanel.imgBattery100:SetActive(false)
	elseif AppConst.GetBatteryLevel() > 20 and AppConst.GetBatteryLevel() <= 80 then
		MainSencePanel.imgBattery20:SetActive(false)
		MainSencePanel.imgBattery80:SetActive(true)
		MainSencePanel.imgBattery100:SetActive(false)
	elseif AppConst.GetBatteryLevel() > 80 and AppConst.GetBatteryLevel() <= 100 then
		MainSencePanel.imgBattery20:SetActive(false)
		MainSencePanel.imgBattery80:SetActive(false)
		MainSencePanel.imgBattery100:SetActive(true)
	end
end

function MainSenceCtrl:CreateSpine()
	local CreateSpine = spineMgr.CreateSpine
	CreateSpine(spineMgr,"JoinRoom",function(obj)
		print("生成spine"..obj.name)
		obj.transform:SetParent(MainSencePanel.btnJoinRoom.transform)
		obj.transform.localScale = Vector3.one
		obj.transform.localPosition = Vector3.zero
	end)
end