require "Controller/CreateShiDianRoomCtrl"
require "Controller/CreateJinHuaRoomCtrl"
require "Controller/CreateNiuRoomCtrl"
require "Controller/CreateCatchRoomCtrl"
require "Controller/CreateRedDragonRoomCtrl"
require "Controller/CreateLandlordsRoomCtrl"
require "Controller/CreateBattleMahjongRoomCtrl"

CreateRoomCtrl = { }
setbaseclass(CreateRoomCtrl, { BaseCtrl })

local roomVo
local text1 = ''
local text2 = ''
local text3 = ''
local text4 = ''
local text5 = ''
local btnNum = nil

-- 启动事件--
function CreateRoomCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	obj.transform.localPosition = Vector3.New(0, 0, 0);

	CreateShiDianRoomCtrl:OnCreate(obj)
	CreateJinHuaRoomCtrl:OnCreate(obj)
	CreateCatchRoomCtrl:OnCreate(obj)
	CreateNiuRoomCtrl:OnCreate(obj)
	CreateRedDragonRoomCtrl:OnCreate(obj)
	CreateLandlordsRoomCtrl:OnCreate(obj)
	CreateBattleMahjongRoomCtrl:OnCreate(obj)

	self:AddClick(CreateRoomPanel.btnQuit, self.OnQuitBtnClick)
	--[[	self:AddOnValueChanged(CreateRoomPanel.togHuashui , self.OntogHuashuiClick)
	self:AddOnValueChanged(CreateRoomPanel.togZhuomazi , self.OntogZhuomaziClick)
	self:AddOnValueChanged(CreateRoomPanel.togShidianban , self.OntogShidianbanClick)
	self:AddOnValueChanged(CreateRoomPanel.togZhajinhua , self.OntogZhajinhuaClick)
	self:AddOnValueChanged(CreateRoomPanel.togNiuniu , self.OntogNiuniuClick)--]]

	----划水
	self:AddOnValueChanged(CreateRoomPanel.huaTog8Inning, self.OnhuaTog8InningClick)
	self:AddOnValueChanged(CreateRoomPanel.huaTog16Inning, self.OnhuaTog16InningClick)
	self:AddOnValueChanged(CreateRoomPanel.huaTogAA, self.OnhuaTogAAClick)
	self:AddOnValueChanged(CreateRoomPanel.huaTogBoss, self.OnhuaTogBossClick)

	self:AddOnValueChanged(CreateRoomPanel.huaTogXiayu0, self.OnhuaTogXiayu0Click)
	self:AddOnValueChanged(CreateRoomPanel.huaTogXiayuNum, self.OnhuaTogXiayuNumClick)

	self:AddOnValueChanged(CreateRoomPanel.huaTogDianpao, self.OnhuaTogDianpaoClick)
	self:AddOnValueChanged(CreateRoomPanel.huaTogBihu, self.OnhuaTogBihuClick)
	self:AddOnValueChanged(CreateRoomPanel.huaTogZimo, self.OnhuaTogZimoClick)
	self:AddOnValueChanged(CreateRoomPanel.huaTogFeng, self.OnhuaTogFengClick)
	self:AddOnValueChanged(CreateRoomPanel.huaTogHong, self.OnhuaTogHongClick)
	self:AddOnValueChanged(CreateRoomPanel.huaTogNum3, self.OnhuaTogNum3Click)
	self:AddOnValueChanged(CreateRoomPanel.huaTogNum4, self.OnhuaTogNum4Click)
	self:AddOnValueChanged(CreateRoomPanel.huaTogRobot, self.OnhuaTogRobotClick)

	-- 加减鱼子
	self:AddClick(CreateRoomPanel.btnDown, self.OnDownBtnClick)
	self:AddClick(CreateRoomPanel.btnUp, self.OnUpBtnClick)

	self:AddClick(CreateRoomPanel.huaBtnCreate, self.OnCreateBtnClick)
	----划水以上

	self:AddClick(CreateRoomPanel.btnBattleMahjong, 	self.OnChangeClick)
	self:AddClick(CreateRoomPanel.btnThreeTwoMahjong, 	self.OnChangeClick)
	self:AddClick(CreateRoomPanel.btnNiuNiu, 			self.OnChangeClick)

	self:InitPanel(global.userVo)
end

