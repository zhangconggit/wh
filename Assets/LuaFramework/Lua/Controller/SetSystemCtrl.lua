-- 文件：系统设置控制器
SetSystemCtrl = { }
setbaseclass(SetSystemCtrl, { BaseCtrl })

isMusicOn = ''
isMusicEffectOn = ''
isShakeOn = ''
isBigCardOn = ''
isNXFYOn = ''

-- 启动事件--
function SetSystemCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	self:AddClick(SetSystemPanel.btnClose, self.OnQuitBtnClick)
	self:AddClickNoChange(SetSystemPanel.btnSetMaskBG, self.OnQuitBtnClick)
	-- self:AddClick(SetSystemPanel.btnFanKui,			self.OnFanKuiBtnClick)
	-- self:AddClick(SetSystemPanel.btnGuanYu,			self.OnGuanYuBtnClick)
	self:AddClick(SetSystemPanel.btnChangeNumber, self.OnChangeBtnClick)
	self:AddClick(SetSystemPanel.btnMusic, self.OnMusicBtnClick)
	self:AddClick(SetSystemPanel.btnMusicEffect, self.OnMusicEffectBtnClick)
	self:AddClick(SetSystemPanel.btnShake, self.OnShakeBtnClick)
	-- self:AddClick(SetSystemPanel.btnBigCard,		self.OnBigCardBtnClick)
	self:AddClick(SetSystemPanel.btnMusicOff, self.OnMusicOffBtnClick)
	self:AddClick(SetSystemPanel.btnMusicEffectOff, self.OnMusicEffectOffBtnClick)
	self:AddClick(SetSystemPanel.btnShakeOff, self.OnShakeOffBtnClick)
	-- self:AddClick(SetSystemPanel.btnBigCardOff,		self.OnBigCardOffBtnClick)

	self:AddClick(SetSystemPanel.btnFangYan, self.OnNXFYBtnClick)
	self:AddClick(SetSystemPanel.btnFangYanOff, self.OnNXFYOffBtnClick)

	self:AddClick(SetSystemPanel.togGPSOn, self.OnGPSBtnOnClick)
	self:AddClick(SetSystemPanel.togGPSOff, self.OnGPSBtnOffClick)

	btnMusic = SetSystemPanel.btnMusic
	btnMusicEffect = SetSystemPanel.btnMusicEffect
	btnShake = SetSystemPanel.btnShake
	btnBigCard = SetSystemPanel.btnBigCard
	btnFangYan = SetSystemPanel.btnFangYan

	btnMusicOff = SetSystemPanel.btnMusicOff
	btnMusicEffectOff = SetSystemPanel.btnMusicEffectOff
	btnShakeOff = SetSystemPanel.btnShakeOff
	btnBigCardOff = SetSystemPanel.btnBigCardOff
	btnFangYanOff = SetSystemPanel.btnFangYanOff

	self:InitPanel(RoleInfo);
end

