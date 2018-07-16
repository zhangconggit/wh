OB_GameMainCtrl = { }
setbaseclass(OB_GameMainCtrl, { BaseCtrl })

local currentEffect

local currentTime
local dateTime = 0
local netTime = 5
local eulerR = nil
local eulerL = nil
local eulerD = nil
local timeCountDown = nil
local roleInfoTable = { }
local this = OB_GameMainCtrl

-- 特效列表--
local EffectList = {
	{ effect_pengyan = nil, effect_duoxiang = nil },
	{ effect_TouxiangL = nil, effect_TouxiangD = nil, effect_TouxiangR = nil, effect_TouxiangU = nil }
}

local HeadEffect = {
	D =
	{
		effect_peng = "nil",
		effect_gang = "nil",
		effect_hu = "nil",
		effect_zimo = "nil",
		effect_ganghu = "nil",
		effect_guafeng = "nil",
		effect_xiayu = "nil",
		effect_huguang = "nil"
	},
	L =
	{
		effect_peng = "nil",
		effect_gang = "nil",
		effect_hu = "nil",
		effect_zimo = "nil",
		effect_ganghu = "nil",
		effect_guafeng = "nil",
		effect_xiayu = "nil",
		effect_huguang = "nil"
	},
	R =
	{
		effect_peng = "nil",
		effect_gang = "nil",
		effect_hu = "nil",
		effect_zimo = "nil",
		effect_ganghu = "nil",
		effect_guafeng = "nil",
		effect_xiayu = "nil",
		effect_huguang = "nil"
	},
	U =
	{
		effect_peng = "nil",
		effect_gang = "nil",
		effect_hu = "nil",
		effect_zimo = "nil",
		effect_ganghu = "nil",
		effect_guafeng = "nil",
		effect_xiayu = "nil",
		effect_huguang = "nil"
	}
}
-- 启动事件--
function OB_GameMainCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	print("====OnCreate=====joinRoomUserVos", #global.joinRoomUserVos)
	self:AddClick(OB_GameMainPanel.btnQuit, self.OnQuitBtnClick)
	-- self:AddClick(OB_GameMainPanel.btnSetSystem, self.OnSetSystemBtnClick)
	self:AddClick(OB_GameMainPanel.btnChat, self.OnChatBtnClick)
	self:AddClick(OB_GameMainPanel.btnPeng, self.OnPengBtnClick)
	self:AddClick(OB_GameMainPanel.btnGang, self.OnGangBtnClick)
	self:AddClick(OB_GameMainPanel.btnHu, self.OnHuBtnClick)
	self:AddClick(OB_GameMainPanel.btnGuo, self.OnGuoBtnClick)
	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(OB_GameMainPanel.imgHeadIconD, self.OnClickHead)
	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(OB_GameMainPanel.imgHeadIconR, self.OnClickHead)
	self:AddClick(OB_GameMainPanel.imgHeadIconU, self.OnClickHead)
	self:AddClick(OB_GameMainPanel.imgHeadIconL, self.OnClickHead)

	self:AddClick(OB_GameMainPanel.btnMask, self.OnCloseHead)
	self:AddClick(OB_GameMainPanel.btnE1, self.OnSendFaceAnim)
	self:AddClick(OB_GameMainPanel.btnE2, self.OnSendFaceAnim)
	self:AddClick(OB_GameMainPanel.btnE3, self.OnSendFaceAnim)
	self:AddClick(OB_GameMainPanel.btnE4, self.OnSendFaceAnim)
	self:AddClick(OB_GameMainPanel.btnE5, self.OnSendFaceAnim)

	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(OB_GameMainPanel.btnSendCode, self.SendDeBugCode)
	self:AddClick(OB_GameMainPanel.imgTingPaiTipsBGImage, self.CloseImgTingPaiTipsBGImage)
	self:AddClick(OB_GameMainPanel.btnTingPai, self.OnTingPaiBtnClick)

	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(OB_GameMainPanel.btnQuitTipsYes, self.OnQuitGameYse)
	self:AddClick(OB_GameMainPanel.btnQuitTipsNo, self.OnQuitGameNo)
	self:AddClick(OB_GameMainPanel.btnGPS, self.OpenGps)

	print("====OnCreate=====joinRoomUserVos")
	-- 用于回放操作
	self:AddClick(OB_GameMainPanel.huiFangQuitButton, self.OnPlayBackQuit)
	self:AddClick(OB_GameMainPanel.huiFangShareButton, self.OnPlayBackShare)
	self:AddClick(OB_GameMainPanel.huiFangHouTuiButton, self.OnPlayBackHouTui)
	self:AddClick(OB_GameMainPanel.huiFangPlayButton, self.OnPlayBackPlay)
	self:AddClick(OB_GameMainPanel.huiFangZanTingButton, self.OnPlayBackZanTing)
	self:AddClick(OB_GameMainPanel.huiFangKuaiJinButton, self.OnPlayBackKuaiJin)
	-- 比赛场
	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(OB_GameMainPanel.btnTuoGuan, self.OnTuoGuakBtnClick)
	self:AddClick(OB_GameMainPanel.btnQuXiaoTuoGuan, self.OnQuXiaoTuoGuakBtnClick)
	-- 新添加
	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(OB_GameMainPanel.btnGouwuche, self.OnbtnGouwucheBtnClick)

	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(OB_GameMainPanel.btnMask, self.OnHidePanelClick)
	self:AddClickNoChange(OB_GameMainPanel.QuitHideButton, self.OnHidePanelClick)
	self:AddClickNoChange(OB_GameMainPanel.btnHideUp, self.OnHidePanelClick)
	self:AddClick(OB_GameMainPanel.btnSettingGame, self.OnShowGameSettingClick)
	self:AddClick(OB_GameMainPanel.btnSettingSystem, self.OnSetSystemBtnClick)
	self:AddClick(OB_GameMainPanel.btnWaitQuitRoom, self.OnQuitBtnClick)
	self:AddClick(OB_GameMainPanel.btnInvitationWeChat, self.OnInvitationWeChatBtnClick)
	self:AddClick(OB_GameMainPanel.btnGameStart, self.OnHeadDClick)
	print("====OnCreate=====joinRoomUserVos")

	self:InitPanel()
	enable = false
	objTableMask = nil
end

-- 初始化面板--
function OB_GameMainCtrl:InitPanel()
	-- 广电
	print("<color=#F0FF0000>-------OB_GameMainCtrl:InitPanel()-------</color>")
	Game.MusicBG("bgm4")

	OB_GameMainPanel.txtScoreD.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)
	OB_GameMainPanel.txtScoreR.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)
	OB_GameMainPanel.txtScoreU.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)
	OB_GameMainPanel.txtScoreL.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)
	RoleInfoCtrl.OnQuitBtnClick()
	global.systemVo.BGSource.volume = 0.2
	OB_GameMainPanel.imgChatD:SetActive(false)
	OB_GameMainPanel.imgChatU:SetActive(false)
	OB_GameMainPanel.imgChatL:SetActive(false)
	OB_GameMainPanel.imgChatR:SetActive(false)
	OB_GameMainPanel.imgFaceIconBGL:SetActive(false)
	OB_GameMainPanel.imgFaceIconBGR:SetActive(false)
	OB_GameMainPanel.imgFaceIconBGD:SetActive(false)
	OB_GameMainPanel.imgFaceIconBGU:SetActive(false)
	OB_GameMainPanel.btnQuit:SetActive(false)
	gameRoom.DClose:SetActive(false)
	gameRoom.txtCountDown:SetActive(false)
	OB_GameMainPanel.imgTingPaiTipsBGImage:SetActive(false)
	OB_GameMainPanel.inputSendCode:SetActive(false)
	OB_GameMainPanel.btnSendCode:SetActive(false)
	OB_GameMainPanel.imgReadyL:SetActive(false)
	OB_GameMainPanel.imgReadyD:SetActive(false)
	OB_GameMainPanel.imgReadyU:SetActive(false)
	OB_GameMainPanel.imgReadyR:SetActive(false)
	OB_GameMainPanel.imgPengGangHuBG:SetActive(false)
	gameRoom.DDong:SetActive(false)
	gameRoom.DXi:SetActive(false)
	gameRoom.DNan:SetActive(false)
	gameRoom.DBei:SetActive(false)
	gameRoom.DOpen:SetActive(false)
	OB_GameMainPanel.imgTips:SetActive(false)
	OB_GameMainPanel.imgHuangZhuang:SetActive(false)
	OB_GameMainPanel.imgLouHu:SetActive(false)
	OB_GameMainPanel.imgHeadLBreak:SetActive(false)
	OB_GameMainPanel.imgHeadRBreak:SetActive(false)
	OB_GameMainPanel.imgHeadUBreak:SetActive(false)
	OB_GameMainPanel.imgHeadDBreak:SetActive(false)
	OB_GameMainPanel.btnTingPai:SetActive(false)
	OB_GameMainPanel.imgGenZhuang:SetActive(false)
	OB_GameMainPanel.imgAnimL:SetActive(false)
	OB_GameMainPanel.imgAnimR:SetActive(false)
	OB_GameMainPanel.imgAnimD:SetActive(false)
	OB_GameMainPanel.imgAnimU:SetActive(false)

	OB_GameMainPanel.imgFangzhuD:SetActive(false)
	OB_GameMainPanel.imgFangzhuR:SetActive(false)
	OB_GameMainPanel.imgFangzhuU:SetActive(false)
	OB_GameMainPanel.imgFangzhuL:SetActive(false)

	OB_GameMainPanel.imgZhuangjiaD:SetActive(false)
	OB_GameMainPanel.imgZhuangjiaR:SetActive(false)
	OB_GameMainPanel.imgZhuangjiaU:SetActive(false)
	OB_GameMainPanel.imgZhuangjiaL:SetActive(false)

	OB_GameMainPanel.imgQuitTips:SetActive(false)
	OB_GameMainPanel.btnGPS:SetActive(false)
	OB_GameMainPanel.btnQuit.transform:SetAsLastSibling()
	OB_GameMainPanel.imgQuitTips.transform:SetAsLastSibling()

	if #global.joinRoomUserVos == 3 then
		OB_GameMainPanel.objHeadU:SetActive(false)
	end

	if global.roomVo.isPlayNum ~= 3 then
		gameRoom.objLight:SetActive(false)
		gameRoom.objSanren:SetActive(false)
	end
	OB_GameMainPanel.imgGameStart:SetActive(false)
	-- 回放操作界面
	OB_GameMainPanel.imgPlayBackBGImage:SetActive(false)
	if GradeDetailCtrl.isPlayBackOperate then
		OB_GameMainPanel.imgPlayBackBGImage:SetActive(true)
		OB_GameMainPanel.huiFangPlayButton:SetActive(false)
		OB_GameMainPanel.huiFangZanTingButton:SetActive(true)
		OB_GameMainPanel.btnQuit:SetActive(false)
		OB_GameMainPanel.btnChat:SetActive(false)
		OB_GameMainPanel.btnTalk:SetActive(false)
		self.isPlayBackPlay = true
		GradeDetailCtrl.isPlayBackOperate = false
	end

	EffectList[2][1] = OB_GameMainPanel.effect_touxiangL
	EffectList[2][2] = OB_GameMainPanel.effect_touxiangD
	EffectList[2][3] = OB_GameMainPanel.effect_touxiangR
	EffectList[2][4] = OB_GameMainPanel.effect_touxiangU
	EffectList[1][1] = OB_GameMainPanel.effect_pengyan
	EffectList[1][2] = OB_GameMainPanel.effect_duoxiang

	for i = 1, #EffectList do
		for j = 1, #EffectList[i] do
			EffectList[i][j]:SetActive(false)
		end
	end
	OB_GameMainCtrl.HideTableEffect()
	timeCountDown = gameRoom.txtCountDown
	local txt = tostring(global.roomVo.playMethod)
	local objtxtRoomNum = gameRoom.objtxtRoomNum
	local objtxtMethod = gameRoom.objtxtMethod
	self:SetText(objtxtMethod, txt)
	-- self:SetText(objtxtRoomNum,global.roomVo.id)

	if global.isDebug == true then
		-- 打包需要隐藏
		this.InputSendCode(false)
	end
	self:InitPlayer()
	self:RefrshScore()


	-- 设置房主
	for i, v in ipairs(global.joinRoomUserVos) do
		if v.index == 1 then
			if global.roomVo.moneyType == RoomMode.goldMode then
				OB_GameMainPanel.imgFangzhuD:SetActive(false)
				OB_GameMainPanel.imgFangzhuR:SetActive(false)
				OB_GameMainPanel.imgFangzhuL:SetActive(false)
				OB_GameMainPanel.imgFangzhuU:SetActive(false)
			elseif global.roomVo.moneyType == RoomMode.wingMode then
				OB_GameMainPanel.imgFangzhuD:SetActive(false)
				OB_GameMainPanel.imgFangzhuR:SetActive(false)
				OB_GameMainPanel.imgFangzhuL:SetActive(false)
				OB_GameMainPanel.imgFangzhuU:SetActive(false)
			else
				local location = getOtherPlayerLocation(v.index)
				if location == "D" then
					OB_GameMainPanel.imgFangzhuD:SetActive(true)
				elseif location == "R" then
					OB_GameMainPanel.imgFangzhuR:SetActive(true)
				elseif location == "L" then
					OB_GameMainPanel.imgFangzhuL:SetActive(true)
				elseif location == "U" then
					OB_GameMainPanel.imgFangzhuU:SetActive(true)
				end
			end
		end
	end
	-- 设置东西南北
	if #global.joinRoomUserVos == 4 then
		local myId = global.userVo.roleId
		local index = getRoleIndexById(myId)
		local location = getOtherPlayerLocation(index)
		if index == 1 then
			gameRoom.objDNXB.transform.rotation =
			Quaternion.Euler(Vector3.New(90, 0, -90))
			gameRoom.objDNXB.transform.localScale = Vector3.New(200, 310, 1)
		elseif index == 2 then
			gameRoom.objDNXB.transform.rotation =
			Quaternion.Euler(Vector3.New(90, 0, 180))
			gameRoom.objDNXB.transform.localScale = Vector3.New(310, 200, 1)
		elseif index == 3 then
			gameRoom.objDNXB.transform.rotation =
			Quaternion.Euler(Vector3.New(90, 0, 90))
			gameRoom.objDNXB.transform.localScale = Vector3.New(200, 310, 1)
		elseif index == 4 then
			gameRoom.objDNXB.transform.rotation =
			Quaternion.Euler(Vector3.New(90, 0, 0))
			gameRoom.objDNXB.transform.localScale = Vector3.New(310, 200, 1)
		end
	end
	if #global.joinRoomUserVos == 3 then
		eulerR = Quaternion.Euler(Vector3.New(0, 0, 90))
		eulerL = Quaternion.Euler(Vector3.New(0, 0, -90))
		eulerD = Quaternion.Euler(Vector3.New(0, 0, 0))
	end
	self:SetText(OB_GameMainPanel.txtTime, AppConst.GetDate())

	-- 比赛场操作界面
	OB_GameMainPanel.btnTuoGuan:SetActive(false)
	OB_GameMainPanel.imgPaiXingBG:SetActive(false)
	OB_GameMainPanel.imgMatchLunCountBG:SetActive(false)
	OB_GameMainPanel.imgTuoGuanBG:SetActive(false)
	gameRoom.objtxtRoomNum:SetActive(true)
	gameRoom.objtxtTitle.transform:GetComponent("Text").color = Color.New(0.14, 0.29, 0.36, 1)
	-- self:SetText(OB_GameMainPanel.txtJuShu,"局数"..gameRoom.curJushu..'/'..global.roomVo.total)
	if global.roomVo.isFangzhu == 3 or global.roomVo.vsRoomNum ~= 0 then
		self.isCanClick = true
		OB_GameMainPanel.btnQuit:SetActive(false)
		OB_GameMainPanel.btnTalk:SetActive(false)
		gameRoom.objtxtRoomNum:SetActive(false)
		gameRoom.objtxtTitle.transform:GetComponent("Text").color = Color.New(0.14, 0.29, 0.36, 0)
		OB_GameMainPanel.imgPaiXingBG:SetActive(true)
		OB_GameMainPanel.imgMatchLunCountBG:SetActive(true)
		if gameRoom.curJushu > 2 then
			gameRoom.curJushu = 1
			-- self:SetText(OB_GameMainPanel.txtJuShu,"局数"..gameRoom.curJushu..'/'..global.roomVo.total)
		end
		for i, v in ipairs(global.joinRoomUserVos) do
			if v.index == 1 then
				local location = getOtherPlayerLocation(v.index)
				if location == "D" then
					OB_GameMainPanel.imgFangzhuD:SetActive(false)
				elseif location == "R" then
					OB_GameMainPanel.imgFangzhuR:SetActive(false)
				elseif location == "L" then
					OB_GameMainPanel.imgFangzhuL:SetActive(false)
				elseif location == "U" then
					OB_GameMainPanel.imgFangzhuU:SetActive(false)
				end
			end
			if global.userVo.roleId == v.roleId then
				self:SetText(OB_GameMainPanel.txtPaiXingMingCi, '第' .. v.curPaiMing .. '名')
			end
			if v.isTrusteeship then
				OB_GameMainPanel.btnTuoGuan:SetActive(false)
				OB_GameMainPanel.imgTuoGuanBG:SetActive(true)
			end
		end
		self:SetText(OB_GameMainPanel.txtCurrentLunInfo, global.roomVo.vscount .. '人快速赛    ' .. '第' .. global.roomVo.lun .. '轮')
	end

	-- 新添加
	OB_GameMainPanel.imgSignalBG.transform.localPosition = Vector3.New(-440, 326, 0)
	OB_GameMainPanel.imgSurplusCards.transform.localPosition = Vector3.New(-340, 326, 0)
	local textBasenum = '底分:' .. tostring(global.roomVo.baseNum)
	local textQualified = tostring(global.roomVo.qualified) .. '进' .. tostring(global.roomVo.qualified) .. '出'
	gameRoom.objtxtTuoguan:SetActive(false)
	gameRoom.objtxtDiZhuAndJinrutiaojian:SetActive(false)
	gameRoom.objtxtRoomNum:SetActive(true)
	gameRoom.objtxtTitle:SetActive(true)
	if global.roomVo.moneyType == RoomMode.goldMode then
		gameRoom.objtxtTuoguan:SetActive(true)
		gameRoom.objtxtDiZhuAndJinrutiaojian:SetActive(true)
		gameRoom.objtxtRoomNum:SetActive(false)
		gameRoom.objtxtTitle:SetActive(false)
		OB_GameMainPanel.imgSignalBG.transform.localPosition = Vector3.New(-565, 326, 0)
		OB_GameMainPanel.imgSurplusCards.transform.localPosition = Vector3.New(-465, 326, 0)
		self:SetText(gameRoom.objtxtDiZhuAndJinrutiaojian, textBasenum .. "\n" .. textQualified)
	elseif global.roomVo.moneyType == RoomMode.wingMode then
		gameRoom.objtxtTuoguan:SetActive(true)
		gameRoom.objtxtDiZhuAndJinrutiaojian:SetActive(true)
		gameRoom.objtxtRoomNum:SetActive(false)
		gameRoom.objtxtTitle:SetActive(false)
		OB_GameMainPanel.imgSignalBG.transform.localPosition = Vector3.New(-565, 326, 0)
		OB_GameMainPanel.imgSurplusCards.transform.localPosition = Vector3.New(-465, 326, 0)
		self:SetText(gameRoom.objtxtDiZhuAndJinrutiaojian, textBasenum .. "\n" .. textQualified)
	end

	dateTime = 0
	this.FaceIcon()
	local gameType = AppConst.getPlayerPrefs("createGameType")

	if tonumber(gameType) == 1 then
		local Ronda = ""
		local text1 = ""
		local text2 = ""
		local text3 = ""

		if global.roomVo.mcreenings == 1 then
			Ronda = "新手场"
		elseif global.roomVo.mcreenings == 2 then
			Ronda = "初级场"
		elseif global.roomVo.mcreenings == 3 then
			Ronda = "中级场"
		elseif global.roomVo.mcreenings == 4 then
			Ronda = "高级场"
		elseif global.roomVo.mcreenings == 5 then
			Ronda = "土豪场"
		end

		if tonumber(huaisSelf) == 1 then
			text1 = "自摸胡"
		else
			text1 = "点炮胡"
		end

		if tonumber(huaisBihu) == 1 then
			text1 = "点炮必胡"
		end

		if tonumber(huaisFeng) == true then
			text2 = "有风牌"
		else
			text2 = "无风牌"
		end

		if global.roomVo.hongzhong == true then
			text3 = "　　　红中癞子"
		else
			text3 = ""
		end

		if global.roomVo.moneyType == RoomMode.goldMode then
			self:SetText(OB_GameMainPanel.txtRoomNum, "金币" .. Ronda)
			self:SetText(OB_GameMainPanel.txtWanFa, "人数：4人局" .. "\n" .. "玩法：点炮胡" .. "\n" .. "特殊：无风牌" .. "\n" .. "鱼子：不下鱼")
			self:SetText(OB_GameMainPanel.txtJuShu, '底分：' .. tostring(global.roomVo.baseNum))
		elseif global.roomVo.moneyType == RoomMode.wingMode then
			self:SetText(OB_GameMainPanel.txtRoomNum, "元宝" .. Ronda)
			self:SetText(OB_GameMainPanel.txtWanFa, "人数：4人局" .. "\n" .. "玩法：点炮胡" .. "\n" .. "特殊：无风牌" .. "\n" .. "鱼子：不下鱼")
			self:SetText(OB_GameMainPanel.txtJuShu, '底分：' .. tostring(global.roomVo.baseNum))
		else
			local text1 = ""
			local text2 = ""
			local text3 = ""
			local text4 = ""

			if global.roomVo.isSelf == 1 then
				text1 = "自摸胡"
			else
				text1 = "点炮胡"
			end

			if global.roomVo.isBihu == 1 then
				text1 = "点炮必胡"
			end

			if global.roomVo.isFeng == 2 then
				text2 = "有风牌"
			else
				text2 = "无风牌"
			end

			if global.roomVo.isRed == 1 then
				text3 = '　　　红中癞子'
			else
				text3 = ""
			end

			if global.roomVo.isFishNum == 0 then
				text4 = '0条鱼'
			else
				text4 = global.roomVo.isFishNum .. "条鱼"
			end

			self:SetText(OB_GameMainPanel.txtRoomNum, "房号：" .. tostring(global.roomVo.id))
			self:SetText(OB_GameMainPanel.txtWanFa, "人数：" .. tostring(global.roomVo.isPlayNum) .. "人局" .. "\n" .. "玩法：" .. text1 .. "\n" .. "特殊：" .. text2 .. "\n" .. text3 .. "\n" .. "鱼子：" .. text4)
			self:SetText(OB_GameMainPanel.txtJuShu, '局数：' .. gameRoom.curJushu .. "/" .. global.roomVo.total)
		end
	else
		local Ronda = ""
		local text1 = ""
		local text2 = ""
		local text3 = ""
		local text4 = ""

		if global.roomVo.mcreenings == 1 then
			Ronda = "新手场"
		elseif global.roomVo.mcreenings == 2 then
			Ronda = "初级场"
		elseif global.roomVo.mcreenings == 3 then
			Ronda = "中级场"
		elseif global.roomVo.mcreenings == 4 then
			Ronda = "高级场"
		elseif global.roomVo.mcreenings == 5 then
			Ronda = "土豪场"
		end

		if global.roomVo.zimohu == true then
			text1 = "自摸胡"
		else
			text1 = "点炮胡"
		end

		if global.roomVo.feng == true then
			text2 = "有风牌"
		else
			text2 = "无风牌"
		end

		if global.roomVo.hongzhong == true then
			text3 = "　　　红中癞子"
		else
			text3 = ""
		end

		if global.roomVo.modeType == 1 then
			text4 = "AA模式"
		else
			text4 = "老板模式"
		end


		if global.roomVo.moneyType == RoomMode.goldMode then
			self:SetText(OB_GameMainPanel.txtRoomNum, "金币" .. Ronda)
			self:SetText(OB_GameMainPanel.txtWanFa, "人数：4人局" .. "\n" .. "玩法：自摸胡" .. "\n" .. "特殊：无风牌" .. "\n" .. "鱼子：不下鱼")
			self:SetText(OB_GameMainPanel.txtJuShu, '底分：' .. tostring(global.roomVo.baseNum))
		elseif global.roomVo.moneyType == RoomMode.wingMode then
			self:SetText(OB_GameMainPanel.txtRoomNum, "元宝" .. Ronda)
			self:SetText(OB_GameMainPanel.txtWanFa, "人数：4人局" .. "\n" .. "玩法：自摸胡" .. "\n" .. "特殊：无风牌" .. "\n" .. "鱼子：不下鱼")
			self:SetText(OB_GameMainPanel.txtJuShu, '底分：' .. tostring(global.roomVo.baseNum))
		else
			self:SetText(OB_GameMainPanel.txtRoomNum, "房号：" .. tostring(global.roomVo.id))
			self:SetText(OB_GameMainPanel.txtWanFa, "人数：" .. tostring(global.roomVo.isPlayNum) .. "人局" .. "\n" .. "玩法：自摸胡" .. "\n" .. "特殊：无风牌" .. "\n" .. "模式：" .. text4)
			self:SetText(OB_GameMainPanel.txtJuShu, '局数：' .. gameRoom.curJushu .. "/" .. global.roomVo.total)
		end
	end
