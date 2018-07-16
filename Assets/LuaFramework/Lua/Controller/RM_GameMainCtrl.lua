RM_GameMainCtrl = { }
setbaseclass(RM_GameMainCtrl, { BaseCtrl })

local currentEffect

local currentTime
local dateTime = 0
local netTime = 5
local eulerR = nil
local eulerL = nil
local eulerD = nil
local timeCountDown = nil
local roleInfoTable = { }
local this = RM_GameMainCtrl

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
function RM_GameMainCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	print("====OnCreate=====joinRoomUserVos", #global.joinRoomUserVos)
	self:AddClick(RM_GameMainPanel.btnQuit, self.OnQuitBtnClick)
	-- self:AddClick(RM_GameMainPanel.btnSetSystem, self.OnSetSystemBtnClick)
	self:AddClick(RM_GameMainPanel.btnChat, self.OnChatBtnClick)
	self:AddClick(RM_GameMainPanel.btnPeng, self.OnPengBtnClick)
	self:AddClick(RM_GameMainPanel.btnGang, self.OnGangBtnClick)
	self:AddClick(RM_GameMainPanel.btnHu, self.OnHuBtnClick)
	self:AddClick(RM_GameMainPanel.btnGuo, self.OnGuoBtnClick)
	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(RM_GameMainPanel.imgHeadIconD, self.OnClickHead)
	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(RM_GameMainPanel.imgHeadIconR, self.OnClickHead)
	self:AddClick(RM_GameMainPanel.imgHeadIconU, self.OnClickHead)
	self:AddClick(RM_GameMainPanel.imgHeadIconL, self.OnClickHead)

	self:AddClick(RM_GameMainPanel.btnMask, self.OnCloseHead)
	self:AddClick(RM_GameMainPanel.btnE1, self.OnSendFaceAnim)
	self:AddClick(RM_GameMainPanel.btnE2, self.OnSendFaceAnim)
	self:AddClick(RM_GameMainPanel.btnE3, self.OnSendFaceAnim)
	self:AddClick(RM_GameMainPanel.btnE4, self.OnSendFaceAnim)
	self:AddClick(RM_GameMainPanel.btnE5, self.OnSendFaceAnim)

	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(RM_GameMainPanel.btnSendCode, self.SendDeBugCode)
	self:AddClick(RM_GameMainPanel.imgTingPaiTipsBGImage, self.CloseImgTingPaiTipsBGImage)
	self:AddClick(RM_GameMainPanel.btnTingPai, self.OnTingPaiBtnClick)

	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(RM_GameMainPanel.btnQuitTipsYes, self.OnQuitGameYse)
	self:AddClick(RM_GameMainPanel.btnQuitTipsNo, self.OnQuitGameNo)
	self:AddClick(RM_GameMainPanel.btnGPS, self.OpenGps)

	print("====OnCreate=====joinRoomUserVos")
	-- 用于回放操作
	self:AddClick(RM_GameMainPanel.huiFangQuitButton, self.OnPlayBackQuit)
	self:AddClick(RM_GameMainPanel.huiFangShareButton, self.OnPlayBackShare)
	self:AddClick(RM_GameMainPanel.huiFangHouTuiButton, self.OnPlayBackHouTui)
	self:AddClick(RM_GameMainPanel.huiFangPlayButton, self.OnPlayBackPlay)
	self:AddClick(RM_GameMainPanel.huiFangZanTingButton, self.OnPlayBackZanTing)
	self:AddClick(RM_GameMainPanel.huiFangKuaiJinButton, self.OnPlayBackKuaiJin)
	-- 比赛场
	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(RM_GameMainPanel.btnTuoGuan, self.OnTuoGuakBtnClick)
	self:AddClick(RM_GameMainPanel.btnQuXiaoTuoGuan, self.OnQuXiaoTuoGuakBtnClick)
	-- 新添加
	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(RM_GameMainPanel.btnGouwuche, self.OnbtnGouwucheBtnClick)

	print("====OnCreate=====joinRoomUserVos")
	self:AddClick(RM_GameMainPanel.btnMask, self.OnHidePanelClick)
	self:AddClickNoChange(RM_GameMainPanel.QuitHideButton, self.OnHidePanelClick)
	self:AddClickNoChange(RM_GameMainPanel.btnHideUp, self.OnHidePanelClick)
	self:AddClick(RM_GameMainPanel.btnSettingGame, self.OnShowGameSettingClick)
	self:AddClick(RM_GameMainPanel.btnSettingSystem, self.OnSetSystemBtnClick)
	self:AddClick(RM_GameMainPanel.btnWaitQuitRoom, self.OnQuitBtnClick)
	self:AddClick(RM_GameMainPanel.btnInvitationWeChat, self.OnInvitationWeChatBtnClick)
	self:AddClick(RM_GameMainPanel.btnGameStart, self.OnHeadDClick)
	print("====OnCreate=====joinRoomUserVos")

	self:InitPanel()
	enable = false
	objTableMask = nil
end

-- 初始化面板--
function RM_GameMainCtrl:InitPanel()
	-- 广电
	print("<color=#F0FF0000>-------RM_GameMainCtrl:InitPanel()-------</color>")
	Game.MusicBG("bgm4")

	RM_GameMainPanel.txtScoreD.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)
	RM_GameMainPanel.txtScoreR.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)
	RM_GameMainPanel.txtScoreU.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)
	RM_GameMainPanel.txtScoreL.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)
	RoleInfoCtrl.OnQuitBtnClick()
	global.systemVo.BGSource.volume = 0.2
	RM_GameMainPanel.imgChatD:SetActive(false)
	RM_GameMainPanel.imgChatU:SetActive(false)
	RM_GameMainPanel.imgChatL:SetActive(false)
	RM_GameMainPanel.imgChatR:SetActive(false)
	RM_GameMainPanel.imgFaceIconBGL:SetActive(false)
	RM_GameMainPanel.imgFaceIconBGR:SetActive(false)
	RM_GameMainPanel.imgFaceIconBGD:SetActive(false)
	RM_GameMainPanel.imgFaceIconBGU:SetActive(false)
	RM_GameMainPanel.btnQuit:SetActive(false)
	gameRoom.DClose:SetActive(false)
	gameRoom.txtCountDown:SetActive(false)
	RM_GameMainPanel.imgTingPaiTipsBGImage:SetActive(false)
	RM_GameMainPanel.inputSendCode:SetActive(false)
	RM_GameMainPanel.btnSendCode:SetActive(false)
	RM_GameMainPanel.imgReadyL:SetActive(false)
	RM_GameMainPanel.imgReadyD:SetActive(false)
	RM_GameMainPanel.imgReadyU:SetActive(false)
	RM_GameMainPanel.imgReadyR:SetActive(false)
	RM_GameMainPanel.imgPengGangHuBG:SetActive(false)
	gameRoom.DDong:SetActive(false)
	gameRoom.DXi:SetActive(false)
	gameRoom.DNan:SetActive(false)
	gameRoom.DBei:SetActive(false)
	gameRoom.DOpen:SetActive(false)
	RM_GameMainPanel.imgTips:SetActive(false)
	RM_GameMainPanel.imgHuangZhuang:SetActive(false)
	RM_GameMainPanel.imgLouHu:SetActive(false)
	RM_GameMainPanel.imgHeadLBreak:SetActive(false)
	RM_GameMainPanel.imgHeadRBreak:SetActive(false)
	RM_GameMainPanel.imgHeadUBreak:SetActive(false)
	RM_GameMainPanel.imgHeadDBreak:SetActive(false)
	RM_GameMainPanel.btnTingPai:SetActive(false)
	RM_GameMainPanel.imgGenZhuang:SetActive(false)
	RM_GameMainPanel.imgAnimL:SetActive(false)
	RM_GameMainPanel.imgAnimR:SetActive(false)
	RM_GameMainPanel.imgAnimD:SetActive(false)
	RM_GameMainPanel.imgAnimU:SetActive(false)

	RM_GameMainPanel.imgFangzhuD:SetActive(false)
	RM_GameMainPanel.imgFangzhuR:SetActive(false)
	RM_GameMainPanel.imgFangzhuU:SetActive(false)
	RM_GameMainPanel.imgFangzhuL:SetActive(false)

	RM_GameMainPanel.imgZhuangjiaD:SetActive(false)
	RM_GameMainPanel.imgZhuangjiaR:SetActive(false)
	RM_GameMainPanel.imgZhuangjiaU:SetActive(false)
	RM_GameMainPanel.imgZhuangjiaL:SetActive(false)

	RM_GameMainPanel.imgQuitTips:SetActive(false)
	RM_GameMainPanel.btnGPS:SetActive(false)
	RM_GameMainPanel.btnQuit.transform:SetAsLastSibling()
	RM_GameMainPanel.imgQuitTips.transform:SetAsLastSibling()

	if #global.joinRoomUserVos == 3 then
		RM_GameMainPanel.objHeadU:SetActive(false)
	end

	if global.roomVo.isPlayNum ~= 3 then
		gameRoom.objLight:SetActive(false)
		gameRoom.objSanren:SetActive(false)
	end
	RM_GameMainPanel.imgGameStart:SetActive(false)
	-- 回放操作界面
	RM_GameMainPanel.imgPlayBackBGImage:SetActive(false)
	if GradeDetailCtrl.isPlayBackOperate then
		RM_GameMainPanel.imgPlayBackBGImage:SetActive(true)
		RM_GameMainPanel.huiFangPlayButton:SetActive(false)
		RM_GameMainPanel.huiFangZanTingButton:SetActive(true)
		RM_GameMainPanel.btnQuit:SetActive(false)
		RM_GameMainPanel.btnChat:SetActive(false)
		RM_GameMainPanel.btnTalk:SetActive(false)
		self.isPlayBackPlay = true
		GradeDetailCtrl.isPlayBackOperate = false
	end

	EffectList[2][1] = RM_GameMainPanel.effect_touxiangL
	EffectList[2][2] = RM_GameMainPanel.effect_touxiangD
	EffectList[2][3] = RM_GameMainPanel.effect_touxiangR
	EffectList[2][4] = RM_GameMainPanel.effect_touxiangU
	EffectList[1][1] = RM_GameMainPanel.effect_pengyan
	EffectList[1][2] = RM_GameMainPanel.effect_duoxiang

	for i = 1, #EffectList do
		for j = 1, #EffectList[i] do
			EffectList[i][j]:SetActive(false)
		end
	end
	RM_GameMainCtrl.HideTableEffect()
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
				RM_GameMainPanel.imgFangzhuD:SetActive(false)
				RM_GameMainPanel.imgFangzhuR:SetActive(false)
				RM_GameMainPanel.imgFangzhuL:SetActive(false)
				RM_GameMainPanel.imgFangzhuU:SetActive(false)
			elseif global.roomVo.moneyType == RoomMode.wingMode then
				RM_GameMainPanel.imgFangzhuD:SetActive(false)
				RM_GameMainPanel.imgFangzhuR:SetActive(false)
				RM_GameMainPanel.imgFangzhuL:SetActive(false)
				RM_GameMainPanel.imgFangzhuU:SetActive(false)
			else
				local location = getOtherPlayerLocation(v.index)
				if location == "D" then
					RM_GameMainPanel.imgFangzhuD:SetActive(true)
				elseif location == "R" then
					RM_GameMainPanel.imgFangzhuR:SetActive(true)
				elseif location == "L" then
					RM_GameMainPanel.imgFangzhuL:SetActive(true)
				elseif location == "U" then
					RM_GameMainPanel.imgFangzhuU:SetActive(true)
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
	self:SetText(RM_GameMainPanel.txtTime, AppConst.GetDate())

	-- 比赛场操作界面
	RM_GameMainPanel.btnTuoGuan:SetActive(false)
	RM_GameMainPanel.imgPaiXingBG:SetActive(false)
	RM_GameMainPanel.imgMatchLunCountBG:SetActive(false)
	RM_GameMainPanel.imgTuoGuanBG:SetActive(false)
	gameRoom.objtxtRoomNum:SetActive(true)
	gameRoom.objtxtTitle.transform:GetComponent("Text").color = Color.New(0.14, 0.29, 0.36, 1)
	-- self:SetText(RM_GameMainPanel.txtJuShu,"局数"..gameRoom.curJushu..'/'..global.roomVo.total)
	if global.roomVo.isFangzhu == 3 or global.roomVo.vsRoomNum ~= 0 then
		self.isCanClick = true
		RM_GameMainPanel.btnQuit:SetActive(false)
		RM_GameMainPanel.btnTalk:SetActive(false)
		gameRoom.objtxtRoomNum:SetActive(false)
		gameRoom.objtxtTitle.transform:GetComponent("Text").color = Color.New(0.14, 0.29, 0.36, 0)
		RM_GameMainPanel.imgPaiXingBG:SetActive(true)
		RM_GameMainPanel.imgMatchLunCountBG:SetActive(true)
		if gameRoom.curJushu > 2 then
			gameRoom.curJushu = 1
			-- self:SetText(RM_GameMainPanel.txtJuShu,"局数"..gameRoom.curJushu..'/'..global.roomVo.total)
		end
		for i, v in ipairs(global.joinRoomUserVos) do
			if v.index == 1 then
				local location = getOtherPlayerLocation(v.index)
				if location == "D" then
					RM_GameMainPanel.imgFangzhuD:SetActive(false)
				elseif location == "R" then
					RM_GameMainPanel.imgFangzhuR:SetActive(false)
				elseif location == "L" then
					RM_GameMainPanel.imgFangzhuL:SetActive(false)
				elseif location == "U" then
					RM_GameMainPanel.imgFangzhuU:SetActive(false)
				end
			end
			if global.userVo.roleId == v.roleId then
				self:SetText(RM_GameMainPanel.txtPaiXingMingCi, '第' .. v.curPaiMing .. '名')
			end
			if v.isTrusteeship then
				RM_GameMainPanel.btnTuoGuan:SetActive(false)
				RM_GameMainPanel.imgTuoGuanBG:SetActive(true)
			end
		end
		self:SetText(RM_GameMainPanel.txtCurrentLunInfo, global.roomVo.vscount .. '人快速赛    ' .. '第' .. global.roomVo.lun .. '轮')
	end

	-- 新添加
	RM_GameMainPanel.imgSignalBG.transform.localPosition = Vector3.New(-440, 326, 0)
	RM_GameMainPanel.imgSurplusCards.transform.localPosition = Vector3.New(-340, 326, 0)
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
		RM_GameMainPanel.imgSignalBG.transform.localPosition = Vector3.New(-565, 326, 0)
		RM_GameMainPanel.imgSurplusCards.transform.localPosition = Vector3.New(-465, 326, 0)
		self:SetText(gameRoom.objtxtDiZhuAndJinrutiaojian, textBasenum .. "\n" .. textQualified)
	elseif global.roomVo.moneyType == RoomMode.wingMode then
		gameRoom.objtxtTuoguan:SetActive(true)
		gameRoom.objtxtDiZhuAndJinrutiaojian:SetActive(true)
		gameRoom.objtxtRoomNum:SetActive(false)
		gameRoom.objtxtTitle:SetActive(false)
		RM_GameMainPanel.imgSignalBG.transform.localPosition = Vector3.New(-565, 326, 0)
		RM_GameMainPanel.imgSurplusCards.transform.localPosition = Vector3.New(-465, 326, 0)
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
			self:SetText(RM_GameMainPanel.txtRoomNum, "金币" .. Ronda)
			self:SetText(RM_GameMainPanel.txtWanFa, "人数：4人局" .. "\n" .. "玩法：点炮胡" .. "\n" .. "特殊：无风牌" .. "\n" .. "鱼子：不下鱼")
			self:SetText(RM_GameMainPanel.txtJuShu, '底分：' .. tostring(global.roomVo.baseNum))
		elseif global.roomVo.moneyType == RoomMode.wingMode then
			self:SetText(RM_GameMainPanel.txtRoomNum, "元宝" .. Ronda)
			self:SetText(RM_GameMainPanel.txtWanFa, "人数：4人局" .. "\n" .. "玩法：点炮胡" .. "\n" .. "特殊：无风牌" .. "\n" .. "鱼子：不下鱼")
			self:SetText(RM_GameMainPanel.txtJuShu, '底分：' .. tostring(global.roomVo.baseNum))
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

			self:SetText(RM_GameMainPanel.txtRoomNum, "房号：" .. tostring(global.roomVo.id))
			self:SetText(RM_GameMainPanel.txtWanFa, "人数：" .. tostring(global.roomVo.isPlayNum) .. "人局" .. "\n" .. "玩法：" .. text1 .. "\n" .. "特殊：" .. text2 .. "\n" .. text3 .. "\n" .. "鱼子：" .. text4)
			self:SetText(RM_GameMainPanel.txtJuShu, '局数：' .. gameRoom.curJushu .. "/" .. global.roomVo.total)
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
			self:SetText(RM_GameMainPanel.txtRoomNum, "金币" .. Ronda)
			self:SetText(RM_GameMainPanel.txtWanFa, "人数：4人局" .. "\n" .. "玩法：自摸胡" .. "\n" .. "特殊：无风牌" .. "\n" .. "鱼子：不下鱼")
			self:SetText(RM_GameMainPanel.txtJuShu, '底分：' .. tostring(global.roomVo.baseNum))
		elseif global.roomVo.moneyType == RoomMode.wingMode then
			self:SetText(RM_GameMainPanel.txtRoomNum, "元宝" .. Ronda)
			self:SetText(RM_GameMainPanel.txtWanFa, "人数：4人局" .. "\n" .. "玩法：自摸胡" .. "\n" .. "特殊：无风牌" .. "\n" .. "鱼子：不下鱼")
			self:SetText(RM_GameMainPanel.txtJuShu, '底分：' .. tostring(global.roomVo.baseNum))
		else
			self:SetText(RM_GameMainPanel.txtRoomNum, "房号：" .. tostring(global.roomVo.id))
			self:SetText(RM_GameMainPanel.txtWanFa, "人数：" .. tostring(global.roomVo.isPlayNum) .. "人局" .. "\n" .. "玩法：自摸胡" .. "\n" .. "特殊：无风牌" .. "\n" .. "模式：" .. text4)
			self:SetText(RM_GameMainPanel.txtJuShu, '局数：' .. gameRoom.curJushu .. "/" .. global.roomVo.total)
		end
	end
