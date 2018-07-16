LoginCtrl = { }
setbaseclass(LoginCtrl, { BaseCtrl })

local userID
local isAgreeUserArgeement = true

function LoginCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	Game.MusicBG("bgm1")
	self:AddClick(LoginPanel.btnTouristLogin, self.OnClick)
	self:AddClick(LoginPanel.btnWeChatLogin, self.OnWeChatLoginBtnClick)
	-- self:AddClick(LoginPanel.btnMobIP, self.OnMobIPBtnClick)
	-- LoginPanel.btnTouristLogin:OnPointerDown(this.OnClick)
	self:AddClick(LoginPanel.btnxieyi, self.Onxieyibg)
	self:AddClick(LoginPanel.btnxieyishow, self.Onxieyishow)
	self:InitPanel()
end

function LoginCtrl:InitPanel()
	--self:isShowIPAndPort(false)
	LoginPanel.xieyibg:SetActive(false)
	GameObject.Find("Canvas/GuiCamera/DownLoadAssetsPanel/bar"):SetActive(false)
	if Game.isReload and networkMgr.isConnect then
		BlockLayerCtrl:UsualOpen("BlockLayer")
		self:Invoke("AutoLogin", 0.5)
		Game.isReload = false
	end
	if weChatFunction.getWeChatState() == true then
		LoginPanel.btnWeChatLogin:SetActive(true)
		LoginPanel.btnTouristLogin:SetActive(true)
	elseif weChatFunction.getWeChatState() == false then
		LoginPanel.btnWeChatLogin:SetActive(true)
		LoginPanel.btnTouristLogin:SetActive(true)
	end
	-- 广电
	-- LoginPanel.btnWeChatLogin:SetActive(false)
	-- LoginPanel.btnTouristLogin:SetActive(true)
	local txtVersion = find("Canvas/GuiCamera/DownLoadAssetsPanel/txtVersionNumber")
	txtVersion.transform:GetComponent('Text').text = 'V' .. AppConst.version

	if AppConst.getPlayerPrefs('isGPSOn') == '' then
		AppConst.setPlayerPrefs("isGPSOn", '1')
	end
	-- 发送GPS信息
	if IS_APP_STORE_CHECK == false then
		Input.location:Start(10, 10);
		coroutine.start(MainSenceCtrl.LocationReq)
		print("========SendGPS======LoginCtrl")
	end
end

function LoginCtrl:AutoLogin()
	if weChatFunction.getWeChatState() == true then
		self.OnWeChatLoginBtnClick()
	else
		self.OnClick()
	end
end

function LoginCtrl.Onxieyibg(go)
	LoginPanel.xieyibg:SetActive(true)
end

function LoginCtrl.Onxieyishow(go)
	LoginPanel.xieyibg:SetActive(false)
end

function LoginCtrl.OnClick(go)
	--if global.userVo == nil then
	--if networkMgr.isConnect == true then
	local self = LoginCtrl
	--Game.MusicEffect(Game.Effect.feizaofly)			--播放音乐
	isAgreeUserArgeement = LoginPanel.togUserArgeement:GetComponent('Toggle').isOn
	if isAgreeUserArgeement then
		-- 打开阻挡层
		BlockLayerCtrl:UsualOpen("BlockLayer")
		self.isYouKeLogin = true

		local login = LoginGame_pb.LoginGameReq()

		login.loginType = 2
		-- 登录类型
		self.loginTypes = login.loginType

		if (AppConst.getCurrentPlatform() == 'Android') then
			login.pid = 'Android'
			-- pid
		end

		if (AppConst.getCurrentPlatform() == 'IOS') then
			login.pid = 'IOS'
			-- pid
		end

		if (login.pid ~= 'IOS' and login.pid ~= 'Android') then
			login.pid = 'PC'
			-- pid
			AppConst.DeleteKey('userID')
		end

		local loginUserID = AppConst.getPlayerPrefs('userID')
		if loginUserID == '' then
			userID = ''
		else
			userID = tostring(loginUserID)
		end
		login.unionId = ''
		login.userId = tostring(userID)
		login.machingId = AppConst.getDeviceID()
		if (login.pid == 'PC') then
			local random = Util.Random(1003333, 1000000000000000)
		    --login.machingId = tostring(random)
			login.machingId = '2123124125151'
		end

		-- 游客登录名字
		local userName = AppConst.getPlayerPrefs('userName')
		login.name = userName;
		local msg = login:SerializeToString()
		Game.SendProtocal(Protocal.Login, msg)
		print("================游客",tostring(login))
		--local msgs = ''
		--Game.SendProtocal(Protocal.GetShareState, msgs)
	else
		MessageTipsCtrl:ShowInfo("请同意用户协议")
	end
