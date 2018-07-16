TH_GameMainCtrl = {
	numberList = { },
	spriteList = { },
	jinhuaList = { },
	niuniuList = { },
	vsIndex = 0,
	lookName = 0,
	isCanClick = true,
	isQipai = false,
}

setbaseclass(TH_GameMainCtrl, { BaseCtrl })
local dateTime = 0
local netTime = 5
local playerPos = { }
local index = 0
local numberSprite = { }
local fenshu = nil

-- 启动事件--
function TH_GameMainCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	self:AddClick(TH_GameMainPanel.btnWaitQuitRoom, self.OnWaitQuitRoomBtnClick)
	self:AddClick(TH_GameMainPanel.btnInvitationWeChat, self.OnInvitationWeChatBtnClick)
	self:AddClick(TH_GameMainPanel.btnGameStart, self.OnGameStartBtnClick)
	-- 开始游戏
	self:AddClick(TH_GameMainPanel.btnSettingSystem, self.OnSetSystemBtnClick)
	self:AddClick(TH_GameMainPanel.btnMask, self.OnHidePanelClick)
	self:AddClick(TH_GameMainPanel.btnChat, self.OnChatBtnClick)
	self:AddClick(TH_GameMainPanel.btnGameMainQuitRoom, self.OnGameMainQuitRoomBtnClick)
	self:AddClick(TH_GameMainPanel.btnQuitTipsYes, self.OnQuitGameYse)
	self:AddClick(TH_GameMainPanel.btnQuitTipsNo, self.OnQuitGameNo)
	self:AddClick(TH_GameMainPanel.btnSettleStartGame, self.OnSettleStartGameBtnClick)
	self:AddClick(TH_GameMainPanel.btnFuZhiRoomNum, self.OnFuZhiRoomNum)
	-- 新添加
	self:AddClick(TH_GameMainPanel.btnSettleQuitGame, self.OnSettleQuitGameBtnClick)

	self:AddClick(TH_GameMainPanel.btnSendCode, self.SendDeBugCode)
	self:AddClick(TH_GameMainPanel.btnShowTips, self.TipsShow)
	self:AddClick(TH_GameMainPanel.btnClose, self.TipsClose)
	self:AddClick(TH_GameMainPanel.btnGPS, self.OpenGps)
	self:AddClickNoChange(TH_GameMainPanel.QuitHideButton, self.OnHidePanelClick)
	self:AddClickNoChange(TH_GameMainPanel.btnHideUp, self.OnHidePanelClick)
	self:AddClick(TH_GameMainPanel.btnSettingGame, self.OnShowGameSettingClick)

	-- 新添加
	self:AddClick(TH_GameMainPanel.btnGouwuche, self.OnbtnGouwucheBtnClick)
	self:AddClick(TH_GameMainPanel.btnPrepareButton, self.PrepareReq)
	-- 准备按钮
	if Room.gameType == RoomType.Tenharf then
		if TenharfRoom.RoomMsg.isWang == 0 then
			self:AddClick(TH_GameMainPanel.btn2Fen, self.OnFenBtnClick)
			self:AddClick(TH_GameMainPanel.btn3Fen, self.OnFenBtnClick)
			self:AddClick(TH_GameMainPanel.btn4Fen, self.OnFenBtnClick)
			self:AddClick(TH_GameMainPanel.btn5FenD, self.OnFenBtnClick)
		else
			self:AddClick(TH_GameMainPanel.btn5FenG, self.OnFenBtnClick)
			self:AddClick(TH_GameMainPanel.btn8Fen, self.OnFenBtnClick)
			self:AddClick(TH_GameMainPanel.btn10Fen, self.OnFenBtnClick)
			self:AddClick(TH_GameMainPanel.btn15Fen, self.OnFenBtnClick)
		end
		self:AddClick(TH_GameMainPanel.btnBuBuPai, self.OnBuPaiBtnClick)
		self:AddClick(TH_GameMainPanel.btnBuPai, self.OnBuPaiBtnClick)
		self:AddClick(TH_GameMainPanel.btnVSCard, self.OnVSCardBtnClick)
		self:AddClick(TH_GameMainPanel.btnBuDang, self.OnDangBtnClick)
		self:AddClick(TH_GameMainPanel.btnDang, self.OnDangBtnClick)
		self:AddClick(TH_GameMainPanel.btnBuQiang, self.OnQiangBtnClick)
		self:AddClick(TH_GameMainPanel.btnQiang, self.OnQiangBtnClick)
	elseif Room.gameType == RoomType.GoldFlower then
		self:AddClick(TH_GameMainPanel.btnJHQiPai, self.OnJHQiPaiClick)
		self:AddClick(TH_GameMainPanel.btnJHBiPai, self.OnJHBiPaiClick)
		self:AddClick(TH_GameMainPanel.btnJHJiaZhu, self.OnJHJiaZhuClick)
		self:AddClick(TH_GameMainPanel.btnJHGengZhu, self.OnJHGengZhuClick)
		self:AddClick(TH_GameMainPanel.btnJHUnDouble, self.OnJHAddBetClick)
		self:AddClick(TH_GameMainPanel.btnJH2Bei, self.OnJHAddBetClick)
		self:AddClick(TH_GameMainPanel.btnJH3Bei, self.OnJHAddBetClick)
		self:AddClick(TH_GameMainPanel.btnJH4Bei, self.OnJHAddBetClick)
		self:AddClick(TH_GameMainPanel.btnJH5Bei, self.OnJHAddBetClick)
		self:AddClick(TH_GameMainPanel.btnBack, self.OnBackBiClick)
		self:AddClick(TH_GameMainPanel.btnLoseAnim1, self.OnJHLoseAnimClick)
		self:AddClick(TH_GameMainPanel.btnLoseAnim2, self.OnJHLoseAnimClick)
		self:AddClick(TH_GameMainPanel.btnLoseAnim3, self.OnJHLoseAnimClick)
		self:AddClick(TH_GameMainPanel.btnLoseAnim4, self.OnJHLoseAnimClick)
		self:AddClick(TH_GameMainPanel.btnLoseAnim5, self.OnJHLoseAnimClick)
		self:AddClick(TH_GameMainPanel.btnLoseAnim6, self.OnJHLoseAnimClick)
	elseif Room.gameType == RoomType.NiuNiu then
		self:AddClick(TH_GameMainPanel.btn1, self.OnBetClick)
		self:AddClick(TH_GameMainPanel.btn2, self.OnBetClick)
		self:AddClick(TH_GameMainPanel.btn3, self.OnBetClick)
		self:AddClick(TH_GameMainPanel.btn4, self.OnBetClick)
		self:AddClick(TH_GameMainPanel.btn5, self.OnBetClick)
		self:AddClick(TH_GameMainPanel.btnQ1, self.OnBetQiangClick)
		self:AddClick(TH_GameMainPanel.btnQ2, self.OnBetQiangClick)
		self:AddClick(TH_GameMainPanel.btnQ3, self.OnBetQiangClick)
		self:AddClick(TH_GameMainPanel.btnQ4, self.OnBetQiangClick)
		self:AddClick(TH_GameMainPanel.btnNotBet, self.OnBetQiangClick)
		self:AddClick(TH_GameMainPanel.btnBuHuan, NiuNiuRoom.NiuNiuChangeReq)
		self:AddClick(TH_GameMainPanel.btnHuanPai, NiuNiuRoom.NiuNiuChangeReq)
		self:AddClick(TH_GameMainPanel.btnShowPai, self.NiuNiuShowPai)
		self:AddClick(TH_GameMainPanel.btnHintCard, self.NiuNiuShowPai)
	end
	self:InitPanel()
end