end

function RM_GameMainCtrl:ChangeQuitState()
	if global.roomVo.moneyType == RoomMode.roomCardMode then

	else
		if Room.isStar then
			RM_GameMainPanel.PanelGameSetting:SetActive(false)
			RM_GameMainPanel.btnWaitQuitRoom:SetActive(true)
			RM_GameMainPanel.imgNotWaitQuitRoom:SetActive(false)
			RM_GameMainPanel.imgNotGameMainQuitRoom:SetActive(true)
		else
			RM_GameMainPanel.PanelGameSetting:SetActive(false)
			RM_GameMainPanel.btnWaitQuitRoom:SetActive(true)
			RM_GameMainPanel.imgNotWaitQuitRoom:SetActive(false)
			RM_GameMainPanel.imgNotGameMainQuitRoom:SetActive(true)
		end
	end
end

-- 申请解散房间--
function RM_GameMainCtrl.OnQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = RM_GameMainCtrl
	RM_GameMainPanel.imgQuitTips:SetActive(true)
	if gameRoom.isOnes then
		self:SetText(RM_GameMainPanel.txtQuitTips, "解散房间不扣房卡，是否确定解散？")
	else
		self:SetText(RM_GameMainPanel.txtQuitTips, "是否确认解散房间")
	end
end