end

-- 微信登录userID为空时拉起授权窗口，不为空就不用拉起授权窗口了
function LoginCtrl.OnWeChatLoginBtnClick(go)
	local self = LoginCtrl
	isAgreeUserArgeement = LoginPanel.togUserArgeement:GetComponent('Toggle').isOn
	if isAgreeUserArgeement then
		-- 打开阻挡层
		BlockLayerCtrl:UsualOpen("BlockLayer")
		self.DeleteUserID()
		local loginUserID = AppConst.getPlayerPrefs('userID')
		if loginUserID == '' then
			weChatFunction.weChatLoginGame()
		else
			local login = LoginGame_pb.LoginGameReq()
			login.userId = tostring(loginUserID)
			login.loginType = 1
			if (AppConst.getCurrentPlatform() == 'Android') then
				login.pid = 'Android'
				-- pid
				login.machingId = AppConst.getDeviceID()
			end

			if (AppConst.getCurrentPlatform() == 'IOS') then
				login.pid = 'IOS'
				-- pid
				login.machingId = AppConst.getDeviceID()
			end
			local nickname = AppConst.getPlayerPrefs('nickname')
			local headimgurl = AppConst.getPlayerPrefs('headimgurl')
			local sex = AppConst.getPlayerPrefs('sex')
			local unionId = AppConst.getPlayerPrefs('unionID')
			-- 获取微信Token
			local token = AppConst.getPlayerPrefs('token')
			print('LoginCtrl.OnWeChatLoginBtnClick', token)
			login.name = nickname;
			login.headimgUrl = headimgurl;
			login.gender = tonumber(sex);
			login.unionId = unionId
			local msg = login:SerializeToString()
			Game.SendProtocal(Protocal.Login, msg)
			local msgs = ''
			Game.SendProtocal(Protocal.GetShareState, msgs)
		end
	else
		MessageTipsCtrl:ShowInfo("请同意用户协议")
	end
end

function LoginCtrl.OnWeChatLoginInfoSend(userInfo, authInfo)
	local login = LoginGame_pb.LoginGameReq()
	local info = weChatUserInfo.CreateFromJson(userInfo)
	local authInfo = WeChatAuthInfo.CreateFromJson(authInfo)
	print('authInfo.token', authInfo.token)
	print('info.unionid', info.unionid, info.openid)
	login.unionId = info.unionid
	login.userId = info.openid
	login.loginType = 1
	if (AppConst.getCurrentPlatform() == 'Android') then
		login.pid = 'Android'
		-- pid
		login.machingId = AppConst.getDeviceID()
	end

	if (AppConst.getCurrentPlatform() == 'IOS') then
		login.pid = 'IOS'
		-- pid
		login.machingId = AppConst.getDeviceID()
	end
	login.name = info.nickname;

	AppConst.setPlayerPrefs('nickname', tostring(login.name))
	login.headimgUrl = info.headimgurl;
	AppConst.setPlayerPrefs('headimgurl', tostring(login.headimgUrl))
	login.gender = info.sex;
	AppConst.setPlayerPrefs('sex', tostring(login.gender))
	-- 缓存微信Token
	AppConst.setPlayerPrefs('token', tostring(authInfo.token))
	AppConst.setPlayerPrefs('userID', tostring(login.userId))
	AppConst.setPlayerPrefs('unionID', tostring(login.unionId))

	local msg = login:SerializeToString()
	Game.SendProtocal(Protocal.Login, msg)
	local msgs = ''
	Game.SendProtocal(Protocal.GetShareState, msgs)
end

