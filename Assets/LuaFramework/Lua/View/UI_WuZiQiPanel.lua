--文件：活动界面
UI_WuZiQiPanel = {}
setbaseclass(UI_WuZiQiPanel, {BasePanel})

function UI_WuZiQiPanel:InitPanel()
	self.imgWhiteQiZi   = self:Child("imgWhiteQiZi")
	self.imgBlackQiZi   = self:Child("imgBlackQiZi")
	self.btnGeZi        = self:Child("btnGeZi")
	self.imgQiPan       = self:Child("imgQiPan")

	self.btnExit		= self:Child("PanelGameSetting/imgHideBg/btnWaitQuitRoom")
    self.imgQuitRoom    = self:Child("PanelGameSetting/imgHideBg/imgNotWaitQuitRoom")
	self.btnShezhi		= self:Child("btnShezhi")
	self.btnPrepare		= self:Child("btnPrepare")
	self.btnStart		= self:Child("btnStart")
	self.btnSetting		= self:Child("btnSetting")
	self.btnSubmit		= self:Child("btnSubmit")
	self.txtRoomNum		= self:Child("txtRoomNum")
	self.btnVoice		= self:Child("btnVoice")
	self.btnType		= self:Child("btnType")
	self.imgWattingMessage	= self:Child("imgWattingMessage")

	self.txtTuition		= self:Child("txtTuition")
    self.imgWattingMessage = self:Child("imgWattingMessage")

    self.imgshurubg		= self:Child("imgshurubg")
    self.btnExitJieSuan	= self:Child("imgshurubg/imgtcbg/btnExitJieSuan")
    self.txtinput		= self:Child("imgshurubg/imgtcbg/imgInputbg/imgInput/txtinput")
    self.btn0			= self:Child("imgshurubg/imgtcbg/imgInputbg/btn0")
	self.btn1 			= self:Child("imgshurubg/imgtcbg/imgInputbg/btn1")
	self.btn2 			= self:Child("imgshurubg/imgtcbg/imgInputbg/btn2")
	self.btn3 			= self:Child("imgshurubg/imgtcbg/imgInputbg/btn3")
	self.btn4 			= self:Child("imgshurubg/imgtcbg/imgInputbg/btn4")
	self.btn5 			= self:Child("imgshurubg/imgtcbg/imgInputbg/btn5")
	self.btn6 			= self:Child("imgshurubg/imgtcbg/imgInputbg/btn6")
	self.btn7 			= self:Child("imgshurubg/imgtcbg/imgInputbg/btn7")
	self.btn8 			= self:Child("imgshurubg/imgtcbg/imgInputbg/btn8")
	self.btn9 			= self:Child("imgshurubg/imgtcbg/imgInputbg/btn9")
	self.btnDelent		= self:Child("imgshurubg/imgtcbg/imgInputbg/btnDelent")
	self.btnSure		= self:Child("imgshurubg/imgtcbg/imgInputbg/btnSure")

    self.AimgPlayer		= self:Child("WzPlayers/imgPlay1")
    self.AimgFangZhu	= self:Child("WzPlayers/imgPlay1/imgFangZhu")
    self.AimgHead		= self:Child("WzPlayers/imgPlay1/imgHead")
    self.AtxtName		= self:Child("WzPlayers/imgPlay1/txtName")
    self.Atxtid 		= self:Child("WzPlayers/imgPlay1/txtID")
    self.AtxtYuanBaoShu	= self:Child("WzPlayers/imgPlay1/txtYuanBaoShu")
    self.AimgDaoJiShi	= self:Child("WzPlayers/imgPlay1/imgDaoJiShi1")
    self.AtxtDaoJiShi	= self:Child("WzPlayers/imgPlay1/imgDaoJiShi1/txtDaoJiShi")

    self.BimgPlayer		= self:Child("WzPlayers/imgPlay2")
    self.BimgFangZhu	= self:Child("WzPlayers/imgPlay2/imgFangZhu")
    self.BimgHead		= self:Child("WzPlayers/imgPlay2/imgHead")
    self.BtxtName		= self:Child("WzPlayers/imgPlay2/txtName")
    self.Btxtid			= self:Child("WzPlayers/imgPlay2/txtID")
    self.BtxtYuanBaoShu	= self:Child("WzPlayers/imgPlay2/txtYuanBaoShu")
    self.BimgDaoJiShi	= self:Child("WzPlayers/imgPlay2/imgDaoJiShi2")
    self.BtxtDaoJiShi	= self:Child("WzPlayers/imgPlay2/imgDaoJiShi2/txtDaoJiShi")


    self.GameOver		= self:Child("GameOver")
    self.btnOverSure    = self:Child("GameOver/btnOverSure")
    self.btnShare		= self:Child("GameOver/btnShare")
    self.imgMyLose		= self:Child("GameOver/imgMyLose")
    self.imgMyWin		= self:Child("GameOver/imgMyWin")

    self.imgWinClosingBG	= self:Child("GameOver/imgWinClosingBG")
    self.imgWinHead			= self:Child("GameOver/imgWinClosingBG/imgHead")
    self.txtWinName			= self:Child("GameOver/imgWinClosingBG/txtPlayer")
    self.txtWinFenshu		= self:Child("GameOver/imgWinClosingBG/txtFenShu")

    self.imgLoseClosingBG	=self:Child("GameOver/imgLoseClosingBG")
    self.imgLoseHead		= self:Child("GameOver/imgLoseClosingBG/imgHead")
    self.txtLoseName		= self:Child("GameOver/imgLoseClosingBG/txtPlayer")
    self.txtLoseFenshu		= self:Child("GameOver/imgLoseClosingBG/txtFenShu")

    self.btnInvitationWeChat = self:Child("btnInvitationWeChat")
    self.btnFuZhiRoomNum = self:Child("btnFuZhiRoomNum")
    self.btnSettingGame = self:Child("btnSettingGame")

    self.btnMask = self:Child("PanelGameSetting/btnMask")
    self.PanelGameSetting = self:Child("PanelGameSetting")
    self.QuitHideButton = self:Child("PanelGameSetting/QuitHideButton")
    self.btnHideUp = self:Child("PanelGameSetting/imgHideBg/btnHidePanelUp")
    self.imgShowNum = self:Child("imgShowNum")


	print("============UI_WuZiQiPanel================",self.imgWhiteQiZi,self.imgBlackQiZi)
end