end

function OB_GameMainCtrl:ChangeQuitState()
	if global.roomVo.moneyType == RoomMode.roomCardMode then

	else
		if Room.isStar then
			OB_GameMainPanel.PanelGameSetting:SetActive(false)
			OB_GameMainPanel.btnWaitQuitRoom:SetActive(true)
			OB_GameMainPanel.imgNotWaitQuitRoom:SetActive(false)
			OB_GameMainPanel.imgNotGameMainQuitRoom:SetActive(true)
		else
			OB_GameMainPanel.PanelGameSetting:SetActive(false)
			OB_GameMainPanel.btnWaitQuitRoom:SetActive(true)
			OB_GameMainPanel.imgNotWaitQuitRoom:SetActive(false)
			OB_GameMainPanel.imgNotGameMainQuitRoom:SetActive(true)
		end
	end
end

-- 申请解散房间--
function OB_GameMainCtrl.OnQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = OB_GameMainCtrl
	OB_GameMainPanel.imgQuitTips:SetActive(true)
	if gameRoom.isOnes then
		self:SetText(OB_GameMainPanel.txtQuitTips, "解散房间不扣房卡，是否确定解散？")
	else
		self:SetText(OB_GameMainPanel.txtQuitTips, "是否确认解散房间")
	end
end