-- 初始化面板--
function SetSystemCtrl:InitPanel(info)
	-- 广电
	-- 以上
	-- 申请苹果审核
	if IS_APP_STORE_CHECK then
		SetSystemPanel.togGPSOn:SetActive(false)
		SetSystemPanel.togGPSOff:SetActive(false)
	end
	SetSystemPanel.btnBigCard:SetActive(false)
	SetSystemPanel.btnBigCardOff:SetActive(false)
	SetSystemPanel.imgTitle1:SetActive(false)

	self:SetText(SetSystemPanel.txtPlayerName, info.name);

	-- 	local image = SetSystemPanel.imgPlayerIcon
	-- 	self:SetText(SetSystemPanel.txtPlayerName, info.name);
	-- 	local sprite = info.image:GetComponent("Image").sprite;
	-- 	weChatFunction.GetSprite(image, sprite);

	if Game.GetSceneName() ~= "main" then
		SetSystemPanel.btnChangeNumber:SetActive(false)
		--SetSystemPanel.imgLine:SetActive(false)
		--SetSystemPanel.imgGame.transform.localPosition = Vector3.New(0, SetSystemPanel.imgGame.transform.localPosition.y, SetSystemPanel.imgGame.transform.localPosition.z)
		--SetSystemPanel.imgMusic.transform.localPosition = Vector3.New(0, SetSystemPanel.imgMusic.transform.localPosition.y, SetSystemPanel.imgMusic.transform.localPosition.z)
	end

	btnMusicOff:SetActive(false)
	btnMusicEffectOff:SetActive(false)
	btnFangYanOff:SetActive(false)
	btnShakeOff:SetActive(false)
	btnBigCardOff:SetActive(false)
	SetSystemPanel.togGPSOff:SetActive(false)

	local login = LoginGame_pb.LoginGameReq()
	if login.loginType == 1 then
		SetSystemPanel.txtWeiXin.SetText('您已微信登录')
	elseif login.loginType == 2 then
		SetSystemPanel.txtWeiXin.SetText('您已游客登录')
	else
		SetSystemPanel.txtWeiXin = nil
	end

	global.systemVo = SystemVo:New()
	if AppConst.getPlayerPrefs('isMusicOn') == '' then
		AppConst.setPlayerPrefs('isMusicOn', '1')
		if global.systemVo.isMusicOn ~= nil then
			global.systemVo.isMusicOn = AppConst.getPlayerPrefs('isMusicOn')
			if global.systemVo.isMusicOn ~= nil and global.systemVo.isMusicOn == '0' then
				btnMusicOff:SetActive(true)
				btnMusic:SetActive(false)
			elseif global.systemVo.isMusicOn ~= nil and global.systemVo.isMusicOn == '1' then
				btnMusicOff:SetActive(false)
				btnMusic:SetActive(true)
			end
		end
		log('----------------------PlayPrefs is nil!!!!')
	else
		log('----------------------AddPlayerPrefs')
		if global.systemVo.isMusicOn ~= nil then
			global.systemVo.isMusicOn = AppConst.getPlayerPrefs('isMusicOn')
			if global.systemVo.isMusicOn ~= nil and global.systemVo.isMusicOn == '0' then
				btnMusicOff:SetActive(true)
				btnMusic:SetActive(false)
			elseif global.systemVo.isMusicOn ~= nil and global.systemVo.isMusicOn == '1' then
				btnMusicOff:SetActive(false)
				btnMusic:SetActive(true)
			end
		end
	end

	if AppConst.getPlayerPrefs('isMusicEffectOn') == '' then
		log('----------------------PlayPrefs is nil!!!!')
		AppConst.setPlayerPrefs('isMusicEffectOn', '1')
		if global.systemVo.isMusicEffectOn ~= nil then
			global.systemVo.isMusicEffectOn = AppConst.getPlayerPrefs('isMusicEffectOn')
			if global.systemVo.isMusicEffectOn ~= nil and global.systemVo.isMusicEffectOn == '0' then
				btnMusicEffectOff:SetActive(true)
				btnMusicEffect:SetActive(false)
			elseif global.systemVo.isMusicEffectOn ~= nil and global.systemVo.isMusicEffectOn == '1' then
				btnMusicEffectOff:SetActive(false)
				btnMusicEffect:SetActive(true)
			end
		end
	else
		log('----------------------AddPlayerPrefs')
		if global.systemVo.isMusicEffectOn ~= nil then
			global.systemVo.isMusicEffectOn = AppConst.getPlayerPrefs('isMusicEffectOn')
			if global.systemVo.isMusicEffectOn ~= nil and global.systemVo.isMusicEffectOn == '0' then
				btnMusicEffectOff:SetActive(true)
				btnMusicEffect:SetActive(false)
			elseif global.systemVo.isMusicEffectOn ~= nil and global.systemVo.isMusicEffectOn == '1' then
				btnMusicEffectOff:SetActive(false)
				btnMusicEffect:SetActive(true)
			end
		end
	end

	if AppConst.getPlayerPrefs('isShakeOn') == '' then
		log('----------------------PlayPrefs is nil!!!!')
		AppConst.setPlayerPrefs('isShakeOn', '1')
		global.systemVo.isShakeOn = AppConst.getPlayerPrefs('isShakeOn')
		if global.systemVo.isShakeOn ~= nil and global.systemVo.isShakeOn == '0' then
			btnShakeOff:SetActive(true)
			btnShake:SetActive(false)
		elseif global.systemVo.isShakeOn ~= nil and global.systemVo.isShakeOn == '1' then
			btnShakeOff:SetActive(false)
			btnShake:SetActive(true)
		end
	else
		log('----------------------AddPlayerPrefs')
		global.systemVo.isShakeOn = AppConst.getPlayerPrefs('isShakeOn')
		if global.systemVo.isShakeOn ~= nil and global.systemVo.isShakeOn == '0' then
			btnShakeOff:SetActive(true)
			btnShake:SetActive(false)
		elseif global.systemVo.isShakeOn ~= nil and global.systemVo.isShakeOn == '1' then
			btnShakeOff:SetActive(false)
			btnShake:SetActive(true)
		end
	end
	if AppConst.getPlayerPrefs('isNXFYOn') == '' then
		log('----------------------PlayPrefs is nil!!!!')
		AppConst.setPlayerPrefs('isNXFYOn','1')
		global.systemVo.isNXFYOn = AppConst.getPlayerPrefs('isNXFYOn')
		if global.systemVo.isNXFYOn ~= nil and global.systemVo.isNXFYOn == '0' then

			btnFangYanOff:SetActive(true)
			-- 广电
			-- btnFangYanOff:SetActive(false)
			btnFangYan:SetActive(false)
		elseif global.systemVo.isNXFYOn ~= nil and global.systemVo.isNXFYOn == '1' then

			btnFangYanOff:SetActive(false)
			btnFangYan:SetActive(true)
			-- 广电
			-- btnFangYan:SetActive(false)
		end
	else
		log('----------------------AddPlayerPrefs')
		global.systemVo.isNXFYOn = AppConst.getPlayerPrefs('isNXFYOn')
		if global.systemVo.isNXFYOn ~= nil and global.systemVo.isNXFYOn == '0' then

			btnFangYanOff:SetActive(true)
			-- 广电
			-- btnFangYanOff:SetActive(false)
			btnFangYan:SetActive(false)
		elseif global.systemVo.isNXFYOn ~= nil and global.systemVo.isNXFYOn == '1' then

			btnFangYanOff:SetActive(false)
			btnFangYan:SetActive(true)
			-- 广电
			-- btnFangYan:SetActive(false)
		end
	end
	-- 房间类型是十点半并且十点半主界面创建着关闭方言功能
	if Room.gameType == RoomType.Tenharf or Room.gameType == RoomType.GoldFlower or Room.gameType == RoomType.CatchPock
		or Room.gameType == RoomType.NiuNiu then
		btnFangYanOff:SetActive(true)
		btnFangYan:SetActive(false)
	end

	-- 申请苹果审核
	if IS_APP_STORE_CHECK == false then
		if AppConst.getPlayerPrefs('isGPSOn') == '' then
			log('----------------------PlayPrefs is nil!!!!')
			AppConst.setPlayerPrefs('isGPSOn', '1')
			global.systemVo.isGPSOn = AppConst.getPlayerPrefs('isGPSOn')
			if global.systemVo.isGPSOn ~= nil and global.systemVo.isGPSOn == '0' then
				SetSystemPanel.togGPSOff:SetActive(true)
				SetSystemPanel.togGPSOn:SetActive(false)
			elseif global.systemVo.isGPSOn ~= nil and global.systemVo.isGPSOn == '1' then
				SetSystemPanel.togGPSOff:SetActive(false)
				SetSystemPanel.togGPSOn:SetActive(true)
			end
		else
			log('----------------------AddPlayerPrefs')
			global.systemVo.isGPSOn = AppConst.getPlayerPrefs('isGPSOn')
			if global.systemVo.isGPSOn ~= nil and global.systemVo.isGPSOn == '0' then
				SetSystemPanel.togGPSOff:SetActive(true)
				SetSystemPanel.togGPSOn:SetActive(false)
			elseif global.systemVo.isGPSOn ~= nil and global.systemVo.isGPSOn == '1' then
				SetSystemPanel.togGPSOff:SetActive(false)
				SetSystemPanel.togGPSOn:SetActive(true)
			end
		end
	end