-- 初始化面板--
function CreateRoomCtrl:InitPanel(userInfo)
	self.roomList = {
		CreateRoomPanel.HuaShui,
		CreateRoomPanel.ShiDianBan,
		CreateRoomPanel.ZhaJinHua,
		CreateRoomPanel.ZhuoMaZi,
		CreateRoomPanel.NiuNiu,
		CreateRoomPanel.RedDragon,
		CreateRoomPanel.RedDragon,
		CreateRoomPanel.Landlords,
		CreateRoomPanel.BattleMahjong
	}
	print("---------------------->>", AppConst.getPlayerPrefs("createGameType"))
	if AppConst.getPlayerPrefs("createGameType") == "" then
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,248,0)
		CreateRoomPanel.HuaShui:SetActive(false)
		-- CreateRoomPanel.togHuashui:GetComponent('Toggle').isOn = true
		CreateRoomPanel.ShiDianBan:SetActive(false)
		-- CreateRoomPanel.togShidianban:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhaJinHua:SetActive(false)
		-- CreateRoomPanel.togZhajinhua :GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhuoMaZi:SetActive(false)
		-- CreateRoomPanel.togZhuomazi:GetComponent('Toggle').isOn = false
		CreateRoomPanel.NiuNiu:SetActive(false)
		-- CreateRoomPanel.togNiuniu:GetComponent('Toggle').isOn = false
		--CreateRoomPanel.imgMask:SetActive(false)
		CreateRoomPanel.RedDragon:SetActive(false)
		CreateRoomPanel.Landlords:SetActive(false)
		CreateRoomPanel.BattleMahjong:SetActive(true)

	elseif tonumber(AppConst.getPlayerPrefs("createGameType")) == 1 then
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,248,0)
		CreateRoomPanel.HuaShui:SetActive(true)
		-- CreateRoomPanel.togHuashui:GetComponent('Toggle').isOn = true
		CreateRoomPanel.ShiDianBan:SetActive(false)
		-- CreateRoomPanel.togShidianban:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhaJinHua:SetActive(false)
		-- CreateRoomPanel.togZhajinhua :GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhuoMaZi:SetActive(false)
		-- CreateRoomPanel.togZhuomazi:GetComponent('Toggle').isOn = false
		CreateRoomPanel.NiuNiu:SetActive(false)
		-- CreateRoomPanel.togNiuniu:GetComponent('Toggle').isOn = false
		--CreateRoomPanel.imgMask:SetActive(false)
		CreateRoomPanel.RedDragon:SetActive(false)
		CreateRoomPanel.Landlords:SetActive(false)
		CreateRoomPanel.BattleMahjong:SetActive(false)

	elseif tonumber(AppConst.getPlayerPrefs("createGameType")) == 2 then
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,150,0)
		CreateRoomPanel.HuaShui:SetActive(false)
		-- CreateRoomPanel.togHuashui:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ShiDianBan:SetActive(true)
		-- CreateRoomPanel.togShidianban:GetComponent('Toggle').isOn = true
		CreateRoomPanel.ZhaJinHua:SetActive(false)
		-- CreateRoomPanel.togZhajinhua :GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhuoMaZi:SetActive(false)
		-- CreateRoomPanel.togZhuomazi:GetComponent('Toggle').isOn = false
		CreateRoomPanel.NiuNiu:SetActive(false)
		-- CreateRoomPanel.togNiuniu:GetComponent('Toggle').isOn = false
		--CreateRoomPanel.imgMask:SetActive(false)
		CreateRoomPanel.RedDragon:SetActive(false)
		CreateRoomPanel.Landlords:SetActive(false)
		CreateRoomPanel.BattleMahjong:SetActive(false)

	elseif tonumber(AppConst.getPlayerPrefs("createGameType")) == 3 then
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,52,0)
		CreateRoomPanel.HuaShui:SetActive(false)
		-- CreateRoomPanel.togHuashui:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ShiDianBan:SetActive(false)
		-- CreateRoomPanel.togShidianban:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhaJinHua:SetActive(true)
		-- CreateRoomPanel.togZhajinhua :GetComponent('Toggle').isOn = true
		CreateRoomPanel.ZhuoMaZi:SetActive(false)
		-- CreateRoomPanel.togZhuomazi:GetComponent('Toggle').isOn = false
		CreateRoomPanel.NiuNiu:SetActive(false)
		-- CreateRoomPanel.togNiuniu:GetComponent('Toggle').isOn = false
		--CreateRoomPanel.imgMask:SetActive(false)
		CreateRoomPanel.RedDragon:SetActive(false)
		CreateRoomPanel.Landlords:SetActive(false)
		CreateRoomPanel.BattleMahjong:SetActive(false)

	elseif tonumber(AppConst.getPlayerPrefs("createGameType")) == 4 then
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,-46,0)
		CreateRoomPanel.HuaShui:SetActive(false)
		-- CreateRoomPanel.togHuashui:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ShiDianBan:SetActive(false)
		-- CreateRoomPanel.togShidianban:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhaJinHua:SetActive(false)
		-- CreateRoomPanel.togZhajinhua :GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhuoMaZi:SetActive(true)
		-- CreateRoomPanel.togZhuomazi:GetComponent('Toggle').isOn = true
		CreateRoomPanel.NiuNiu:SetActive(false)
		-- CreateRoomPanel.togNiuniu:GetComponent('Toggle').isOn = false
		--CreateRoomPanel.imgMask:SetActive(false)
		CreateRoomPanel.RedDragon:SetActive(false)
		CreateRoomPanel.Landlords:SetActive(false)
		CreateRoomPanel.BattleMahjong:SetActive(false)
	elseif tonumber(AppConst.getPlayerPrefs("createGameType")) == 5 then
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,-144,0)
		CreateRoomPanel.HuaShui:SetActive(false)
		-- CreateRoomPanel.togHuashui:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ShiDianBan:SetActive(false)
		-- CreateRoomPanel.togShidianban:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhaJinHua:SetActive(false)
		-- CreateRoomPanel.togZhajinhua :GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhuoMaZi:SetActive(false)
		-- CreateRoomPanel.togZhuomazi:GetComponent('Toggle').isOn = false
		CreateRoomPanel.NiuNiu:SetActive(true)
		-- CreateRoomPanel.togNiuniu:GetComponent('Toggle').isOn = true
		--CreateRoomPanel.imgMask:SetActive(false)
		CreateRoomPanel.RedDragon:SetActive(false)
		CreateRoomPanel.Landlords:SetActive(false)
		CreateRoomPanel.BattleMahjong:SetActive(false)
	elseif tonumber(AppConst.getPlayerPrefs("createGameType")) == 7 then
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,-144,0)
		CreateRoomPanel.HuaShui:SetActive(false)
		-- CreateRoomPanel.togHuashui:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ShiDianBan:SetActive(false)
		-- CreateRoomPanel.togShidianban:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhaJinHua:SetActive(false)
		-- CreateRoomPanel.togZhajinhua :GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhuoMaZi:SetActive(false)
		-- CreateRoomPanel.togZhuomazi:GetComponent('Toggle').isOn = false
		CreateRoomPanel.NiuNiu:SetActive(false)
		-- CreateRoomPanel.togNiuniu:GetComponent('Toggle').isOn = true
		--CreateRoomPanel.imgMask:SetActive(false)
		CreateRoomPanel.RedDragon:SetActive(true)
		CreateRoomPanel.Landlords:SetActive(false)
		CreateRoomPanel.BattleMahjong:SetActive(false)
	elseif tonumber(AppConst.getPlayerPrefs("createGameType")) == 8 then
		CreateRoomPanel.HuaShui:SetActive(false)
		-- CreateRoomPanel.togHuashui:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ShiDianBan:SetActive(false)
		-- CreateRoomPanel.togShidianban:GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhaJinHua:SetActive(false)
		-- CreateRoomPanel.togZhajinhua :GetComponent('Toggle').isOn = false
		CreateRoomPanel.ZhuoMaZi:SetActive(false)
		-- CreateRoomPanel.togZhuomazi:GetComponent('Toggle').isOn = false
		CreateRoomPanel.NiuNiu:SetActive(false)
		-- CreateRoomPanel.togNiuniu:GetComponent('Toggle').isOn = true
		--CreateRoomPanel.imgMask:SetActive(false)
		CreateRoomPanel.RedDragon:SetActive(false)
		CreateRoomPanel.Landlords:SetActive(true)
		CreateRoomPanel.BattleMahjong:SetActive(false)
	elseif tonumber(AppConst.getPlayerPrefs("createGameType")) == 9 then
		CreateRoomPanel.HuaShui:SetActive(false)
		CreateRoomPanel.ShiDianBan:SetActive(false)
		CreateRoomPanel.ZhaJinHua:SetActive(false)
		CreateRoomPanel.ZhuoMaZi:SetActive(false)
		CreateRoomPanel.NiuNiu:SetActive(false)
		--CreateRoomPanel.imgMask:SetActive(false)
		CreateRoomPanel.RedDragon:SetActive(false)
		CreateRoomPanel.Landlords:SetActive(false)
		CreateRoomPanel.BattleMahjong:SetActive(true)
	end
	-- local newIcon = CreateRoomPanel.imgNewGameTips
	-- 申请苹果审核
	if IS_APP_STORE_CHECK then
		-- CreateRoomPanel.togZhuomazi:SetActive(false)
		-- CreateRoomPanel.togShidianban:SetActive(false)
		-- CreateRoomPanel.togZhajinhua:SetActive(false)
		-- CreateRoomPanel.togNiuniu:SetActive(false)
		-- newIcon:SetActive(false)
	end
	-- 未完成功能全都不显示
	if IS_COMPLETE_FUNCTION then
		newIcon:SetActive(false)
	end

	-- newIcon.transform.localPosition = Vector3.New(-160,-380,0)
	roomVo = RoomVo:New()
	roomVo.id = 1
	roomVo.total = 8
	roomVo.modeType = 1
	roomVo.isSelf = 2
	roomVo.isFeng = 1
	roomVo.isRed = 2
	roomVo.isFishNum = 0
	roomVo.isPlayNum = 4
	roomVo.isRobot = 2
	roomVo.isBihu = 2
	-- roomVo.gameType  = 1  --划水
	CreateRoomPanel.huaTogRobot:SetActive(false)
	-- CreateRoomPanel.huaTogRobot:SetActive(global.isDebug)
	self:SetText(CreateRoomPanel.huaTxtDiamond, "x" .. userInfo.diamond)
	--CreateRoomPanel.imgMask:SetActive(false)

	----划水
	if AppConst.getPlayerPrefs("huaTotal") == "" then
		-- 缓存上一次点的按钮的信息
		CreateRoomPanel.huaTog8Inning:GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.huaTog8InningTxt1, "<color=#48BDFF>8局</color>")
		CreateRoomPanel.huaTog16Inning:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.huaTog16InningTxt1, "<color=#5D6D6D>16局</color>")
	else
		roomVo.total = tonumber(AppConst.getPlayerPrefs("huaTotal"))
		if tonumber(AppConst.getPlayerPrefs("huaTotal")) == 8 then
			CreateRoomPanel.huaTog8Inning:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTog8InningTxt1, "<color=#48BDFF>8局</color>")

			CreateRoomPanel.huaTog16Inning:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTog16InningTxt1, "<color=#5D6D6D>16局</color>")
		else
			CreateRoomPanel.huaTog8Inning:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTog8InningTxt1, "<color=#5D6D6D>8局</color>")

			CreateRoomPanel.huaTog16Inning:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTog16InningTxt1, "<color=#48BDFF>16局</color>")
		end
	end

	if AppConst.getPlayerPrefs("huaPay") == "" then
		CreateRoomPanel.huaTogAA:GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.huaTogAATxt1, "<color=#48BDFF>AA</color>")
		if AppConst.getPlayerPrefs("huaTotal") == "" then
			self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x1]</color>")
		else
			if tonumber(AppConst.getPlayerPrefs("huaTotal")) == 8 then
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[		    x2]</color>")
			end
		end
		CreateRoomPanel.huaTogBoss:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.huaTogBossTxt1, "<color=#5D6D6D>老板</color>")
		CreateRoomPanel.huaImgBoss:SetActive(false)
	else
		roomVo.modeType = tonumber(AppConst.getPlayerPrefs("huaPay"))
		if tonumber(AppConst.getPlayerPrefs("huaPay")) == 1 then
			CreateRoomPanel.huaTogAA:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTogAATxt1, "<color=#48BDFF>AA</color>")
			if AppConst.getPlayerPrefs("huaTotal") == "" then
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			else
				if tonumber(AppConst.getPlayerPrefs("huaTotal")) == 8 then
					self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x1]</color>")
				else
					self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x2]</color>")
				end
			end
			CreateRoomPanel.huaTogBoss:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogBossTxt1, "<color=#5D6D6D>老板</color>")
			CreateRoomPanel.huaImgBoss:SetActive(false)
		else
			CreateRoomPanel.huaTogAA:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogAATxt1, "<color=#5D6D6D>AA</color>")
			CreateRoomPanel.huaImgAA:SetActive(false)

			CreateRoomPanel.huaTogBoss:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTogBossTxt1, "<color=#48BDFF>老板</color>")
			if AppConst.getPlayerPrefs("huaTotal") == "" then
				if AppConst.getPlayerPrefs("huaisPlayNum") == "" then
					self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
				else
					if tonumber(AppConst.getPlayerPrefs("huaisPlayNum")) == 3 then
						self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x3]</color>")
					else
						self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
					end
				end
			else
				if tonumber(AppConst.getPlayerPrefs("huaTotal")) == 8 then
					if AppConst.getPlayerPrefs("huaisPlayNum") == "" then
						self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
					else
						if tonumber(AppConst.getPlayerPrefs("isPlayNum")) == 3 then
							self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x3]</color>")
						else
							self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
						end
					end
				else
					if AppConst.getPlayerPrefs("huaisPlayNum") == "" then
						self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x8]</color>")
					else
						if tonumber(AppConst.getPlayerPrefs("huaisPlayNum")) == 3 then
							self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x6]</color>")
						else
							self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x8]</color>")
						end
					end
				end
			end

		end
	end

	if AppConst.getPlayerPrefs("huaisSelf") == "" then
		CreateRoomPanel.huaTogDianpao:GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.huaTogDianpaoTxt, "<color=#48BDFF>点炮胡</color>")

		CreateRoomPanel.huaTogZimo:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.huaTogZimoTxt, "<color=#5D6D6D>自摸胡</color>")
		roomVo.isBihu = 2
	else
		roomVo.isSelf = tonumber(AppConst.getPlayerPrefs("huaisSelf"))
		if tonumber(AppConst.getPlayerPrefs("huaisSelf")) == 2 then
			CreateRoomPanel.huaTogDianpao:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTogDianpaoTxt, "<color=#48BDFF>点炮胡</color>")

			CreateRoomPanel.huaTogZimo:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogZimoTxt, "<color=#5D6D6D>自摸胡</color>")

			CreateRoomPanel.huaTogBihu:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogBihuTxt, "<color=#5D6D6D>点炮必胡</color>")
		else
			CreateRoomPanel.huaTogDianpao:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogDianpaoTxt, "<color=#5D6D6D>点炮胡</color>")

			CreateRoomPanel.huaTogZimo:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTogZimoTxt, "<color=#48BDFF>自摸胡</color>")

			CreateRoomPanel.huaTogBihu:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogBihuTxt, "<color=#5D6D6D>点炮必胡</color>")
		end
		roomVo.isBihu = 2
	end

	if AppConst.getPlayerPrefs("huaisBihu") == "" then
		-- 点炮必胡
		CreateRoomPanel.huaTogBihu:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.huaTogBihuTxt, "<color=#5D6D6D>点炮必胡</color>")
	else
		roomVo.isBihu = tonumber(AppConst.getPlayerPrefs("huaisBihu"))
		if roomVo.isBihu == 1 then
			CreateRoomPanel.huaTogBihu:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTogBihuTxt, "<color=#48BDFF>点炮必胡</color>")

			CreateRoomPanel.huaTogDianpao:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogDianpaoTxt, "<color=#5D6D6D>点炮胡</color>")

			CreateRoomPanel.huaTogZimo:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogZimoTxt, "<color=#5D6D6D>自摸胡</color>")
			roomVo.isSelf = 2
		else
			CreateRoomPanel.huaTogBihu:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogBihuTxt, "<color=#5D6D6D>点炮必胡</color>")
		end
	end

	if AppConst.getPlayerPrefs("huaisFeng") == "" then
		CreateRoomPanel.huaTogFeng:GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.huaTogFengTxt, "<color=#48BDFF>不要风牌</color>")
	else
		roomVo.isFeng = tonumber(AppConst.getPlayerPrefs("huaisFeng"))
		if tonumber(AppConst.getPlayerPrefs("huaisFeng")) == 1 then
			CreateRoomPanel.huaTogFeng:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTogFengTxt, "<color=#48BDFF>不要风牌</color>")
		else
			CreateRoomPanel.huaTogFeng:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogFengTxt, "<color=#5D6D6D>不要风牌</color>")
		end
	end


	if AppConst.getPlayerPrefs("huaisRed") == "" then
		-- 红中
		CreateRoomPanel.huaTogHong:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.huaTogHongTxt, "<color=#5D6D6D>红中赖子</color>")
	else
		roomVo.isRed = tonumber(AppConst.getPlayerPrefs("huaisRed"))
		if tonumber(AppConst.getPlayerPrefs("huaisRed")) == 2 then
			CreateRoomPanel.huaTogHong:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogHongTxt, "<color=#5D6D6D>红中赖子</color>")
		else
			CreateRoomPanel.huaTogHong:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTogHongTxt, "<color=#48BDFF>红中赖子</color>")
		end
	end


	if AppConst.getPlayerPrefs("huaisFishNum") == "" then
		btnNum = AppConst.getPlayerPrefs("btnyuziNum")
		if AppConst.getPlayerPrefs("btnyuziNum") == "" then
			btnNum = 2
		elseif tonumber(AppConst.getPlayerPrefs("btnyuziNum")) > 18 then
			btnNum = 18
		end

		CreateRoomPanel.huaTogXiayu0:GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.huaTogXiayu0Txt, "不下鱼")
		CreateRoomPanel.huaTogXiayuNum:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.huaTogXiayuNumTxt, "<color=#5D6D6D>" .. btnNum .. "鱼</color>")
		CreateRoomPanel.btnDown:SetActive(false)
		CreateRoomPanel.btnUp:SetActive(false)
	else
		if tonumber(AppConst.getPlayerPrefs("huaisFishNum")) == 0 then
			btnNum = AppConst.getPlayerPrefs("huabtnyuziNum")
			if AppConst.getPlayerPrefs("huabtnyuziNum") == "" then
				btnNum = 2
			elseif tonumber(AppConst.getPlayerPrefs("huabtnyuziNum")) > 18 then
				btnNum = 18
			end

			CreateRoomPanel.huaTogXiayu0:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTogXiayu0Txt, "不下鱼")
			CreateRoomPanel.huaTogXiayuNum:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogXiayuNumTxt, "<color=#5D6D6D>" .. btnNum .. "鱼</color>")
			CreateRoomPanel.btnDown:SetActive(false)
			CreateRoomPanel.btnUp:SetActive(false)
		else
			btnNum = AppConst.getPlayerPrefs("huabtnyuziNum")
			if AppConst.getPlayerPrefs("huabtnyuziNum") == "" then
				btnNum = 2
			elseif tonumber(AppConst.getPlayerPrefs("huabtnyuziNum")) > 18 then
				btnNum = 18
			end

			CreateRoomPanel.huaTogXiayu0:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogXiayu0Txt, "<color=#5D6D6D>不下鱼</color>")
			CreateRoomPanel.huaTogXiayuNum:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTogXiayuNumTxt, "<color=#48BDFF>" .. btnNum .. "鱼</color>")
			if AppConst.getPlayerPrefs("huabtnyuziNum") == "2" then
				CreateRoomPanel.btnDown:SetActive(false)
				CreateRoomPanel.btnUp:SetActive(true)
			elseif AppConst.getPlayerPrefs("huabtnyuziNum") == "18" then
				CreateRoomPanel.btnDown:SetActive(true)
				CreateRoomPanel.btnUp:SetActive(false)
			end
		end
	end


	if AppConst.getPlayerPrefs("isPlayNum") == "" then
		CreateRoomPanel.huaTogNum4:GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.huaTogNum4Txt, "<color=#48BDFF>4人局</color>")

		CreateRoomPanel.huaTogNum3:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.huaTogNum3Txt, "<color=#5D6D6D>3人局</color>")
	else
		roomVo.isPlayNum = tonumber(AppConst.getPlayerPrefs("isPlayNum"))
		if tonumber(AppConst.getPlayerPrefs("isPlayNum")) == 4 then
			CreateRoomPanel.huaTogNum4:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTogNum4Txt, "<color=#48BDFF>4人局</color>")

			CreateRoomPanel.huaTogNum3:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogNum3Txt, "<color=#5D6D6D>3人局</color>")
		else
			CreateRoomPanel.huaTogNum4:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogNum4Txt, "<color=#5D6D6D>4人局</color>")

			CreateRoomPanel.huaTogNum3:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTogNum3Txt, "<color=#48BDFF>3人局</color>")
		end
	end


	if AppConst.getPlayerPrefs("isRobot") == "" then
		CreateRoomPanel.huaTogRobot:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.huaTogRobotTxt, "<color=#5D6D6D>人机模式</color>")
	else
		if tonumber(AppConst.getPlayerPrefs("isRobot")) == 2 then
			CreateRoomPanel.huaTogRobot:GetComponent('Toggle').isOn = false
			self:SetText(CreateRoomPanel.huaTogRobotTxt, "<color=#5D6D6D>人机模式</color>")
		else
			CreateRoomPanel.huaTogRobot:GetComponent('Toggle').isOn = true
			self:SetText(CreateRoomPanel.huaTogRobotTxt, "<color=#48BDFF>人机模式</color>")
		end
	end
	----划水以上
	-- 十点半界面初始化
	CreateShiDianRoomCtrl:InitPanel(global.userVo)
	-- 炸金花界面初始化
	CreateJinHuaRoomCtrl:InitPanel(global.userVo)
	-- 牛牛界面初始化
	CreateNiuRoomCtrl:InitPanel(global.userVo)
	-- 捉麻子
	CreateCatchRoomCtrl:InitPanel(global.userVo)
	-- 红中麻将界面初始化
	CreateRedDragonRoomCtrl:InitPanel(global.userVo)
	-- 斗地主界面初始化
	CreateLandlordsRoomCtrl:InitPanel(global.userVo)
	-- 血战麻将界面初始化
	CreateBattleMahjongRoomCtrl:InitPanel(global.userVo)