function OB_GameMainCtrl.CloseImgTingPaiTipsBGImage(go)
	OB_GameMainPanel.imgTingPaiTipsBGImage:SetActive(false)
end

-- 设置按钮
function OB_GameMainCtrl.OnSetSystemBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	SetSystemCtrl:GetInfo(global.userVo.name, global.userVo.roleId, global.userVo.roleIp,
	OB_GameMainPanel.btnHeadIconD)
	SetSystemCtrl:Open('SetSystem')
end

-- 语音按钮
function OB_GameMainCtrl.OnChatBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	GameChatCtrl:Open('GameChat')
end

-- 游戏开始--
function OB_GameMainCtrl.GameStart()
	local self = OB_GameMainCtrl
	this.CountDown(false)
	-- Game.MusicBG("bgm4")
	gameRoom.DClose:SetActive(false)

	OB_GameMainCtrl:Close()
	OB_GameMainCtrl:Open("GameMain", function()
		GameRoom.gameObjCardContainer:SetActive(true)
		self:SetText(GameRoom.objtxtTuoguan, "玩家15秒未操作，将自动进入托管状态")
	end )
end

-- 数字显示
function OB_GameMainCtrl.ShowCount()
	self = OB_GameMainCtrl
	self:InvokeRepeat("CardTime", 0.1, 300000000)
end

-- 表情窗左--
function OB_GameMainCtrl.FaceIconBGL(isShow)
	OB_GameMainPanel.imgFaceIconBGL:SetActive(isShow)
	coroutine.start(this.HideImgFaceIconBGL)
end

-- 表情窗右--
function OB_GameMainCtrl.FaceIconBGR(isShow)
	OB_GameMainPanel.imgFaceIconBGR:SetActive(isShow)
	coroutine.start(this.HideImgFaceIconBGR)
end

-- 表情窗上--
function OB_GameMainCtrl.FaceIconBGU(isShow)
	OB_GameMainPanel.imgFaceIconBGU:SetActive(isShow)
	coroutine.start(this.HideImgFaceIconBGU)
end

-- 表情窗下--
function OB_GameMainCtrl.FaceIconBGD(isShow)
	OB_GameMainPanel.imgFaceIconBGD:SetActive(isShow)
	coroutine.start(this.HideImgFaceIconBGD)
end

-- 停牌提示--
function OB_GameMainCtrl.TingPaiTipsBG(isShow)
	OB_GameMainPanel.imgGameStart:SetActive(isShow)
end

-- 碰杠胡提示--
function OB_GameMainCtrl.PengGangHuBG(isShow)
	OB_GameMainPanel.imgPengGangHuBG:SetActive(isShow)
	local peng = OB_GameMainPanel:FindChild('btnPeng')
	local gang = OB_GameMainPanel:FindChild('btnGang')
	local hu = OB_GameMainPanel:FindChild('btnHu')
	local guo = OB_GameMainPanel:FindChild('btnGuo')
end

-- 打牌标记
function OB_GameMainCtrl.CardDirection(pos)
	local cardDirection = OB_GameMainPanel.imgPlayCardDirection
	cardDirection:SetActive(true)
	cardDirection.transform.position = pos
	cardDirection.transform.position = Vector3.New(pos.x, -7.8, pos.z)
end

-- 特效管理--
function OB_GameMainCtrl.EffectMgr(effectName, pos)
	if not Game.isReloadBattle or gameRoom.hasReload then
		for i = 1, #EffectList do
			for j = 1, #EffectList[i] do
				if EffectList[i][j].name == effectName then
					if EffectList[i][j].activeSelf == true then return end
					currentEffect = EffectList[i][j]
					currentEffect:SetActive(true)
				end
			end
		end
		if effectName == 'effect_pengyan' then
			currentEffect.transform.position = pos
		end
		if effectName == "effect_duoxiang" then
			Game.ChangeLanguage("hu")
		end
		local co = coroutine.start(this.effect)
		table.insert(Network.crts, co)
	end
end

-- 每次调用2秒后隐藏
function OB_GameMainCtrl.effect()
	coroutine.wait(2)
	if GradeDetailCtrl.isPlayBackPlayEffect then
	else
		if not OB_GameMainCtrl.isCreate then return end
		currentEffect:SetActive(false)
	end
end

-- 出牌时间--
function OB_GameMainCtrl.CountDown(isShow)
	gameRoom.txtCountDown:SetActive(isShow)
	enable = isShow
	if enable then
		currentTime = 10
	end
end

-- 发送作弊码--
function OB_GameMainCtrl.InputSendCode(isShow)
	OB_GameMainPanel.inputSendCode:SetActive(isShow)
	OB_GameMainPanel.btnSendCode:SetActive(isShow)
end

-- 显示剩多少张牌
function OB_GameMainCtrl.SurplusCardNum(msg)
	self = OB_GameMainCtrl
	self:SetText(OB_GameMainPanel.txtSurplusNum, msg)
end

local c
local isAdd = false
local anum = 1
local t1 = 0
local t2 = 0
-- 语音及音效--
-- 系统设置音乐按钮只控制背景音乐，所有别的声音都用音效按钮控制
function OB_GameMainCtrl.FaceIcon()
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
		if global.systemVo.isTalk == "0" then
			global.systemVo.BGSource.volume = 0.2
		else
			global.systemVo.BGSource.volume = 0
		end
		-- global.systemVo.CardSource.volume = 1
		-- global.systemVo.TalkSource.volume = 1
	end
end