function RM_GameMainCtrl.CloseImgTingPaiTipsBGImage(go)
	RM_GameMainPanel.imgTingPaiTipsBGImage:SetActive(false)
end

-- 设置按钮
function RM_GameMainCtrl.OnSetSystemBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	SetSystemCtrl:GetInfo(global.userVo.name, global.userVo.roleId, global.userVo.roleIp,
	RM_GameMainPanel.btnHeadIconD)
	SetSystemCtrl:Open('SetSystem')
end

-- 语音按钮
function RM_GameMainCtrl.OnChatBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	GameChatCtrl:Open('GameChat')
end

-- 游戏开始--
function RM_GameMainCtrl.GameStart()
	local self = RM_GameMainCtrl
	this.CountDown(false)
	-- Game.MusicBG("bgm4")
	gameRoom.DClose:SetActive(false)

	RM_GameMainCtrl:Close()
	RM_GameMainCtrl:Open("GameMain", function()
		GameRoom.gameObjCardContainer:SetActive(true)
		self:SetText(GameRoom.objtxtTuoguan, "玩家15秒未操作，将自动进入托管状态")
	end )
end

-- 数字显示
function RM_GameMainCtrl.ShowCount()
	self = RM_GameMainCtrl
	self:InvokeRepeat("CardTime", 0.1, 300000000)
end

-- 表情窗左--
function RM_GameMainCtrl.FaceIconBGL(isShow)
	RM_GameMainPanel.imgFaceIconBGL:SetActive(isShow)
	coroutine.start(this.HideImgFaceIconBGL)
end

-- 表情窗右--
function RM_GameMainCtrl.FaceIconBGR(isShow)
	RM_GameMainPanel.imgFaceIconBGR:SetActive(isShow)
	coroutine.start(this.HideImgFaceIconBGR)
end

-- 表情窗上--
function RM_GameMainCtrl.FaceIconBGU(isShow)
	RM_GameMainPanel.imgFaceIconBGU:SetActive(isShow)
	coroutine.start(this.HideImgFaceIconBGU)
end

-- 表情窗下--
function RM_GameMainCtrl.FaceIconBGD(isShow)
	RM_GameMainPanel.imgFaceIconBGD:SetActive(isShow)
	coroutine.start(this.HideImgFaceIconBGD)
end

-- 停牌提示--
function RM_GameMainCtrl.TingPaiTipsBG(isShow)
	RM_GameMainPanel.imgGameStart:SetActive(isShow)
end

-- 碰杠胡提示--
function RM_GameMainCtrl.PengGangHuBG(isShow)
	RM_GameMainPanel.imgPengGangHuBG:SetActive(isShow)
	local peng = RM_GameMainPanel:FindChild('btnPeng')
	local gang = RM_GameMainPanel:FindChild('btnGang')
	local hu = RM_GameMainPanel:FindChild('btnHu')
	local guo = RM_GameMainPanel:FindChild('btnGuo')
end

-- 打牌标记
function RM_GameMainCtrl.CardDirection(pos)
	local cardDirection = RM_GameMainPanel.imgPlayCardDirection
	cardDirection:SetActive(true)
	cardDirection.transform.position = pos
	cardDirection.transform.position = Vector3.New(pos.x, -7.8, pos.z)
end

-- 特效管理--
function RM_GameMainCtrl.EffectMgr(effectName, pos)
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
function RM_GameMainCtrl.effect()
	coroutine.wait(2)
	if GradeDetailCtrl.isPlayBackPlayEffect then
	else
		if not RM_GameMainCtrl.isCreate then return end
		currentEffect:SetActive(false)
	end
end

-- 出牌时间--
function RM_GameMainCtrl.CountDown(isShow)
	gameRoom.txtCountDown:SetActive(isShow)
	enable = isShow
	if enable then
		currentTime = 10
	end
end

-- 发送作弊码--
function RM_GameMainCtrl.InputSendCode(isShow)
	RM_GameMainPanel.inputSendCode:SetActive(isShow)
	RM_GameMainPanel.btnSendCode:SetActive(isShow)
end

-- 显示剩多少张牌
function RM_GameMainCtrl.SurplusCardNum(msg)
	self = RM_GameMainCtrl
	self:SetText(RM_GameMainPanel.txtSurplusNum, msg)
end

local c
local isAdd = false
local anum = 1
local t1 = 0
local t2 = 0
-- 语音及音效--
-- 系统设置音乐按钮只控制背景音乐，所有别的声音都用音效按钮控制
function RM_GameMainCtrl.FaceIcon()
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