end

function CreateRoomCtrl.OnChangeClick(go)
	local self = CreateRoomCtrl
	if go.name == "btnBattleMahjong" then
		print("------------------xuezhan-----------------------")
		CreateRoomPanel.NiuNiu:SetActive(false)
		CreateRoomPanel.BattleMahjong:SetActive(true)
		CreateRoomPanel.imgBattleMahjong:SetActive(true)
		CreateRoomPanel.imgThreeTwoMahjong:SetActive(false)
		CreateRoomPanel.imgNiuNiu:SetActive(false)
		--self.roomNum = 9
	elseif go.name == "btnThreeTwoMahjong" then
		CreateRoomPanel.NiuNiu:SetActive(false)
		CreateRoomPanel.BattleMahjong:SetActive(true)
		CreateRoomPanel.imgBattleMahjong:SetActive(false)
		CreateRoomPanel.imgThreeTwoMahjong:SetActive(true)
		CreateRoomPanel.imgNiuNiu:SetActive(false)
		--self.roomNum = 9
	elseif go.name == "btnNiuNiu" then
		print("------------------牛牛-----------------------")
		CreateRoomPanel.NiuNiu:SetActive(true)
		CreateRoomPanel.BattleMahjong:SetActive(false)
		CreateRoomPanel.imgBattleMahjong:SetActive(false)
		CreateRoomPanel.imgThreeTwoMahjong:SetActive(false)
		CreateRoomPanel.imgNiuNiu:SetActive(true)
		--self.roomNum = 5
	end