function OB_GameMainCtrl.CardTime()
	-- 出牌倒计时--
	if enable then
		currentTime = currentTime - 0.1
		t1, t2 = math.modf(currentTime)
		local txt = gameRoom.txtCountDown.transform:GetComponent('Text')

		if t1 < 10 then
			txt.text = '0' .. t1
			-- 东南西北闪烁
			if isAdd == false then
				anum = anum - 0.1
				OB_GameMainCtrl.ColorChange(objTableMask, anum)
				OB_GameMainCtrl.ColorChange(gameRoom.objLight, anum)
				if anum < 0.5 then
					isAdd = true
				end
			else
				anum = anum + 0.1
				if objTableMask == nil then
				else
					OB_GameMainCtrl.ColorChange(objTableMask, anum)
					OB_GameMainCtrl.ColorChange(gameRoom.objLight, anum)
				end
				if anum > 0.9 then
					isAdd = false
				end
			end
		else
			txt.text = t1
		end
		if t1 == 0 then
			anum = 1
			Game.MusicEffect("naozhong")
			OB_GameMainCtrl.ColorChange(objTableMask, anum)
			OB_GameMainCtrl.ColorChange(OB_GameMainPanel.objLight, anum)
			enable = false
			if global.systemVo.isShakeOn == '1' then

				if global.firstMoChess ~= nil and global.firstMoChess.roleId == global.userVo.roleId then
					AppConst.Vibrate()
				end
			end
		end
	end

	-- 系统时间
	dateTime = dateTime - 0.1
	if dateTime < 0 then
		local self = OB_GameMainCtrl
		if OB_GameMainPanel.txtTime ~= nil then
			self:SetText(OB_GameMainPanel.txtTime, AppConst.GetDate())
		end
		dateTime = 10
	end
	-- 网络信号获取间隔
	netTime = netTime - 0.1
	if netTime < 0 then
		local self = OB_GameMainCtrl
		self:NetWork()
		netTime = 5
	end
	this.FaceIcon()
end

-- 网络信号
function OB_GameMainCtrl:NetWork()
	local level = network_delay
	if level > 0 and level < 50 then
		OB_GameMainPanel.imgSignal2:SetActive(true)
		OB_GameMainPanel.imgSignal3:SetActive(true)
		OB_GameMainPanel.imgSignal4:SetActive(true)
		OB_GameMainPanel.imgSignal5:SetActive(true)
	elseif level > 50 and level < 100 then
		OB_GameMainPanel.imgSignal2:SetActive(true)
		OB_GameMainPanel.imgSignal3:SetActive(true)
		OB_GameMainPanel.imgSignal4:SetActive(true)
		OB_GameMainPanel.imgSignal5:SetActive(true)
	elseif level > 100 and level < 150 then
		OB_GameMainPanel.imgSignal2:SetActive(true)
		OB_GameMainPanel.imgSignal3:SetActive(true)
		OB_GameMainPanel.imgSignal4:SetActive(true)
		OB_GameMainPanel.imgSignal5:SetActive(false)
	elseif level > 150 and level < 200 then
		OB_GameMainPanel.imgSignal2:SetActive(true)
		OB_GameMainPanel.imgSignal3:SetActive(true)
		OB_GameMainPanel.imgSignal4:SetActive(false)
		OB_GameMainPanel.imgSignal5:SetActive(false)
	else
		OB_GameMainPanel.imgSignal2:SetActive(true)
		OB_GameMainPanel.imgSignal3:SetActive(false)
		OB_GameMainPanel.imgSignal4:SetActive(false)
		OB_GameMainPanel.imgSignal5:SetActive(false)
	end
end

-- 黄庄
function OB_GameMainCtrl.NoWin()
	if OB_GameMainCtrl.isCreate then
		OB_GameMainPanel.imgHuangZhuang:SetActive(true)
		coroutine.wait(1.5)
		if not OB_GameMainPanel then return end
		OB_GameMainPanel.imgHuangZhuang:SetActive(false)
	end
end

-- 颜色渐变
function OB_GameMainCtrl.ColorChange(obj, anum)
	if obj == nil then
		return
	end
	c = obj.transform:GetComponent('MeshRenderer').material.color
	c.a = anum
	obj.transform:GetComponent('MeshRenderer').material.color = c
end


-- 表情窗口4秒以后消失
function OB_GameMainCtrl.HideImgFaceIconBGL()
	coroutine.wait(4)
	gameRoom.leftEmoticonObject:Destroy()
	OB_GameMainPanel.imgFaceIconBGL:SetActive(false)
end

function OB_GameMainCtrl.HideImgFaceIconBGR()
	coroutine.wait(4)
	gameRoom.rightEmoticonObject:Destroy()
	OB_GameMainPanel.imgFaceIconBGR:SetActive(false)
end

function OB_GameMainCtrl.HideImgFaceIconBGU()
	coroutine.wait(4)
	gameRoom.upEmoticonObject:Destroy()
	OB_GameMainPanel.imgFaceIconBGU:SetActive(false)
end

function OB_GameMainCtrl.HideImgFaceIconBGD()
	coroutine.wait(4)
	gameRoom.selfEmoticonObject:Destroy()
	OB_GameMainPanel.imgFaceIconBGD:SetActive(false)
end

function OB_GameMainCtrl.OnPengBtnClick()
	this.PengGangHuSignOperate(SingType.SING_PENG)
end

function OB_GameMainCtrl.OnGangBtnClick()
	local len = table.maxn(gameRoom.curSignType)
	for i = 1, len, 1 do
		local signType = gameRoom.curSignType[i]
		if signType == SingType.SING_ANGANG or signType == SingType.SING_MINGGANG or signType == SingType.SING_GUOLUGANG then
			this.PengGangHuSignOperate(signType)
			break
		end
	end
end

function OB_GameMainCtrl.OnHuBtnClick()
	print("-------HU---------")
	local len = table.maxn(gameRoom.curSignType)
	for i = 1, len, 1 do
		local signType = gameRoom.curSignType[i]
		if signType == SingType.SING_HU or signType == SingType.SING_ZIMO then
			this.PengGangHuSignOperate(signType)
			break
		end
	end
end

function OB_GameMainCtrl.OnGuoBtnClick()
	print("-------GUO-------", global.roomVo.isBihu, RoomRunStatic.IsBiHu)
	if global.roomVo.isBihu == 1 then
		if RoomRunStatic.IsBiHu then
			OB_GameMainCtrl.SetIconTips("当前为点必胡模式，无法过牌！")
		else
			this.PengGangHuSignOperate(SingType.SING_GUO)
		end
	else
		this.PengGangHuSignOperate(SingType.SING_GUO)
	end
end

function OB_GameMainCtrl.PengGangHuSignOperate(SignTypeInfo)
	local signInfo = PushSignOperate_pb.PushSignOperateReq()
	signInfo.signType = SignTypeInfo
	local msg = signInfo:SerializeToString()
	Game.SendProtocal(Protocal.Card_PushSignOperate, msg)
	OB_GameMainPanel.imgPengGangHuBG:SetActive(false)
end

-- 收到开始游戏消息
function OB_GameMainCtrl.StartGameRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = LongTypeReturn_pb.LongTypeReturnRes()
	msg:ParseFromString(data)
	local roleID = msg.longVal
	local roleIndex = getRoleIndexById(roleID)

	local location = getOtherPlayerLocation(roleIndex)
	if location == 'D' then
		OB_GameMainPanel.imgReadyD:SetActive(true)
	elseif location == 'R' then
		OB_GameMainPanel.imgReadyR:SetActive(true)
	elseif location == 'L' then
		OB_GameMainPanel.imgReadyL:SetActive(true)
	elseif location == 'U' then
		OB_GameMainPanel.imgReadyU:SetActive(true)
	else
		logWarn('--------------------------->location error')
	end
end

function OB_GameMainCtrl:GameStarting()
	print("<color=#fffc16>-------GameStarting-------</color>")
	OB_GameMainPanel.imgGameStart:SetActive(true)
	local co = coroutine.start( function()
		coroutine.wait(0.5)
		OB_GameMainPanel.imgGameStart:SetActive(false)
	end )
	table.insert(Network.crts, co)
end

-- 收到别人断线或离线消息
function OB_GameMainCtrl.OfflinePush(msg)
	if not OB_GameMainCtrl.isCreate then
		return
	end
	local roleId = msg.roleId
	-- 断线（重连）roleId
	local state = msg.state
	-- true=上线  false=离线
	local roleIndex = getRoleIndexById(roleId)
	local location = getOtherPlayerLocation(roleIndex)

	if location == 'D' then
		if OB_GameMainPanel.imgHeadDBreak then
			OB_GameMainPanel.imgHeadDBreak:SetActive(not state)
		end
	elseif location == 'R' then
		if OB_GameMainPanel.imgHeadRBreak then
			OB_GameMainPanel.imgHeadRBreak:SetActive(not state)
		end
	elseif location == 'L' then
		if OB_GameMainPanel.imgHeadLBreak then
			OB_GameMainPanel.imgHeadLBreak:SetActive(not state)
		end
	elseif location == 'U' then
		if OB_GameMainPanel.imgHeadUBreak then
			OB_GameMainPanel.imgHeadUBreak:SetActive(not state)
		end
	else
		logWarn('--------------------------->Reconnection location error')
	end
end

-- 碰烟\胡光特效
function OB_GameMainCtrl.SmokeEffect(location, effectName, pos)
	if not Game.isReloadBattle or gameRoom.hasReload then
		local txtPos = nil
		if pos ~= nil then
			if location == 'D' then
				effectpos = Vector3.New(pos.x - 0.4, pos.y, pos.z)
			elseif location == 'R' then
				effectpos = Vector3.New(pos.x, pos.y, pos.z - 0.4)
			elseif location == 'U' then
				effectpos = Vector3.New(pos.x + 0.4, pos.y, pos.z)
			elseif location == 'L' then
				effectpos = Vector3.New(pos.x, pos.y, pos.z + 0.4)
			end
			OB_GameMainCtrl.EffectMgr(effectName, effectpos)
		end
	end
end

function OB_GameMainCtrl.HideTableEffect()
	for k, v in pairs(HeadEffect.D) do
		HeadEffect.D[k] = BasePanel:GOChild(OB_GameMainPanel.imgHeadD, k)
		HeadEffect.D[k]:SetActive(false)
	end
	for k, v in pairs(HeadEffect.L) do
		HeadEffect.L[k] = BasePanel:GOChild(OB_GameMainPanel.imgHeadL, k)
		HeadEffect.L[k]:SetActive(false)
	end
	for k, v in pairs(HeadEffect.R) do
		HeadEffect.R[k] = BasePanel:GOChild(OB_GameMainPanel.imgHeadR, k)
		HeadEffect.R[k]:SetActive(false)
	end
	for k, v in pairs(HeadEffect.U) do
		HeadEffect.U[k] = BasePanel:GOChild(OB_GameMainPanel.imgHeadU, k)
		HeadEffect.U[k]:SetActive(false)
	end
end

function OB_GameMainCtrl.ShowTableEffect(location, effectName)
	local self = OB_GameMainCtrl
	local effectObj = nil
	local list = nil
	local talkName = ""
	if location == 'D' then
		list = HeadEffect.D
	elseif location == 'R' then
		list = HeadEffect.R
	elseif location == 'U' then
		list = HeadEffect.U
	elseif location == 'L' then
		list = HeadEffect.L
	end
	if effectName == "effect_peng" then
		talkName = "peng"
	elseif effectName == "effect_guafeng" then
		talkName = "gang"
		Game.MusicEffect("minggang")
	elseif effectName == "effect_xiayu" then
		talkName = "gang"
		Game.MusicEffect("angang")
	elseif effectName == "effect_hu" or effectName == "effect_ganghu" then
		talkName = "hu"
	elseif effectName == "effect_zimo" then
		talkName = "zimo"
	end

	for k, v in pairs(list) do
		if k == effectName then
			v:SetActive(true)
			coroutine.start( function()
				coroutine.wait(0.3)
				if talkName ~= "" then
					Game.ChangeLanguage(talkName)
				end
				coroutine.wait(2)
				if not OB_GameMainCtrl.isCreate then return end
				v:SetActive(false)
			end )
		end
	end