function RM_GameMainCtrl.CardTime()
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
				RM_GameMainCtrl.ColorChange(objTableMask, anum)
				RM_GameMainCtrl.ColorChange(gameRoom.objLight, anum)
				if anum < 0.5 then
					isAdd = true
				end
			else
				anum = anum + 0.1
				if objTableMask == nil then
				else
					RM_GameMainCtrl.ColorChange(objTableMask, anum)
					RM_GameMainCtrl.ColorChange(gameRoom.objLight, anum)
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
			RM_GameMainCtrl.ColorChange(objTableMask, anum)
			RM_GameMainCtrl.ColorChange(RM_GameMainPanel.objLight, anum)
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
		local self = RM_GameMainCtrl
		if RM_GameMainPanel.txtTime ~= nil then
			self:SetText(RM_GameMainPanel.txtTime, AppConst.GetDate())
		end
		dateTime = 10
	end
	-- 网络信号获取间隔
	netTime = netTime - 0.1
	if netTime < 0 then
		local self = RM_GameMainCtrl
		self:NetWork()
		netTime = 5
	end
	this.FaceIcon()
end

-- 网络信号
function RM_GameMainCtrl:NetWork()
	local level = network_delay
	if level > 0 and level < 50 then
		RM_GameMainPanel.imgSignal2:SetActive(true)
		RM_GameMainPanel.imgSignal3:SetActive(true)
		RM_GameMainPanel.imgSignal4:SetActive(true)
		RM_GameMainPanel.imgSignal5:SetActive(true)
	elseif level > 50 and level < 100 then
		RM_GameMainPanel.imgSignal2:SetActive(true)
		RM_GameMainPanel.imgSignal3:SetActive(true)
		RM_GameMainPanel.imgSignal4:SetActive(true)
		RM_GameMainPanel.imgSignal5:SetActive(true)
	elseif level > 100 and level < 150 then
		RM_GameMainPanel.imgSignal2:SetActive(true)
		RM_GameMainPanel.imgSignal3:SetActive(true)
		RM_GameMainPanel.imgSignal4:SetActive(true)
		RM_GameMainPanel.imgSignal5:SetActive(false)
	elseif level > 150 and level < 200 then
		RM_GameMainPanel.imgSignal2:SetActive(true)
		RM_GameMainPanel.imgSignal3:SetActive(true)
		RM_GameMainPanel.imgSignal4:SetActive(false)
		RM_GameMainPanel.imgSignal5:SetActive(false)
	else
		RM_GameMainPanel.imgSignal2:SetActive(true)
		RM_GameMainPanel.imgSignal3:SetActive(false)
		RM_GameMainPanel.imgSignal4:SetActive(false)
		RM_GameMainPanel.imgSignal5:SetActive(false)
	end
end

-- 黄庄
function RM_GameMainCtrl.NoWin()
	if RM_GameMainCtrl.isCreate then
		RM_GameMainPanel.imgHuangZhuang:SetActive(true)
		coroutine.wait(1.5)
		if not RM_GameMainPanel then return end
		RM_GameMainPanel.imgHuangZhuang:SetActive(false)
	end
end

-- 颜色渐变
function RM_GameMainCtrl.ColorChange(obj, anum)
	if obj == nil then
		return
	end
	c = obj.transform:GetComponent('MeshRenderer').material.color
	c.a = anum
	obj.transform:GetComponent('MeshRenderer').material.color = c
end


-- 表情窗口4秒以后消失
function RM_GameMainCtrl.HideImgFaceIconBGL()
	coroutine.wait(4)
	gameRoom.leftEmoticonObject:Destroy()
	RM_GameMainPanel.imgFaceIconBGL:SetActive(false)
end

function RM_GameMainCtrl.HideImgFaceIconBGR()
	coroutine.wait(4)
	gameRoom.rightEmoticonObject:Destroy()
	RM_GameMainPanel.imgFaceIconBGR:SetActive(false)
end

function RM_GameMainCtrl.HideImgFaceIconBGU()
	coroutine.wait(4)
	gameRoom.upEmoticonObject:Destroy()
	RM_GameMainPanel.imgFaceIconBGU:SetActive(false)
end

function RM_GameMainCtrl.HideImgFaceIconBGD()
	coroutine.wait(4)
	gameRoom.selfEmoticonObject:Destroy()
	RM_GameMainPanel.imgFaceIconBGD:SetActive(false)
end

function RM_GameMainCtrl.OnPengBtnClick()
	this.PengGangHuSignOperate(SingType.SING_PENG)
end

function RM_GameMainCtrl.OnGangBtnClick()
	local len = table.maxn(gameRoom.curSignType)
	for i = 1, len, 1 do
		local signType = gameRoom.curSignType[i]
		if signType == SingType.SING_ANGANG or signType == SingType.SING_MINGGANG or signType == SingType.SING_GUOLUGANG then
			this.PengGangHuSignOperate(signType)
			break
		end
	end
end

function RM_GameMainCtrl.OnHuBtnClick()
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

function RM_GameMainCtrl.OnGuoBtnClick()
	print("-------GUO-------", global.roomVo.isBihu, RoomRunStatic.IsBiHu)
	if global.roomVo.isBihu == 1 then
		if RoomRunStatic.IsBiHu then
			RM_GameMainCtrl.SetIconTips("当前为点必胡模式，无法过牌！")
		else
			this.PengGangHuSignOperate(SingType.SING_GUO)
		end
	else
		this.PengGangHuSignOperate(SingType.SING_GUO)
	end
end

function RM_GameMainCtrl.PengGangHuSignOperate(SignTypeInfo)
	local signInfo = PushSignOperate_pb.PushSignOperateReq()
	signInfo.signType = SignTypeInfo
	local msg = signInfo:SerializeToString()
	Game.SendProtocal(Protocal.Card_PushSignOperate, msg)
	RM_GameMainPanel.imgPengGangHuBG:SetActive(false)
end

-- 收到开始游戏消息
function RM_GameMainCtrl.StartGameRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = LongTypeReturn_pb.LongTypeReturnRes()
	msg:ParseFromString(data)
	local roleID = msg.longVal
	local roleIndex = getRoleIndexById(roleID)

	local location = getOtherPlayerLocation(roleIndex)
	if location == 'D' then
		RM_GameMainPanel.imgReadyD:SetActive(true)
	elseif location == 'R' then
		RM_GameMainPanel.imgReadyR:SetActive(true)
	elseif location == 'L' then
		RM_GameMainPanel.imgReadyL:SetActive(true)
	elseif location == 'U' then
		RM_GameMainPanel.imgReadyU:SetActive(true)
	else
		logWarn('--------------------------->location error')
	end
end

function RM_GameMainCtrl:GameStarting()
	print("<color=#fffc16>-------GameStarting-------</color>")
	RM_GameMainPanel.imgGameStart:SetActive(true)
	local co = coroutine.start( function()
		coroutine.wait(0.5)
		RM_GameMainPanel.imgGameStart:SetActive(false)
	end )
	table.insert(Network.crts, co)
end

-- 收到别人断线或离线消息
function RM_GameMainCtrl.OfflinePush(msg)
	if not RM_GameMainCtrl.isCreate then
		return
	end
	local roleId = msg.roleId
	-- 断线（重连）roleId
	local state = msg.state
	-- true=上线  false=离线
	local roleIndex = getRoleIndexById(roleId)
	local location = getOtherPlayerLocation(roleIndex)

	if location == 'D' then
		if RM_GameMainPanel.imgHeadDBreak then
			RM_GameMainPanel.imgHeadDBreak:SetActive(not state)
		end
	elseif location == 'R' then
		if RM_GameMainPanel.imgHeadRBreak then
			RM_GameMainPanel.imgHeadRBreak:SetActive(not state)
		end
	elseif location == 'L' then
		if RM_GameMainPanel.imgHeadLBreak then
			RM_GameMainPanel.imgHeadLBreak:SetActive(not state)
		end
	elseif location == 'U' then
		if RM_GameMainPanel.imgHeadUBreak then
			RM_GameMainPanel.imgHeadUBreak:SetActive(not state)
		end
	else
		logWarn('--------------------------->Reconnection location error')
	end
end

-- 碰烟\胡光特效
function RM_GameMainCtrl.SmokeEffect(location, effectName, pos)
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
			RM_GameMainCtrl.EffectMgr(effectName, effectpos)
		end
	end
