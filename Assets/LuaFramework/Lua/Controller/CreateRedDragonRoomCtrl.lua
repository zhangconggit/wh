-- 红中麻将
CreateRedDragonRoomCtrl = {
}
setbaseclass(CreateRedDragonRoomCtrl, { BaseCtrl })

local roomRed = { }

local text1 = ''
local text2 = ''
local text3 = ''
local text4 = ''
local text5 = ''
local btnNum = nil

function CreateRedDragonRoomCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	obj.transform.localPosition = Vector3.New(0, 0, 0);

	self:AddOnValueChanged(CreateRoomPanel.btnQuit, self.OnRedQuitBtnClick)

	self:AddOnValueChanged(CreateRoomPanel.redTog8Inning, self.OnredTog8InningClick)
	self:AddOnValueChanged(CreateRoomPanel.redTog16Inning, self.OnredTog16InningClick)
	self:AddOnValueChanged(CreateRoomPanel.redTogAA, self.OnredTogAAClick)
	self:AddOnValueChanged(CreateRoomPanel.redTogBoss, self.OnredTogBossClick)

	self:AddOnValueChanged(CreateRoomPanel.redTogNum3, self.OnredTogNum3Click)
	self:AddOnValueChanged(CreateRoomPanel.redTogNum4, self.OnredTogNum4Click)
	self:AddOnValueChanged(CreateRoomPanel.redTogRobot, self.OnredTogRobotClick)

	self:AddClick(CreateRoomPanel.redBtnCreate, self.OnRedCreateBtnClick)

	self:InitPanel(global.userVo)
end

