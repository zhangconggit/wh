Ll_GameMainPanel = {}

setbaseclass(Ll_GameMainPanel, {BasePanel})

function Ll_GameMainPanel:InitPanel()
	 --好友等待
    self.panel_WaitFriend = self:Child("panel_WaitFriend")
    self.btnWaitQuitRoom = self:Child("panel_WaitFriend/btnWaitQuitRoom")
    self.btnInvitationWeChat = self:Child("panel_WaitFriend/btnInvitationWeChat")
    self.btnGameStart = self:Child("panel_WaitFriend/btnGameStart")

    --斗地主
    self.imgLlGameMain = self:Child("imgLlGameMain")
    self.imgBtn   = self:Child("imgLlGameMain/imgBtn")
    self.btnBuChu = self:Child("imgLlGameMain/imgBtn/btnQiPai")
    self.btnTiShi = self:Child("imgLlGameMain/imgBtn/btnBiPai")
    self.btnChuPai= self:Child("imgLlGameMain/imgBtn/btnJiaZhu")
    self.imgClock = self:Child("imgLlGameMain/imgClock")
    self.txtClock = self:Child("imgLlGameMain/imgClock/Text")
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
    self.btnSettleQuitGame = self:Child("panel_SingleSettlement/BottomBtn/btnSettleQuitGame")
    self.OpenCard = self:Child("StartingOpenCard")
    self.StartGameOrOpenCard = self:Child("StartGameOrOpenCard")
    self.btnDirStartingGame = self:Child("StartGameOrOpenCard/btnStartGame")
    self.btnStartOpenCard = self:Child("StartGameOrOpenCard/btnOpenCard")


    --公用
    self.btnQuitRoom = self:Child("btnQuitRoom")
    self.btnTalk = self:Child("btnTalk")
    self.imgTips = self:Child("imgTips")
    self.imgPublicCard = self:Child("imgPublicCard")
    self.btnSetSystem = self:Child("btnSetSystem")
    self.btnGPS = self:Child("btnGPS")
    self.btnChat = self:Child("btnChat")
    self.btnGameMainQuitRoom = self:Child("btnGameMainQuitRoom")
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
end