end

function RM_GameMainCtrl.HideTableEffect()
	for k, v in pairs(HeadEffect.D) do
		HeadEffect.D[k] = BasePanel:GOChild(RM_GameMainPanel.imgHeadD, k)
		HeadEffect.D[k]:SetActive(false)
	end
	for k, v in pairs(HeadEffect.L) do
		HeadEffect.L[k] = BasePanel:GOChild(RM_GameMainPanel.imgHeadL, k)
		HeadEffect.L[k]:SetActive(false)
	end
	for k, v in pairs(HeadEffect.R) do
		HeadEffect.R[k] = BasePanel:GOChild(RM_GameMainPanel.imgHeadR, k)
		HeadEffect.R[k]:SetActive(false)
	end
	for k, v in pairs(HeadEffect.U) do
		HeadEffect.U[k] = BasePanel:GOChild(RM_GameMainPanel.imgHeadU, k)
		HeadEffect.U[k]:SetActive(false)
	end
end

function RM_GameMainCtrl.ShowTableEffect(location, effectName)
	local self = RM_GameMainCtrl
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
				if not RM_GameMainCtrl.isCreate then return end
				v:SetActive(false)
			end )
		end
	end
end

-- 聊天提示
function RM_GameMainCtrl.ChatTips()
	RM_GameMainPanel.imgTips:SetActive(true)
	coroutine.start(this.ChatWait)
end
function RM_GameMainCtrl.ChatWait()
	coroutine.wait(1.8)
	RM_GameMainPanel.imgTips:SetActive(false)
end

-- 文本自适应
function RM_GameMainCtrl.ChatLength(chatText, location)
	local pic = nil
	local txt = nil
	local panel = nil
	if RM_GameMainCtrl.isCreate then
		if location == "D" then
			panel = RM_GameMainPanel.imgChatD
			pic = RM_GameMainPanel.imgChatD:GetComponent("Image")
			txt = RM_GameMainPanel.txtChatD:GetComponent("Text")
		elseif location == "R" then
			panel = RM_GameMainPanel.imgChatR
			pic = RM_GameMainPanel.imgChatR:GetComponent("Image")
			txt = RM_GameMainPanel.txtChatR:GetComponent("Text")
		elseif location == "U" then
			panel = RM_GameMainPanel.imgChatU
			pic = RM_GameMainPanel.imgChatU:GetComponent("Image")
			txt = RM_GameMainPanel.txtChatU:GetComponent("Text")
		elseif location == "L" then
			panel = RM_GameMainPanel.imgChatL
			pic = RM_GameMainPanel.imgChatL:GetComponent("Image")
			txt = RM_GameMainPanel.txtChatL:GetComponent("Text")
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

