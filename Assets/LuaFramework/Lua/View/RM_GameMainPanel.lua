-- 主打牌界面
RM_GameMainPanel = { }

setbaseclass(RM_GameMainPanel, { BasePanel })

function RM_GameMainPanel:InitPanel()
	logWarn("-----------------------------------------RM_GameMainPanel")
	self.selfUiCardImage = self:Child("selfUiCardImage")
	-- self.btnQuit = self:Child("btnQuit")
	self.btnSetSystem = self:Child("btnSetSystem")
	self.btnGPS = self:Child("btnGPS")
	self.btnChat = self:Child("btnChat")
	self.imgGameStart = self:Child("imgGameStart")
	self.imgPlayCardDirection = self:Child("imgPlayCardDirection")
	-- 当前局数
	self.imgSurplusInningNumBG = self:Child("imgSurplusInningNumBG")
	self.txtSurplusInningNum = self:Child("imgSurplusInningNumBG/txtSurplusInningNum")
	-- 剩余牌数
	self.txtSurplusNum = self:Child("imgSurplusCards/txtSurplusNum")
	-- 系统时间
	self.txtTime = self:Child("imgSignalBG/txtTime")
	-- 信号强度
	self.imgSignal1 = self:Child("imgSignalBG/imgSignal1")
	self.imgSignal2 = self:Child("imgSignalBG/imgSignal2")
	self.imgSignal3 = self:Child("imgSignalBG/imgSignal3")
	self.imgSignal4 = self:Child("imgSignalBG/imgSignal4")
	self.imgSignal5 = self:Child("imgSignalBG/imgSignal5")
	-- 桌面底字
	-- self.txtRoomNum = self:Child("txtRoomNum")
	-- self.txtPlayMethod = self:Child("txtPlayMethod")

	self.imgChatD = self:Child("imgChatD")
	self.imgChatR = self:Child("imgChatR")
	self.imgChatU = self:Child("imgChatU")
	self.imgChatL = self:Child("imgChatL")

	self.imgZhuangjiaD = self:Child("imgZhuangjiaD")
	self.imgZhuangjiaR = self:Child("imgZhuangjiaR")
	self.imgZhuangjiaL = self:Child("imgZhuangjiaL")
	self.imgZhuangjiaU = self:Child("imgZhuangjiaU")

	self.imgFangzhuD = self:Child("imgHeadD/imgFangzhu")
	self.imgFangzhuR = self:Child("imgHeadR/imgFangzhu")
	self.imgFangzhuU = self:Child("imgHeadU/imgFangzhu")
	self.imgFangzhuL = self:Child("imgHeadL/imgFangzhu")


	self.txtChatD = self:Child("imgChatD/txtChatD")
	self.txtChatL = self:Child("imgChatL/txtChatL")
	self.txtChatU = self:Child("imgChatU/txtChatU")
	self.txtChatR = self:Child("imgChatR/txtChatR")

	self.imgFaceIconBGL = self:Child("imgFaceIconBGL")
	self.imgFaceIconBGR = self:Child("imgFaceIconBGR")
	self.imgFaceIconBGU = self:Child("imgFaceIconBGU")
	self.imgFaceIconBGD = self:Child("imgFaceIconBGD")

	self.imgFaceIconBGDGrid = self:Child("imgFaceIconBGD/imgFaceIconBGDGrid")
	self.imgFaceIconBGLGrid = self:Child("imgFaceIconBGL/imgFaceIconBGLGrid")
	self.imgFaceIconBGRGrid = self:Child("imgFaceIconBGR/imgFaceIconBGRGrid")
	self.imgFaceIconBGUGrid = self:Child("imgFaceIconBGU/imgFaceIconBGUGrid")
	self.imgTingPaiTipsBGImage = self:Child("imgTingPaiTipsBGImage")
	self.imgTingPaiTipsBG = self:Child("imgTingPaiTipsBGImage/imgTingPaiTipsBG")
	self.GridTingPai = self:Child("imgTingPaiTipsBGImage/imgTingPaiTipsBG/GridTingPai")
	self.GridTingPaiCard = self:Child("imgTingPaiTipsBGImage/imgTingPaiTipsBG/GridTingPaiCard")

	self.imgPengGangHuBG = self:Child("imgPengGangHuBG")
	self.btnPeng = self:Child("imgPengGangHuBG/btnPeng")
	self.btnGang = self:Child("imgPengGangHuBG/btnGang")
	self.btnHu = self:Child("imgPengGangHuBG/btnHu")
	self.btnGuo = self:Child("imgPengGangHuBG/btnGuo")
	self.btnNil = self:Child("imgPengGangHuBG/btnNil")

	self.inputSendCode = self:Child("inputSendCode")
	self.btnSendCode = self:Child("btnSendCode")

	self.imgReadyL = self:Child("imgReadyL")
	self.imgReadyR = self:Child("imgReadyR")
	self.imgReadyU = self:Child("imgReadyU")
	self.imgReadyD = self:Child("imgReadyD")

	self.effect_touxiangL = self:Child("effect_TouxiangL")
	self.effect_touxiangR = self:Child("effect_TouxiangR")
	self.effect_touxiangD = self:Child("effect_TouxiangD")
	self.effect_touxiangU = self:Child("effect_TouxiangU")

	self.effect_pengyan = self:Child("effect_pengyan")
	self.effect_huguang = self:Child("effect_huguang")
	self.effect_duoxiang = self:Child("effect_duoxiang")


	-- 提示
	self.imgTips = self:Child("imgTips")

	-- 人物头像
	self.imgHeadIconD = self:Child("imgHeadD/MaskHeadD")
	self.imgHeadIconU = self:Child("imgHeadU/MaskHeadU")
	self.imgHeadIconR = self:Child("imgHeadR/MaskHeadR")
	self.imgHeadIconL = self:Child("imgHeadL/MaskHeadL")

	self.btnHeadIconD = self:Child("imgHeadD/MaskHeadD/imgD")
	self.btnHeadIconU = self:Child("imgHeadU/MaskHeadU/imgU")
	self.btnHeadIconR = self:Child("imgHeadR/MaskHeadR/imgR")
	self.btnHeadIconL = self:Child("imgHeadL/MaskHeadL/imgL")
	self.txtScoreD = self:Child("imgHeadD/txtScore")
	self.txtScoreR = self:Child("imgHeadR/txtScore")
	self.txtScoreU = self:Child("imgHeadU/txtScore")
	self.txtScoreL = self:Child("imgHeadL/txtScore")
	self.objHeadU = self:Child("imgHeadU")
	self.imgHeadLBreak = self:Child("imgHeadL/Image")
	self.imgHeadDBreak = self:Child("imgHeadD/Image")
	self.imgHeadRBreak = self:Child("imgHeadR/Image")
	self.imgHeadUBreak = self:Child("imgHeadU/Image")

	self.imgHeadD = self:Child("imgHeadD")
	self.imgHeadR = self:Child("imgHeadR")
	self.imgHeadL = self:Child("imgHeadL")
	self.imgHeadU = self:Child("imgHeadU")

	self.btnTingPai = self:Child("btnTingPai")
	self.imgAnimL = self:Child("imgHeadL/imgAnimL")
	self.imgAnimR = self:Child("imgHeadR/imgAnimR")
	self.imgAnimD = self:Child("imgHeadD/imgAnimD")
	self.imgAnimU = self:Child("imgHeadU/imgAnimU")
	self.imgAnimList = self:Child("imgAnimList")

	self.imgQuitTips = self:Child("QuitGameTips")
	self.txtQuitTips = self:Child("QuitGameTips/txtMessageTips")
	self.btnQuitTipsYes = self:Child("QuitGameTips/btnSure")
	self.btnQuitTipsNo = self:Child("QuitGameTips/btnRefuse")
	self.imgLouHu = self:Child("imgLouHu")
	self.imgGenZhuang = self:Child("imgGenZhuang")
	self.imgHuangZhuang = self:Child("imgHuangZhuang")
	-- 广电
	self.btnTalk = self:Child("btnTalk")
	self.imgPlayBackBGImage = self:Child("imgPlayBackBGImage")
	self.huiFangQuitButton = self:Child("imgPlayBackBGImage/huiFangQuitButton")
	self.huiFangShareButton = self:Child("imgPlayBackBGImage/huiFangShareButton")
	self.huiFangHouTuiButton = self:Child("imgPlayBackBGImage/huiFangHouTuiButton")
	self.huiFangPlayButton = self:Child("imgPlayBackBGImage/huiFangPlayButton")
	self.huiFangZanTingButton = self:Child("imgPlayBackBGImage/huiFangZanTingButton")
	self.huiFangKuaiJinButton = self:Child("imgPlayBackBGImage/huiFangKuaiJinButton")
	self.huiFangFillBar = self:Child("imgPlayBackBGImage/huiFangJinDuSlider/huiFangFillBar")
	-- 比赛场
	self.btnTuoGuan = self:Child("btnTuoGuan")
	self.imgPaiXingBG = self:Child("imgPaiXingBG")
	self.txtPaiXingMingCi = self:Child("imgPaiXingBG/txtPaiXingMingCi")
	self.imgMatchLunCountBG = self:Child("imgMatchLunCountBG")
	self.txtCurrentLunInfo = self:Child("imgMatchLunCountBG/txtCurrentLunInfo")
	self.imgTuoGuanBG = self:Child("imgTuoGuanBG")
	self.btnQuXiaoTuoGuan = self:Child("imgTuoGuanBG/btnQuXiaoTuoGuan")
	-- 新添加
	self.imgJinbiD = self:Child("imgHeadD/imgJinbiD")
	self.imgJinbiR = self:Child("imgHeadR/imgJinbiR")
	self.imgJinbiU = self:Child("imgHeadU/imgJinbiU")
	self.imgJinbiL = self:Child("imgHeadL/imgJinbiL")
	self.imgYuanbaoD = self:Child("imgHeadD/imgYuanbaoD")
	self.imgYuanbaoR = self:Child("imgHeadR/imgYuanbaoR")
	self.imgYuanbaoU = self:Child("imgHeadU/imgYuanbaoU")
	self.imgYuanbaoL = self:Child("imgHeadL/imgYuanbaoL")

	self.imgSignalBG = self:Child("imgSignalBG")
	self.imgSurplusCards = self:Child("imgSurplusCards")
	self.btnGouwuche = self:Child("btnGouwuche")
	self.btnSettingGame = self:Child("btnSettingGame")

	-- GameSetting Panel
	self.PanelGameSetting = self:Child("PanelGameSetting")
	self.QuitHideButton = self:Child("PanelGameSetting/QuitHideButton")
	self.imgNotWaitQuitRoom = self:Child("PanelGameSetting/imgHideBg/imgNotWaitQuitRoom")
	self.btnWaitQuitRoom = self:Child("PanelGameSetting/imgHideBg/btnWaitQuitRoom")
	self.imgNotGameMainQuitRoom = self:Child("PanelGameSetting/imgHideBg/imgNotGameMainQuitRoom")
	self.btnQuit = self:Child("PanelGameSetting/imgHideBg/btnGameMainQuitRoom")
	self.btnSettingSystem = self:Child("PanelGameSetting/imgHideBg/btnSettingSystem")
	self.btnShowTips = self:Child("PanelGameSetting/imgHideBg/btnShowTips")
	self.btnMask = self:Child("PanelGameSetting/btnMask")
	self.btnSettingGame = self:Child("btnSettingGame")
	self.btnHideUp = self:Child("PanelGameSetting/imgHideBg/btnHidePanelUp")

	self.txtRoomNum = self:Child("imgRoomMessageBG/txtRoomNum")
	self.txtWanFa = self:Child("imgRoomMessageBG/txtWanFa")
	self.txtJuShu = self:Child("imgRoomMessageBG/txtJuShu")
	self.txtMessage = self:Child("imgRoomMessageBG/txtMessage")

	self.btnInvitationWeChat = self:Child("btnInvitationWeChat");
	self.btnGameStart = self:Child("btnGameStart");
	self.imgJoinRoom = self:Child("imgJoinRoom");
	self.playerName = self:Child("imgJoinRoom/Name");
	-- GameSetting Panel
	self.PanelGameSetting = self:Child("PanelGameSetting")
	self.QuitHideButton = self:Child("PanelGameSetting/QuitHideButton")
	self.imgNotWaitQuitRoom = self:Child("PanelGameSetting/imgHideBg/imgNotWaitQuitRoom")
	self.btnWaitQuitRoom = self:Child("PanelGameSetting/imgHideBg/btnWaitQuitRoom")
	self.imgNotGameMainQuitRoom = self:Child("PanelGameSetting/imgHideBg/imgNotGameMainQuitRoom")
	self.btnGameMainQuitRoom = self:Child("PanelGameSetting/imgHideBg/btnGameMainQuitRoom")
	self.btnSettingSystem = self:Child("PanelGameSetting/imgHideBg/btnSettingSystem")
	self.btnShowTips = self:Child("PanelGameSetting/imgHideBg/btnShowTips")
	self.btnMask = self:Child("PanelGameSetting/btnMask")
	self.btnSettingGame = self:Child("btnSettingGame")
	self.btnHideUp = self:Child("PanelGameSetting/imgHideBg/btnHidePanelUp")

	self.txtRoomNum = self:Child("imgRoomMessageBG/txtRoomNum")
	self.txtWanFa = self:Child("imgRoomMessageBG/txtWanFa")
	self.txtJuShu = self:Child("imgRoomMessageBG/txtJuShu")
	self.txtMessage = self:Child("imgRoomMessageBG/txtMessage")
end