-- 初始化面板--
function TH_GameMainCtrl:InitPanel()
	print("------------<<<<<<<<<----<<<<<<房间信息显示<<<----<<<<<<<<<----<<<<<<<<<",Room.gameType , RoomType.NiuNiu)
	TH_GameMainPanel.imgHTGameMain:SetActive(false)
	TH_GameMainPanel.imgHTSingleSettlement:SetActive(false)
	TH_GameMainPanel.imgTips:SetActive(false)
	TH_GameMainPanel.btnGameStart:SetActive(false)
	TH_GameMainPanel.imgPublicCard:SetActive(false)
	TH_GameMainPanel.imgSignalBG:SetActive(false)
	TH_GameMainPanel.btnShowPai:SetActive(false)
	TH_GameMainPanel.btnHintCard:SetActive(false)
	TH_GameMainPanel.btnGPS:SetActive(false)
	-- TH_GameMainPatxtWanFanel.imgNiuWin:SetActive(false)
	TH_GameMainPanel.imgNiuLose:SetActive(false)
	TH_GameMainPanel.imgNNGameMain:SetActive(false)
	TH_GameMainPanel.btnInvitationWeChat:SetActive(true)
	TH_GameMainPanel.btnSettleQuitGame:SetActive(false)
	TH_GameMainPanel.PanelGameSetting:SetActive(false)
	TH_GameMainPanel.btnWaitQuitRoom:SetActive(true) --亮色
	TH_GameMainPanel.imgNotWaitQuitRoom:SetActive(false)  --灰色
	TH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
	TH_GameMainPanel.imgNotGameMainQuitRoom:SetActive(true)
	TH_GameMainPanel.btnFuZhiRoomNum:SetActive(true)

	-- 公共牌图片
	self.publicCardSprite = {
		th = TH_GameMainPanel.cardth:GetComponent("Image").sprite,
		thone = TH_GameMainPanel.cardthone:GetComponent("Image").sprite,
		jh = TH_GameMainPanel.cardjh:GetComponent("Image").sprite,
		jhone = TH_GameMainPanel.cardjhone:GetComponent("Image").sprite,
		nn = TH_GameMainPanel.cardnn:GetComponent("Image").sprite,
		nnone = TH_GameMainPanel.cardnnone:GetComponent("Image").sprite,
		card_gray = TH_GameMainPanel.card_gray:GetComponent("Image").sprite
	}

	TH_GameMainCtrl:NumberShow(50)
	self.clockStart = false
	if Room.gameType == RoomType.Tenharf then
		-- 十点半
		TenharfRoom.imgJuShu:SetActive(false)
		TH_GameMainPanel.imgIsBuPai:SetActive(false)
		TH_GameMainPanel.btnVSCard:SetActive(false)
		TH_GameMainPanel.imgIsDangZhuang:SetActive(false)
		TH_GameMainPanel.imgIsQiangZhuang:SetActive(false)
		TH_GameMainPanel.imgFenShu2:SetActive(false)
		TH_GameMainPanel.imgFenShu:SetActive(false)
		TH_GameMainPanel.txtCurBet:SetActive(false)
		TH_GameMainPanel.btnChat:SetActive(false)
		TH_GameMainPanel.jinhuaTip:SetActive(false)
		TH_GameMainPanel.shidianbanTip:SetActive(true)
		TH_GameMainPanel.niuniuTip:SetActive(false)
		TH_GameMainPanel.btnPrepareButton:SetActive(false)
		TH_GameMainPanel.imgClock:SetActive(false)

		if TenharfRoom.RoomMsg.moneyType == RoomMode.goldMode then
			-- 金币模式
			TH_GameMainPanel.btnInvitationWeChat:SetActive(false)
			TH_GameMainPanel.btnSettleQuitGame:SetActive(true)
			TH_GameMainPanel.btnFuZhiRoomNum:SetActive(false)
			if GoldFlowerRoom.RoomMsg.star then
				-- 如果游戏开始
				TH_GameMainPanel.btnPrepareButton:SetActive(false)
			elseif isPlayerReload ~= true then
				TH_GameMainPanel.btnPrepareButton:SetActive(true)
			end
			isPlayerReload = false
		elseif TenharfRoom.RoomMsg.moneyType == RoomMode.wingMode then
			-- 元宝模式
			TH_GameMainPanel.btnInvitationWeChat:SetActive(false)
			TH_GameMainPanel.btnSettleQuitGame:SetActive(true)
			TH_GameMainPanel.btnFuZhiRoomNum:SetActive(false)
			if GoldFlowerRoom.RoomMsg.star then
				-- 如果游戏开始
				TH_GameMainPanel.btnPrepareButton:SetActive(false)
			elseif isPlayerReload ~= true then
				TH_GameMainPanel.btnPrepareButton:SetActive(true)
			end
			isPlayerReload = false
		end
		TH_GameMainPanel.imgPublicCard:GetComponent("Image").sprite = self.publicCardSprite.th
		local thWanfa1 = ''
		local thWanfa2 = ''
		local thWanfa3 = ''
		local thWanfa4 = ''
		local thWanfa = ''

		if TenharfRoom.RoomMsg.isMaster == 0 then
			thWanfa1 = "随机庄家"
		elseif TenharfRoom.RoomMsg.isMaster == 1 then
			thWanfa1 = "房主首庄"
		end
		if TenharfRoom.RoomMsg.tenHalfTotal == 2 then
			thWanfa2 = "每人2局"
		elseif TenharfRoom.RoomMsg.tenHalfTotal == 4 then
			thWanfa2 = "每人4局"
		elseif TenharfRoom.RoomMsg.tenHalfTotal == 6 then
			thWanfa2 = "每人6局"
		end

		-- 新添加
		if TenharfRoom.RoomMsg.moneyType == RoomMode.goldMode then
			thWanfa2 = ""
		elseif TenharfRoom.RoomMsg.moneyType == RoomMode.wingMode then
			thWanfa2 = ""
		end

		if TenharfRoom.RoomMsg.isWang == 0 then
			thWanfa3 = '无王牌'
			fenshu = TH_GameMainPanel.imgFenShu2
		elseif TenharfRoom.RoomMsg.isWang == 1 then
			thWanfa3 = '王牌半点'
			fenshu = TH_GameMainPanel.imgFenShu
		end

		thWanfa = thWanfa1 .. '/' .. thWanfa2 .. '/' .. thWanfa3
		self.gameWanfa = thWanfa

		local Ronda = ""
		if TenharfRoom.RoomMsg.mcreenings == 1 then
			Ronda = "新手场"
		elseif TenharfRoom.RoomMsg.mcreenings == 2 then
			Ronda = "初级场"
		elseif TenharfRoom.RoomMsg.mcreenings == 3 then
			Ronda = "中级场"
		elseif TenharfRoom.RoomMsg.mcreenings == 4 then
			Ronda = "高级场"
		elseif TenharfRoom.RoomMsg.mcreenings == 5 then
			Ronda = "土豪场"
		end

		if TenharfRoom.RoomMsg.moneyType == RoomMode.goldMode then
			self:SetText(TenharfRoom.txtRoomNum, "")
			self:SetText(TenharfRoom.txtWanFa, "")
			self:SetText(TenharfRoom.txtRoomMessage, '')
			self:SetText(TenharfRoom.txtJuShu, "")
			self:SetText(TenharfRoom.txtMessage, "金币" .. Ronda .. "\n" .. "庄家：随机庄家" .. "\n" .. "王牌：王牌半点" .. "\n" .. "底分：" .. TenharfRoom.RoomMsg.baseNum)
		elseif TenharfRoom.RoomMsg.moneyType == RoomMode.wingMode then
			self:SetText(TenharfRoom.txtRoomNum, "")
			self:SetText(TenharfRoom.txtWanFa, "")
			self:SetText(TenharfRoom.txtRoomMessage, '')
			self:SetText(TenharfRoom.txtJuShu, "")
			self:SetText(TenharfRoom.txtMessage, "元宝" .. Ronda .. "\n" .. "庄家：随机庄家" .. "\n" .. "王牌：王牌半点" .. "\n" .. "底分：" .. TenharfRoom.RoomMsg.baseNum)
		else
			self:SetText(TenharfRoom.txtWanFa, "庄家：" .. thWanfa1 .. "\n" .. "玩法：" .. thWanfa2 .. "\n" .. "王牌：" .. thWanfa3 .. "\n")
			self:SetText(TenharfRoom.txtRoomNum, '房号：' .. tostring(TenharfRoom.RoomMsg.id))
		end

		-- 新添加
		local textTenharfBasenum = '底注：' .. tostring(TenharfRoom.RoomMsg.baseNum)
		local textTenharfQualified = tostring(TenharfRoom.RoomMsg.qualified) .. '进' .. tostring(TenharfRoom.RoomMsg.qualified) .. '出'
		if TenharfRoom.RoomMsg.moneyType == RoomMode.goldMode or TenharfRoom.RoomMsg.moneyType == RoomMode.wingMode then
			self:SetText(TenharfRoom.txtJuShu, "")
			TenharfRoom.imgJuShu:SetActive(false)
			TenharfRoom.txtRoomNum.transform.localPosition = Vector3.New(6, 52, 0)
		else
			TenharfRoom.txtRoomNum.transform.localPosition = Vector3.New(6, 52, 0)
		end
		print("-------------------wanfa------", textTenharfQualified)

		TH_GameMainCtrl.ShowCount()
		Game.MusicBG("bgm6")
		self.clockTxt = TH_GameMainPanel.txtClock.transform:GetComponent('Text')
	elseif Room.gameType == RoomType.GoldFlower then
		-- 炸金花
		GoldFlowerRoom.imgJuShu:SetActive(false)
		TH_GameMainPanel.imgJHCompareOrBet:SetActive(false)
		TH_GameMainPanel.imgVsShow:SetActive(false)
		TH_GameMainPanel.imgJHBeishu:SetActive(false)
		TH_GameMainPanel.txtCurBet:SetActive(false)
		TH_GameMainPanel.btnChat:SetActive(false)
		TH_GameMainPanel.btnBack:SetActive(false)
		TH_GameMainPanel.imgLoseAnim:SetActive(false)
		TH_GameMainPanel.jinhuaTip:SetActive(true)
		TH_GameMainPanel.shidianbanTip:SetActive(false)
		TH_GameMainPanel.btnPrepareButton:SetActive(false)
		TH_GameMainPanel.niuniuTip:SetActive(false)
		TH_GameMainPanel.imgClock:SetActive(false)
		if GoldFlowerRoom.RoomMsg.moneyType == RoomMode.goldMode then
			TH_GameMainPanel.btnInvitationWeChat:SetActive(false)
			TH_GameMainPanel.btnSettleQuitGame:SetActive(true)
			TH_GameMainPanel.btnFuZhiRoomNum:SetActive(false)
			if GoldFlowerRoom.RoomMsg.star then
				TH_GameMainPanel.btnPrepareButton:SetActive(false)
			elseif isPlayerReload ~= true then
				TH_GameMainPanel.btnPrepareButton:SetActive(true)
			end
			isPlayerReload = false
		elseif GoldFlowerRoom.RoomMsg.moneyType == RoomMode.wingMode then
			TH_GameMainPanel.btnInvitationWeChat:SetActive(false)
			TH_GameMainPanel.btnSettleQuitGame:SetActive(true)
			TH_GameMainPanel.btnFuZhiRoomNum:SetActive(false)
			if GoldFlowerRoom.RoomMsg.star then
				TH_GameMainPanel.btnPrepareButton:SetActive(false)
			elseif isPlayerReload ~= true then
				TH_GameMainPanel.btnPrepareButton:SetActive(true)
			end
			isPlayerReload = false
		end
		TH_GameMainPanel.imgPublicCard:GetComponent("Image").sprite = self.publicCardSprite.jh

		self.jinhuaList = {
			baozi = TH_GameMainPanel.imgBaoZi:GetComponent("Image").sprite,
			shunjin = TH_GameMainPanel.imgShunJin:GetComponent("Image").sprite,
			jinhua = TH_GameMainPanel.imgJinHua:GetComponent("Image").sprite,
			shunzi = TH_GameMainPanel.imgShunZi:GetComponent("Image").sprite
		}

		self.vsList = {
			objL =
			{
				head = TH_GameMainPanel.Lhead,
				score = TH_GameMainPanel.LtxtScore,
				name = TH_GameMainPanel.LtxtName,
				cardList =
				{
					TH_GameMainPanel.Limg1:GetComponent("Image"),
					TH_GameMainPanel.Limg2:GetComponent("Image"),
					TH_GameMainPanel.Limg3:GetComponent("Image")
				}
			},
			objR =
			{
				head = TH_GameMainPanel.Rhead,
				score = TH_GameMainPanel.RtxtScore,
				name = TH_GameMainPanel.RtxtName,
				cardList =
				{
					TH_GameMainPanel.Rimg1:GetComponent("Image"),
					TH_GameMainPanel.Rimg2:GetComponent("Image"),
					TH_GameMainPanel.Rimg3:GetComponent("Image")
				}
			}
		}

		local thWanfa1 = ''
		local thWanfa2 = ''
		local thWanfa3 = ''
		local thWanfa = ''
		if GoldFlowerRoom.RoomMsg.jinHuaTotal == 8 then
			thWanfa1 = "8局"
		elseif GoldFlowerRoom.RoomMsg.jinHuaTotal == 16 then
			thWanfa1 = "16局"
		end

		-- 新添加
		if GoldFlowerRoom.RoomMsg.moneyType == RoomMode.goldMode then
			thWanfa1 = ""
		elseif GoldFlowerRoom.RoomMsg.moneyType == RoomMode.wingMode then
			thWanfa1 = ""
		end

		if GoldFlowerRoom.RoomMsg.jinHuaPlayMethond == 1 then
			thWanfa2 = "比大小"
		elseif GoldFlowerRoom.RoomMsg.jinHuaPlayMethond == 2 then
			thWanfa2 = "比花色"
		elseif GoldFlowerRoom.RoomMsg.jinHuaPlayMethond == 3 then
			thWanfa2 = "全比"
		end
		if GoldFlowerRoom.RoomMsg.isLeopard == 1 then
			thWanfa3 = '豹子奖励'
		else
			thWanfa3 = ''
		end
		if GoldFlowerRoom.RoomMsg.isDouble == 1 then
			thWanfa4 = '             双倍比牌'
		else
			thWanfa4 = ''
		end
		thWanfa = thWanfa1 .. '/' .. thWanfa2 .. thWanfa3 .. thWanfa4
		self.gameWanfa = thWanfa

		if thWanfa3 == '' and thWanfa4 == '' then
			self:SetText(GoldFlowerRoom.txtWanFa, "玩法：" .. thWanfa2 .. "\n")
		elseif thWanfa3 == '豹子奖励' and thWanfa4 == '' then
			self:SetText(GoldFlowerRoom.txtWanFa, "玩法：" .. thWanfa2 .. "\n" .. "特殊：豹子奖励")
		elseif thWanfa3 == '' and thWanfa4 == '             双倍比牌' then
			self:SetText(GoldFlowerRoom.txtWanFa, "玩法：" .. thWanfa2 .. "\n" .. "特殊：双倍比牌")
		elseif thWanfa3 == '豹子奖励' and thWanfa4 == '             双倍比牌' then
			self:SetText(GoldFlowerRoom.txtWanFa, "玩法：" .. thWanfa2 .. "\n" .. "特殊：" .. thWanfa3 .. "\n" .. thWanfa4 .. "\n")
		end

		local txtTop = '<color=#EEEEEE>封顶</color>：0/' .. GoldFlowerRoom.alltop
		local txtMen = ''
		if GoldFlowerRoom.allmenLun == 0 then
			txtMen = '<color=#EEEEEE>不闷</color>'
		else
			txtMen = '<color=#EEEEEE>闷牌</color>：0/' .. GoldFlowerRoom.allmenLun
		end
		local txtBi = '<color=#EEEEEE>比牌</color>：0/' .. GoldFlowerRoom.allbiLun

		GoldFlowerRoom.txtRoomNum.transform.localPosition = Vector3.New(17, 70, 0)

		local Ronda = ""
		if GoldFlowerRoom.RoomMsg.mcreenings == 1 then
			Ronda = "新手场"
		elseif GoldFlowerRoom.RoomMsg.mcreenings == 2 then
			Ronda = "初级场"
		elseif GoldFlowerRoom.RoomMsg.mcreenings == 3 then
			Ronda = "中级场"
		elseif GoldFlowerRoom.RoomMsg.mcreenings == 4 then
			Ronda = "高级场"
		elseif GoldFlowerRoom.RoomMsg.mcreenings == 5 then
			Ronda = "土豪场"
		end

		if GoldFlowerRoom.RoomMsg.moneyType == RoomMode.goldMode then
			self:SetText(GoldFlowerRoom.txtRoomNum, "")
			self:SetText(GoldFlowerRoom.txtWanFa, "")
			self:SetText(GoldFlowerRoom.txtRoomMessage, '')
			self:SetText(GoldFlowerRoom.txtPlayMathond, "")
			self:SetText(GoldFlowerRoom.txtJuShu, "")
			self:SetText(GoldFlowerRoom.txtMessage, "金币" .. Ronda .. "\n" .. "玩法：全比" .. "\n" .. "特殊：双倍比牌" .. "\n" .. txtTop .. "\n" .. txtBi .. "\n" .. "底分：" .. GoldFlowerRoom.RoomMsg.baseNum)
		elseif GoldFlowerRoom.RoomMsg.moneyType == RoomMode.wingMode then
			self:SetText(GoldFlowerRoom.txtRoomNum, "")
			self:SetText(GoldFlowerRoom.txtWanFa, "")
			self:SetText(GoldFlowerRoom.txtRoomMessage, '')
			self:SetText(GoldFlowerRoom.txtPlayMathond, "")
			self:SetText(GoldFlowerRoom.txtJuShu, "")
			self:SetText(GoldFlowerRoom.txtMessage, "元宝" .. Ronda .. "\n" .. "玩法：全比" .. "\n" .. "特殊：双倍比牌" .. "\n" .. txtTop .. "\n" .. txtBi .. "\n" .. "底分：" .. GoldFlowerRoom.RoomMsg.baseNum)
		else
			self:SetText(GoldFlowerRoom.txtRoomNum, '房号：' .. tostring(GoldFlowerRoom.RoomMsg.id))
			self:SetText(GoldFlowerRoom.txtPlayMathond, "总注：0" .. "\n" .. txtTop .. "\n" .. txtMen .. "\n" .. txtBi)
		end

		for i = 1, 8 do
			self.spriteList["bet" .. i] = TH_GameMainPanel.betList.transform:FindChild("" .. i):GetComponent("Image").sprite
		end
		self.vsIndex = 0
		self.lookName = 0
		self.isCanClick = true
		-- 获取表情
		local face = TH_GameMainPanel.imgFace
		for i = 1, face.transform.childCount do
			local obj = face.transform:GetChild(i - 1)
			self:AddClick(obj.gameObject, GoldFlowerRoom.SendFaceIcon)
		end
		TH_GameMainCtrl.ShowCount()
		Game.MusicBG("bgm2")
		self.clockTxt = TH_GameMainPanel.txtClock.transform:GetComponent('Text')
	elseif Room.gameType == RoomType.NiuNiu then
		print("------------<<<<<<<<<----<<<<<<牛牛房间信息显示<<<----<<<<<<<<<----<<<<<<<<<")
		-- 牛牛
		TH_GameMainPanel.imgSettlementLost:SetActive(false)
		TH_GameMainPanel.imgSettlementWin:SetActive(false)
		TH_GameMainPanel.imgBeiShu:SetActive(false)
		TH_GameMainPanel.txtCurBet:SetActive(false)
		TH_GameMainPanel.btnChat:SetActive(false)
		TH_GameMainPanel.jinhuaTip:SetActive(false)
		TH_GameMainPanel.shidianbanTip:SetActive(false)
		TH_GameMainPanel.niuniuTip:SetActive(true)
		TH_GameMainPanel.btnHuanPai:SetActive(false)
		TH_GameMainPanel.btnShowPai:SetActive(false)
		TH_GameMainPanel.btnHintCard:SetActive(false)
		TH_GameMainPanel.btnBuHuan:SetActive(false)
		TH_GameMainPanel.imgClock:SetActive(false)
		TH_GameMainPanel.objN1:SetActive(false)
		TH_GameMainPanel.objN2:SetActive(false)
		TH_GameMainPanel.objN3:SetActive(false)
		TH_GameMainPanel.objN4:SetActive(false)
		TH_GameMainPanel.objN5:SetActive(false)
		TH_GameMainPanel.objN6:SetActive(false)
		TH_GameMainPanel.objN7:SetActive(false)
		TH_GameMainPanel.btnPrepareButton:SetActive(false)
		if NiuNiuRoom.RoomMsg.moneyType == RoomMode.goldMode then
			TH_GameMainPanel.btnInvitationWeChat:SetActive(false)
			TH_GameMainPanel.btnSettleQuitGame:SetActive(false)
			TH_GameMainPanel.btnFuZhiRoomNum:SetActive(false)
			if NiuNiuRoom.RoomMsg.star then
				TH_GameMainPanel.btnPrepareButton:SetActive(false)
			elseif isPlayerReload ~= true then
				-- 断线重连的时候是不能出现准备按钮的
				TH_GameMainPanel.btnPrepareButton:SetActive(true)
			end
			isPlayerReload = false
		elseif NiuNiuRoom.RoomMsg.moneyType == RoomMode.wingMode then
			TH_GameMainPanel.btnInvitationWeChat:SetActive(false)
			TH_GameMainPanel.btnSettleQuitGame:SetActive(false)
			TH_GameMainPanel.btnFuZhiRoomNum:SetActive(false)
			if NiuNiuRoom.RoomMsg.star then
				TH_GameMainPanel.btnPrepareButton:SetActive(false)
			elseif isPlayerReload ~= true then
				TH_GameMainPanel.btnPrepareButton:SetActive(true)
			end
			isPlayerReload = false
		end
		TH_GameMainPanel.imgPublicCard:GetComponent("Image").sprite = self.publicCardSprite.nn
		local thWanfa1 = ''
		local thWanfa2 = ''
		local thWanfa3 = ''
		local thWanfa = ''
		self:SetText(NiuNiuRoom.txtRoomNum, '房号：' .. tostring(NiuNiuRoom.RoomMsg.id))
		if NiuNiuRoom.RoomMsg.moneyType == 0 then
			print("------------------------这是牛牛房卡场--------------------------------------------")
			local fen = NiuNiuRoom.RoomMsg.baseScore
			thWanfa1 = fen .. "分"
			self.scoreBet = 0
			if fen == "1-4" then
				self.scoreBet = 1
			--[[elseif fen == "3-6" then
				self.scoreBet = 3
			elseif fen == "5-8" then
				self.scoreBet = 5
			elseif fen == "7-10" then
				self.scoreBet = 7--]]
			end
			self.BtnList = {
				{ num = 0, txt = TH_GameMainPanel.btn1txt },
				{ num = 0, txt = TH_GameMainPanel.btn2txt },
				{ num = 0, txt = TH_GameMainPanel.btn3txt },
				{ num = 0, txt = TH_GameMainPanel.btn4txt },
			}
			-- 牛牛牌型提示
			if NiuNiuRoom.RoomMsg.special ~= "ul" and NiuNiuRoom.RoomMsg.special ~= "" then
				self.niuTipList = { }
				self.niuTipList[17] = TH_GameMainPanel.objN1
				self.niuTipList[16] = TH_GameMainPanel.objN2
				self.niuTipList[15] = TH_GameMainPanel.objN3
				self.niuTipList[14] = TH_GameMainPanel.objN4
				self.niuTipList[13] = TH_GameMainPanel.objN5
				self.niuTipList[12] = TH_GameMainPanel.objN6
				self.niuTipList[11] = TH_GameMainPanel.objN7
				local strArray = ""
				strArray = string_split(NiuNiuRoom.RoomMsg.special, "|")

				for a, b in ipairs(strArray) do
					self.niuTipList[tonumber(b)]:SetActive(true)
				end
			end

			-- 按钮分显示
			for i, v in ipairs(self.BtnList) do
				v.num = self.scoreBet
				self:SetText(v.txt, self.scoreBet .. " 倍")
				self.scoreBet = self.scoreBet + 1
			end

			if NiuNiuRoom.RoomMsg.totalJushu == 10 then
				thWanfa2 = "10局"
			elseif NiuNiuRoom.RoomMsg.totalJushu == 20 then
				thWanfa2 = "20局"
			end

			-- 新添加
			if NiuNiuRoom.RoomMsg.moneyType == RoomMode.goldMode then
				thWanfa2 = ""
			elseif NiuNiuRoom.RoomMsg.moneyType == RoomMode.wingMode then
				thWanfa2 = ""
			end

			if NiuNiuRoom.RoomMsg.star then
				-- 游戏开始进入算观战玩家
				TH_GameMainPanel.btnFuZhiRoomNum:SetActive(false)
			end

			thWanfa3 = "6人"
			if NiuNiuRoom.RoomMsg.maxPush == 0 then
				thWanfa4 = "不推注"
				NiuNiuRoom.huanFlag = true
			else
				thWanfa4 =  "封顶"
			end
			thWanfa = thWanfa1 .. '/' .. thWanfa2 .. '/' .. thWanfa3 .. '/' .. thWanfa4

			print("--------------------------房间号-----------------------------------",tostring(NiuNiuRoom.RoomMsg.id))
			self:SetText(NiuNiuRoom.txtRoomNum, '房号：' .. tostring(NiuNiuRoom.RoomMsg.id))
		else
			local baseList = { }
			if NiuNiuRoom.RoomMsg.moneyType == 1 then
				-- 金币
				baseList = {
					[50] = "新手场:底分 ",
					[100] = "初级场:底分 ",
					[300] = "中级场:底分 ",
					[1000] = "高华场:底分 ",
					[5000] = "土豪场:底分 ",
				}
			else
				-- 元宝
				baseList = {
					[50] = "新手场:底分 ",
					[100] = "初级场:底分 ",
					[200] = "中级场:底分 ",
					[500] = "高华场:底分 ",
					[1000] = "土豪场:底分 ",
				}
			end
			local fen = NiuNiuRoom.RoomMsg.baseNum
			--thWanfa1 = baseList[fen] .. fen
			self.BtnList = {
				{ num = 0, txt = TH_GameMainPanel.btn1txt },
				{ num = 0, txt = TH_GameMainPanel.btn2txt },
				{ num = 0, txt = TH_GameMainPanel.btn3txt },
				{ num = 0, txt = TH_GameMainPanel.btn4txt },
			}


			local startValue = tonumber(string.sub(NiuNiuRoom.RoomMsg.baseScore, 1, 1))
			local endValue = tonumber(string.sub(NiuNiuRoom.RoomMsg.baseScore, 3, 3))
			--[[for i = startValue, endValue do
				self.BtnList[i].num = i
				self:SetText(self.BtnList[i].txt, self.BtnList[i].num .. "倍")
			end--]]

			-- 牛牛牌型提示
			if NiuNiuRoom.RoomMsg.special ~= "ul" and NiuNiuRoom.RoomMsg.special ~= "" then
				self.niuTipList = { }
				self.niuTipList[17] = TH_GameMainPanel.objN1
				self.niuTipList[16] = TH_GameMainPanel.objN2
				self.niuTipList[15] = TH_GameMainPanel.objN3
				self.niuTipList[14] = TH_GameMainPanel.objN4
				self.niuTipList[13] = TH_GameMainPanel.objN5
				self.niuTipList[12] = TH_GameMainPanel.objN6
				self.niuTipList[11] = TH_GameMainPanel.objN7
				local strArray = ""
				strArray = string_split(NiuNiuRoom.RoomMsg.special, "|")
				for a, b in ipairs(strArray) do
					self.niuTipList[tonumber(b)]:SetActive(true)
				end
			end
			thWanfa = thWanfa1
			TH_GameMainPanel.btnGameStart:SetActive(false)
			TH_GameMainPanel.btnInvitationWeChat:SetActive(false)
			TH_GameMainPanel.btnSettleQuitGame:SetActive(false)
			TH_GameMainPanel.btnFuZhiRoomNum:SetActive(false)
			local textTenharfBasenum = '底注：' .. tostring(NiuNiuRoom.RoomMsg.baseNum)
			local textTenharfQualified = tostring(NiuNiuRoom.RoomMsg.qualified) .. '进' .. tostring(TenharfRoom.RoomMsg.qualified) .. '出'
			self:SetText(NiuNiuRoom.txtJuShu, textTenharfBasenum .. "\n" .. textTenharfQualified)
			self:SetText(NiuNiuRoom.txtRoomMessage, '')
		end
		self.gameWanfa = thWanfa
		local Ronda = ""
		if NiuNiuRoom.RoomMsg.mcreenings == 1 then
			Ronda = "新手场"
		elseif NiuNiuRoom.RoomMsg.mcreenings == 2 then
			Ronda = "初级场"
		elseif NiuNiuRoom.RoomMsg.mcreenings == 3 then
			Ronda = "中级场"
		elseif NiuNiuRoom.RoomMsg.mcreenings == 4 then
			Ronda = "高级场"
		elseif NiuNiuRoom.RoomMsg.mcreenings == 5 then
			Ronda = "土豪场"
		end

		if NiuNiuRoom.RoomMsg.moneyType == RoomMode.goldMode then
			self:SetText(NiuNiuRoom.txtRoomNum, "")
			self:SetText(NiuNiuRoom.txtWanFa, "")
			self:SetText(NiuNiuRoom.txtJuShu, "")
			self:SetText(NiuNiuRoom.txtMessage, "金币" .. Ronda .. "\n" .. "选庄：明牌抢庄" .. "\n" .. "底注：1-4分" .. "\n" .. "底分：" .. NiuNiuRoom.RoomMsg.baseNum)
		elseif NiuNiuRoom.RoomMsg.moneyType == RoomMode.wingMode then
			self:SetText(NiuNiuRoom.txtRoomNum, "")
			self:SetText(NiuNiuRoom.txtWanFa, "")
			self:SetText(NiuNiuRoom.txtJuShu, "")
			self:SetText(NiuNiuRoom.txtMessage, "元宝" .. Ronda .. "\n" .. "选庄：明牌抢庄" .. "\n" .. "底注：1-4分" .. "\n" .. "底分：" .. NiuNiuRoom.RoomMsg.baseNum)
		else
			--self:SetText(NiuNiuRoom.txtWanFa, "选庄：明牌抢庄" .. "\n" .. "底分：" .. thWanfa1 .. "\n" .. "封顶：" .. thWanfa4)
			self:SetText(NiuNiuRoom.txtWanFa, "底分：" .. thWanfa1)
		end

		self.clockTxt = TH_GameMainPanel.txtClock.transform:GetComponent('Text')
		print(self.clockTxt)
		print(TH_GameMainPanel.txtClock)
		self.niuniuList = {
			n0 = TH_GameMainPanel.img0:GetComponent("Image").sprite,
			n1 = TH_GameMainPanel.img1:GetComponent("Image").sprite,
			n2 = TH_GameMainPanel.img2:GetComponent("Image").sprite,
			n3 = TH_GameMainPanel.img3:GetComponent("Image").sprite,
			n4 = TH_GameMainPanel.img4:GetComponent("Image").sprite,
			n5 = TH_GameMainPanel.img5:GetComponent("Image").sprite,
			n6 = TH_GameMainPanel.img6:GetComponent("Image").sprite,
			n7 = TH_GameMainPanel.img7:GetComponent("Image").sprite,
			n8 = TH_GameMainPanel.img8:GetComponent("Image").sprite,
			n9 = TH_GameMainPanel.img9:GetComponent("Image").sprite,
			n10 = TH_GameMainPanel.img10:GetComponent("Image").sprite,
			n11 = TH_GameMainPanel.img11:GetComponent("Image").sprite,
			n12 = TH_GameMainPanel.img12:GetComponent("Image").sprite,
			n13 = TH_GameMainPanel.img13:GetComponent("Image").sprite,
			n14 = TH_GameMainPanel.img14:GetComponent("Image").sprite,
			n15 = TH_GameMainPanel.img15:GetComponent("Image").sprite,
			n16 = TH_GameMainPanel.img16:GetComponent("Image").sprite,
			n17 = TH_GameMainPanel.img17:GetComponent("Image").sprite,
		}

		self.niuBetList = {
			TH_GameMainPanel.bet1:GetComponent("Image").sprite,
			TH_GameMainPanel.bet2:GetComponent("Image").sprite,
			TH_GameMainPanel.bet3:GetComponent("Image").sprite,
			TH_GameMainPanel.bet4:GetComponent("Image").sprite,
		}

		TH_GameMainCtrl.ShowCount()
		--Game.MusicBG("bgm3")
		self.isDown = false
		self.isOver = false
		self.isFrist = false
		self.DownCard = nil
		self.UpCard = nil
	end
	-- NoticeTipsCtrl:Open("NoticeTips")
	-- self:InputSendCode(false)