end

function CreateRoomCtrl.OnDownBtnClick(go)
	if btnNum == 2 then
		CreateRoomPanel.btnDown:SetActive(false)
		return
	end
	btnNum = btnNum - 1
	CreateRoomPanel.btnUp:SetActive(true)
	roomVo.isFishNum = btnNum
	self:SetText(CreateRoomPanel.huaTogXiayuNumTxt, "<color=#48BDFF>" .. btnNum .. "鱼</color>")
	AppConst.setPlayerPrefs("huabtnyuziNum", tostring(btnNum));
	if btnNum == 2 then
		CreateRoomPanel.btnDown:SetActive(false)
	end
end

function CreateRoomCtrl.OnUpBtnClick(go)
	if btnNum == 18 then
		CreateRoomPanel.btnUp:SetActive(false)
		return
	end
	btnNum = btnNum + 1
	CreateRoomPanel.btnDown:SetActive(true)
	roomVo.isFishNum = btnNum
	self:SetText(CreateRoomPanel.huaTogXiayuNumTxt, "<color=#48BDFF>" .. btnNum .. "鱼</color>")
	AppConst.setPlayerPrefs("huabtnyuziNum", tostring(btnNum));
	if btnNum == 18 then
		CreateRoomPanel.btnUp:SetActive(false)
	end