end

-- 聊天提示
function OB_GameMainCtrl.ChatTips()
	OB_GameMainPanel.imgTips:SetActive(true)
	coroutine.start(this.ChatWait)
end
function OB_GameMainCtrl.ChatWait()
	coroutine.wait(1.8)
	OB_GameMainPanel.imgTips:SetActive(false)
end

-- 文本自适应
function OB_GameMainCtrl.ChatLength(chatText, location)
	local pic = nil
	local txt = nil
	local panel = nil
	if OB_GameMainCtrl.isCreate then
		if location == "D" then
			panel = OB_GameMainPanel.imgChatD
			pic = OB_GameMainPanel.imgChatD:GetComponent("Image")
			txt = OB_GameMainPanel.txtChatD:GetComponent("Text")
		elseif location == "R" then
			panel = OB_GameMainPanel.imgChatR
			pic = OB_GameMainPanel.imgChatR:GetComponent("Image")
			txt = OB_GameMainPanel.txtChatR:GetComponent("Text")
		elseif location == "U" then
			panel = OB_GameMainPanel.imgChatU
			pic = OB_GameMainPanel.imgChatU:GetComponent("Image")
			txt = OB_GameMainPanel.txtChatU:GetComponent("Text")
		elseif location == "L" then
			panel = OB_GameMainPanel.imgChatL
			pic = OB_GameMainPanel.imgChatL:GetComponent("Image")
			txt = OB_GameMainPanel.txtChatL:GetComponent("Text")
		end
	end
	txt.text = chatText
	local co = coroutine.start( function()
		panel:SetActive(true)
		coroutine.wait(0)
		pic.rectTransform.sizeDelta = Vector2.New(txt.rectTransform.sizeDelta.x + 30, pic.rectTransform.sizeDelta.y)
		coroutine.wait(4)
		panel:SetActive(false)
		global.systemVo.BGSource.volume = 0.2
	end )
	table.insert(Network.crts, co)
end