end
-- 发送作弊码--
function TH_GameMainCtrl:InputSendCode(isShow)
	TH_GameMainPanel.inputSendCode:SetActive(isShow)
	TH_GameMainPanel.btnSendCode:SetActive(isShow)
end
-- 发送作弊码
function TH_GameMainCtrl.SendDeBugCode()
	self = TH_GameMainCtrl
	local txtCode = self:GetInputText(TH_GameMainPanel.inputSendCode)
	local signInfo = StringPara_pb.StringParaReq()
	signInfo.val = txtCode
	local msg = signInfo:SerializeToString()
	Game.SendProtocal(Protocal.StringPara, msg)
end
-- 显示数字
function TH_GameMainCtrl:NumberShow(num)
	if num >= 0 then
		self:SetText(TH_GameMainPanel.txtWin, "+" .. num)
		TH_GameMainPanel.txtWin:SetActive(true)
		TH_GameMainPanel.txtLose:SetActive(false)
	else
		self:SetText(TH_GameMainPanel.txtLose, "" .. num)
		TH_GameMainPanel.txtWin:SetActive(false)
		TH_GameMainPanel.txtLose:SetActive(true)
	end
end

-- 复制房间号
function TH_GameMainCtrl.OnFuZhiRoomNum(go)
	local self = TH_GameMainCtrl
	--Game.MusicEffect(Game.Effect.joinRoom)
	if Room.gameType == RoomType.Tenharf then
		Util.CopyText(tostring(TenharfRoom.RoomMsg.id))
	elseif Room.gameType == RoomType.GoldFlower then
		Util.CopyText(tostring(GoldFlowerRoom.RoomMsg.id))
	elseif Room.gameType == RoomType.NiuNiu then
		print("===============复制房号====================",Room.gameType,RoomType.NiuNiu)
		Util.CopyText(tostring(NiuNiuRoom.RoomMsg.id))
	end
	TH_GameMainCtrl.SetIconTips("已复制成功房号到粘贴板")