function RM_GameMainCtrl:ClickIcon(id, iconObj)
	print("====global.setPosition==", #global.setPosition)
	local roleInfo = { }
	for i, v in ipairs(global.joinRoomUserVos) do
		print(id .. "=======RM_GameMainCtrl:ClickIcon========" .. iconObj.name)
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
function RM_GameMainCtrl.OnClickHead(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	if GradeDetailCtrl.isPlayBackClickHead then
		return
	end
	local location = getOtherPlayerLocation(getRoleIndexById(go.name))
	local playerIcon = nil
	if location == 'R' then
		playerIcon = RM_GameMainPanel.btnHeadIconR
	elseif location == 'U' then
		playerIcon = RM_GameMainPanel.btnHeadIconU
	elseif location == 'D' then
		playerIcon = RM_GameMainPanel.btnHeadIconD
	elseif location == 'L' then
		playerIcon = RM_GameMainPanel.btnHeadIconL
	else
		logWarn("get role location err")
	end
	print("=============================", location)
	RM_GameMainCtrl:ClickIcon(go.name, playerIcon)
end

-- 发送作弊码
function RM_GameMainCtrl.SendDeBugCode()
	self = RM_GameMainCtrl
	local txtCode = self:GetInputText(RM_GameMainPanel.inputSendCode)
	local signInfo = StringPara_pb.StringParaReq()
	signInfo.val = txtCode
	local msg = signInfo:SerializeToString()
	Game.SendProtocal(Protocal.StringPara, msg)
end

-- 收到作弊码
function RM_GameMainCtrl.StringParaRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = StringPara_pb.StringParaRes()
	msg:ParseFromString(data)
	log("GetStringPara ----------------------------" .. msg.strs)
end

-- 根据玩家ID设置积分
function RM_GameMainCtrl.SetScore(roleIndex, jifen, roleId)
	print("============SetScore")
	-- local self = RM_GameMainCtrl
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
function RM_GameMainCtrl:RefrshScore()
	print("=====RefrshScore")
	RM_GameMainPanel.imgJinbiD:SetActive(false)
	RM_GameMainPanel.imgJinbiR:SetActive(false)
	RM_GameMainPanel.imgJinbiU:SetActive(false)
	RM_GameMainPanel.imgJinbiL:SetActive(false)
	RM_GameMainPanel.imgYuanbaoD:SetActive(false)
	RM_GameMainPanel.imgYuanbaoR:SetActive(false)
	RM_GameMainPanel.imgYuanbaoU:SetActive(false)
	RM_GameMainPanel.imgYuanbaoL:SetActive(false)
	RM_GameMainPanel.imgSurplusInningNumBG:SetActive(false)
	local self = RM_GameMainCtrl
	if global.roomVo.moneyType == RoomMode.goldMode then
		RM_GameMainPanel.imgJinbiD:SetActive(true)
		RM_GameMainPanel.imgJinbiR:SetActive(true)
		RM_GameMainPanel.imgJinbiU:SetActive(true)
		RM_GameMainPanel.imgJinbiL:SetActive(true)
		for i, v in ipairs(global.joinRoomUserVos) do
			for i, c in ipairs(global.roleInfoTable) do
				if global.roleInfoTable[i][2] == v.roleId then
					global.roleInfoTable[i][3] = v.goldcoin
					self:SetText(global.roleInfoTable[i][5], formatNumber(v.goldcoin))
				end
			end
		end
	elseif global.roomVo.moneyType == RoomMode.wingMode then
		RM_GameMainPanel.imgYuanbaoD:SetActive(true)
		RM_GameMainPanel.imgYuanbaoR:SetActive(true)
		RM_GameMainPanel.imgYuanbaoU:SetActive(true)
		RM_GameMainPanel.imgYuanbaoL:SetActive(true)
		for i, v in ipairs(global.joinRoomUserVos) do
			for i, c in ipairs(global.roleInfoTable) do
				if global.roleInfoTable[i][2] == v.roleId then
					global.roleInfoTable[i][3] = v.wing
					self:SetText(global.roleInfoTable[i][5], formatNumber(v.wing))
				end
			end
		end
	elseif global.roomVo.moneyType == RoomMode.roomCardMode then
		RM_GameMainPanel.imgSurplusInningNumBG:SetActive(false)
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

function RM_GameMainCtrl:HeadIcon(index)
	local location = getOtherPlayerLocation(index)
	RM_GameMainCtrl.ColorChange(gameRoom.objLight, 1)
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
		RM_GameMainCtrl.ColorChange(gameRoom.DDong, 1)
		gameRoom.DDong:SetActive(true)
		gameRoom.DXi:SetActive(false)
		gameRoom.DNan:SetActive(false)
		gameRoom.DBei:SetActive(false)
		objTableMask = gameRoom.DDong
	elseif index == 2 then
		RM_GameMainCtrl.ColorChange(gameRoom.DNan, 1)
		gameRoom.DDong:SetActive(false)
		gameRoom.DXi:SetActive(false)
		gameRoom.DNan:SetActive(true)
		gameRoom.DBei:SetActive(false)
		objTableMask = gameRoom.DNan
	elseif index == 3 then
		RM_GameMainCtrl.ColorChange(gameRoom.DXi, 1)
		gameRoom.DDong:SetActive(false)
		gameRoom.DXi:SetActive(true)
		gameRoom.DNan:SetActive(false)
		gameRoom.DBei:SetActive(false)
		objTableMask = gameRoom.DXi
	elseif index == 4 then
		RM_GameMainCtrl.ColorChange(gameRoom.DBei, 1)
		gameRoom.DDong:SetActive(false)
		gameRoom.DXi:SetActive(false)
		gameRoom.DNan:SetActive(false)
		gameRoom.DBei:SetActive(true)
		objTableMask = gameRoom.DBei
	end
	RM_GameMainCtrl.SurplusCardNum(gameRoom.cardTotal)
end

function RM_GameMainCtrl:OnTingPaiBtnClick()
	RoomRunStatic.tingCardBtnClick()
end

function RM_GameMainCtrl:ZhuangJiaShow(index)
	local location = getOtherPlayerLocation(index)
	if location == "D" then
		RM_GameMainPanel.imgZhuangjiaD:SetActive(true)
		RM_GameMainPanel.imgZhuangjiaR:SetActive(false)
		RM_GameMainPanel.imgZhuangjiaU:SetActive(false)
		RM_GameMainPanel.imgZhuangjiaL:SetActive(false)
	elseif location == "R" then
		RM_GameMainPanel.imgZhuangjiaD:SetActive(false)
		RM_GameMainPanel.imgZhuangjiaR:SetActive(true)
		RM_GameMainPanel.imgZhuangjiaU:SetActive(false)
		RM_GameMainPanel.imgZhuangjiaL:SetActive(false)
	elseif location == "L" then
		RM_GameMainPanel.imgZhuangjiaD:SetActive(false)
		RM_GameMainPanel.imgZhuangjiaR:SetActive(false)
		RM_GameMainPanel.imgZhuangjiaU:SetActive(false)
		RM_GameMainPanel.imgZhuangjiaL:SetActive(true)
	elseif location == "U" then
		RM_GameMainPanel.imgZhuangjiaD:SetActive(false)
		RM_GameMainPanel.imgZhuangjiaR:SetActive(false)
		RM_GameMainPanel.imgZhuangjiaU:SetActive(true)
		RM_GameMainPanel.imgZhuangjiaL:SetActive(false)
	end
end

function RM_GameMainCtrl:OnQuitGameYse()
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

	RM_GameMainPanel.imgQuitTips:SetActive(false)
end

function RM_GameMainCtrl:OnQuitGameNo()
	Game.MusicEffect(Game.Effect.buttonBack)
	RM_GameMainPanel.imgQuitTips:SetActive(false)
end

function RM_GameMainCtrl.SetIconTips(str, bool)
	self = RM_GameMainCtrl
	if bool == nil then
		if RM_GameMainPanel.imgTips.activeSelf == true then return end
		RM_GameMainCtrl.ChatTips()
		local tipsText = BasePanel:GOChild(RM_GameMainPanel.imgTips, "Name")
		local tipsPos = Vector3.New(0, -172.8, 3782)
		local sequence = DG.Tweening.DOTween.Sequence()
		sequence:Append(RM_GameMainPanel.imgTips.transform:DOLocalMoveY(tipsPos.y + 50, 2, false))
		:OnComplete( function()
			RM_GameMainPanel.imgTips.transform.localPosition = tipsPos
		end )
		self:SetText(tipsText, str)
	elseif bool == true then
		local tipsText = BasePanel:GOChild(RM_GameMainPanel.imgTips, "Name")
		local tipsPos = Vector3.New(0, -130, 3782)
		RM_GameMainPanel.imgTips.transform.localPosition = tipsPos
		RM_GameMainPanel.imgTips:SetActive(true)
		self:SetText(tipsText, str)
	else
		RM_GameMainPanel.imgTips:SetActive(false)
	end
end

function RM_GameMainCtrl.LouHuRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = IntTypeReturn_pb.IntTypeReturnRes()
	msg:ParseFromString(data)
	local intVal = msg.intVal
	RM_GameMainPanel.imgLouHu:SetActive(true)
end

function RM_GameMainCtrl.GenZhuangRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = IntTypeReturn_pb.IntTypeReturnRes()
	msg:ParseFromString(data)
	local intVal = msg.intVal
	RM_GameMainCtrl.SetIconTips("跟庄成功，下把结算翻番！")
	RM_GameMainPanel.imgGenZhuang:SetActive(true)
	local co = coroutine.start(RM_GameMainCtrl.GenZhuangShow)
	table.insert(Network.crts, co)
end

function RM_GameMainCtrl.LouhuShow()
	coroutine.wait(2)
	RM_GameMainPanel.imgLouHu:SetActive(false)
end

function RM_GameMainCtrl.GenZhuangShow()
	coroutine.wait(2)
	RM_GameMainPanel.imgGenZhuang:SetActive(false)
end
-- 回放退出
function RM_GameMainCtrl:OnPlayBackQuit()
	local self = RM_GameMainCtrl
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
function RM_GameMainCtrl:OnPlayBackShare()
end

-- 回放后退
function RM_GameMainCtrl:OnPlayBackHouTui()
	if GradeDetailCtrl.i < 3 then
		return
	end
	local self = RM_GameMainCtrl
	self.isPlayBackPlay = false
	self.isPlayBackPlayHouTui = true
	RM_GameMainPanel.huiFangPlayButton:SetActive(true)
	RM_GameMainPanel.huiFangZanTingButton:SetActive(false)
	GradeDetailCtrl.i = GradeDetailCtrl.i - 1
	local buzhouId = GradeDetailCtrl.playBackInfoList[GradeDetailCtrl.i].buzhouId
	local playBackType = GradeDetailCtrl.playBackInfoList[GradeDetailCtrl.i].type
	local data = GradeDetailCtrl.playBackInfoList[GradeDetailCtrl.i].data
	gameRoom.PlayBackHouTui(buzhouId, playBackType, data)
	local currentJinDu = GradeDetailCtrl.i / #GradeDetailCtrl.playBackInfoList
	RM_GameMainCtrl:SetProgress(RM_GameMainPanel.huiFangFillBar, currentJinDu)
end

-- 回放播放
function RM_GameMainCtrl:OnPlayBackPlay()
	local self = RM_GameMainCtrl
	RM_GameMainPanel.huiFangPlayButton:SetActive(false)
	RM_GameMainPanel.huiFangZanTingButton:SetActive(true)
	self.isPlayBackPlay = true
end

-- 回放暂停
function RM_GameMainCtrl:OnPlayBackZanTing()
	local self = RM_GameMainCtrl
	RM_GameMainPanel.huiFangPlayButton:SetActive(true)
	RM_GameMainPanel.huiFangZanTingButton:SetActive(false)
	self.isPlayBackPlay = false
end

-- 回放快进
function RM_GameMainCtrl:OnPlayBackKuaiJin()
	if GradeDetailCtrl.i > #GradeDetailCtrl.playBackInfoList then
		return
	end
	local self = RM_GameMainCtrl
	self.isPlayBackPlay = false
	RM_GameMainPanel.huiFangPlayButton:SetActive(true)
	RM_GameMainPanel.huiFangZanTingButton:SetActive(false)
	local buzhouId = GradeDetailCtrl.playBackInfoList[GradeDetailCtrl.i].buzhouId
	local playBackType = GradeDetailCtrl.playBackInfoList[GradeDetailCtrl.i].type
	local data = GradeDetailCtrl.playBackInfoList[GradeDetailCtrl.i].data
	gameRoom.PlayBack(buzhouId, playBackType, data)
	GradeDetailCtrl.i = GradeDetailCtrl.i + 1
	local currentJinDu = GradeDetailCtrl.i / #GradeDetailCtrl.playBackInfoList
	RM_GameMainCtrl:SetProgress(RM_GameMainPanel.huiFangFillBar, currentJinDu)
end

-- 比赛托管
function RM_GameMainCtrl.OnTuoGuakBtnClick(go)
	local vsTrusteeship = VsTrusteeship_pb.VsTrusteeshipReq()
	if self.isCanClick then
		vsTrusteeship.isTrusteeship = true
		-- 是否托管
		local msg = vsTrusteeship:SerializeToString()
		Game.SendProtocal(Protocal.VsTrusteeship, msg)
		self.isCanClick = false
	end
end

function RM_GameMainCtrl.OnQuXiaoTuoGuakBtnClick(go)
	local vsTrusteeship = VsTrusteeship_pb.VsTrusteeshipReq()
	-- if self.isCanClick then
	vsTrusteeship.isTrusteeship = false
	local msg = vsTrusteeship:SerializeToString()
	Game.SendProtocal(Protocal.VsTrusteeship, msg)
	-- self.isCanClick = false
	-- end
end

-- GPS面板
function RM_GameMainCtrl.OpenGps(go)
	print("---------OpenGps---------", Room.gpsList, MahjongRoom)
	GPSInfoCtrl:Open("GPSInfo", function()
		GPSInfoCtrl:InitPanel(Room.gpsList, MahjongRoom)
	end )
end


function RM_GameMainCtrl.OnbtnGouwucheBtnClick()
	Game.MusicEffect(Game.Effect.joinRoom)
	ShopMallCtrl:Open("ShopMall")
end

function RM_GameMainCtrl.OnShowGameSettingClick(go)
	RM_GameMainPanel.PanelGameSetting:SetActive(true)
	RM_GameMainPanel.btnSettingGame:SetActive(false)
	RM_GameMainPanel.btnHideUp:SetActive(true)
end

function RM_GameMainCtrl.OnHidePanelClick(go)
	RM_GameMainPanel.PanelGameSetting:SetActive(false)
	RM_GameMainPanel.btnHideUp:SetActive(false)
	RM_GameMainPanel.btnSettingGame:SetActive(true)
end

-- 发送退出房间消息
function RM_GameMainCtrl.OnQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	DissolutionRoomTipsCtrl:Open('DissolutionRoomTips')
end

-- 收到断线重连消息
function RM_GameMainCtrl.OfflinePush(msg)
	if not RM_GameMainPanel.isCreate then
		return
	end
	local roleId = msg.roleId
	-- 断线（重连）roleId
	local state = msg.state
	-- true=上线  false=离线
	local roleIndex = getRoleIndexById(roleId)
	local location = getOtherPlayerLocation(roleIndex)
	if location == 'D' then
		if RM_GameMainPanel.imgHeadDBreak then
			RM_GameMainPanel.imgHeadDBreak:SetActive(not state)
		end
	elseif location == 'R' then
		if RM_GameMainPanel.imgHeadRBreak then
			RM_GameMainPanel.imgHeadRBreak:SetActive(not state)
		end
	elseif location == 'L' then
		if RM_GameMainPanel.imgHeadLBreak then
			RM_GameMainPanel.imgHeadLBreak:SetActive(not state)
		end
	elseif location == 'U' then
		if RM_GameMainPanel.imgHeadUBreak then
			RM_GameMainPanel.imgHeadUBreak:SetActive(not state)
		end
	else
		logWarn('--------------------------->Reconnection location error')
	end
end

function RM_GameMainCtrl.OnInvitationWeChatBtnClick(go)
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

function RM_GameMainCtrl.OnGameStartBtnClick(go)
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
function RM_GameMainCtrl:InitPlayer()
	local self = RM_GameMainCtrl
	RM_GameMainPanel.btnHeadIconD:SetActive(true)
	RM_GameMainPanel.btnHeadIconR:SetActive(true)
	RM_GameMainPanel.btnHeadIconL:SetActive(true)

	if #global.joinRoomUserVos == 4 then
		RM_GameMainPanel.btnHeadIconU:SetActive(true)
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
	roleInfoTable["R"][4] = RM_GameMainPanel.btnHeadIconR:GetComponent("Image").sprite
	roleInfoTable["L"][4] = RM_GameMainPanel.btnHeadIconL:GetComponent("Image").sprite
	roleInfoTable["D"][4] = RM_GameMainPanel.btnHeadIconD:GetComponent("Image").sprite
	if #joinRoomUseVos == 4 then
		roleInfoTable["U"][4] = RM_GameMainPanel.btnHeadIconU:GetComponent("Image").sprite
	end

	roleInfoTable["R"][5] = RM_GameMainPanel.txtScoreR
	roleInfoTable["L"][5] = RM_GameMainPanel.txtScoreL
	roleInfoTable["D"][5] = RM_GameMainPanel.txtScoreD
	if #joinRoomUseVos == 4 then
		roleInfoTable["U"][5] = RM_GameMainPanel.txtScoreU
	end

	roleInfoTable["R"][6] = RM_GameMainPanel.effect_touxiangR
	roleInfoTable["L"][6] = RM_GameMainPanel.effect_touxiangL
	roleInfoTable["D"][6] = RM_GameMainPanel.effect_touxiangD
	if #joinRoomUseVos == 4 then
		roleInfoTable["U"][6] = RM_GameMainPanel.effect_touxiangU
	end
	print("=======HeadAndjifenShow---3")
	global.roleInfoTable[1] = roleInfoTable["R"]
	global.roleInfoTable[2] = roleInfoTable["L"]
	global.roleInfoTable[4] = roleInfoTable["D"]
	if #joinRoomUseVos == 4 then
		global.roleInfoTable[3] = roleInfoTable["U"]
	end
	-- 面板所有信息初始化
	RM_GameMainPanel.btnInvitationWeChat:SetActive(false)
	RM_GameMainPanel.imgHeadL:SetActive(false)
	RM_GameMainPanel.imgHeadD:SetActive(false)
	RM_GameMainPanel.imgHeadR:SetActive(false)
	RM_GameMainPanel.imgHeadU:SetActive(false)
	RM_GameMainPanel.txtScoreL:SetActive(false)
	RM_GameMainPanel.txtScoreD:SetActive(false)
	RM_GameMainPanel.txtScoreR:SetActive(false)
	RM_GameMainPanel.txtScoreU:SetActive(false)
	RM_GameMainPanel.btnGameStart:SetActive(false)
	RM_GameMainPanel.imgJoinRoom:SetActive(false)

	RM_GameMainPanel.imgJinbiL:SetActive(false)
	RM_GameMainPanel.imgJinbiD:SetActive(false)
	RM_GameMainPanel.imgJinbiR:SetActive(false)
	RM_GameMainPanel.imgJinbiU:SetActive(false)
	RM_GameMainPanel.imgYuanbaoL:SetActive(false)
	RM_GameMainPanel.imgYuanbaoD:SetActive(false)
	RM_GameMainPanel.imgYuanbaoR:SetActive(false)
	RM_GameMainPanel.imgYuanbaoU:SetActive(false)


	for i, v in ipairs(global.joinRoomUserVos) do
		local position = getOtherPlayerLocation(v.index)
		local headObj = nil
		local num = 0
		if position == 'R' then
			RM_GameMainPanel.btnHeadIconR:SetActive(true)
			RM_GameMainPanel.imgHeadIconR.name = v.roleId
			print("麻将==人物==信息1", RM_GameMainPanel.imgHeadIconR.name, v.roleId)
			headObj = RM_GameMainPanel.btnHeadIconR
			local img = RM_GameMainPanel.btnHeadIconR
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
			RM_GameMainPanel.btnHeadIconD:SetActive(true)
			RM_GameMainPanel.imgHeadIconD.name = v.roleId
			print("麻将==人物==信息2", RM_GameMainPanel.imgHeadIconD.name, v.roleId)
			headObj = RM_GameMainPanel.btnHeadIconD
			local img = RM_GameMainPanel.btnHeadIconD
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
			RM_GameMainPanel.btnHeadIconL:SetActive(true)
			RM_GameMainPanel.imgHeadIconL.name = v.roleId
			print("麻将==人物==信息3", RM_GameMainPanel.imgHeadIconL.name, v.roleId)
			headObj = RM_GameMainPanel.btnHeadIconL
			local img = RM_GameMainPanel.btnHeadIconL
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
			RM_GameMainPanel.btnHeadIconU:SetActive(true)
			RM_GameMainPanel.imgHeadIconU.name = v.roleId
			print("麻将==人物==信息4", RM_GameMainPanel.imgHeadIconU.name, v.roleId)
			headObj = RM_GameMainPanel.btnHeadIconU
			local img = RM_GameMainPanel.btnHeadIconU
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
		-- 	RM_GameMainPanel.imgOKD:SetActive(true)
		RM_GameMainPanel.imgHeadD:SetActive(true)
		RM_GameMainPanel.txtScoreD:SetActive(true)
		RM_GameMainPanel.txtScoreD.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)


		-- 	RM_GameMainPanel.btnQuitRoom:SetActive(false)
		-- 申请苹果审核
		if IS_APP_STORE_CHECK or LoginCtrl.loginTypes == 2 then
			RM_GameMainPanel.btnInvitationWeChat:SetActive(false)
		else
			RM_GameMainPanel.btnInvitationWeChat:SetActive(true)
		end
		if global.roomVo.moneyType == RoomMode.goldMode then
			RM_GameMainPanel.imgJinbiD:SetActive(true)
			self:SetText(RM_GameMainPanel.txtScoreD, formatNumber(global.userVo.goldcoin))
			RM_GameMainPanel.btnInvitationWeChat:SetActive(false)
		elseif global.roomVo.moneyType == RoomMode.wingMode then
			RM_GameMainPanel.imgYuanbaoD:SetActive(true)
			print(RM_GameMainPanel.txtScoreD.name, "===============快乐撒娇地块======================", formatNumber(global.userVo.wing))
			self:SetText(RM_GameMainPanel.txtScoreD, formatNumber(global.userVo.wing))
			RM_GameMainPanel.btnInvitationWeChat:SetActive(false)
		end
		-- RM_GameMainPanel.imgHeadD.name = myRoleId
	end

	for i, v in ipairs(global.setPosition) do
		local position = getOtherPlayerLocation(v.index)
		if position == 'R' then
			-- 		RM_GameMainPanel.imgOKR:SetActive(true)
			RM_GameMainPanel.imgHeadR:SetActive(true)
			RM_GameMainPanel.txtScoreR:SetActive(true)
			RM_GameMainPanel.txtScoreR.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)

			if global.roomVo.moneyType == RoomMode.goldMode then
				RM_GameMainPanel.imgJinbiR:SetActive(true)
				self:SetText(RM_GameMainPanel.txtScoreR, formatNumber(v.goldcoin))
			elseif global.roomVo.moneyType == RoomMode.wingMode then
				RM_GameMainPanel.imgYuanbaoR:SetActive(true)
				self:SetText(RM_GameMainPanel.txtScoreR, formatNumber(v.wing))
			end

			-- 		RM_GameMainPanel.btnQuitRoom:SetActive(false)
			-- 		RM_GameMainPanel.imgHeadR.name = v.roleId
			local img = RM_GameMainPanel.btnHeadIconR
			if (AppConst.getCurrentPlatform() == "PC") then
				local url = "http://pic.qqtn.com/up/2017-4/2017041016062719079.jpg"
				weChatFunction.SetPic(img, v.roleId, url)
			else
				weChatFunction.SetPic(img, v.roleId, v.headImg)
			end
			-- 		self:JoinRoomShow(v.name)
		elseif position == 'D' then
			-- 		RM_GameMainPanel.imgOKD:SetActive(true)
			RM_GameMainPanel.imgHeadD:SetActive(true)
			RM_GameMainPanel.txtScoreD:SetActive(true)
			RM_GameMainPanel.txtScoreD.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)

			if global.roomVo.moneyType == RoomMode.goldMode then
				RM_GameMainPanel.imgJinbiD:SetActive(true)
				self:SetText(RM_GameMainPanel.txtScoreD, formatNumber(v.goldcoin))
			elseif global.roomVo.moneyType == RoomMode.wingMode then
				RM_GameMainPanel.imgYuanbaoD:SetActive(true)
				self:SetText(RM_GameMainPanel.txtScoreD, formatNumber(v.wing))
			end

			-- 		RM_GameMainPanel.btnQuitRoom:SetActive(false)
			-- 		RM_GameMainPanel.imgHeadD.name = v.roleId
			local img = RM_GameMainPanel.btnHeadIconD
			if (AppConst.getCurrentPlatform() == "PC") then
				local url = "https://ps.ssl.qhimg.com/t01e9783b7417515cc0.jpg"
				weChatFunction.SetPic(img, v.roleId, url)
			else
				weChatFunction.SetPic(img, v.roleId, v.headImg)
			end
			-- 		self:JoinRoomShow(v.name)
		elseif position == 'L' then
			-- 		RM_GameMainPanel.imgOKL:SetActive(true)
			RM_GameMainPanel.imgHeadL:SetActive(true)
			RM_GameMainPanel.txtScoreL:SetActive(true)
			RM_GameMainPanel.txtScoreL.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)

			if global.roomVo.moneyType == RoomMode.goldMode then
				RM_GameMainPanel.imgJinbiL:SetActive(true)
				self:SetText(RM_GameMainPanel.txtScoreL, formatNumber(v.goldcoin))
			elseif global.roomVo.moneyType == RoomMode.wingMode then
				RM_GameMainPanel.imgYuanbaoL:SetActive(true)
				self:SetText(RM_GameMainPanel.txtScoreL, formatNumber(v.wing))
			end

			-- 		RM_GameMainPanel.btnQuitRoom:SetActive(false)
			local img = RM_GameMainPanel.btnHeadIconL
			-- 		RM_GameMainPanel.imgHeadL.name = v.roleId
			if (AppConst.getCurrentPlatform() == "PC") then
				local url = "http://diy.qqjay.com/u2/2014/1012/4204849e421dfea8b1af148f0dce4bfe.jpg"
				weChatFunction.SetPic(img, v.roleId, url)
			else
				weChatFunction.SetPic(img, v.roleId, v.headImg)
			end
			-- 		self:JoinRoomShow(v.name)
		elseif position == 'U' then
			-- 		RM_GameMainPanel.imgOKU:SetActive(true)
			RM_GameMainPanel.imgHeadU:SetActive(true)
			RM_GameMainPanel.txtScoreU:SetActive(true)
			RM_GameMainPanel.txtScoreU.transform:GetComponent("Text").color = Color.New(1, 0.81, 0.05, 1)

			if global.roomVo.moneyType == RoomMode.goldMode then
				RM_GameMainPanel.imgJinbiU:SetActive(true)
				self:SetText(RM_GameMainPanel.txtScoreU, formatNumber(v.goldcoin))
			elseif global.roomVo.moneyType == RoomMode.wingMode then
				RM_GameMainPanel.imgYuanbaoU:SetActive(true)
				self:SetText(RM_GameMainPanel.txtScoreU, formatNumber(v.wing))
			end

			-- 		RM_GameMainPanel.imgHeadU.name = v.roleId
			local img = RM_GameMainPanel.btnHeadIconU
			if (AppConst.getCurrentPlatform() == "PC") then
				local url = "http://pic.qqtn.com/up/2017-5/2017052714205462228.jpg"
				weChatFunction.SetPic(img, v.roleId, url)
			else
				weChatFunction.SetPic(img, v.roleId, v.headImg)
			end
			-- 		self:JoinRoomShow(v.name)
		end
		if GameRoom.resCount == GameRoom.needResCount then
			RM_GameMainCtrl.SetTableText()
		end
	end
end

-- 东南西北 1234
function RM_GameMainCtrl:DNXB(myId)
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
-- function RM_GameMainCtrl:JoinRoomShow(name)
-- -- self = RM_GameMainPanel
-- -- local clipName = GradeCtrl:GetShortName(name)
-- -- curObj = RM_GameMainPanel.imgJoinRoom
-- -- RM_GameMainPanel.imgJoinRoom:SetActive(true)
-- -- self:SetText(RM_GameMainPanel.playerName,clipName)
-- -- coroutine.start(RM_GameMainPanel.WaitClose)
-- end

function RM_GameMainCtrl.SetTableText()
	local self = RM_GameMainCtrl
	local txt = tostring(global.roomVo.playMethod)
	local objtxtRoomNum = gameRoom.objtxtRoomNum
	local objtxtMethod = gameRoom.objtxtMethod
	if objtxtRoomNum ~= nil and objtxtMethod ~= nil then
		self:SetText(objtxtMethod, txt)
		self:SetText(objtxtRoomNum, global.roomVo.id)
	end
end

function RM_GameMainCtrl.WaitClose()
	coroutine.wait(2)
	curObj:SetActive(false)
end