function OB_GameMainCtrl:ClickIcon(id, iconObj)
	print("====global.setPosition==", #global.setPosition)
	local roleInfo = { }
	for i, v in ipairs(global.joinRoomUserVos) do
		print(id .. "=======OB_GameMainCtrl:ClickIcon========" .. iconObj.name)
		if id == v.roleId then
			roleInfo = { name = v.name, roleId = v.roleId, roleIp = v.ip, image = iconObj, sex = v.gender, diamond = v.diamond, typeInfo = "Big" }
			break
		end
	end
	PlayCardRoleCtrl:Open("PlayCardRole", function()
		PlayCardRoleCtrl:InitPanel(roleInfo)
	end )
end

-- 点击头像
function OB_GameMainCtrl.OnClickHead(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	if GradeDetailCtrl.isPlayBackClickHead then
		return
	end
	local location = getOtherPlayerLocation(getRoleIndexById(go.name))
	local playerIcon = nil
	if location == 'R' then
		playerIcon = OB_GameMainPanel.btnHeadIconR
	elseif location == 'U' then
		playerIcon = OB_GameMainPanel.btnHeadIconU
	elseif location == 'D' then
		playerIcon = OB_GameMainPanel.btnHeadIconD
	elseif location == 'L' then
		playerIcon = OB_GameMainPanel.btnHeadIconL
	else
		logWarn("get role location err")
	end
	print("=============================", location)
	OB_GameMainCtrl:ClickIcon(go.name, playerIcon)
end

-- 发送作弊码
function OB_GameMainCtrl.SendDeBugCode()
	self = OB_GameMainCtrl
	local txtCode = self:GetInputText(OB_GameMainPanel.inputSendCode)
	local signInfo = StringPara_pb.StringParaReq()
	signInfo.val = txtCode
	local msg = signInfo:SerializeToString()
	Game.SendProtocal(Protocal.StringPara, msg)
end

-- 收到作弊码
function OB_GameMainCtrl.StringParaRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = StringPara_pb.StringParaRes()
	msg:ParseFromString(data)
	log("GetStringPara ----------------------------" .. msg.strs)
end

-- 根据玩家ID设置积分
function OB_GameMainCtrl.SetScore(roleIndex, jifen, roleId)
	print("============SetScore")
	-- local self = OB_GameMainCtrl
	-- local playerNum = global.roomVo.isPlayNum
	-- local zongfen = tonumber(jifen)
	-- for i,v in ipairs(global.roleInfoTable) do
	-- 	if jifen == 3 then
	-- 		if roleIndex == global.roleInfoTable[i][1] then
	-- 			self:SetText(global.roleInfoTable[i][5],tostring(global.roleInfoTable[i][3]+zongfen))
	-- 		end
	-- 		if roleId == global.roleInfoTable[i][2] then
	-- 			self:SetText(global.roleInfoTable[i][5],tostring(global.roleInfoTable[i][3]-zongfen))
	-- 		end
	-- 	else
	-- 		if roleIndex == global.roleInfoTable[i][1] then
	-- 			self:SetText(global.roleInfoTable[i][5],tostring((global.roleInfoTable[i][3]+(zongfen*playerNum))))
	-- 		else
	-- 			self:SetText(global.roleInfoTable[i][5],tostring(global.roleInfoTable[i][3]-(zongfen)))
	-- 		end
	-- 	end
	-- end
end

-- 刷新分数
function OB_GameMainCtrl:RefrshScore()
	print("=====RefrshScore")
	OB_GameMainPanel.imgJinbiD:SetActive(false)
	OB_GameMainPanel.imgJinbiR:SetActive(false)
	OB_GameMainPanel.imgJinbiU:SetActive(false)
	OB_GameMainPanel.imgJinbiL:SetActive(false)
	OB_GameMainPanel.imgYuanbaoD:SetActive(false)
	OB_GameMainPanel.imgYuanbaoR:SetActive(false)
	OB_GameMainPanel.imgYuanbaoU:SetActive(false)
	OB_GameMainPanel.imgYuanbaoL:SetActive(false)
	OB_GameMainPanel.imgSurplusInningNumBG:SetActive(false)
	local self = OB_GameMainCtrl
	if global.roomVo.moneyType == RoomMode.goldMode then
		OB_GameMainPanel.imgJinbiD:SetActive(true)
		OB_GameMainPanel.imgJinbiR:SetActive(true)
		OB_GameMainPanel.imgJinbiU:SetActive(true)
		OB_GameMainPanel.imgJinbiL:SetActive(true)
		for i, v in ipairs(global.joinRoomUserVos) do
			for i, c in ipairs(global.roleInfoTable) do
				if global.roleInfoTable[i][2] == v.roleId then
					global.roleInfoTable[i][3] = v.goldcoin
					self:SetText(global.roleInfoTable[i][5], formatNumber(v.goldcoin))
				end
			end
		end
	elseif global.roomVo.moneyType == RoomMode.wingMode then
		OB_GameMainPanel.imgYuanbaoD:SetActive(true)
		OB_GameMainPanel.imgYuanbaoR:SetActive(true)
		OB_GameMainPanel.imgYuanbaoU:SetActive(true)
		OB_GameMainPanel.imgYuanbaoL:SetActive(true)
		for i, v in ipairs(global.joinRoomUserVos) do
			for i, c in ipairs(global.roleInfoTable) do
				if global.roleInfoTable[i][2] == v.roleId then
					global.roleInfoTable[i][3] = v.wing
					self:SetText(global.roleInfoTable[i][5], formatNumber(v.wing))
				end
			end
		end
	elseif global.roomVo.moneyType == RoomMode.roomCardMode then
		OB_GameMainPanel.imgSurplusInningNumBG:SetActive(false)
		if #global.joinRoomUserVos == 3 then
			for i, v in ipairs(global.joinRoomUserVos) do
				if global.roleInfoTable[1][2] == v.roleId then
					global.roleInfoTable[1][3] = v.jifen
					self:SetText(global.roleInfoTable[1][5], formatNumber(v.jifen))
				end
				if global.roleInfoTable[2][2] == v.roleId then
					global.roleInfoTable[2][3] = v.jifen
					self:SetText(global.roleInfoTable[2][5], formatNumber(v.jifen))
				end
				if global.roleInfoTable[4][2] == v.roleId then
					global.roleInfoTable[4][3] = v.jifen
					self:SetText(global.roleInfoTable[4][5], formatNumber(v.jifen))
				end
			end
		else
			for i, v in ipairs(global.joinRoomUserVos) do
				for i, c in ipairs(global.roleInfoTable) do
					if global.roleInfoTable[i][2] == v.roleId then
						global.roleInfoTable[i][3] = v.jifen
						self:SetText(global.roleInfoTable[i][5], formatNumber(v.jifen))
						print("=====global.roleInfoTable===", v.jifen)
					end
				end
			end
		end
	end
end

function OB_GameMainCtrl:HeadIcon(index)
	local location = getOtherPlayerLocation(index)
	OB_GameMainCtrl.ColorChange(gameRoom.objLight, 1)
	if location == "D" then
		roleInfoTable["R"][6]:SetActive(false)
		roleInfoTable["L"][6]:SetActive(false)
		if #global.joinRoomUserVos == 4 then
			roleInfoTable["U"][6]:SetActive(false)
		else
			gameRoom.objLight.transform.localRotation = eulerD
		end
		roleInfoTable["D"][6]:SetActive(true)

	elseif location == "R" then
		roleInfoTable["R"][6]:SetActive(true)
		roleInfoTable["L"][6]:SetActive(false)
		if #global.joinRoomUserVos == 4 then
			roleInfoTable["U"][6]:SetActive(false)
		else
			gameRoom.objLight.transform.localRotation = eulerR
		end
		roleInfoTable["D"][6]:SetActive(false)
	elseif location == "L" then
		roleInfoTable["R"][6]:SetActive(false)
		roleInfoTable["L"][6]:SetActive(true)
		if #global.joinRoomUserVos == 4 then
			roleInfoTable["U"][6]:SetActive(false)
		else
			gameRoom.objLight.transform.localRotation = eulerL
		end
		roleInfoTable["D"][6]:SetActive(false)
	elseif location == "U" then
		roleInfoTable["R"][6]:SetActive(false)
		roleInfoTable["L"][6]:SetActive(false)
		if #global.joinRoomUserVos == 4 then
			roleInfoTable["U"][6]:SetActive(true)
		end
		roleInfoTable["D"][6]:SetActive(false)
	end

	if index == 1 then
		OB_GameMainCtrl.ColorChange(gameRoom.DDong, 1)
		gameRoom.DDong:SetActive(true)
		gameRoom.DXi:SetActive(false)
		gameRoom.DNan:SetActive(false)
		gameRoom.DBei:SetActive(false)
		objTableMask = gameRoom.DDong
	elseif index == 2 then
		OB_GameMainCtrl.ColorChange(gameRoom.DNan, 1)
		gameRoom.DDong:SetActive(false)
		gameRoom.DXi:SetActive(false)
		gameRoom.DNan:SetActive(true)
		gameRoom.DBei:SetActive(false)
		objTableMask = gameRoom.DNan
	elseif index == 3 then
		OB_GameMainCtrl.ColorChange(gameRoom.DXi, 1)
		gameRoom.DDong:SetActive(false)
		gameRoom.DXi:SetActive(true)
		gameRoom.DNan:SetActive(false)
		gameRoom.DBei:SetActive(false)
		objTableMask = gameRoom.DXi
	elseif index == 4 then
		OB_GameMainCtrl.ColorChange(gameRoom.DBei, 1)
		gameRoom.DDong:SetActive(false)
		gameRoom.DXi:SetActive(false)
		gameRoom.DNan:SetActive(false)
		gameRoom.DBei:SetActive(true)
		objTableMask = gameRoom.DBei
	end
	OB_GameMainCtrl.SurplusCardNum(gameRoom.cardTotal)
end

function OB_GameMainCtrl:OnTingPaiBtnClick()
	RoomRunStatic.tingCardBtnClick()
end

function OB_GameMainCtrl:ZhuangJiaShow(index)
	local location = getOtherPlayerLocation(index)
	if location == "D" then
		OB_GameMainPanel.imgZhuangjiaD:SetActive(true)
		OB_GameMainPanel.imgZhuangjiaR:SetActive(false)
		OB_GameMainPanel.imgZhuangjiaU:SetActive(false)
		OB_GameMainPanel.imgZhuangjiaL:SetActive(false)
	elseif location == "R" then
		OB_GameMainPanel.imgZhuangjiaD:SetActive(false)
		OB_GameMainPanel.imgZhuangjiaR:SetActive(true)
		OB_GameMainPanel.imgZhuangjiaU:SetActive(false)
		OB_GameMainPanel.imgZhuangjiaL:SetActive(false)
	elseif location == "L" then
		OB_GameMainPanel.imgZhuangjiaD:SetActive(false)
		OB_GameMainPanel.imgZhuangjiaR:SetActive(false)
		OB_GameMainPanel.imgZhuangjiaU:SetActive(false)
		OB_GameMainPanel.imgZhuangjiaL:SetActive(true)
	elseif location == "U" then
		OB_GameMainPanel.imgZhuangjiaD:SetActive(false)
		OB_GameMainPanel.imgZhuangjiaR:SetActive(false)
		OB_GameMainPanel.imgZhuangjiaU:SetActive(true)
		OB_GameMainPanel.imgZhuangjiaL:SetActive(false)
	end
end

function OB_GameMainCtrl:OnQuitGameYse()
	Game.MusicEffect(Game.Effect.joinRoom)
	if global.roomVo.id == nil then
		MessageTipsCtrl:ShowInfo("房间号为空")
		return
	end
	-- if Game.isReloadBattle and not gameRoom.hasReload then
	-- 	MessageTipsCtrl:ShowInfo("请稍等")
	-- 	return
	-- end
	Game.SendProtocal(Protocal.ApplyDisRoom)

	OB_GameMainPanel.imgQuitTips:SetActive(false)
end

function OB_GameMainCtrl:OnQuitGameNo()
	Game.MusicEffect(Game.Effect.buttonBack)
	OB_GameMainPanel.imgQuitTips:SetActive(false)
end

function OB_GameMainCtrl.SetIconTips(str, bool)
	self = OB_GameMainCtrl
	if bool == nil then
		if OB_GameMainPanel.imgTips.activeSelf == true then return end
		OB_GameMainCtrl.ChatTips()
		local tipsText = BasePanel:GOChild(OB_GameMainPanel.imgTips, "Name")
		local tipsPos = Vector3.New(0, -172.8, 3782)
		local sequence = DG.Tweening.DOTween.Sequence()
		sequence:Append(OB_GameMainPanel.imgTips.transform:DOLocalMoveY(tipsPos.y + 50, 2, false))
		:OnComplete( function()
			OB_GameMainPanel.imgTips.transform.localPosition = tipsPos
		end )
		self:SetText(tipsText, str)
	elseif bool == true then
		local tipsText = BasePanel:GOChild(OB_GameMainPanel.imgTips, "Name")
		local tipsPos = Vector3.New(0, -130, 3782)
		OB_GameMainPanel.imgTips.transform.localPosition = tipsPos
		OB_GameMainPanel.imgTips:SetActive(true)
		self:SetText(tipsText, str)
	else
		OB_GameMainPanel.imgTips:SetActive(false)
	end
end

function OB_GameMainCtrl.LouHuRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = IntTypeReturn_pb.IntTypeReturnRes()
	msg:ParseFromString(data)
	local intVal = msg.intVal
	OB_GameMainPanel.imgLouHu:SetActive(true)
end

function OB_GameMainCtrl.GenZhuangRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = IntTypeReturn_pb.IntTypeReturnRes()
	msg:ParseFromString(data)
	local intVal = msg.intVal
	OB_GameMainCtrl.SetIconTips("跟庄成功，下把结算翻番！")
	OB_GameMainPanel.imgGenZhuang:SetActive(true)
	local co = coroutine.start(OB_GameMainCtrl.GenZhuangShow)
	table.insert(Network.crts, co)
end

function OB_GameMainCtrl.LouhuShow()
	coroutine.wait(2)
	OB_GameMainPanel.imgLouHu:SetActive(false)
end

function OB_GameMainCtrl.GenZhuangShow()
	coroutine.wait(2)
	OB_GameMainPanel.imgGenZhuang:SetActive(false)
end
-- 回放退出
function OB_GameMainCtrl:OnPlayBackQuit()
	local self = OB_GameMainCtrl
	gameRoom.rightCards = { }
	gameRoom.leftCards = { }
	gameRoom.upCards = { }
	self.isPlayBackPlay = false
	GradeDetailCtrl.isPlayBackClickHead = false
	GradeDetailCtrl.isPlayBackReload = false
	GradeDetailCtrl.isPlayBackPlayEffect = false
	GradeDetailCtrl:CancelInvoke("PlayBackOperate")
	Network.ClearCtrs()
	Game.LoadScene("main")
	self.isOpenGrade = true
end

-- 回放分享
function OB_GameMainCtrl:OnPlayBackShare()
end

-- 回放后退
function OB_GameMainCtrl:OnPlayBackHouTui()
	if GradeDetailCtrl.i < 3 then
		return
	end
	local self = OB_GameMainCtrl
	self.isPlayBackPlay = false
	self.isPlayBackPlayHouTui = true
	OB_GameMainPanel.huiFangPlayButton:SetActive(true)
	OB_GameMainPanel.huiFangZanTingButton:SetActive(false)
	GradeDetailCtrl.i = GradeDetailCtrl.i - 1
	local buzhouId = GradeDetailCtrl.playBackInfoList[GradeDetailCtrl.i].buzhouId
	local playBackType = GradeDetailCtrl.playBackInfoList[GradeDetailCtrl.i].type
	local data = GradeDetailCtrl.playBackInfoList[GradeDetailCtrl.i].data
	gameRoom.PlayBackHouTui(buzhouId, playBackType, data)
	local currentJinDu = GradeDetailCtrl.i / #GradeDetailCtrl.playBackInfoList
	OB_GameMainCtrl:SetProgress(OB_GameMainPanel.huiFangFillBar, currentJinDu)
end

-- 回放播放
function OB_GameMainCtrl:OnPlayBackPlay()
	local self = OB_GameMainCtrl
	OB_GameMainPanel.huiFangPlayButton:SetActive(false)
	OB_GameMainPanel.huiFangZanTingButton:SetActive(true)
	self.isPlayBackPlay = true
end

-- 回放暂停
function OB_GameMainCtrl:OnPlayBackZanTing()
	local self = OB_GameMainCtrl
	OB_GameMainPanel.huiFangPlayButton:SetActive(true)
	OB_GameMainPanel.huiFangZanTingButton:SetActive(false)
	self.isPlayBackPlay = false
end

-- 回放快进
function OB_GameMainCtrl:OnPlayBackKuaiJin()
	if GradeDetailCtrl.i > #GradeDetailCtrl.playBackInfoList then
		return
	end
	local self = OB_GameMainCtrl
	self.isPlayBackPlay = false
	OB_GameMainPanel.huiFangPlayButton:SetActive(true)
	OB_GameMainPanel.huiFangZanTingButton:SetActive(false)
	local buzhouId = GradeDetailCtrl.playBackInfoList[GradeDetailCtrl.i].buzhouId
	local playBackType = GradeDetailCtrl.playBackInfoList[GradeDetailCtrl.i].type
	local data = GradeDetailCtrl.playBackInfoList[GradeDetailCtrl.i].data
	gameRoom.PlayBack(buzhouId, playBackType, data)
	GradeDetailCtrl.i = GradeDetailCtrl.i + 1
	local currentJinDu = GradeDetailCtrl.i / #GradeDetailCtrl.playBackInfoList
	OB_GameMainCtrl:SetProgress(OB_GameMainPanel.huiFangFillBar, currentJinDu)
end

-- 比赛托管
function OB_GameMainCtrl.OnTuoGuakBtnClick(go)
	local vsTrusteeship = VsTrusteeship_pb.VsTrusteeshipReq()
	if self.isCanClick then
		vsTrusteeship.isTrusteeship = true
		-- 是否托管
		local msg = vsTrusteeship:SerializeToString()
		Game.SendProtocal(Protocal.VsTrusteeship, msg)
		self.isCanClick = false
	end
end

function OB_GameMainCtrl.OnQuXiaoTuoGuakBtnClick(go)
	local vsTrusteeship = VsTrusteeship_pb.VsTrusteeshipReq()
	-- if self.isCanClick then
	vsTrusteeship.isTrusteeship = false
	local msg = vsTrusteeship:SerializeToString()
	Game.SendProtocal(Protocal.VsTrusteeship, msg)
	-- self.isCanClick = false
	-- end
end

-- GPS面板
function OB_GameMainCtrl.OpenGps(go)
	print("---------OpenGps---------", Room.gpsList, MahjongRoom)
	GPSInfoCtrl:Open("GPSInfo", function()
		GPSInfoCtrl:InitPanel(Room.gpsList, MahjongRoom)
	end )
end


function OB_GameMainCtrl.OnbtnGouwucheBtnClick()
	Game.MusicEffect(Game.Effect.joinRoom)
	ShopMallCtrl:Open("ShopMall")
end

function OB_GameMainCtrl.OnShowGameSettingClick(go)
	OB_GameMainPanel.PanelGameSetting:SetActive(true)
	OB_GameMainPanel.btnSettingGame:SetActive(false)
	OB_GameMainPanel.btnHideUp:SetActive(true)
end

function OB_GameMainCtrl.OnHidePanelClick(go)
	OB_GameMainPanel.PanelGameSetting:SetActive(false)
	OB_GameMainPanel.btnHideUp:SetActive(false)
	OB_GameMainPanel.btnSettingGame:SetActive(true)
end

-- 发送退出房间消息
function OB_GameMainCtrl.OnQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	DissolutionRoomTipsCtrl:Open('DissolutionRoomTips')
end

-- 收到断线重连消息
function OB_GameMainCtrl.OfflinePush(msg)
	if not OB_GameMainPanel.isCreate then
		return
	end
	local roleId = msg.roleId
	-- 断线（重连）roleId
	local state = msg.state
	-- true=上线  false=离线
	local roleIndex = getRoleIndexById(roleId)
	local location = getOtherPlayerLocation(roleIndex)
	if location == 'D' then
		if OB_GameMainPanel.imgHeadDBreak then
			OB_GameMainPanel.imgHeadDBreak:SetActive(not state)
		end
	elseif location == 'R' then
		if OB_GameMainPanel.imgHeadRBreak then
			OB_GameMainPanel.imgHeadRBreak:SetActive(not state)
		end
	elseif location == 'L' then
		if OB_GameMainPanel.imgHeadLBreak then
			OB_GameMainPanel.imgHeadLBreak:SetActive(not state)
		end
	elseif location == 'U' then
		if OB_GameMainPanel.imgHeadUBreak then
			OB_GameMainPanel.imgHeadUBreak:SetActive(not state)
		end
	else
		logWarn('--------------------------->Reconnection location error')
	end
end

function OB_GameMainCtrl.OnInvitationWeChatBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	if (AppConst.getCurrentPlatform() == 'PC') then
		MessageTipsCtrl:ShowInfo("当前不能分享！ ")
		return
	end
	local currentPalyNum = #global.joinRoomUserVos
	local playNum = global.roomVo.isPlayNum - currentPalyNum
	local playNumText = ""
	if global.roomVo.isPlayNum == 4 then
		if playNum == 1 then
			playNumText = "3缺1"
		elseif playNum == 2 then
			playNumText = "2缺2"
		elseif playNum == 3 then
			playNumText = "1缺3"
		end
	elseif global.roomVo.isPlayNum == 3 then
		if playNum == 1 then
			playNumText = "2缺1"
		elseif playNum == 2 then
			playNumText = "1缺2"
		end
	end

	local shareContent = "房号:" .. tostring(global.roomVo.id) .. "," .. tostring(global.roomVo.total) .. "局," .. tostring(global.roomVo.isPlayNum) .. "人," .. tostring(global.roomVo.playMethod) .. ",速度来啊!【麻将】"
	local imageUrl = 'http://download.hzjiuyou.com/shareicon/tuidaohu.png'
	local title = "麻将-" .. tostring(global.roomVo.id) .. "，" .. tostring(playNumText)
	local downUrl = 'http://download.hzjiuyou.com/dl/hzdownload.htm'
	weChatFunction.weChatInviteFriendBtnClick(shareContent, imageUrl, title, downUrl)
end

function OB_GameMainCtrl.OnGameStartBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
end

-- 下一个索引位  par1:当前索引 par2:房间人数
function getNextIndex(curIndex, roomNum)
	local index = curIndex + 1
	if (index > roomNum) then
		index = 1
	end
	return index
end

-- 初始化UI信息 位置的显示
function OB_GameMainCtrl:InitPlayer()
	local self = OB_GameMainCtrl
	OB_GameMainPanel.btnHeadIconD:SetActive(true)
	OB_GameMainPanel.btnHeadIconR:SetActive(true)
	OB_GameMainPanel.btnHeadIconL:SetActive(true)

	if #global.joinRoomUserVos == 4 then
		OB_GameMainPanel.btnHeadIconU:SetActive(true)
		gameRoom.objLight:SetActive(false)
	else
		gameRoom.objLight:SetActive(true)
	end
	print("=======HeadAndjifenShow---1", #global.joinRoomUserVos)
	local joinRoomUseVos = global.joinRoomUserVos
	-- 本端的roleid
	local myRoleId = global.userVo.roleId
	roleInfoTable = { }
	roleInfoTable["R"] = { }
	roleInfoTable["L"] = { }
	roleInfoTable["U"] = { }
	roleInfoTable["D"] = { }
	local dri = nil
	-- 获取当前端的索引
	local myIndex = getRoleIndexById(myRoleId)
	for i, v in ipairs(joinRoomUseVos) do
		if v.index == 1 then
			dri = getOtherPlayerLocation(v.index)
			roleInfoTable[dri] = { v.index, v.roleId, v.jifen }
		elseif v.index == 2 then
			dri = getOtherPlayerLocation(v.index)
			roleInfoTable[dri] = { v.index, v.roleId, v.jifen }
		elseif v.index == 3 then
			dri = getOtherPlayerLocation(v.index)
			roleInfoTable[dri] = { v.index, v.roleId, v.jifen }
		elseif v.index == 4 then
			dri = getOtherPlayerLocation(v.index)
			roleInfoTable[dri] = { v.index, v.roleId, v.jifen }
		end
	end
	print("=======HeadAndjifenShow---2")
	roleInfoTable["R"][4] = OB_GameMainPanel.btnHeadIconR:GetComponent("Image").sprite
	roleInfoTable["L"][4] = OB_GameMainPanel.btnHeadIconL:GetComponent("Image").sprite
	roleInfoTable["D"][4] = OB_GameMainPanel.btnHeadIconD:GetComponent("Image").sprite
	if #joinRoomUseVos == 4 then
		roleInfoTable["U"][4] = OB_GameMainPanel.btnHeadIconU:GetComponent("Image").sprite
	end

	roleInfoTable["R"][5] = OB_GameMainPanel.txtScoreR
	roleInfoTable["L"][5] = OB_GameMainPanel.txtScoreL
	roleInfoTable["D"][5] = OB_GameMainPanel.txtScoreD
	if #joinRoomUseVos == 4 then
		roleInfoTable["U"][5] = OB_GameMainPanel.txtScoreU
	end

	roleInfoTable["R"][6] = OB_GameMainPanel.effect_touxiangR
	roleInfoTable["L"][6] = OB_GameMainPanel.effect_touxiangL
	roleInfoTable["D"][6] = OB_GameMainPanel.effect_touxiangD
	if #joinRoomUseVos == 4 then
		roleInfoTable["U"][6] = OB_GameMainPanel.effect_touxiangU
	end
	print("=======HeadAndjifenShow---3")
	global.roleInfoTable[1] = roleInfoTable["R"]
	global.roleInfoTable[2] = roleInfoTable["L"]
	global.roleInfoTable[4] = roleInfoTable["D"]
	if #joinRoomUseVos == 4 then
		global.roleInfoTable[3] = roleInfoTable["U"]
	end
	-- 面板所有信息初始化
	OB_GameMainPanel.btnInvitationWeChat:SetActive(false)
	OB_GameMainPanel.imgHeadL:SetActive(false)
	OB_GameMainPanel.imgHeadD:SetActive(false)
	OB_GameMainPanel.imgHeadR:SetActive(false)
	OB_GameMainPanel.imgHeadU:SetActive(false)
	OB_GameMainPanel.txtScoreL:SetActive(false)
	OB_GameMainPanel.txtScoreD:SetActive(false)
	OB_GameMainPanel.txtScoreR:SetActive(false)
	OB_GameMainPanel.txtScoreU:SetActive(false)
	OB_GameMainPanel.btnGameStart:SetActive(false)
	OB_GameMainPanel.imgJoinRoom:SetActive(false)

	OB_GameMainPanel.imgJinbiL:SetActive(false)
	OB_GameMainPanel.imgJinbiD:SetActive(false)
	OB_GameMainPanel.imgJinbiR:SetActive(false)
	OB_GameMainPanel.imgJinbiU:SetActive(false)
	OB_GameMainPanel.imgYuanbaoL:SetActive(false)
	OB_GameMainPanel.imgYuanbaoD:SetActive(false)
	OB_GameMainPanel.imgYuanbaoR:SetActive(false)
	OB_GameMainPanel.imgYuanbaoU:SetActive(false)


	for i, v in ipairs(global.joinRoomUserVos) do
		local position = getOtherPlayerLocation(v.index)
		local headObj = nil
		local num = 0
		if position == 'R' then
			OB_GameMainPanel.btnHeadIconR:SetActive(true)
			OB_GameMainPanel.imgHeadIconR.name = v.roleId
			print("麻将==人物==信息1", OB_GameMainPanel.imgHeadIconR.name, v.roleId)
			headObj = OB_GameMainPanel.btnHeadIconR
			local img = OB_GameMainPanel.btnHeadIconR
			if (AppConst.getCurrentPlatform() == "PC") then
				local url = "http://pic.qqtn.com/up/2017-4/2017041016062719079.jpg"
				weChatFunction.SetPic(img, v.roleId, url)
			else
				if GradeDetailCtrl.isPlayBackPlayEffect then
					local rightUrl = AppConst.getPlayerPrefs('rightUrl' .. tostring(v.roleId))
					weChatFunction.SetPic(img, v.roleId, rightUrl)
				else
					weChatFunction.SetPic(img, v.roleId, v.headImg)
					AppConst.setPlayerPrefs('rightUrl' .. tostring(v.roleId), v.headImg)
				end
			end
			num = 2
		elseif position == 'D' then
			OB_GameMainPanel.btnHeadIconD:SetActive(true)
			OB_GameMainPanel.imgHeadIconD.name = v.roleId
			print("麻将==人物==信息2", OB_GameMainPanel.imgHeadIconD.name, v.roleId)
			headObj = OB_GameMainPanel.btnHeadIconD
			local img = OB_GameMainPanel.btnHeadIconD
			if (AppConst.getCurrentPlatform() == "PC") then
				local url = "https://ps.ssl.qhimg.com/t01e9783b7417515cc0.jpg"
				weChatFunction.SetPic(img, v.roleId, url)
			else
				if GradeDetailCtrl.isPlayBackPlayEffect then
					local selfUrl = AppConst.getPlayerPrefs('selfUrl' .. tostring(v.roleId))
					weChatFunction.SetPic(img, v.roleId, selfUrl)
				else
					weChatFunction.SetPic(img, v.roleId, v.headImg)
					AppConst.setPlayerPrefs('selfUrl' .. tostring(v.roleId), v.headImg)
				end
			end
			num = 1
		elseif position == 'L' then
			OB_GameMainPanel.btnHeadIconL:SetActive(true)
			OB_GameMainPanel.imgHeadIconL.name = v.roleId
			print("麻将==人物==信息3", OB_GameMainPanel.imgHeadIconL.name, v.roleId)
			headObj = OB_GameMainPanel.btnHeadIconL
			local img = OB_GameMainPanel.btnHeadIconL
			if (AppConst.getCurrentPlatform() == "PC") then
				local url = ""
				weChatFunction.SetPic(img, v.roleId, url)
			else
				if GradeDetailCtrl.isPlayBackPlayEffect then
					local leftUrl = AppConst.getPlayerPrefs('leftUrl' .. tostring(v.roleId))
					weChatFunction.SetPic(img, v.roleId, leftUrl)
				else
					weChatFunction.SetPic(img, v.roleId, v.headImg)
					AppConst.setPlayerPrefs('leftUrl' .. tostring(v.roleId), v.headImg)
				end
			end
			num = 4
		elseif position == 'U' then
			OB_GameMainPanel.btnHeadIconU:SetActive(true)
			OB_GameMainPanel.imgHeadIconU.name = v.roleId
			print("麻将==人物==信息4", OB_GameMainPanel.imgHeadIconU.name, v.roleId)
			headObj = OB_GameMainPanel.btnHeadIconU
			local img = OB_GameMainPanel.btnHeadIconU
			if (AppConst.getCurrentPlatform() == "PC") then
				local url = "http://pic.qqtn.com/up/2017-5/2017052714205462228.jpg"
				weChatFunction.SetPic(img, v.roleId, url)
			else
				if GradeDetailCtrl.isPlayBackPlayEffect then
					local upUrl = AppConst.getPlayerPrefs('upUrl' .. tostring(v.roleId))
					weChatFunction.SetPic(img, v.roleId, upUrl)
				else
					weChatFunction.SetPic(img, v.roleId, v.headImg)
					AppConst.setPlayerPrefs('upUrl' .. tostring(v.roleId), v.headImg)
				end
			end
			num = 3
		end
		local playerObj = {
			id = tostring(v.roleId),
			ip = v.ip,
			name = v.name,
			index = v.index,
			imgHead = headObj,
			sitIndex = num
		}
		table.insert(MahjongRoom.players, playerObj)
	end

	-- 房间总人数列表
	local joinRoomUseVos = global.joinRoomUserVos
	print("====global.joinRoomUseVos==", #global.joinRoomUserVos)

	local roomNum = getLength(joinRoomUseVos)
	-- 本端的roleid
	local myRoleId = global.userVo.roleId
	-- 获取当前端的索引
	local myIndex = getRoleIndexById(myRoleId)
	if myIndex == 1 then
		global.setPosition = joinRoomUseVos
		-- 	OB_GameMainPanel.imgOKD:SetActive(true)
		OB_GameMainPanel.imgHeadD:SetActive(true)
		OB_GameMainPanel.txtScoreD:SetActive(true)
		OB_GameMainPanel.txtScoreD.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)


		-- 	OB_GameMainPanel.btnQuitRoom:SetActive(false)
		-- 申请苹果审核
		if IS_APP_STORE_CHECK or LoginCtrl.loginTypes == 2 then
			OB_GameMainPanel.btnInvitationWeChat:SetActive(false)
		else
			OB_GameMainPanel.btnInvitationWeChat:SetActive(true)
		end
		if global.roomVo.moneyType == RoomMode.goldMode then
			OB_GameMainPanel.imgJinbiD:SetActive(true)
			self:SetText(OB_GameMainPanel.txtScoreD, formatNumber(global.userVo.goldcoin))
			OB_GameMainPanel.btnInvitationWeChat:SetActive(false)
		elseif global.roomVo.moneyType == RoomMode.wingMode then
			OB_GameMainPanel.imgYuanbaoD:SetActive(true)
			print(OB_GameMainPanel.txtScoreD.name, "===============快乐撒娇地块======================", formatNumber(global.userVo.wing))
			self:SetText(OB_GameMainPanel.txtScoreD, formatNumber(global.userVo.wing))
			OB_GameMainPanel.btnInvitationWeChat:SetActive(false)
		end
		-- OB_GameMainPanel.imgHeadD.name = myRoleId
	end

	for i, v in ipairs(global.setPosition) do
		local position = getOtherPlayerLocation(v.index)
		if position == 'R' then
			-- 		OB_GameMainPanel.imgOKR:SetActive(true)
			OB_GameMainPanel.imgHeadR:SetActive(true)
			OB_GameMainPanel.txtScoreR:SetActive(true)
			OB_GameMainPanel.txtScoreR.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)

			if global.roomVo.moneyType == RoomMode.goldMode then
				OB_GameMainPanel.imgJinbiR:SetActive(true)
				self:SetText(OB_GameMainPanel.txtScoreR, formatNumber(v.goldcoin))
			elseif global.roomVo.moneyType == RoomMode.wingMode then
				OB_GameMainPanel.imgYuanbaoR:SetActive(true)
				self:SetText(OB_GameMainPanel.txtScoreR, formatNumber(v.wing))
			end

			-- 		OB_GameMainPanel.btnQuitRoom:SetActive(false)
			-- 		OB_GameMainPanel.imgHeadR.name = v.roleId
			local img = OB_GameMainPanel.btnHeadIconR
			if (AppConst.getCurrentPlatform() == "PC") then
				local url = "http://pic.qqtn.com/up/2017-4/2017041016062719079.jpg"
				weChatFunction.SetPic(img, v.roleId, url)
			else
				weChatFunction.SetPic(img, v.roleId, v.headImg)
			end
			-- 		self:JoinRoomShow(v.name)
		elseif position == 'D' then
			-- 		OB_GameMainPanel.imgOKD:SetActive(true)
			OB_GameMainPanel.imgHeadD:SetActive(true)
			OB_GameMainPanel.txtScoreD:SetActive(true)
			OB_GameMainPanel.txtScoreD.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)

			if global.roomVo.moneyType == RoomMode.goldMode then
				OB_GameMainPanel.imgJinbiD:SetActive(true)
				self:SetText(OB_GameMainPanel.txtScoreD, formatNumber(v.goldcoin))
			elseif global.roomVo.moneyType == RoomMode.wingMode then
				OB_GameMainPanel.imgYuanbaoD:SetActive(true)
				self:SetText(OB_GameMainPanel.txtScoreD, formatNumber(v.wing))
			end

			-- 		OB_GameMainPanel.btnQuitRoom:SetActive(false)
			-- 		OB_GameMainPanel.imgHeadD.name = v.roleId
			local img = OB_GameMainPanel.btnHeadIconD
			if (AppConst.getCurrentPlatform() == "PC") then
				local url = "https://ps.ssl.qhimg.com/t01e9783b7417515cc0.jpg"
				weChatFunction.SetPic(img, v.roleId, url)
			else
				weChatFunction.SetPic(img, v.roleId, v.headImg)
			end
			-- 		self:JoinRoomShow(v.name)
		elseif position == 'L' then
			-- 		OB_GameMainPanel.imgOKL:SetActive(true)
			OB_GameMainPanel.imgHeadL:SetActive(true)
			OB_GameMainPanel.txtScoreL:SetActive(true)
			OB_GameMainPanel.txtScoreL.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)

			if global.roomVo.moneyType == RoomMode.goldMode then
				OB_GameMainPanel.imgJinbiL:SetActive(true)
				self:SetText(OB_GameMainPanel.txtScoreL, formatNumber(v.goldcoin))
			elseif global.roomVo.moneyType == RoomMode.wingMode then
				OB_GameMainPanel.imgYuanbaoL:SetActive(true)
				self:SetText(OB_GameMainPanel.txtScoreL, formatNumber(v.wing))
			end

			-- 		OB_GameMainPanel.btnQuitRoom:SetActive(false)
			local img = OB_GameMainPanel.btnHeadIconL
			-- 		OB_GameMainPanel.imgHeadL.name = v.roleId
			if (AppConst.getCurrentPlatform() == "PC") then
				local url = "http://diy.qqjay.com/u2/2014/1012/4204849e421dfea8b1af148f0dce4bfe.jpg"
				weChatFunction.SetPic(img, v.roleId, url)
			else
				weChatFunction.SetPic(img, v.roleId, v.headImg)
			end
			-- 		self:JoinRoomShow(v.name)
		elseif position == 'U' then
			-- 		OB_GameMainPanel.imgOKU:SetActive(true)
			OB_GameMainPanel.imgHeadU:SetActive(true)
			OB_GameMainPanel.txtScoreU:SetActive(true)
			OB_GameMainPanel.txtScoreU.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)

			if global.roomVo.moneyType == RoomMode.goldMode then
				OB_GameMainPanel.imgJinbiU:SetActive(true)
				self:SetText(OB_GameMainPanel.txtScoreU, formatNumber(v.goldcoin))
			elseif global.roomVo.moneyType == RoomMode.wingMode then
				OB_GameMainPanel.imgYuanbaoU:SetActive(true)
				self:SetText(OB_GameMainPanel.txtScoreU, formatNumber(v.wing))
			end

			-- 		OB_GameMainPanel.imgHeadU.name = v.roleId
			local img = OB_GameMainPanel.btnHeadIconU
			if (AppConst.getCurrentPlatform() == "PC") then
				local url = "http://pic.qqtn.com/up/2017-5/2017052714205462228.jpg"
				weChatFunction.SetPic(img, v.roleId, url)
			else
				weChatFunction.SetPic(img, v.roleId, v.headImg)
			end
			-- 		self:JoinRoomShow(v.name)
		end
		if GameRoom.resCount == GameRoom.needResCount then
			OB_GameMainCtrl.SetTableText()
		end
	end