end

function TH_GameMainCtrl.OnShowGameSettingClick(go)
	TH_GameMainPanel.PanelGameSetting:SetActive(true)
	TH_GameMainPanel.btnSettingGame:SetActive(false)
	TH_GameMainPanel.btnHideUp:SetActive(true)
end

function TH_GameMainCtrl.OnHidePanelClick(go)
	TH_GameMainPanel.PanelGameSetting:SetActive(false)
	TH_GameMainPanel.btnHideUp:SetActive(false)
	TH_GameMainPanel.btnSettingGame:SetActive(true)
end



function TH_GameMainCtrl.OnInvitationWeChatBtnClick(go)
	local self = TH_GameMainCtrl
	--Game.MusicEffect(Game.Effect.joinRoom)
	local currentPalyNum = 0
	if Room.gameType == RoomType.Tenharf then
		currentPalyNum = TenharfRoom.playerCount
	elseif Room.gameType == RoomType.GoldFlower then
		currentPalyNum = GoldFlowerRoom.playerCount
	elseif Room.gameType == RoomType.NiuNiu then
		currentPalyNum = NiuNiuRoom.playerCount
	end
	print('TH_GameMainCtrl.OnInvitationWeChatBtnClick===========', currentPalyNum)
	local playNum = 5 - currentPalyNum
	local playNumText = ""
	if playNum == 1 then
		playNumText = "4缺1"
	elseif playNum == 2 then
		playNumText = "3缺2"
	elseif playNum == 3 then
		playNumText = "2缺3"
	elseif playNum == 4 then
		playNumText = "1缺4"
	end

	if Room.gameType == RoomType.Tenharf then
		local shareContent = "房号:" .. tostring(TenharfRoom.RoomMsg.id) .. ",玩法:" .. tostring(self.gameWanfa) .. ",速度来啊!【十点半】"
		local imageUrl = 'http://download.hzjiuyou.com/shareicon/shidianban.png'
		local title = "十点半-" .. tostring(TenharfRoom.RoomMsg.id) .. "，" .. tostring(playNumText)
		local downUrl = 'http://download.hzjiuyou.com/dl/hzdownload.htm'
		weChatFunction.weChatInviteFriendBtnClick(shareContent, imageUrl, title, downUrl)
	elseif Room.gameType == RoomType.GoldFlower then
		local shareContent = "房号:" .. tostring(GoldFlowerRoom.RoomMsg.id) .. ",玩法:" .. tostring(self.gameWanfa) .. ",速度来啊!【拼三张】"
		local imageUrl = 'http://download.hzjiuyou.com/shareicon/pinsanz.png'
		local title = "拼三张-" .. tostring(GoldFlowerRoom.RoomMsg.id) .. "，" .. tostring(playNumText)
		local downUrl = 'http://download.hzjiuyou.com/dl/hzdownload.htm'
		weChatFunction.weChatInviteFriendBtnClick(shareContent, imageUrl, title, downUrl)
	elseif Room.gameType == RoomType.NiuNiu then
		local shareContent = "房号:" .. tostring(NiuNiuRoom.RoomMsg.id) .. ",玩法:" .. tostring(self.gameWanfa) .. ",速度来啊!【牛牛】"
		local imageUrl = '' 	 --图片
		local title = "牛牛-" .. tostring(NiuNiuRoom.RoomMsg.id) .. "，" .. tostring(playNumText)
		local downUrl = 'https://fir.im/s1hn' 		 --下载地址
		weChatFunction.weChatInviteFriendBtnClick(shareContent, imageUrl, title, downUrl)
	end
