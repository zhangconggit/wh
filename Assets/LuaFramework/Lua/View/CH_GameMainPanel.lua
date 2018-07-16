CH_GameMainPanel = {}

setbaseclass(CH_GameMainPanel, {BasePanel})

function CH_GameMainPanel:InitPanel()
	 --好友等待
    self.panel_WaitFriend = self:Child("panel_WaitFriend")
    self.btnInvitationWeChat = self:Child("panel_WaitFriend/btnInvitationWeChat")
    self.btnGameStart = self:Child("panel_WaitFriend/btnGameStart")

    --捉麻子
    self.imgCHGameMain = self:Child("imgCHGameMain")
    self.imgBtn   = self:Child("imgCHGameMain/imgBtn")
    self.btnBuChu = self:Child("imgCHGameMain/imgBtn/btnQiPai")
    self.btnTiShi = self:Child("imgCHGameMain/imgBtn/btnBiPai")
    self.btnChuPai= self:Child("imgCHGameMain/imgBtn/btnJiaZhu")
    self.imgClock = self:Child("imgCHGameMain/imgClock")
    self.txtClock = self:Child("imgCHGameMain/imgClock/Text")
    --每局结算
    self.panel_SingleSettlement = self:Child("panel_SingleSettlement")
    self.imgSettlementWin = self:Child("panel_SingleSettlement/imgSettlementWin")
    self.imgSettlementLost = self:Child("panel_SingleSettlement/imgSettlementLost")
    self.imgSettlementFenShu = self:Child("panel_SingleSettlement/imgSettlementFenShu")
    self.imgSettlementFenShu1 = self:Child("panel_SingleSettlement/imgSettlementFenShu/imgSettlementFenShu1")
    self.imgSettlementFenShu2 = self:Child("panel_SingleSettlement/imgSettlementFenShu/imgSettlementFenShu2")
    self.imgSettlementFenShu3 = self:Child("panel_SingleSettlement/imgSettlementFenShu/imgSettlementFenShu3")
    self.imgSettlementFenShu4 = self:Child("panel_SingleSettlement/imgSettlementFenShu/imgSettlementFenShu4")
    self.imgNumber =self:Child("panel_SingleSettlement/imgNumber")
    self.btnSettleStartGame =self:Child("panel_SingleSettlement/BottomBtn/btnSettleStartGame")
    --新添加
    self.btnSettleQuitGame =self:Child("panel_SingleSettlement/BottomBtn/btnSettleQuitGame")
    
    --公用
    self.btnQuitRoom = self:Child("btnQuitRoom")
    self.btnTalk = self:Child("btnTalk")
    self.imgTips = self:Child("imgTips")
    self.imgPublicCard = self:Child("imgPublicCard")
    self.btnGPS = self:Child("btnGPS")
    self.btnChat = self:Child("btnChat")
    self.imgQuitTips = self:Child("QuitGameTips")
    self.txtQuitTips = self:Child("QuitGameTips/txtMessageTips")
    self.btnQuitTipsYes = self:Child("QuitGameTips/btnSure")
    self.btnQuitTipsNo = self:Child("QuitGameTips/btnRefuse")
    self.imgAnimList =  self:Child("imgAnimList")
    self.imgSignalBG = self:Child("imgSignalBG")
    self.txtTime    = self:Child("imgSignalBG/txtTime")
    self.imgSignal1 = self:Child("imgSignalBG/imgSignal1")
    self.imgSignal2 = self:Child("imgSignalBG/imgSignal2")
    self.imgSignal3 = self:Child("imgSignalBG/imgSignal3")
    self.imgSignal4 = self:Child("imgSignalBG/imgSignal4")
    self.imgSignal5 = self:Child("imgSignalBG/imgSignal5")
    self.inputSendCode = self:Child("inputSendCode")
    self.btnSendCode = self:Child("btnSendCode")

    self.btn_gray   = self:Child("cardList/btn_gray")
    self.btnGouwuche    = self:Child("btnGouwuche")

    --新添加捉麻子结算界面的输赢number(3017.12.07)
    self.txtWin = self:Child("panel_SingleSettlement/imgSettlementWin/txtWin")
    self.txtLose = self:Child("panel_SingleSettlement/imgSettlementLost/txtLose")

    self.btnGameMainQuitRoom    = self:Child("PanelGameSetting/imgHideBg/btnGameMainQuitRoom")
    self.btnWaitQuitRoom        = self:Child("PanelGameSetting/imgHideBg/btnWaitQuitRoom")
    self.btnSetSystem           = self:Child("PanelGameSetting/imgHideBg/btnSettingSystem")
    self.btnSettingGame         = self:Child("btnSettingGame")
    self.PanelGameSetting       = self:Child("PanelGameSetting")
    self.QuitHideButton         = self:Child("PanelGameSetting/QuitHideButton")
    self.imgNotWaitQuitRoom     =self:Child("PanelGameSetting/imgHideBg/imgNotWaitQuitRoom")
    self.imgNotGameMainQuitRoom = self:Child("PanelGameSetting/imgHideBg/imgNotGameMainQuitRoom")
    self.btnMask                = self:Child("PanelGameSetting/btnMask")
    self.btnHideUp              = self:Child("PanelGameSetting/imgHideBg/btnHidePanelUp")
end