end


function CreateRoomCtrl.OnCreateBtnClick(go)
	CreateRoomCtrl:Close()
	CreateRoomCtrl.PlayEffectMusic()
	global.systemVo.TalkSource:Stop()
	global.roomVo = roomVo

	local createRoom = CreateRoom_pb.CreateRoomReq()
	createRoom.jushu = roomVo.total
	-- 开房局数
	createRoom.zimohu = roomVo.isSelf
	-- 是否自能自摸胡
	createRoom.feng = roomVo.isFeng
	-- 是否不要风牌 1=是  2=否
	createRoom.hongzhong = roomVo.isRed
	-- 是否要红中赖子  1=是 2=否
	createRoom.bihu = roomVo.isBihu
	-- 是否点必胡  1=是 2=否
	createRoom.yu = tonumber(roomVo.isFishNum)
	-- 下的鱼数
	createRoom.roleNum = roomVo.isPlayNum
	-- 几人局
	createRoom.robot = roomVo.isRobot
	-- 是否机器人局
	createRoom.modeType = roomVo.modeType
	-- 是否AA 1=是 2=否
	print("--是否自能自摸胡  推倒胡")
	AppConst.setPlayerPrefs("huaTotal", tostring(roomVo.total))
	AppConst.setPlayerPrefs("huaisSelf", tostring(roomVo.isSelf))
	AppConst.setPlayerPrefs("huaisBihu", tostring(roomVo.isBihu))
	AppConst.setPlayerPrefs("huaisFeng", tostring(roomVo.isFeng))
	AppConst.setPlayerPrefs("huaisRed", tostring(roomVo.isRed))
	AppConst.setPlayerPrefs("huaisFishNum", tostring(roomVo.isFishNum))
	AppConst.setPlayerPrefs("huaisPlayNum", tostring(roomVo.isPlayNum))
	AppConst.setPlayerPrefs("huaisRobot", tostring(roomVo.isRobot))
	AppConst.setPlayerPrefs("huaPay", tostring(roomVo.modeType))

	AppConst.setPlayerPrefs("createGameType", 1)
	BlockLayerCtrl:UsualOpen("BlockLayer")
	local msg = createRoom:SerializeToString()
	Game.SendProtocal(Protocal.CreateRoom, msg)

	if roomVo.modeType == 1 then
		text5 = 'AA模式'
	else
		text5 = '老板模式'
	end

	if roomVo.isFishNum == 0 then
		text4 = '不下鱼'
	elseif roomVo.isFishNum == btnNum then
		text4 = btnNum .. '条鱼'
	end
	if roomVo.isSelf == 1 then
		text3 = '自摸胡'
	else
		text3 = "点炮胡"
	end

	if roomVo.isBihu == 1 then
		text3 = "点炮必胡"
	end

	if roomVo.isFeng == 1 then
		text2 = "无风牌"
	else
		text2 = '有风牌'
	end

	if roomVo.isRed == 1 then
		text1 = '红中麻将'
	else
		text1 = "推倒胡"
	end
	global.roomVo.playMethod = text1 .. "  " .. text2 .. "  " .. text3 .. "  " .. text4 .. "  " .. text5
	-- global.roomVo.playMethod = text1.."  "..text2.."  "..text3.."\n".."\t\t      "..text4.."  "..text5
	-- global.roomVo.playMethod = text1.."  "..text2.."  "..text3.."\n"..text4.."     "..text5.." 带跟庄".."\n".."漏胡        荒庄加倍"