end

-- 开始游戏按钮
function TH_GameMainCtrl.OnGameStartBtnClick(go)
	-- 开始游戏
	if Room.gameType == RoomType.Tenharf then
		local startGame = TenHalfStartGame_pb.TenHalfStartGameRes()
		local msg = startGame:SerializeToString()
		Game.SendProtocal(Protocal.TenHalfStartGame, msg)
	elseif Room.gameType == RoomType.GoldFlower then
		local msg = ""
		Game.SendProtocal(Protocal.GoldStartGame, msg)
	elseif Room.gameType == RoomType.NiuNiu then
		local msg = ""
		Game.SendProtocal(Protocal.NiuDeal, msg)
	end
end

function TH_GameMainCtrl.OnStartGameInfoShow(jushu)
	local self = TH_GameMainCtrl
	TH_GameMainPanel.imgSignalBG:SetActive(false)
	TH_GameMainPanel.imgHTWaitFriends:SetActive(false)
	TH_GameMainPanel.imgHTGameMain:SetActive(true)
	TH_GameMainPanel.imgQuitTips:SetActive(false)
	TH_GameMainPanel.btnGameMainQuitRoom:SetActive(true)
	TH_GameMainPanel.imgNotGameMainQuitRoom:SetActive(false)
	TH_GameMainPanel.btnWaitQuitRoom:SetActive(false)
	TH_GameMainPanel.imgNotWaitQuitRoom:SetActive(true) --灰色
	-- TH_GameMainPanel.btnChat:SetActive(false)
	local room = nil
	if Room.gameType == RoomType.Tenharf then
		room = TenharfRoom
		room.txtRoomNum.transform.localPosition = Vector3.New(0, 114, 0)
	elseif Room.gameType == RoomType.NiuNiu then
		room = NiuNiuRoom
	end
	-- 新添加
	if room.RoomMsg.moneyType == RoomMode.goldMode or room.RoomMsg.moneyType == RoomMode.wingMode then
		TH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
		TH_GameMainPanel.imgNotGameMainQuitRoom:SetActive(true)
	end
	room.imgJuShu:SetActive(false)
	self:SetText(room.txtJuShu, jushu or "")
	-- 新添加
	local textTenharfBasenum = '底注：' .. tostring(TenharfRoom.RoomMsg.baseNum)
	local textTenharfQualified = tostring(TenharfRoom.RoomMsg.qualified) .. '进' .. tostring(TenharfRoom.RoomMsg.qualified) .. '出'
	if room.RoomMsg.moneyType == RoomMode.goldMode then
		self:SetText(TenharfRoom.txtJuShu, "")
	elseif room.RoomMsg.moneyType == RoomMode.wingMode then
		self:SetText(TenharfRoom.txtJuShu, "")
	end
end