end

function SetSystemCtrl:GetInfo(a, b, c, d)
	RoleInfo = { name = a, roleId = b, roleIp = c, image = d }
	print("RoleInfo========", d)
end

-- 退出界面--
function SetSystemCtrl.OnQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	RoleInfo = { }
	local self = SetSystemCtrl
	self:Close()
end
function SetSystemCtrl.OnFanKuiBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	NoticeTipsCtrl:Close('NoticeTips')
	SetSystemCtrl:Close('SetSystem')
	MainSencePanel.panelFanKui:SetActive(true)
end    
-- 音乐设置--
function SetSystemCtrl.OnMusicBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	global.systemVo.isMusicOn = '0'

	btnMusicOff:SetActive(true)
	btnMusic:SetActive(false)
	AppConst.setPlayerPrefs("isMusicOn", global.systemVo.isMusicOn)
	log(global.systemVo.isMusicOn)
end

function SetSystemCtrl.OnMusicOffBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	global.systemVo.isMusicOn = '1'
	btnMusicOff:SetActive(false)
	btnMusic:SetActive(true)
	AppConst.setPlayerPrefs("isMusicOn", global.systemVo.isMusicOn)
end
function SetSystemCtrl.OnChangeBtnClick(go)
	global.systemVo.TalkSource:Stop()
	Game.MusicEffect(Game.Effect.buttonBack)
	AppConst.DeleteKey('userID')
	local self = MainSenceCtrl
	self:Close()
	Game.LoadScene("login")
	log(tostring(networkMgr.isConnect))
