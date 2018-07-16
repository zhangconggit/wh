MainSencePanel = {};
setbaseclass(MainSencePanel, {BasePanel})

function MainSencePanel:InitPanel()

	logWarn("-----------------------------------------MainSencePanel");
	
	self.btnCommitInfo = self:Child("fartherOfMainSence/btnCommitInfo");
	self.btnSystemSet = self:Child("btnMore");
	self.btnHelp = self:Child("btnHelp");
	self.btnActivity = self:Child("fartherOfMainSence/btnActivity");
	self.effectshuye = self:Child("effectshuye");
	self.effecthuaban = self:Child("effecthuaban");
	self.btnHeadImg = self:Child("btnHeadIcon");
	self.btnGrade = self:Child("fartherOfMainSence/btnGrade");
	self.btnXiaoXi =self:Child("fartherOfMainSence/btnXiaoXi")
	self.btnJuLeBu =self:Child("fartherOfMainSence/btnJuLeBu")
	
	self.imgHeadIcon = self:Child("btnHeadIcon/imgMask/Image");
	self.roleId = self:Child("txtRoleID");
	self.name = self:Child("txtRoleName");
	self.diamond = self:Child("txtDiamondNumber");                        --玩家房卡数量

	self.panelExitGame=self:Child("QuitGameTipsPanel")
	self.btnSendDiamond = self:Child("btnSendDiamond");
	self.panelSendDiamond = self:Child("panelSendDiamond");
	self.inputRoleID = self:Child("panelSendDiamond/inputRoleID");
	self.inputDiamond = self:Child("panelSendDiamond/inputDiamond");
	self.btnConfirm = self:Child("panelSendDiamond/btnConfirm");
	self.btnClose = self:Child("panelSendDiamond/btnClose");
    self.btnQXTuiChu = self:Child("QuitGameTipsPanel/btnCancle");
    self.btnQXTuiChuMask = self:Child("QuitGameTipsPanel/imgMaskBG");
    self.btnQXFanKui = self:Child("FanKuiPanel/btnQX");

	self.imgLightBg = self:Child("imgLightBg");
	self.imgNightBg = self:Child("imgNightBg");

	--新添加
	self.btnRankList = self:Child("fartherOfMainSence/btnRankList");
	self.btnMall     = self:Child("btnMall");          --商城

	self.btnFriends  = self:Child("btnFriends");
	self.imgGoldBG  = self:Child("imgGoldBG");
	self.txtGoldNum  = self:Child("imgGoldBG/txtGoldNum");                --玩家金币数量
	self.btnMatchRoom  = self:Child("btnMatchRoom");
	self.imgDuoBaoGuang  = self:Child("imgDuoBaoGuang");
	--self.txtCoinNum = self:Child("imgCoinBG/txtCoinNum");                 --玩家元宝数量
	self.btnKefu	= self:Child("fartherOfMainSence/btnKefu")			  --客服

	self.image1L = self:Child("fartherOfMainSence/imghuangdengPianBG/TopPanel/imgDian/gundongdian1Liang");
	self.image1M = self:Child("fartherOfMainSence/imghuangdengPianBG/TopPanel/imgDian/gundongdian1Mie");
	self.image2L = self:Child("fartherOfMainSence/imghuangdengPianBG/TopPanel/imgDian/gundongdian2Liang");
	self.image2M = self:Child("fartherOfMainSence/imghuangdengPianBG/TopPanel/imgDian/gundongdian2Mie");
	self.image3L = self:Child("fartherOfMainSence/imghuangdengPianBG/TopPanel/imgDian/gundongdian3Liang");
	self.image3M = self:Child("fartherOfMainSence/imghuangdengPianBG/TopPanel/imgDian/gundongdian3Mie");

	self.activeParent= self:Child("fartherOfMainSence/imghuangdengPianBG/TopPanel/Viewport/Content");

	--新添加大厅功能
	--self.btnCerateRoom  = self:Child("fartherOfMainSence/btnCerateRoom");
	self.btnJoinRoom  = self:Child("fartherOfMainSence/btnJoinRoom");
	self.btnMahjongRoom  = self:Child("fartherOfMainSence/ChooseGame/Viewport/Content/btnMahjongRoom");
	self.btnNiuniuRoom  = self:Child("fartherOfMainSence/ChooseGame/Viewport/Content/btnNiuniuRoom");
	self.btnRedDragonRoom  = self:Child("fartherOfMainSence/ChooseGame/Viewport/Content/btnRedDragonRoom");
	self.btnGameCerateRoom	= self:Child("fartherOfMainSence/btnGameCerateRoom")

    self.gameMainScrollbar = self:Child("fartherOfMainSence/GameMainScrollbar")
    self.ActiveScrollbar = self:Child("fartherOfMainSence/imghuangdengPianBG/TopPanel/ActiveScrollbar")

    self.btnS = self:Child("ChooseRoom/btnS");
	self.ChooseRoom  = self:Child("ChooseRoom");
	self.btnChuji  = self:Child("ChooseRoom/btnS/btnChuji");
	self.btnZhongji  = self:Child("ChooseRoom/btnS/btnZhongji");
	self.btnGaoJi  = self:Child("ChooseRoom/btnS/btnGaoJi");
	self.btnHaoHua  = self:Child("ChooseRoom/btnS/btnHaoHua");
	self.btnDaHaoHua  = self:Child("ChooseRoom/btnS/btnDaHaoHua");
	self.goldMode  = self:Child("ChooseRoom/goldMode");
	--self.wingMode  = self:Child("ChooseRoom/wingMode");
	self.roomCardMode  = self:Child("ChooseRoom/roomCardMode");
	self.btnBack  = self:Child("ChooseRoom/btnBack");    

	self.imgJinBi = self:Child("ChooseRoom/goldMode/imgJinBi")         --金币背景
	self.imgYuanBao = self:Child("ChooseRoom/wingMode/imgYuanBao")     --元宝按钮背景
	self.imgFriend = self:Child("ChooseRoom/roomCardMode/imgFriend")   --好友同玩按钮背景

	self.fartherOfMainSence = self:Child("fartherOfMainSence")         --进入二级界面时要隐去一级界面的部分UI
	self.imgsJinBi = self:Child("ChooseRoom/btnS/imgsJinBi")                --金币图片
	self.imgsYuanBo = self:Child("ChooseRoom/btnS/imgsYuanBo")              --元宝图片
    
    --self.btnSetting = self:Child("btnMore")    --设置
    self.btnHelpNew = self:Child("btnHelpNew")    --帮助
    self.btnExit = self:Child("fartherOfMainSence/btnExit")     --显示退出界面
    self.btnQuit = self:Child("QuitGameTipsPanel/btnSure")        	--注销按钮,暂时不用

    --实名认证
    self.btnCertification 		= self:Child("btnCertification") --实名认证打开按钮
    self.CertificationPanel 	= self:Child("CertificationPanel") --实名认证面板
    self.txtCertification3 		= self:Child("CertificationPanel/ipfdCertification3/txtCertification3") --实名认证名字
    self.txtCertification7 		= self:Child("CertificationPanel/ipfdCertification7/txtCertification7") --实名认证身份证
    self.btnCertificationShow 	= self:Child("CertificationPanel/btnCertificationShow")	--关闭
    self.btnCertificationSure 	= self:Child("CertificationPanel/btnCertificationSure") --确认
    self.imgCertificationTip 	= self:Child("imgCertificationTip")						--提示

    self.btnJinBiPay  = self:Child("imgGoldBG/btnJinBiPay");          ---------------加金币
    --self.btnYuanBaoPay = self:Child("imgCoinBG/btnYuanBaoPay");       ---------------加元宝
    self.btnFangKaPay = self:Child("btnFangKaPay");                   ---------------加房卡 

    --游戏类型的Icon
    self.imgNiuIcon = self:Child("ChooseRoom/imgHeadIcons/imgNiuIcon");               --牛牛
    self.imgHuaShuiIcon = self:Child("ChooseRoom/imgHeadIcons/imgHuaShuiIcon");       --划水
    self.imgHongZhongIcon = self:Child("ChooseRoom/imgHeadIcons/imgHongZhongIcon");   --红中
    self.imgZhaJinHuaIcon = self:Child("ChooseRoom/imgHeadIcons/imgZhaJinHuaIcon");   --金花
    self.imgZhuoMaZiIcon = self:Child("ChooseRoom/imgHeadIcons/imgZhuoMaZiIcon");     --麻子
    self.imgShiDianBanIcon = self:Child("ChooseRoom/imgHeadIcons/imgShiDianBanIcon"); --十点半
    self.imaLandlordsIcon = self:Child("ChooseRoom/imgHeadIcons/imgLandlordsIcon")	  --斗地主
    self.imgBattleMahjongIcon = self:Child("ChooseRoom/imgHeadIcons/imgBattleMahjongIcon")	  --血战麻将
    
    --电量
    self.battery		= self:Child("battery")
    self.imgBattery20 	= self:Child("battery/imgBattery20")
    self.imgBattery80 	= self:Child("battery/imgBattery80")
    self.imgBattery100 	= self:Child("battery/imgBattery100")
    --WIFI
    self.sign 			= self:Child("sign")
    self.imgSign1 		= self:Child("sign/imgSign1")
    self.imgSign2 		= self:Child("sign/imgSign2")
    self.imgSign3 		= self:Child("sign/imgSign3")
    self.imgSign4 		= self:Child("sign/imgSign4")
    self.imgSignWifi1 	= self:Child("sign/imgSignWifi1")
    self.imgSignWifi2 	= self:Child("sign/imgSignWifi2")
    self.imgSignWifi3 	= self:Child("sign/imgSignWifi3")

    --底注