function TH_GameMainCtrl:FenShow(bool)
	if Room.gameType == RoomType.Tenharf then
		fenshu:SetActive(bool)
		if TenharfRoom.RoomMsg.isWang == 0 then
			TH_GameMainPanel.btn2Fen.transform.localPosition = Vector3.New(-225, 0, 0)
			TH_GameMainPanel.btn3Fen.transform.localPosition = Vector3.New(-75, 0, 0)
			TH_GameMainPanel.btn4Fen:SetActive(false)
			TH_GameMainPanel.btn5FenD.transform.localPosition = Vector3.New(225, 0, 0)
		elseif TenharfRoom.RoomMsg.isWang == 1 then
			TH_GameMainPanel.btn5FenG.transform.localPosition = Vector3.New(-225, 0, 0)
			TH_GameMainPanel.btn8Fen.transform.localPosition = Vector3.New(-75, 0, 0)
			TH_GameMainPanel.btn10Fen.transform.localPosition = Vector3.New(75, 0, 0)
			TH_GameMainPanel.btn15Fen.transform.localPosition = Vector3.New(225, 0, 0)
		end
	else
		TH_GameMainPanel.imgFenShu2:SetActive(bool)
	end
end

-- 随机庄
function TH_GameMainCtrl:PlayGame(zhuang, suiji, roleIndex, cardInfo)
	local self = TH_GameMainCtrl
	if Room.gameType == RoomType.Tenharf then
		self.OnStartGameInfoShow()
		local totalJushu = TenharfRoom.playerCount * TenharfRoom.RoomMsg.tenHalfTotal
		self:SetText(TenharfRoom.txtJuShu, '局数：1' .. '/' .. tostring(totalJushu))
		local num = #TenharfRoom.players
		if suiji then
			local cards = TH_GameMainPanel.imgPublicCard
			TenharfRoom:IconMove(zhuang, cards)
		else
			TenharfRoom.players[zhuang].imgZhuang:SetActive(true)
			if not TenharfRoom.players[zhuang].imgZhuang then
				TenharfRoom.players[zhuang].imgZhuang:SetActive(true)
			end
			TH_GameMainPanel.imgPublicCard:SetActive(true)
			-- 发牌的背景牌
			TenharfRoom:DealCards(zhuang)
		end
		-- 新添加
		local textTenharfBasenum = '底注：' .. tostring(TenharfRoom.RoomMsg.baseNum)
		local textTenharfQualified = tostring(TenharfRoom.RoomMsg.qualified) .. '进' .. tostring(TenharfRoom.RoomMsg.qualified) .. '出'
		if TenharfRoom.RoomMsg.moneyType == RoomMode.goldMode or TenharfRoom.RoomMsg.moneyType == RoomMode.wingMode then
			self:SetText(TenharfRoom.txtJuShu, "")
			TenharfRoom.imgJuShu:SetActive(false)
			TenharfRoom.txtRoomNum.transform.localPosition = Vector3.New(0, 60, 0)
		end
	elseif Room.gameType == RoomType.NiuNiu then
		TH_GameMainPanel.imgHTWaitFriends:SetActive(false)
		TH_GameMainPanel.imgNNGameMain:SetActive(true)
		TH_GameMainPanel.imgQuitTips:SetActive(false)
		TH_GameMainPanel.btnGameMainQuitRoom:SetActive(true)
		TH_GameMainPanel.imgNotGameMainQuitRoom:SetActive(false)
		-- 新添加
		if NiuNiuRoom.RoomMsg.moneyType == RoomMode.goldMode or NiuNiuRoom.RoomMsg.moneyType == RoomMode.wingMode then
			TH_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
			TH_GameMainPanel.imgNotGameMainQuitRoom:SetActive(true)
		end

		TH_GameMainPanel.btnChat:SetActive(false)
		local num = #NiuNiuRoom.players
		if suiji then
			local cards = TH_GameMainPanel.imgPublicCard
			NiuNiuRoom:IconMove(zhuang, cards, roleIndex, cardInfo)
		else
			NiuNiuRoom.players[zhuang].imgZhuang:SetActive(true)
			TH_GameMainPanel.imgPublicCard:SetActive(true)
			NiuNiuRoom:DealCards(zhuang, roleIndex, cardInfo)
		end
	end
end

function TH_GameMainCtrl.OnChatBtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	GameChatCtrl:Open('GameChat')
end
-- 下注
local turnNum = 0
function TH_GameMainCtrl.OnFenBtnClick(go)

	local fen = 0
	local room = nil
	if Room.gameType == RoomType.Tenharf then
		room = TenharfRoom
	elseif Room.gameType == RoomType.GoldFlower then
		room = GoldFlowerRoom
		--Game.MusicEffect(Game.Effect.bet)
	elseif Room.gameType == RoomType.NiuNiu then
		if go.name == "btn2Fen" then
			fen = 2
		elseif go.name == "btn3Fen" then
			fen = 3
		elseif go.name == "btn4Fen" then
			fen = 4
		elseif go.name == "btn5FenD" then
			fen = 5
		end
		NiuNiuRoom.NiuNiuBetReq(fen)
		--Game.MusicEffect(Game.Effect.niuBet)
		return
	end
	if room.RoomMsg.isWang == 0 then
		if go.name == "btn2Fen" then
			fen = 2
		elseif go.name == "btn3Fen" then
			fen = 3
			-- elseif go.name == "btn4Fen" then
			--     fen = 4
		elseif go.name == "btn5FenD" then
			fen = 5
		end
	else
		if go.name == "btn5FenG" then
			fen = 5
		elseif go.name == "btn8Fen" then
			fen = 8
		elseif go.name == "btn10Fen" then
			fen = 10
		elseif go.name == "btn15Fen" then
			fen = 15
		end
	end
	if Room.gameType == RoomType.Tenharf then
		TenharfRoom.TenHalfBetReq(fen)
		--Game.MusicEffect(Game.Effect.bet)
	end
end

-- 补牌
function TH_GameMainCtrl.OnBuPaiBtnClick(go)
	if go.name == "btnBuPai" then
		TenharfRoom.TenHalfBuCardReq(true)
	else
		TenharfRoom.TenHalfBuCardReq(false)
	end
end

function TH_GameMainCtrl:ClickIcon(id, iconObj)
	local roleInfo = { }
	local room = nil
	if Room.gameType == RoomType.Tenharf then
		room = TenharfRoom
	elseif Room.gameType == RoomType.GoldFlower then
		room = GoldFlowerRoom
	elseif Room.gameType == RoomType.NiuNiu then
		room = NiuNiuRoom
	elseif Room.gameType == RoomType.Landlords then
		room = LandlordsRoom
	end
	for i, v in ipairs(room.playersData) do
		if id == v.roleId then
			roleInfo = {
				name = v.name,
				roleId = v.roleId,
				roleIp = v.ip,
				image = iconObj,
				sex = v.sex,
				index = v.index
			}
			break
		end
	end

	TH_RoleInfoCtrl:Open("TH_RoleInfo", function()
		if TH_GameMainPanel.imgHTWaitFriends.activeSelf then
			TH_RoleInfoCtrl:InitPanel(roleInfo, false, room)
		else
			TH_RoleInfoCtrl:InitPanel(roleInfo, true, room)
		end
	end )
end