end

function CreateRoomCtrl.OnQuitBtnClick(go)
	--Game.MusicEffect(Game.Effect.buttonBack)
	local self = CreateRoomCtrl
	self:Close()
end

function CreateRoomCtrl.OnCreateRoomRes(buffer)
	local self = CreateRoomCtrl
	local data = buffer:ReadBuffer()
	local msg = CreateRoom_pb.CreateRoomRes()
	msg:ParseFromString(data)

	print('CreateRoomCtrl.OnCreateRoomRes====', msg.roomNum)
	print('CreateRoomCtrl.OnCreateRoomRes333333', msg.moneyType)

	-- 房卡模式
	if msg.moneyType == RoomMode.roomCardMode then
		global.roomVo = RoomVo:New()
		global.roomVo.id = msg.roomNum
		global.roomVo.isFangzhu = 1
	else
		local roomVo = RoomVo:New()
		roomVo.id = msg.roomNum
		-- 新添加
		roomVo.baseNum = msg.basenum
		roomVo.qualified = msg.qualified
		roomVo.moneyType = msg.moneyType
		roomVo.mcreenings = msg.mcreenings
		roomVo.zimohu = msg.zimohu
		roomVo.feng = msg.feng
		roomVo.hongzhong = msg.hongzhong
		roomVo.yu = msg.yu
		roomVo.isFishNum = msg.jushu
		print('CreateRoomCtrl.OnCreateRoomRes222222', msg.baseNum, msg.qualified, msg.moneyType)

		roomVo.isFangzhu = 1
		global.roomVo = roomVo
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
	Room.gameType = RoomType.Mahjong
	Game.LoadScene("mahjong")
	--CreateRoomCtrl.PlayEffectMusic()