-- 初始化面板
function CreateRedDragonRoomCtrl:InitPanel(userInfo)
	-- 房间信息表

	roomRed = roomRedDragonVo:New()
	roomRed.id = 1
	roomRed.total = 8
	-- 局数
	roomRed.modeType = 1
	-- 是否AA
	roomRed.isSelf = 1
	-- 是否自摸
	roomRed.isFeng = 1
	-- 是否不要风
	roomRed.isRed = 1
	-- 是否是红中
	roomRed.isFishNum = 0
	-- 下鱼数
	roomRed.isPlayNum = 4
	-- 玩家数
	roomRed.isRobot = 2
	-- 是否要机器人
	roomRed.isBihu = 2
	-- 是否必须胡牌

	CreateRoomPanel.redTogRobot:SetActive(false)
	self:SetText(CreateRoomPanel.redTxtDiamond, "x" .. userInfo.diamond)
	--CreateRoomPanel.imgMask:SetActive(false)
	print("asdfasdfa===============", AppConst.getPlayerPrefs("redPay"))
	----红中麻将
	if AppConst.getPlayerPrefs("redTotal") == "" then
		CreateRoomPanel.redTog8Inning:GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.redTog8InningTxt1, "<color=#48BDFF>8局</color>")
		CreateRoomPanel.redTog16Inning:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.redTog16InningTxt1, "<color=#5D6D6D>16局</color>")
	else
		roomRed.total = tonumber(AppConst.getPlayerPrefs("redTotal"))
		if tonumber(AppConst.getPlayerPrefs("redTotal")) == 8 then
			CreateRoomPanel.redTog8Inning:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.redTog8InningTxt1, "<color=#48BDFF>8局</color>")

			CreateRoomPanel.redTog16Inning:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.redTog16InningTxt1, "<color=#5D6D6D>16局</color>")
		else
			CreateRoomPanel.redTog8Inning:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.redTog8InningTxt1, "<color=#5D6D6D>8局</color>")

			CreateRoomPanel.redTog16Inning:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.redTog16InningTxt1, "<color=#48BDFF>16局</color>")
		end
	end

	if AppConst.getPlayerPrefs("redPay") == "" then
		CreateRoomPanel.redTogAA:GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.redTogAATxt1, "<color=#48BDFF>AA</color>")
		if AppConst.getPlayerPrefs("redTotal") == "" then
			self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x1]</color>")
		else
			if tonumber(AppConst.getPlayerPrefs("redTotal")) == 8 then
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			else
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			end
		end
		CreateRoomPanel.redTogBoss:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.redTogBossTxt1, "<color=#5D6D6D>老板</color>")
		CreateRoomPanel.redImgBoss:SetActive(false)
	else
		roomRed.modeType = tonumber(AppConst.getPlayerPrefs("redPay"))
		if tonumber(AppConst.getPlayerPrefs("redPay")) == 1 then
			CreateRoomPanel.redTogAA:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.redTogAATxt1, "<color=#48BDFF>AA</color>")
			if AppConst.getPlayerPrefs("redTotal") == "" then
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			else
				if tonumber(AppConst.getPlayerPrefs("redTotal")) == 8 then
					self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x1]</color>")
				else
					self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x2]</color>")
				end
			end
			CreateRoomPanel.redTogBoss:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.redTogBossTxt1, "<color=#5D6D6D>老板</color>")
			CreateRoomPanel.redImgBoss:SetActive(false)
		else
			CreateRoomPanel.redTogAA:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.redTogAATxt1, "<color=#5D6D6D>AA</color>")
			CreateRoomPanel.redImgAA:SetActive(false)

			CreateRoomPanel.redTogBoss:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.redTogBossTxt1, "<color=#48BDFF>老板</color>")
			if AppConst.getPlayerPrefs("redTotal") == "" then
				if AppConst.getPlayerPrefs("isPlayNum") == "" then
					self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
				else
					if tonumber(AppConst.getPlayerPrefs("isPlayNum")) == 3 then
						self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x3]</color>")
					else
						self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
					end
				end
			else
				if tonumber(AppConst.getPlayerPrefs("redTotal")) == 8 then
					if AppConst.getPlayerPrefs("redisPlayNum") == "" then
						self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
					else
						if tonumber(AppConst.getPlayerPrefs("redisPlayNum")) == 3 then
							self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x3]</color>")
						else
							self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
						end
					end
				else
					if AppConst.getPlayerPrefs("redisPlayNum") == "" then
						self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x8]</color>")
					else
						if tonumber(AppConst.getPlayerPrefs("redisPlayNum")) == 3 then
							self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x6]</color>")
						else
							self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x8]</color>")
						end
					end
				end
			end

		end
	end

	CreateRoomPanel.redTogDianpao:GetComponent('Toggle').isOn = false
	self:SetText(CreateRoomPanel.redTogDianpaoTxt, "<color=#5D6D6D>点炮胡</color>")

	CreateRoomPanel.redTogZimo:GetComponent('Toggle').isOn = true
	self:SetText(CreateRoomPanel.redTogZimoTxt, "<color=#48BDFF>自摸胡</color>")

	CreateRoomPanel.redTogBihu:GetComponent('Toggle').isOn = false
	self:SetText(CreateRoomPanel.redTogBihuTxt, "<color=#5D6D6D>点炮必胡</color>")


	CreateRoomPanel.redTogFeng:GetComponent('Toggle').isOn = true
	self:SetText(CreateRoomPanel.redTogFengTxt, "<color=#48BDFF>不要风牌</color>")


	CreateRoomPanel.redTogHong:GetComponent('Toggle').isOn = false
	self:SetText(CreateRoomPanel.redTogHongTxt, "<color=#5D6D6D>红中赖子</color>")


	CreateRoomPanel.redTogXiayu0:GetComponent('Toggle').isOn = true
	self:SetText(CreateRoomPanel.redTogXiayu0Txt, "不下鱼")
	CreateRoomPanel.redTogXiayuNum:GetComponent('Toggle').isOn = false
	self:SetText(CreateRoomPanel.redTogXiayuNumTxt, "<color=#5D6D6D>0鱼</color>")

	CreateRoomPanel.btnDown:SetActive(false)
	CreateRoomPanel.btnUp:SetActive(false)

	if AppConst.getPlayerPrefs("redisPlayNum") == "" then
		CreateRoomPanel.redTogNum4:GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.redTogNum4Txt, "<color=#48BDFF>4人局</color>")

		CreateRoomPanel.redTogNum3:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.redTogNum3Txt, "<color=#5D6D6D>3人局</color>")
	else
		roomRed.isPlayNum = tonumber(AppConst.getPlayerPrefs("redisPlayNum"))
		if roomRed.isPlayNum == 4 then
			CreateRoomPanel.redTogNum4:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.redTogNum4Txt, "<color=#48BDFF>4人局</color>")

			CreateRoomPanel.redTogNum3:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.redTogNum3Txt, "<color=#5D6D6D>3人局</color>")
		else
			CreateRoomPanel.redTogNum4:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.redTogNum4Txt, "<color=#5D6D6D>4人局</color>")

			CreateRoomPanel.redTogNum3:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.redTogNum3Txt, "<color=#48BDFF>3人局</color>")
		end
	end


	if AppConst.getPlayerPrefs("redisRobot") == "" then
		CreateRoomPanel.redTogRobot:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.redTogRobotTxt, "<color=#5D6D6D>人机模式</color>")
	else
		if tonumber(AppConst.getPlayerPrefs("redisRobot")) == 2 then
			CreateRoomPanel.redTogRobot:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.redTogRobotTxt, "<color=#5D6D6D>人机模式</color>")
		else
			CreateRoomPanel.redTogRobot:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.redTogRobotTxt, "<color=#48BDFF>人机模式</color>")
		end
	end