-- 点击头像
function TH_GameMainCtrl.OnClickHead(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	TH_GameMainCtrl:ClickIcon(go.name, go)
end

-- 持续更新信息显示
function TH_GameMainCtrl.ShowCount()
	self = TH_GameMainCtrl
	self:InvokeRepeat("CardTime", 0.1, 300000000)
end

local clockTime = 15
local clockingTime = 10
local clockStart = false

function TH_GameMainCtrl.CardTime()
	local self = TH_GameMainCtrl
	-- 系统时间
	dateTime = dateTime - 0.1
	if dateTime < 0 then
		if TH_GameMainPanel.txtTime ~= nil then
			self:SetText(TH_GameMainPanel.txtTime, AppConst.GetDate())
		end
		dateTime = 10
	end
	-- 网络信号获取间隔
	netTime = netTime - 0.1
	if netTime < 0 then
		self:NetWork()
		netTime = 5
	end
	self.FaceIcon()

	-- 闹钟倒计时
	if clockStart then
		clockTime = clockTime - 0.1
		t1, t2 = math.modf(clockTime)
		local txt = TH_GameMainPanel.txtClock.transform:GetComponent('Text')
		if t1 < 10 then
			txt.text = '0' .. t1
		else
			txt.text = t1
		end
		if clockTime <= 0 then
			txt.text = '00'
			clockStart = false
			--Game.MusicEffect("naozhong")
		end
		TH_GameMainPanel.imgClock:GetComponent("Image").fillAmount =(clockTime - 1) / clockingTime
	end
end


-- 语音及音效--
function TH_GameMainCtrl.FaceIcon()
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
	else
		if global.systemVo.isTalk == "0" then
			global.systemVo.BGSource.volume = 0.3
		else
			global.systemVo.BGSource.volume = 0
		end
	end
end

-- 网络信号
function TH_GameMainCtrl:NetWork()
	local level = network_delay
	if level > 0 and level < 50 then
		TH_GameMainPanel.imgSignal2:SetActive(true)
		TH_GameMainPanel.imgSignal3:SetActive(true)
		TH_GameMainPanel.imgSignal4:SetActive(true)
		TH_GameMainPanel.imgSignal5:SetActive(true)
	elseif level > 50 and level < 100 then
		TH_GameMainPanel.imgSignal2:SetActive(true)
		TH_GameMainPanel.imgSignal3:SetActive(true)
		TH_GameMainPanel.imgSignal4:SetActive(true)
		TH_GameMainPanel.imgSignal5:SetActive(true)
	elseif level > 100 and level < 150 then
		TH_GameMainPanel.imgSignal2:SetActive(true)
		TH_GameMainPanel.imgSignal3:SetActive(true)
		TH_GameMainPanel.imgSignal4:SetActive(true)
		TH_GameMainPanel.imgSignal5:SetActive(false)
	elseif level > 150 and level < 200 then
		TH_GameMainPanel.imgSignal2:SetActive(true)
		TH_GameMainPanel.imgSignal3:SetActive(true)
		TH_GameMainPanel.imgSignal4:SetActive(false)
		TH_GameMainPanel.imgSignal5:SetActive(false)
	else
		TH_GameMainPanel.imgSignal2:SetActive(true)
		TH_GameMainPanel.imgSignal3:SetActive(false)
		TH_GameMainPanel.imgSignal4:SetActive(false)
		TH_GameMainPanel.imgSignal5:SetActive(false)
	end
end

function TH_GameMainCtrl.OnSetSystemBtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local touxiang = nil
	if Room.gameType == RoomType.Tenharf then
		touxiang = TenharfRoom:GetPlayer(TenharfRoom.myIndex)
	elseif Room.gameType == RoomType.GoldFlower then
		touxiang = GoldFlowerRoom:GetPlayer(GoldFlowerRoom.myIndex)
	elseif Room.gameType == RoomType.NiuNiu then
		touxiang = NiuNiuRoom:GetPlayer(NiuNiuRoom.myIndex)
	end
	SetSystemCtrl:GetInfo(global.userVo.name, global.userVo.roleId, global.userVo.roleIp,
	BasePanel:GOChild(touxiang, "Mask/" .. global.userVo.roleId))
	SetSystemCtrl:Open('SetSystem')
end

-- 发送退出房间消息
function TH_GameMainCtrl.OnWaitQuitRoomBtnClick(go)
	--Game.MusicEffect(Game.Effect.buttonBack)
	DissolutionRoomTipsCtrl:Open('DissolutionRoomTips')
end

-- 申请解散房间--
function TH_GameMainCtrl.OnGameMainQuitRoomBtnClick(go)
	--Game.MusicEffect(Game.Effect.buttonBack)
	local self = TH_GameMainCtrl
	TH_GameMainPanel.imgQuitTips:SetActive(true)
	self:SetText(TH_GameMainPanel.txtQuitTips, "是否确认解散房间")
	-- if gameRoom.isOnes then
	--     self:SetText(TH_GameMainPanel.txtQuitTips,"解散房间不扣房卡，是否确定解散？")
	-- else
	--     self:SetText(TH_GameMainPanel.txtQuitTips,"是否确认解散房间")
	-- end
end

function TH_GameMainCtrl:OnQuitGameYse()
	--Game.MusicEffect(Game.Effect.joinRoom)
	-- if global.roomVo.id == nil then
	--     MessageTipsCtrl:ShowInfo("房号为空")
	--     return
	-- end
	Game.SendProtocal(Protocal.ApplyDisRoom)
	TH_GameMainPanel.imgQuitTips:SetActive(false)
end

function TH_GameMainCtrl:OnQuitGameNo()
	--Game.MusicEffect(Game.Effect.buttonBack)
	TH_GameMainPanel.imgQuitTips:SetActive(false)
end

-- 十点半
function TH_GameMainCtrl.OnVSCardBtnClick(go)
	local tenHalfVSCard = TenHalfVSCard_pb.TenHalfVSCardRes()
	local msg = tenHalfVSCard:SerializeToString()
	Game.SendProtocal(Protocal.TenHalfVSCard, msg)
end

function TH_GameMainCtrl.OnDangBtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	if Room.gameType == RoomType.Tenharf then
		if go.name == "btnDang" then
			TenharfRoom.TenHalfIsBankerReq(true)
		else
			TenharfRoom.TenHalfIsBankerReq(false)
		end
	elseif Room.gameType == RoomType.NiuNiu then
		if go.name == "btnDang" then
			NiuNiuRoom.NiuNiuIsBankerReq(true)
		else
			NiuNiuRoom.NiuNiuIsBankerReq(false)
		end
	end
end

function TH_GameMainCtrl.OnQiangBtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	if Room.gameType == RoomType.Tenharf then
		if go.name == "btnQiang" then
			TenharfRoom.TenHalfIsQiangBankerReq(true)
		else
			TenharfRoom.TenHalfIsQiangBankerReq(false)
		end
	elseif Room.gameType == RoomType.NiuNiu then
		if go.name == "btnQiang" then
			NiuNiuRoom.NiuNiuIsQiangBankerReq(true)
		else
			NiuNiuRoom.NiuNiuIsQiangBankerReq(false)
		end
	end
end

-- 打完一局重新开始按钮--
function TH_GameMainCtrl.OnSettleStartGameBtnClick(go)
	-- if Room.btnStartClick then return end
	--Game.MusicEffect(Game.Effect.joinRoom)
	if Room.gameType == RoomType.Tenharf then
		-- 十点半
		local tenHalfSettlementStartGame = TenHalfSettlementStartGame_pb.TenHalfSettlementStartGameRes()
		local msg = tenHalfSettlementStartGame:SerializeToString()
		Game.SendProtocal(Protocal.TenHalfSettlementStartGame, msg)
	elseif Room.gameType == RoomType.GoldFlower then
		-- 炸金花
		local goldFlowerSettlementStartGame = GoldSettlementStartGame_pb.GoldSettlementStartGameRes()
		local msg = goldFlowerSettlementStartGame:SerializeToString()
		Game.SendProtocal(Protocal.GoldSettlementStartGame, msg)
	elseif Room.gameType == RoomType.NiuNiu then
		-- 牛牛
		local msg = ""
		if NiuNiuRoom:GetPlayer(NiuNiuRoom.myIndex).isReady then return end
		Game.SendProtocal(Protocal.NiuSettlementStartGame, msg)
	end
	-- 点击开始按钮，开始按钮消失
	if TH_GameMainPanel.imgHTSingleSettlement.activeSelf then
		TH_GameMainPanel.imgHTSingleSettlement:SetActive(false)
	end

	local msg = ""
	Game.SendProtocal(Protocal.EndGameShowPai, msg)  -- 点击重新开始时清理桌面	
end

function TH_GameMainCtrl.OnSettleQuitGameBtnClick(go)
	--Game.MusicEffect(Game.Effect.buttonBack)
	Game.SendProtocal(Protocal.QuitMateRoom)
end

-- 聊天窗下--
function TH_GameMainCtrl.ChatWindow(chatSelfIndex, chatText, roomType)
	local self = TH_GameMainCtrl
	self.chatIndex = chatSelfIndex
	local go = roomType:GetPlayer(chatSelfIndex)
	local txt = go.txtChat:GetComponent("Text")
	if go.imgChat == nil then
		go.imgChat = go.transform:FindChild("imgChat").gameObject
	end
	local img = go.imgChat:GetComponent("Image")
	txt.text = chatText
	local co = coroutine.start( function()
		go.imgChat:SetActive(true)
		coroutine.wait(0)
		img.rectTransform.sizeDelta = Vector2.New(txt.rectTransform.sizeDelta.x + 50, img.rectTransform.sizeDelta.y)
		coroutine.wait(4)
		go.imgChat:SetActive(false)
		global.systemVo.BGSource.volume = 0.3
	end )
	table.insert(Network.crts, co)
end

-- 表情窗下--
function TH_GameMainCtrl.FaceIconBGD(chatSelfIndexs, isShow, go, roomType)
	local self = TH_GameMainCtrl
	roomType:GetPlayer(chatSelfIndexs).imgFaceIcon:SetActive(isShow)
	local co = coroutine.start( function()
		coroutine.wait(3)
		go:Destroy()
		roomType:GetPlayer(chatSelfIndexs).imgFaceIcon:SetActive(true)
	end )
	table.insert(Network.crts, co)
end

local R = 0
local G = 1
local K = false
local amount = 1
local kuangHead = nil
local ismyIndex = nil
function TH_GameMainCtrl:ChangeKuang(img, index)
	ismyIndex = index
	self:CancelInvoke("UpDateFunc")
	img.color = Color.green
	kuangHead = img
	K = true
	R = 0
	G = 1
	amount = 1
	self:InvokeRepeat("UpDateFunc", 0.01, 128)
end

-- 框颜色渐变
function TH_GameMainCtrl.UpDateFunc()
	if K then
		amount = amount - 0.008
		if R < 1 then
			R = R + 0.015
		elseif R ~= 1 then
			G = G - 0.015
		end
		if G <= 0.1 then
			amount = 1
			K = false
			if global.systemVo.isShakeOn == '1' then
				if ismyIndex == TenharfRoom.myIndex then
					AppConst.Vibrate()
					print("!!!!!!!!!!MY~~~Vibrate!!!!!!!!!!")
				end
			end
		end
	end
	kuangHead.color = Color.New(R, G, 0, 1)
	kuangHead.fillAmount = amount
end


function TH_GameMainCtrl.SetIconTips(str, bool)
	self = TH_GameMainCtrl
	if bool == nil then
		if TH_GameMainPanel.imgTips.activeSelf == true then return end
		TH_GameMainCtrl.ChatTips()
		local tipsText = BasePanel:GOChild(TH_GameMainPanel.imgTips, "Name")
		local tipsPos = Vector3.New(0, -172.8, 0)
		local sequence = DG.Tweening.DOTween.Sequence()
		sequence:Append(TH_GameMainPanel.imgTips.transform:DOLocalMoveY(tipsPos.y + 50, 2, false))
		:OnComplete( function()
			TH_GameMainPanel.imgTips.transform.localPosition = tipsPos
		end )
		self:SetText(tipsText, str)
	elseif bool == true then
		local tipsText = BasePanel:GOChild(TH_GameMainPanel.imgTips, "Name")
		local tipsPos = Vector3.New(0, -60, 0)
		TH_GameMainPanel.imgTips.transform.localPosition = tipsPos
		TH_GameMainPanel.imgTips:SetActive(true)
		self:SetText(tipsText, str)
	else
		TH_GameMainPanel.imgTips:SetActive(false)
	end
end

-- 聊天提示
function TH_GameMainCtrl.ChatTips()
	local self = TH_GameMainCtrl
	TH_GameMainPanel.imgTips:SetActive(true)
	coroutine.start(self.ChatWait)
end

function TH_GameMainCtrl.ChatWait()
	coroutine.wait(1.8)
	TH_GameMainPanel.imgTips:SetActive(false)
end

-- 扎金花操作按钮
function TH_GameMainCtrl:ShowOperateBtn()
	TH_GameMainPanel.imgJHCompareOrBet:SetActive(true)
end

function TH_GameMainCtrl.OnJHQiPaiClick(go)
	local msg = ""
	TH_GameMainPanel.imgJHCompareOrBet:SetActive(false)
	Game.SendProtocal(Protocal.GoldDisCards, msg)
	TH_GameMainPanel.imgFace:SetActive(false)
	-- 點擊棄牌，讓動畫顯示出來
end

-- 比牌按钮
function TH_GameMainCtrl.OnJHBiPaiClick(go)
	print("-=---------OnJHBiPaiClick--")
	local num = 0
	local kanpaiNum = 0
	local list = { }
	for i, v in ipairs(GoldFlowerRoom.players) do
		if not v.qipaiFlag then
			num = num + 1
			table.insert(list, v)
		end
		if not v.qipaiFlag and v.kanpaiFlag then
			kanpaiNum = kanpaiNum + 1
		end
	end
	if num == 2 then
		-- 如果就剩两个人
		for i, v in ipairs(list) do
			if v.index ~= GoldFlowerRoom.myIndex then
				GoldFlowerRoom.GoldVSCardReq(v.index)
				return
			end
		end
	end
	-- 提示
	if kanpaiNum < 2 then
		TH_GameMainCtrl.SetIconTips("看牌人数不足2人！")
		return
	end
	local curCache = GoldFlowerRoom:GetPlayer(GoldFlowerRoom.myIndex)
	if not curCache.kanpaiFlag and num > 2 then
		TH_GameMainCtrl.SetIconTips("你没看牌，不能比牌！")
		return
	end
	for i, v in ipairs(GoldFlowerRoom.players) do
		if v.index ~= GoldFlowerRoom.myIndex then
			if v.kanpaiFlag and not v.qipaiFlag then
				v.imgCompare:SetActive(true)
				v.imgCur:SetActive(true)
			end
		end
	end
	TH_GameMainPanel.imgJHCompareOrBet:SetActive(false)
	TH_GameMainPanel.btnBack:SetActive(true)
end

function TH_GameMainCtrl.OnBackBiClick()
	--Game.MusicEffect(Game.Effect.joinRoom)
	TH_GameMainPanel.imgJHCompareOrBet:SetActive(true)
	TH_GameMainPanel.btnBack:SetActive(false)
	for i, v in ipairs(GoldFlowerRoom.players) do
		v.imgCompare:SetActive(false)
		v.imgCur:SetActive(false)
	end
end

function TH_GameMainCtrl:SendVSReq(index)
	if self.vsIndex ~= index then
		self.vsIndex = index
		GoldFlowerRoom.GoldVSCardReq(index)
	end
end

function TH_GameMainCtrl:SendLookReq(name)
	if self.lookName ~= name then
		self.lookName = name
	end
	print("lookIndex------------", name)
	GoldFlowerRoom.GoldLookCard(GoldFlowerRoom.myIndex)
	-- 此处修改了第二局不能看牌的问题
end

function TH_GameMainCtrl.OnJHJiaZhuClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	TH_GameMainPanel.imgJHCompareOrBet:SetActive(false)
	TH_GameMainPanel.imgJHBeishu:SetActive(true)
end

function TH_GameMainCtrl.OnJHGengZhuClick(go)
	print("OnJHGengZhuClick-----------", self.isCanClick)
	if self.isCanClick then
		self.isCanClick = false
		GoldFlowerRoom.GoldAddJifenReq(fenshu, "follow")
	end
	print("OnJHGengZhuClick-----------1", self.isCanClick)
end

function TH_GameMainCtrl.OnJHAddBetClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local fenshu = 0
	if go.name == "btnUnDouble" then
		TH_GameMainPanel.imgJHCompareOrBet:SetActive(true)
		TH_GameMainPanel.imgJHBeishu:SetActive(false)
		return
	elseif go.name == "btn2Bei" then
		fenshu = 2
	elseif go.name == "btn3Bei" then
		fenshu = 3
	elseif go.name == "btn4Bei" then
		fenshu = 4
	elseif go.name == "btn5Bei" then
		fenshu = 5
	end
	GoldFlowerRoom.GoldAddJifenReq(fenshu, "add")
	TH_GameMainPanel.imgJHBeishu:SetActive(false)
end

function TH_GameMainCtrl.TipsShow(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	TH_GameMainPanel.imgShowTips:SetActive(true)
end

function TH_GameMainCtrl.TipsClose(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	TH_GameMainPanel.imgShowTips:SetActive(false)
end

-- GPS面板
function TH_GameMainCtrl.OpenGps(go)
	local room = nil
	--Game.MusicEffect(Game.Effect.joinRoom)
	if Room.gameType == RoomType.Tenharf then
		room = TenharfRoom
	elseif Room.gameType == RoomType.GoldFlower then
		room = GoldFlowerRoom
	elseif Room.gameType == RoomType.NiuNiu then
		room = NiuNiuRoom
	elseif Room.gameType == RoomType.CatchPock then
		room = CatchPockRoom
	elseif Room.gameType == RoomType.Mahjong then
		room = MahjongRoom
	elseif Room.gameType == RoomType.Landlords then
		room = LandlordsRoom
	end
	GPSInfoCtrl:Open("GPSInfo", function()
		GPSInfoCtrl:InitPanel(Room.gpsList, room)
	end )
end

-- 牛牛
-- 亮牌
function TH_GameMainCtrl.NiuNiuShowPai(go)
	local showType = false
	local data = NiuNiuShowCard_pb.NiuNiuShowCardReq()
	if go.name == "btnShowPai" then
		showType = true
		TH_GameMainPanel.btnShowPai:SetActive(false)
		TH_GameMainPanel.btnHintCard:SetActive(false)
	else
		showType = false
		TH_GameMainPanel.btnHintCard:SetActive(false)
	end
	data.isShow = showType
	local msg = data:SerializeToString()
	--Game.MusicEffect(Game.Effect.joinRoom)
	Game.SendProtocal(Protocal.NiuShow, msg)
end

-- 抢庄下注
function TH_GameMainCtrl.OnBetQiangClick(go)
	print("------------------", go.name)
	local bet = 0
	if go.name == "btnTitle" then
		bet = 0
	elseif go.name == "btnQ1" then
		bet = 1
	elseif go.name == "btnQ2" then
		bet = 2
	elseif go.name == "btnQ3" then
		bet = 3
	elseif go.name == "btnQ4" then
		bet = 4
	end
	NiuNiuRoom.NiuNiuIsQiangBankerReq(bet)
end

function TH_GameMainCtrl.OnBetClick(go)
	if go.name == "btn1" then
		bet = self.BtnList[1].num
	elseif go.name == "btn2" then
		bet = self.BtnList[2].num
	elseif go.name == "btn3" then
		bet = self.BtnList[3].num
	elseif go.name == "btn4" then
		bet = self.BtnList[4].num
	elseif go.name == "btn5" then
		bet = NiuNiuRoom:GetPlayer(NiuNiuRoom.myIndex).betScore
	end
	NiuNiuRoom.NiuNiuBetReq(bet)
	TH_GameMainPanel.btnBet:SetActive(false)
end

-- 闹钟倒计时
function TH_GameMainCtrl:CountDown(time, state)
	TH_GameMainPanel.imgClock:SetActive(true)
	clockTime = time
	clockingTime = time
	clockStart = true
	print("-----------------------------state", time, state)
end

-- 闹钟倒计时2
function TH_GameMainCtrl:CountDown2(time)
	TH_GameMainPanel.imgClock:SetActive(true)
	clockTime = time
	clockingTime = time
	clockStart = true
end

function TH_GameMainCtrl:DisableClock()
	if TH_GameMainPanel.imgClock.activeSelf then
		TH_GameMainPanel.imgClock:SetActive(false)
	end
end
-- 收到显示闹钟的消息
function TH_GameMainCtrl.GetNaoZhongRes(buffer) -- 这里的冒号改为点
	print("*******************收到显示闹钟的消息************************")
	local self = TH_GameMainCtrl
	print("------------------GetNaoZhongRes---------------")
	local data = buffer:ReadBuffer()
	local msg = CountDown_pb.CountDownRes()
	msg:ParseFromString(data)
	local times = msg.second
	local co = coroutine.start( function()
		while not TH_GameMainCtrl.isCreate do
			coroutine.step()
		end
		self:CountDown2(times)
		TH_GameMainCtrl.ShowCount()
	end )
	table.insert(Network.crts, co)

end

function TH_GameMainCtrl.OnbtnGouwucheBtnClick()
	--Game.MusicEffect(Game.Effect.joinRoom)
	ShopMallCtrl:Open("ShopMall")
end

-- 牛牛炸金花十点半的准备按钮
function TH_GameMainCtrl.PrepareReq()
	local msg = ""
	if Room.gameType == RoomType.NiuNiu then
		Game.SendProtocal(Protocal.NiuRoomReady, msg)
	elseif Room.gameType == RoomType.GoldFlower then
		Game.SendProtocal(Protocal.GoldFlowerReady, msg)
	elseif Room.gameType == RoomType.Tenharf then
		Game.SendProtocal(Protocal.TenHalfReady, msg)
	end
	TH_GameMainPanel.btnPrepareButton:SetActive(false)
end

--牛牛炸金花十点半退出游戏按钮显示控制
function TH_GameMainCtrl.LockRoomRes()
    TH_GameMainPanel.btnWaitQuitRoom:SetActive(false) --亮色
	TH_GameMainPanel.imgNotWaitQuitRoom:SetActive(true) --灰色
end