end


function CreateRoomCtrl.OntogHuashuiClick(go, bool)
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,248,0)
		CreateRoomPanel.HuaShui:SetActive(true)
		--CreateRoomPanel.imgMask:SetActive(false)
	else
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,248,0)
		CreateRoomPanel.HuaShui:SetActive(false)
	end
end

function CreateRoomCtrl.OntogShidianbanClick(go, bool)
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,150,0)
		CreateRoomPanel.ShiDianBan:SetActive(true)
		--CreateRoomPanel.imgMask:SetActive(false)
	else
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,150,0)
		CreateRoomPanel.ShiDianBan:SetActive(false)
	end
end

function CreateRoomCtrl.OntogZhajinhuaClick(go, bool)
	-- 未完成功能全都不显示
	if IS_COMPLETE_FUNCTION then
		CreateRoomCtrl.PlayEffectMusic()
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,52,0)
		--CreateRoomPanel.imgMask:SetActive(true)
		return
	end
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,52,0)
		CreateRoomPanel.ZhaJinHua:SetActive(true)
		--CreateRoomPanel.imgMask:SetActive(false)
	else
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,52,0)
		CreateRoomPanel.ZhaJinHua:SetActive(false)
	end
end

function CreateRoomCtrl.OntogZhuomaziClick(go, bool)
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,-46,0)
		CreateRoomPanel.ZhuoMaZi:SetActive(true)
		--CreateRoomPanel.imgMask:SetActive(false)
	else
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,-46,0)
		CreateRoomPanel.ZhuoMaZi:SetActive(false)
	end
end

function CreateRoomCtrl.OntogNiuniuClick(go, bool)
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,-144,0)
		CreateRoomPanel.NiuNiu:SetActive(true)
		--CreateRoomPanel.imgMask:SetActive(false)
	else
		-- CreateRoomPanel.imgArrow.transform.localPosition = Vector3.New(-20,-144,0)
		CreateRoomPanel.NiuNiu:SetActive(false)
	end
	-- 未完成功能暂时遮挡
	-- --CreateRoomPanel.imgMask:SetActive(true)
end

----------------------划水
function CreateRoomCtrl.OnhuaTog8InningClick(go, bool)
	print("======================......推倒胡8人局..........")
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.total = 8
		self:SetText(CreateRoomPanel.huaTog8InningTxt1, "<color=#48BDFF>8局</color>")
		if roomVo.modeType == 1 then
			if roomVo.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			end

		else
			if roomVo.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x3]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
			end
		end
	else
		self:SetText(CreateRoomPanel.huaTog8InningTxt1, "<color=#5D6D6D>8局</color>")
	end
end

function CreateRoomCtrl.OnhuaTog16InningClick(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.total = 16
		self:SetText(CreateRoomPanel.huaTog16InningTxt1, "<color=#48BDFF>16局</color>")
		if roomVo.modeType == 1 then
			if roomVo.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			end

		else
			if roomVo.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x6]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x8]</color>")
			end

		end
	else
		self:SetText(CreateRoomPanel.huaTog16InningTxt1, "<color=#5D6D6D>16局</color>")
	end
end

function CreateRoomCtrl.OnhuaTogAAClick(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.modeType = 1
		CreateRoomPanel.huaImgAA:SetActive(true)
		self:SetText(CreateRoomPanel.huaTogAATxt1, "<color=#48BDFF>AA</color>")
		if roomVo.total == 8 then
			if roomVo.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			end

		elseif roomVo.total == 16 then
			if roomVo.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			end

		end
	else
		CreateRoomPanel.huaImgAA:SetActive(false)
		self:SetText(CreateRoomPanel.huaTogAATxt1, "<color=#5D6D6D>AA</color>")
	end
end

function CreateRoomCtrl.OnhuaTogBossClick(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.modeType = 2
		CreateRoomPanel.huaImgBoss:SetActive(true)
		self:SetText(CreateRoomPanel.huaTogBossTxt1, "<color=#48BDFF>老板</color>")
		if roomVo.total == 8 then
			if roomVo.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x3]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
			end

		elseif roomVo.total == 16 then
			if roomVo.isPlayNum == 3 then
				self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x6]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x8]</color>")
			end

		end
	else
		CreateRoomPanel.huaImgBoss:SetActive(false)
		self:SetText(CreateRoomPanel.huaTogBossTxt1, "<color=#5D6D6D>老板</color>")
	end
end