end

-- 创建房间
function CreateRedDragonRoomCtrl.OnRedCreateBtnClick(go)
	print("===================>>>>>>>>>>>>创建房间------")
	CreateRedDragonRoomCtrl:Close()
	CreateRoomCtrl.PlayEffectMusic()
	global.systemVo.TalkSource:Stop()
	global.roomRedDragonVo = roomRed

	if CreateRoomPanel.redTog8Inning:GetComponent('Toggle').isOn == true then
    	    roomRed.total = 8 
    else
    		roomRed.total = 16
    end

    if CreateRoomPanel.redTogAA:GetComponent('Toggle').isOn == true then 
    	  roomRed.modeType = 1
    else
    	  roomRed.modeType = 2
    end
    
    if CreateRoomPanel.redTogNum3:GetComponent('Toggle').isOn == true then
    	roomRed.isPlayNum = 3
    else
    	roomRed.isPlayNum = 4
    end


	local createRedRoom = CreateHongRoom_pb.CreateHongRoomReq()
	createRedRoom.jushu = roomRed.total
	-- 开房局数
	createRedRoom.zimohu = roomRed.isSelf
	-- 是否自能自摸胡
	createRedRoom.feng = roomRed.isFeng
	-- 是否不要风牌 1=是  2=否
	createRedRoom.hongzhong = roomRed.isRed
	-- 是否要红中赖子  1=是 2=否
	createRedRoom.bihu = roomRed.isBihu
	-- 是否点必胡  1=是 2=否
	createRedRoom.yu = tonumber(roomRed.isFishNum)
	-- 下的鱼数
	createRedRoom.roleNum = roomRed.isPlayNum
	-- 几人局
	createRedRoom.robot = roomRed.isRobot
	-- 是否机器人局
	createRedRoom.modeType = roomRed.modeType
	-- 是否AA 1=是 2=否




	AppConst.setPlayerPrefs("redTotal", tostring(roomRed.total))
	AppConst.setPlayerPrefs("redisSelf", tostring(roomRed.isSelf))
	AppConst.setPlayerPrefs("redisBihu", tostring(roomRed.isBihu))
	AppConst.setPlayerPrefs("redisFeng", tostring(roomRed.isFeng))
	AppConst.setPlayerPrefs("redisRed", tostring(roomRed.isRed))
	AppConst.setPlayerPrefs("redisFishNum", tostring(roomRed.isFishNum))
	AppConst.setPlayerPrefs("redisPlayNum", tostring(roomRed.isPlayNum))
	AppConst.setPlayerPrefs("redisRobot", tostring(roomRed.isRobot))
	AppConst.setPlayerPrefs("redPay", tostring(roomRed.modeType))

	AppConst.setPlayerPrefs("createGameType", 7)
	BlockLayerCtrl:UsualOpen("BlockLayer")
	local msg = createRedRoom:SerializeToString()
	Game.SendProtocal(Protocal.CreateRedDragonRoom, msg)

	if roomRed.modeType == 1 then
		text5 = 'AA模式'
	else
		text5 = '老板模式'
	end

	text4 = '不下鱼'

	text3 = '自摸胡'

	if createRedRoom.isBihu == 1 then
		text3 = "点炮必胡"
	end

	text2 = "无风牌"

	text1 = '红中麻将'

	global.roomRedDragonVo.playMethod = text1 .. "  " .. text2 .. "  " .. text3 .. "  " .. text4 .. "  " .. text5
	-- global.roomRedDragonVo.playMethod = text1.."  "..text2.."  "..text3.."\n".."\t\t      "..text4.."  "..text5
	-- global.roomRedDragonVo.playMethod = text1.."  "..text2.."  "..text3.."\n"..text4.."     "..text5.." 带跟庄".."\n".."漏胡        荒庄加倍"