--[[    self.txtScoreChuJi 		= self:Child("ChooseRoom/btnS/textNumbers/imgPerChuJi/txtScoreChuJi")
    self.txtScoreZhongJi 	= self:Child("ChooseRoom/btnS/textNumbers/imgPerZhongJi/txtScoreZhongJi")
    self.txtScoreGaoJi 		= self:Child("ChooseRoom/btnS/textNumbers/imgPerGaoJi/txtScoreGaoJi")
    self.txtScoreHaoHua 	= self:Child("ChooseRoom/btnS/textNumbers/imgPerHaoHua/txtScoreHaoHua")
    self.txtScoreDaHaoHua 	= self:Child("ChooseRoom/btnS/textNumbers/imgPerDaHaoHua/txtScoreDaHaoHua")

    self.txtJOne			= self:Child("ChooseRoom/btnS/textNumbers/imgJOne/txtJOne")
    self.txtJTwo			= self:Child("ChooseRoom/btnS/textNumbers/imgJTwo/txtJTwo")
    self.txtJThree			= self:Child("ChooseRoom/btnS/textNumbers/imgJThree/txtJThree")
    self.txtJFour			= self:Child("ChooseRoom/btnS/textNumbers/imgJFour/txtJFour")
    self.txtJFive			= self:Child("ChooseRoom/btnS/textNumbers/imgJFive/txtJFive")

    self.txtPerNumChuJi 	= self:Child("ChooseRoom/btnS/textNumbers/imgPerChuJi/txtPerNumChuJi")
    self.txtPerNumZhongJi 	= self:Child("ChooseRoom/btnS/textNumbers/imgPerZhongJi/txtPerNumZhongJi")
    self.txtPerNumGaoJi 	= self:Child("ChooseRoom/btnS/textNumbers/imgPerGaoJi/txtPerNumGaoJi")
    self.txtPerNumHaoHua 	= self:Child("ChooseRoom/btnS/textNumbers/imgPerHaoHua/txtPerNumHaoHua")
    self.txtPerNumDaHaoHua  = self:Child("ChooseRoom/btnS/textNumbers/imgPerDaHaoHua/txtPerNumDaHaoHua")--]]
    self.spineHudie = self:Child("HuDie")
end