end

-- 东南西北 1234
function OB_GameMainCtrl:DNXB(myId)
	if global.roomVo.isPlayNum == 3 then
		gameRoom.objSanren:SetActive(true)
	else
		local index = getRoleIndexById(myId)
		-- print("myIndex ==============", index)
		if index == 1 then
			gameRoom.objDNXB.transform.rotation =
			Quaternion.Euler(Vector3.New(90, 0, -90))
			gameRoom.objDNXB.transform.localScale = Vector3.New(200, 310, 1)
		elseif index == 2 then
			gameRoom.objDNXB.transform.rotation =
			Quaternion.Euler(Vector3.New(90, 0, 180))
			gameRoom.objDNXB.transform.localScale = Vector3.New(310, 200, 1)
		elseif index == 3 then
			gameRoom.objDNXB.transform.rotation =
			Quaternion.Euler(Vector3.New(90, 0, 90))
			gameRoom.objDNXB.transform.localScale = Vector3.New(200, 310, 1)
		elseif index == 4 then
			gameRoom.objDNXB.transform.rotation =
			Quaternion.Euler(Vector3.New(90, 0, 0))
			gameRoom.objDNXB.transform.localScale = Vector3.New(310, 200, 1)
		end
	end
end

---- 加入房间显示
-- function OB_GameMainCtrl:JoinRoomShow(name)
-- -- self = OB_GameMainPanel
-- -- local clipName = GradeCtrl:GetShortName(name)
-- -- curObj = OB_GameMainPanel.imgJoinRoom
-- -- OB_GameMainPanel.imgJoinRoom:SetActive(true)
-- -- self:SetText(OB_GameMainPanel.playerName,clipName)
-- -- coroutine.start(OB_GameMainPanel.WaitClose)
-- end

function OB_GameMainCtrl.SetTableText()
	local self = OB_GameMainCtrl
	local txt = tostring(global.roomVo.playMethod)
	local objtxtRoomNum = gameRoom.objtxtRoomNum
	local objtxtMethod = gameRoom.objtxtMethod
	if objtxtRoomNum ~= nil and objtxtMethod ~= nil then
		self:SetText(objtxtMethod, txt)
		self:SetText(objtxtRoomNum, global.roomVo.id)
	end
end

function OB_GameMainCtrl.WaitClose()
	coroutine.wait(2)
	curObj:SetActive(false)
end