function CreateRoomCtrl.OnhuaTogXiayu0Click(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isFishNum = 0

		self:SetText(CreateRoomPanel.huaTogXiayu0Txt, "<color=#48BDFF>不下鱼</color>")
		AppConst.setPlayerPrefs("btnyuziNum", tostring(btnNum));
	else
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isFishNum = btnNum
		self:SetText(CreateRoomPanel.huaTogXiayu0Txt, "<color=#5D6D6D>不下鱼</color>")
	end
end

function CreateRoomCtrl.OnhuaTogXiayuNumClick(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isFishNum = btnNum
		self:SetText(CreateRoomPanel.huaTogXiayuNumTxt, "<color=#48BDFF>" .. btnNum .. "鱼</color>")
		CreateRoomPanel.btnDown:SetActive(true)
		CreateRoomPanel.btnUp:SetActive(true)
		if AppConst.getPlayerPrefs("btnyuziNum") == "2" then
			CreateRoomPanel.btnDown:SetActive(false)
			CreateRoomPanel.btnUp:SetActive(true)
		elseif AppConst.getPlayerPrefs("btnyuziNum") == "18" then
			CreateRoomPanel.btnDown:SetActive(true)
			CreateRoomPanel.btnUp:SetActive(false)
		end
	else
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isFishNum = 0
		self:SetText(CreateRoomPanel.huaTogXiayuNumTxt, "<color=#5D6D6D>" .. btnNum .. "鱼</color>")
		CreateRoomPanel.btnDown:SetActive(false)
		CreateRoomPanel.btnUp:SetActive(false)
	end
end

function CreateRoomCtrl.ChangeBtnNum(num)
	if num ~= nil then
		btnNum = num
		roomVo.isFishNum = btnNum
	else
		if btnNum == nil then
			btnNum = 2
			return btnNum
		end
	end
end

function CreateRoomCtrl.OnhuaTogDianpaoClick(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isSelf = 2
		self:SetText(CreateRoomPanel.huaTogDianpaoTxt, "<color=#48BDFF>点炮胡</color>")
		roomVo.isRed = 2
		roomVo.isBihu = 2
		CreateRoomPanel.huaTogHong:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.huaTogHongTxt, "<color=#5D6D6D>红中赖子</color>")
	else
		self:SetText(CreateRoomPanel.huaTogDianpaoTxt, "<color=#5D6D6D>点炮胡</color>")
	end
end

function CreateRoomCtrl.OnhuaTogBihuClick(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isBihu = 1
		roomVo.isSelf = 2
		self:SetText(CreateRoomPanel.huaTogBihuTxt, "<color=#48BDFF>点炮必胡</color>")
		roomVo.isRed = 2
		CreateRoomPanel.huaTogHong:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.huaTogHongTxt, "<color=#5D6D6D>红中赖子</color>")
	else
		roomVo.isBihu = 2
		self:SetText(CreateRoomPanel.huaTogBihuTxt, "<color=#5D6D6D>点炮必胡</color>")
	end
end

function CreateRoomCtrl.OnhuaTogZimoClick(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isSelf = 1
		roomVo.isBihu = 2
		self:SetText(CreateRoomPanel.huaTogZimoTxt, "<color=#48BDFF>自摸胡</color>")
	else
		self:SetText(CreateRoomPanel.huaTogZimoTxt, "<color=#5D6D6D>自摸胡</color>")
	end
end

function CreateRoomCtrl.OnhuaTogFengClick(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isFeng = 1
		self:SetText(CreateRoomPanel.huaTogFengTxt, "<color=#48BDFF>不要风牌</color>")
	else
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isFeng = 2
		self:SetText(CreateRoomPanel.huaTogFengTxt, "<color=#5D6D6D>不要风牌</color>")
	end
end

function CreateRoomCtrl.OnhuaTogHongClick(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isRed = 1
		self:SetText(CreateRoomPanel.huaTogHongTxt, "<color=#48BDFF>红中赖子</color>")
		roomVo.isSelf = 1
		CreateRoomPanel.huaTogZimo:GetComponent('Toggle').isOn = true
		self:SetText(CreateRoomPanel.huaTogZimoTxt, "<color=#48BDFF>自摸胡</color>")
		CreateRoomPanel.huaTogDianpao:GetComponent('Toggle').isOn = false
		self:SetText(CreateRoomPanel.huaTogDianpaoTxt, "<color=#5D6D6D>点炮胡</color>")
	else
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isRed = 2
		self:SetText(CreateRoomPanel.huaTogHongTxt, "<color=#5D6D6D>红中赖子</color>")
	end
end

function CreateRoomCtrl.OnhuaTogNum3Click(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isPlayNum = 3
		self:SetText(CreateRoomPanel.huaTogNum3Txt, "<color=#48BDFF>3人局</color>")
		if roomVo.modeType == 1 then
			if roomVo.total == 8 then
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			end

		else
			if roomVo.total == 8 then
				self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x3]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x6]</color>")
			end
		end
	else
		self:SetText(CreateRoomPanel.huaTogNum3Txt, "<color=#5D6D6D>3人局</color>")
	end
end

function CreateRoomCtrl.OnhuaTogNum4Click(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isPlayNum = 4
		if roomVo.modeType == 1 then
			if roomVo.total == 8 then
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x1]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogAATxt2, "<color=#48BDFF>[			x2]</color>")
			end
		else
			if roomVo.total == 8 then
				self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x4]</color>")
			else
				self:SetText(CreateRoomPanel.huaTogBossTxt2, "<color=#48BDFF>[			x8]</color>")
			end
		end
		self:SetText(CreateRoomPanel.huaTogNum4Txt, "<color=#48BDFF>4人局</color>")
	else
		self:SetText(CreateRoomPanel.huaTogNum4Txt, "<color=#5D6D6D>4人局</color>")
	end
end

function CreateRoomCtrl.OnhuaTogRobotClick(go, bool)
	local self = CreateRoomCtrl
	if bool then
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isRobot = 1
		self:SetText(CreateRoomPanel.huaTogRobotTxt, "<color=#48BDFF>人机模式</color>")
	else
		CreateRoomCtrl.PlayEffectMusic()
		roomVo.isRobot = 2
		self:SetText(CreateRoomPanel.huaTogRobotTxt, "<color=#5D6D6D>人机模式</color>")
	end
end
----------------------划水以上

function CreateRoomCtrl.PlayEffectMusic()
	if CreateRoomCtrl.isCreate then
		--Game.MusicEffect(Game.Effect.joinRoom)
	end
end

function CreateRoomCtrl.ShowMathond(obj)
	if obj.name == "btnColor" then
		CreateRoomPanel.huaImgBihu:SetActive(true)
	end
end

function CreateRoomCtrl.HideMathond(obj)
	if obj.name == "btnColor" then
		CreateRoomPanel.huaImgBihu:SetActive(false)
	end
end

function CreateRoomCtrl:RoomInfoShow(num)
	for i, v in ipairs(self.roomList) do
		if num == i then
			v:SetActive(true)
		else
			v:SetActive(false)
		end
	end
end