end

-- 退出
function CreateRedDragonRoomCtrl.OnQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = CreateRedDragonRoomCtrl
	self:Close()
end

-- 收到创建房间回调
function CreateRedDragonRoomCtrl.OnCreateHongRoomRes(buffer)
	local self = CreateRedDragonRoomCtrl
	local data = buffer:ReadBuffer()
	local msg = CreateHongRoom_pb.CreateHongRoomRes()
	msg:ParseFromString(data)

	print('CreateRedDragonRoomCtrl.CreateHongRoomRes====', msg.roomNum)

	-- 房卡模式
	if msg.moneyType == RoomMode.roomCardMode then
		global.roomRedDragonVo.id = msg.roomNum
		global.roomRedDragonVo.isFangzhu = 1
	else
		local roomRedDrago = roomRedDragonVo:New()
		roomRedDrago.id = msg.roomNum
		-- 新添加
		roomRedDrago.baseNum = msg.baseNum
		roomRedDrago.qualified = msg.qualified
		roomRedDrago.moneyType = msg.moneyType
		roomRedDrago.mcreenings = msg.mcreenings
		print('CreateRedDragonRoomCtrl.OnCreateRoomRes222222', msg.baseNum, msg.qualified)

		roomRedDrago.isFangzhu = 1
		global.roomRedDragonVo = roomRedDrago
	end

	-- 创建房间的人。加入到数据缓存中
	local joinRoomUserVo = JoinRoomUserVo:New()
	local userVo = global.userVo
	joinRoomUserVo.index = 1
	joinRoomUserVo.roleId = userVo.roleId
	joinRoomUserVo.name = userVo.name
	joinRoomUserVo.ip = userVo.roleIp
	joinRoomUserVo.headImg = userVo.headImg
	joinRoomUserVo.diamond = userVo.diamond
	joinRoomUserVo.gender = userVo.gender
	-- 新添加
	joinRoomUserVo.goldcoin = userVo.goldcoin
	-- 金币数量
	joinRoomUserVo.wing = userVo.wing
	-- 元宝数量

	global.joinRoomUserVos[1] = joinRoomUserVo
	self:Close()
	MainSenceCtrl:Close()
	Room.gameType = RoomType.RedDragon
	Game.LoadScene("mahjong")
	CreateRoomCtrl.PlayEffectMusic()
end

-- 选择8人局
function CreateRedDragonRoomCtrl.OnredTog8InningClick(go, bool)
	print("===================>>>>>>>>>>>>红中麻将选8局------")
	local self = CreateRedDragonRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomRed.total = 8
		self:SetText(CreateRoomPanel.redTog8InningTxt1, "<color=#48BDFF>8局</color>")
		if roomRed.modeType == 1 then
			if roomRed.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			else
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			end

		else
			if roomRed.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x3]</color>")
			else
				self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
			end
		end
	else
		self:SetText(CreateRoomPanel.redTog8InningTxt1, "<color=#5D6D6D>8局</color>")
	end
end