function LoginCtrl.OnLoginRes(buffer)
	local self = LoginCtrl
	local data = buffer:ReadBuffer()
	print('==============ssss========', data)
	local msg = LoginGame_pb.LoginGameRes()
	msg:ParseFromString(data)
	local nowTime = msg.nowTime
	-- long型时间戳
	local offset = msg.offset
	-- int型,时区偏移量
	local userId = msg.userId
	-- string userId
	global.isDebug = msg.isdebug
	-- 是否是debug模式
	global.isUserType = msg.userType
	-- 1是普通账号 2是GM账号
	global.isregister = msg.isregister
	-- 是否第一次注册

	log("LoginType-----------" .. global.isUserType)
	-- if(tostring(userId) ~= AppConst.getPlayerPrefs('userID')) then
	-- AppConst.setPlayerPrefs('userID',tostring(userId))
	-- end
	
	if self.isYouKeLogin then
		AppConst.setPlayerPrefs('userID', tostring(userId))
		self.isYouKeLogin = false
	end
	self.isFormLogin = true

	local ip = msg.ip
	-- string ip
	print('==============asd=======',table.getn(msg.userInfo), msg.userInfo[1])
	local userInfo = msg.userInfo[1]
	local userVo = UserVo:New()
	print('==============asd=======', msg.userInfo)
	userVo.roleId = userInfo.roleId
	userVo.name = userInfo.name
	userVo.gender = userInfo.gender
	userVo.diamond = userInfo.diamond
	userVo.headImg = userInfo.headImg
	userVo.roleIp = ip
	userVo.state = userInfo.state
	userVo.goldcoin = userInfo.goldcoin
	-- 金币数量
	--userVo.wing = userInfo.wing
	-- 元宝数量
	print('userInfo.goldcoin', userInfo.goldcoin, userInfo.wing)
	userVo.signDays = userInfo.signDays
	-- 初始商城模式
	userVo.modes = 2
	-- 记录安卓还是IOS
	if (AppConst.getCurrentPlatform() == 'Android') then
		userVo.banben = 1
	end

	if (AppConst.getCurrentPlatform() == 'IOS') then
		userVo.banben = 2
	end
	-- 已经签到的天数
	userVo.isSign = userInfo.isSign
	-- 今天是否已经签到
	userVo.abcd = userVo.isSign
	userVo.signature = userInfo.shortDesc
	-- 玩家的个性签名
	global.userVo = userVo
	-- 缓存玩家名字（供游客使用）
	AppConst.setPlayerPrefs('userName', tostring(global.userVo.name))
	logWarn("---------------RoleName>>" .. global.userVo.name)
	print("userVo====-----------------登陆的时候是否签到----------------------====",userInfo.isSign)
	for k, v in pairs(userVo) do
		print(k, v)
	end
	print("============userVo")
	-- 语音登录
	weChatFunction.YunVaOnLogin(global.userVo.name, tostring(global.userVo.roleId))

	Game.SendProtocal(Protocal.GetNoitceInfo)
	MainSenceCtrl.SendLocation()
	-- 关闭阻挡层
	BlockLayerCtrl:Close();
	self:Close()
	if userInfo.roomNum > 0 and userInfo.state > 0 then
		--print("============isReloadBattle=====userInfo.roomNum====", userInfo.state, userInfo.roomNum)
		self.isFormLogin = false
		if userInfo.state == 2 then
			Game.isReloadBattle = true
		end

	else
		print("============isReloadBattle222", userInfo.state)
		Game.LoadScene("main")
	end
end

-- 定期清理userID,保证用户修改了微信信息能及时更新
function LoginCtrl.DeleteUserID()
	local self = LoginCtrl
	local curTime = AppConst.getPlayerPrefs('loginTime')
	if curTime == "" then
		tab = os.date("*t", os.time());
		AppConst.setPlayerPrefs('loginTime', tostring(tab.yday))
	else
		tab = os.date("*t", os.time());
		local time = tab.yday - tonumber(curTime)
		if time >= 7 or time < 0 then
			-- 七天清理一次,小于0是为了避免跨年导致天数为负的情况
			AppConst.DeleteKey('userID')
			AppConst.DeleteKey('loginTime')
		end
	end
	-- 下次热更去掉这里
	local yday = AppConst.getPlayerPrefs('loginDay')
	print('LoginCtrl.DeleteUserID===', yday)
	if yday == "" then
		AppConst.DeleteKey('userID')
		AppConst.setPlayerPrefs('loginDay', tostring('loginDaysss'))
	end
end

-- 方便快速修改IP和端口
-- function LoginCtrl.OnMobIPBtnClick(go)
-- 	networkMgr:SocketClose()
-- 	local self = LoginCtrl
-- 	local ip = self:GetInputText(LoginPanel.inputIP)
-- 	local port = self:GetInputText(LoginPanel.inputPort)
-- 	AppConst.SocketAddress = ip
-- 	AppConst.SocketPort = tonumber(port)
--     Game.AudioObject()
--     AppConst.uuuIdKeyBytes = nil
-- 	networkMgr:SendConnect()
-- end

-- function LoginCtrl:isShowIPAndPort(isShow)
-- 	print("LoginCtrl:isShowIPAndPort========")
-- 	LoginPanel.inputIP:SetActive(isShow)
-- 	LoginPanel.inputPort:SetActive(isShow)
-- 	LoginPanel.btnMobIP:SetActive(isShow)
-- 	if isShow then
-- 		self:SetInputText(LoginPanel.inputIP,'182.151.214.180')
-- 		self:SetInputText(LoginPanel.inputPort,'8003')
-- 	end
-- end