end
-- 音效设置--
function SetSystemCtrl.OnMusicEffectBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	global.systemVo.isMusicEffectOn = '0'
	btnMusicEffectOff:SetActive(true)
	btnMusicEffect:SetActive(false)
	AppConst.setPlayerPrefs("isMusicEffectOn", global.systemVo.isMusicEffectOn)
end

function SetSystemCtrl.OnMusicEffectOffBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	global.systemVo.isMusicEffectOn = '1'
	btnMusicEffectOff:SetActive(false)
	btnMusicEffect:SetActive(true)
	AppConst.setPlayerPrefs("isMusicEffectOn", global.systemVo.isMusicEffectOn)
end

-- 震动设置--
function SetSystemCtrl.OnShakeBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	global.systemVo.isShakeOn = '0'
	btnShakeOff:SetActive(true)
	btnShake:SetActive(false)
	AppConst.setPlayerPrefs("isShakeOn", global.systemVo.isShakeOn)
end

function SetSystemCtrl.OnShakeOffBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	global.systemVo.isShakeOn = '1'
	btnShakeOff:SetActive(false)
	btnShake:SetActive(true)
	AppConst.setPlayerPrefs("isShakeOn", global.systemVo.isShakeOn)
end

-- 放大出牌设置--
-- function SetSystemCtrl.OnBigCardBtnClick(go)
-- 	Game.MusicEffect(Game.Effect.joinRoom)
-- 	global.systemVo.isBigCardOn ='0'
-- 	btnBigCardOff:SetActive(true)
-- 	btnBigCard:SetActive(false)
-- 	AppConst.setPlayerPrefs("isBigCardOn",global.systemVo.isBigCardOn)
-- end

-- function SetSystemCtrl.OnBigCardOffBtnClick(go)
-- 	Game.MusicEffect(Game.Effect.joinRoom)
-- 	global.systemVo.isBigCardOn ='1'
-- 	btnBigCardOff:SetActive(false)
-- 	btnBigCard:SetActive(true)
-- 	AppConst.setPlayerPrefs("isBigCardOn",global.systemVo.isBigCardOn)
-- end

-- 方言设置--
function SetSystemCtrl.OnNXFYBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	global.systemVo.isNXFYOn = '0'
	btnFangYanOff:SetActive(true)
	btnFangYan:SetActive(false)
	AppConst.setPlayerPrefs("isNXFYOn", global.systemVo.isNXFYOn)
end

function SetSystemCtrl.OnNXFYOffBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	-- 房间类型是十点半并且十点半主界面创建着关闭方言功能
	if Room.gameType == RoomType.Tenharf or Room.gameType == RoomType.GoldFlower or Room.gameType == RoomType.CatchPock
		or Room.gameType == RoomType.NiuNiu or Room.gameType == RoomType.WuZiQi then
		return
	end
	global.systemVo.isNXFYOn = '1'
	btnFangYanOff:SetActive(false)
	btnFangYan:SetActive(true)
	AppConst.setPlayerPrefs("isNXFYOn", global.systemVo.isNXFYOn)
end

-- GPS设置--
function SetSystemCtrl.OnGPSBtnOnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	global.systemVo.isGPSOn = '0'
	SetSystemPanel.togGPSOff:SetActive(true)
	SetSystemPanel.togGPSOn:SetActive(false)
	AppConst.setPlayerPrefs("isGPSOn", global.systemVo.isGPSOn)

	if Game.GetSceneName() == "mahjong" or Game.GetSceneName() == "room" then
		if Input.location.isEnabledByUser then
			MessageTipsCtrl:ShowInfo("为了更好的游戏体验，请前往本机设置中找到并开启定位服务后允许大厅访问位置信息。")
		else
			MessageTipsCtrl:ShowInfo("为了更好的游戏体验，请开启<color=#318c09>游戏</color>及<color=#b41818>设备系统设置</color>中GPS定位")
		end
	end

	if Game.GetSceneName() == "main" then
		MessageTipsCtrl:ShowInfo("为了更好的游戏体验，请前往本机设置中找到并开启定位服务后允许大厅访问位置信息。")
	end
end

function SetSystemCtrl.OnGPSBtnOffClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	global.systemVo.isGPSOn = '1'
	SetSystemPanel.togGPSOff:SetActive(false)
	SetSystemPanel.togGPSOn:SetActive(true)
	AppConst.setPlayerPrefs("isGPSOn", global.systemVo.isGPSOn)
end