-- 选择16人局
function CreateRedDragonRoomCtrl.OnredTog16InningClick(go, bool)
	print("===================>>>>>>>>>>>>红中麻将选16局------")
	local self = CreateRedDragonRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomRed.total = 16
		self:SetText(CreateRoomPanel.redTog16InningTxt1, "<color=#48BDFF>16局</color>")
		if roomRed.modeType == 1 then
			if roomRed.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			else
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			end

		else
			if roomRed.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x6]</color>")
			else
				self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x8]</color>")
			end

		end
	else
		self:SetText(CreateRoomPanel.redTog16InningTxt1, "<color=#5D6D6D>16局</color>")
	end
end

-- 选择AA模式
function CreateRedDragonRoomCtrl.OnredTogAAClick(go, bool)
	print("===================>>>>>>>>>>>>红中麻将AA模式------")
	local self = CreateRedDragonRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomRed.modeType = 1
		CreateRoomPanel.redImgAA:SetActive(true)
		self:SetText(CreateRoomPanel.redTogAATxt1, "<color=#48BDFF>AA</color>")
		if roomRed.total == 8 then
			if roomRed.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			else
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			end

		elseif roomRed.total == 16 then
			if roomRed.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			else
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			end

		end
	else
		CreateRoomPanel.redImgAA:SetActive(false)
		self:SetText(CreateRoomPanel.redTogAATxt1, "<color=#5D6D6D>AA</color>")
	end
end

-- 选择老板模式
function CreateRedDragonRoomCtrl.OnredTogBossClick(go, bool)
	print("===================>>>>>>>>>>>>红中麻将老板模式------")
	local self = CreateRedDragonRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomRed.modeType = 2
		CreateRoomPanel.redImgBoss:SetActive(true)
		self:SetText(CreateRoomPanel.redTogBossTxt1, "<color=#48BDFF>老板</color>")
		if roomRed.total == 8 then
			if roomRed.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x3]</color>")
			else
				self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
			end

		elseif roomRed.total == 16 then
			if roomRed.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x6]</color>")
			else
				self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x8]</color>")
			end

		end
	else
		CreateRoomPanel.redImgBoss:SetActive(false)
		self:SetText(CreateRoomPanel.redTogBossTxt1, "<color=#5D6D6D>老板</color>")
	end
end

-- 选择3人
function CreateRedDragonRoomCtrl.OnredTogNum3Click(go, bool)
	print("===================>>>>>>>>>>>>红中麻将3人------")
	local self = CreateRedDragonRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomRed.isPlayNum = 3
		self:SetText(CreateRoomPanel.redTogNum3Txt, "<color=#48BDFF>3人局</color>")
		if roomRed.modeType == 1 then
			if roomRed.total == 8 then
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			else
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			end
		else
			if roomRed.total == 8 then
				self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x3]</color>")
			else
				self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x6]</color>")
			end
		end
	else
		self:SetText(CreateRoomPanel.redTogNum3Txt, "<color=#5D6D6D>3人局</color>")
	end
end

-- 选择4人
function CreateRedDragonRoomCtrl.OnredTogNum4Click(go, bool)
	print("===================>>>>>>>>>>>>红中麻将4人------")
	local self = CreateRedDragonRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomRed.isPlayNum = 4
		if roomRed.modeType == 1 then
			if roomRed.total == 8 then
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			else
				self:SetText(CreateRoomPanel.redTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			end

		else
			if roomRed.total == 8 then
				self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
			else
				self:SetText(CreateRoomPanel.redTogBossTxt2, "<color=#48BDFF>[			x8]</color>")
			end
		end
		self:SetText(CreateRoomPanel.redTogNum4Txt, "<color=#48BDFF>4人局</color>")
	else
		self:SetText(CreateRoomPanel.redTogNum4Txt, "<color=#5D6D6D>4人局</color>")
	end
end

-- 选择机器人
function CreateRedDragonRoomCtrl.OnredTogRobotClick(go, bool)
	print("===================>>>>>>>>>>>>红中麻将机器人------")
	local self = CreateRedDragonRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomRed.isRobot = 1
		self:SetText(CreateRoomPanel.redTogRobotTxt, "<color=#48BDFF>人机模式</color>")
	else
		CreateRoomCtrl.PlayEffectMusic()
		roomRed.isRobot = 2
		self:SetText(CreateRoomPanel.redTogRobotTxt, "<color=#5D6D6D>人机模式</color>")
	end
end
