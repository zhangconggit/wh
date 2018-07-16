CreateRoomPanel = {};
setbaseclass(CreateRoomPanel,{BasePanel})

--初始化面板--
function CreateRoomPanel:InitPanel()

logWarn("-----------------------------------------CreateRoomPanel");

    self.HuaShui = self:Child("HuaShui");
	self.ZhuoMaZi = self:Child("ZhuoMaZi");
	self.ShiDianBan = self:Child("ShiDianBan");
	self.ZhaJinHua = self:Child("ZhaJinHua");
	self.NiuNiu = self:Child("NiuNiu");
	self.RedDragon=self:Child("RedDragon");
	self.Landlords = self:Child("Landlords")

    self.btnQuit = self:Child("btnQuit");
	self.togHuashui = self:Child("togGroupLeft/togHuaShui");
	self.togZhuomazi = self:Child("togGroupLeft/togZhuomazi");
	self.togShidianban = self:Child("togGroupLeft/togShidianban");
	self.togZhajinhua = self:Child("togGroupLeft/togZhajinhua");
	self.togNiuniu = self:Child("togGroupLeft/togNiuniu");
	self.imgArrow = self:Child("imgArrowBg/imgArrow");
	self.imgNewGameTips = self:Child("togGroupLeft/imgNewGameTips");
	self.togGroupLeft = self:Child("togGroupLeft");
	self.imgArrowBg = self:Child("imgArrowBg");
	self.imgMask = self:Child("imgMask");

----划水
	self.huaTog8Inning = self:Child("HuaShui/togGroupInning/tog8Inning");
	self.huaTog8InningTxt1 = self:Child("HuaShui/togGroupInning/tog8Inning/txt8Inning");

	self.huaTog16Inning = self:Child("HuaShui/togGroupInning/tog16Inning");
	self.huaTog16InningTxt1 = self:Child("HuaShui/togGroupInning/tog16Inning/txt16Inning");

	self.huaTogAA = self:Child("HuaShui/togGroupPay/togAA");
	self.huaTogAATxt1 = self:Child("HuaShui/togGroupPay/togAA/txt8Inning");
	self.huaImgAA = self:Child("HuaShui/togGroupPay/togAA/imgDiamond");
	self.huaTogAATxt2 = self:Child("HuaShui/togGroupPay/togAA/imgDiamond/txtDiamondNumber");

	self.huaTogBoss = self:Child("HuaShui/togGroupPay/togBoss");
	self.huaTogBossTxt1 = self:Child("HuaShui/togGroupPay/togBoss/txt16Inning");
	self.huaImgBoss = self:Child("HuaShui/togGroupPay/togBoss/imgDiamond");
	self.huaTogBossTxt2= self:Child("HuaShui/togGroupPay/togBoss/imgDiamond/txtDiamondNumber");

	self.huaTogXiayu0 = self:Child("HuaShui/togGroupXiaYu/togXiayu0");
	self.huaTogXiayu0Txt = self:Child("HuaShui/togGroupXiaYu/togXiayu0/txtXiayu0");

	self.huaTogXiayuNum = self:Child("HuaShui/togGroupXiaYu/togXiayuNum");
	self.huaTogXiayuNumTxt = self:Child("HuaShui/togGroupXiaYu/togXiayuNum/txtXiayuNum");

	self.huaTogDianpao = self:Child("HuaShui/togGroupPlayMethod/togDianpao");
	self.huaTogDianpaoTxt = self:Child("HuaShui/togGroupPlayMethod/togDianpao/txtDianpao");

	self.huaTogZimo = self:Child("HuaShui/togGroupPlayMethod/togZimo");
	self.huaTogZimoTxt = self:Child("HuaShui/togGroupPlayMethod/togZimo/txtZimo");

	self.huaTogBihu = self:Child("HuaShui/togGroupPlayMethod/togBihu");
	self.huaTogBihuTxt = self:Child("HuaShui/togGroupPlayMethod/togBihu/txtBihu");
	self.huaBtnBihu = self:Child("HuaShui/togGroupPlayMethod/togBihu/btnColor");
	self.huaImgBihu = self:Child("HuaShui/togGroupPlayMethod/togBihu/imgColor");

	self.huaTogFeng = self:Child("HuaShui/togFeng");
	self.huaTogFengTxt = self:Child("HuaShui/togFeng/txtFeng");

	self.huaTogHong = self:Child("HuaShui/togHong");
	self.huaTogHongTxt = self:Child("HuaShui/togHong/txtHong");

	self.huaTogNum3 = self:Child("HuaShui/togGroupPlayNum/togNum3");
	self.huaTogNum3Txt = self:Child("HuaShui/togGroupPlayNum/togNum3/txtNum3");

	self.huaTogNum4 = self:Child("HuaShui/togGroupPlayNum/togNum4");
	self.huaTogNum4Txt = self:Child("HuaShui/togGroupPlayNum/togNum4/txtNum4");

	self.huaTogRobot = self:Child("HuaShui/togGroupPlayNum/togRobot");
	self.huaTogRobotTxt = self:Child("HuaShui/togGroupPlayNum/togRobot/txtRobot");
	
	self.btnDown		= self:Child("HuaShui/togGroupXiaYu/btnDown")
	self.btnUp			= self:Child("HuaShui/togGroupXiaYu/btnUp")	
	self.inputNum		= self:Child("HuaShui/togGroupXiaYu/togXiayuNum/InputField")
	self.txtXiayuNum	= self:Child("HuaShui/togGroupXiaYu/togXiayuNum/txtXiayuNum")

	self.huaBtnCreate = self:Child("HuaShui/btnCreate");
	self.huaTxtDiamond = self:Child("HuaShui/btnCreate/txtDiamondNumber");
	----划水以上

	----十点半
	self.shiTog2Inning = self:Child("ShiDianBan/togGroupInning/tog2Inning");
	self.shiTog2InningTxt1 = self:Child("ShiDianBan/togGroupInning/tog2Inning/txt2Inning");
	self.shiTog2InningTxt2 = self:Child("ShiDianBan/togGroupInning/tog2Inning/txtDiamondNumber");

	self.shiTog4Inning = self:Child("ShiDianBan/togGroupInning/tog4Inning");
	self.shiTog4InningTxt1 = self:Child("ShiDianBan/togGroupInning/tog4Inning/txt4Inning");
	self.shiTog4InningTxt2= self:Child("ShiDianBan/togGroupInning/tog4Inning/txtDiamondNumber");

	self.shiTog6Inning = self:Child("ShiDianBan/togGroupInning/tog6Inning");
	self.shiTog6InningTxt1 = self:Child("ShiDianBan/togGroupInning/tog6Inning/txt6Inning");
	self.shiTog6InningTxt2= self:Child("ShiDianBan/togGroupInning/tog6Inning/txtDiamondNumber");

	self.shiTogWuHua5 = self:Child("ShiDianBan/togPlayMethod/togWuHua5");
	self.shiTogWuHua5Txt = self:Child("ShiDianBan/togPlayMethod/togWuHua5/txtWuHua5");

	self.shiTogShi5 = self:Child("ShiDianBan/togPlayMethod/togShi5");
	self.shiTogShi5Txt = self:Child("ShiDianBan/togPlayMethod/togShi5/txtShi5");

	self.shiTogWu3 = self:Child("ShiDianBan/togPlayMethod/togWu3");
	self.shiTogWu3Txt = self:Child("ShiDianBan/togPlayMethod/togWu3/txtWu3");

	self.shiTogShi3 = self:Child("ShiDianBan/togPlayMethod/togShi3");
	self.shiTogShi3Txt = self:Child("ShiDianBan/togPlayMethod/togShi3/txtShi3");

	self.shiTogWuWang = self:Child("ShiDianBan/togWangPai/togWuWang");
	self.shiTogWuWangTxt = self:Child("ShiDianBan/togWangPai/togWuWang/txtWuWang");

	self.shiTogWang = self:Child("ShiDianBan/togWangPai/togWang");
	self.shiTogWangTxt = self:Child("ShiDianBan/togWangPai/togWang/txtWang");

	self.shiTogSuiJi = self:Child("ShiDianBan/togZhuang/togSuiJi");
	self.shiTogSuiJiTxt = self:Child("ShiDianBan/togZhuang/togSuiJi/txtSuiJi");

	self.shiTogFangZhu = self:Child("ShiDianBan/togZhuang/togFangZhu");
	self.shiTogFangZhuTxt = self:Child("ShiDianBan/togZhuang/togFangZhu/txtFangZhu");


	self.shiTogRobot = self:Child("ShiDianBan/togZhuang/togRobot");
	self.shiTogRobotTxt = self:Child("ShiDianBan/togZhuang//txtRobot");

	self.shiBtnCreate = self:Child("ShiDianBan/btnCreateTenHalf");
	self.shiTxtDiamond = self:Child("ShiDianBan/btnCreateTenHalf/txtDiamondNumber");

	self.imgShiMathondTips = self:Child("ShiDianBan/togWangPai/imgMathondTips");
	----十点半以上

	----炸金花
	self.jinTog8Inning = self:Child("ZhaJinHua/togGroupInning/togJin8Inning");
	self.jinTog8InningTxt1 = self:Child("ZhaJinHua/togGroupInning/togJin8Inning/txt8Inning");
	self.jinTog8InningTxt2 = self:Child("ZhaJinHua/togGroupInning/togJin8Inning/txtDiamondNumber");

	self.jinTog16Inning = self:Child("ZhaJinHua/togGroupInning/togJin16Inning");
	self.jinTog16InningTxt1 = self:Child("ZhaJinHua/togGroupInning/togJin16Inning/txt16Inning");
	self.jinTog16InningTxt2= self:Child("ZhaJinHua/togGroupInning/togJin16Inning/txtDiamondNumber");

	self.jinTogSize = self:Child("ZhaJinHua/togPlayMethod/togGroupMethod/togSize");
	self.jinTogSizeTxt = self:Child("ZhaJinHua/togPlayMethod/togGroupMethod/togSize/txtSize");
	self.jinBtnSize = self:Child("ZhaJinHua/togPlayMethod/togGroupMethod/togSize/btnSize");
	self.imgSizeMathond = self:Child("ZhaJinHua/togPlayMethod/togGroupMethod/togSize/imgSize");

	self.jinTogColor = self:Child("ZhaJinHua/togPlayMethod/togGroupMethod/togColor");
	self.jinTogColorTxt = self:Child("ZhaJinHua/togPlayMethod/togGroupMethod/togColor/txtColor");
	self.jinBtnColor = self:Child("ZhaJinHua/togPlayMethod/togGroupMethod/togColor/btnColor");
	self.imgColorMathond = self:Child("ZhaJinHua/togPlayMethod/togGroupMethod/togColor/imgColor");

	self.jinTogJin = self:Child("ZhaJinHua/togPlayMethod/togGroupMethod/togJin");
	self.jinTogJinTxt = self:Child("ZhaJinHua/togPlayMethod/togGroupMethod/togJin/txtJin");
	self.jinBtnJin = self:Child("ZhaJinHua/togPlayMethod/togGroupMethod/togJin/btnJin");
    self.imgJinMathond = self:Child("ZhaJinHua/togPlayMethod/togGroupMethod/togJin/imgJin");

	self.jinTogLeopard = self:Child("ZhaJinHua/togPlayMethod/togLeopard");
	self.jinTogLeopardTxt = self:Child("ZhaJinHua/togPlayMethod/togLeopard/txtLeopard");

	self.jinTogDouble = self:Child("ZhaJinHua/togPlayMethod/togDouble");
	self.jinTogDoubleTxt = self:Child("ZhaJinHua/togPlayMethod/togDouble/txtDouble");


	self.jinTogTopRound5 = self:Child("ZhaJinHua/togGroupTop/togRound5");
	self.jinTogTopRound5Txt = self:Child("ZhaJinHua/togGroupTop/togRound5/txtRound5");

	self.jinTogTopRound10 = self:Child("ZhaJinHua/togGroupTop/togRound10");
	self.jinTogTopRound10Txt = self:Child("ZhaJinHua/togGroupTop/togRound10/txtRound10");

	self.jinTogTopRound15 = self:Child("ZhaJinHua/togGroupTop/togRound15");
	self.jinTogTopRound15Txt = self:Child("ZhaJinHua/togGroupTop/togRound15/txtRound15");


	self.jinTogCompareRound1 = self:Child("ZhaJinHua/togGroupCompare/togCompareRound1");
	self.jinTogCompareRound1Txt = self:Child("ZhaJinHua/togGroupCompare/togCompareRound1/txtRound1");

	self.jinTogCompareRound2 = self:Child("ZhaJinHua/togGroupCompare/togCompareRound2");
	self.jinTogCompareRound2Txt = self:Child("ZhaJinHua/togGroupCompare/togCompareRound2/txtRound2");

	self.jinTogCompareRound3 = self:Child("ZhaJinHua/togGroupCompare/togCompareRound3");
	self.jinTogCompareRound3Txt = self:Child("ZhaJinHua/togGroupCompare/togCompareRound3/txtRound3");


	self.jinTogGuessRound1 = self:Child("ZhaJinHua/togGroupGuess/togGuessRound1");
	self.jinTogGuessRound1Txt = self:Child("ZhaJinHua/togGroupGuess/togGuessRound1/txtRound1");

	self.jinTogGuessRound2 = self:Child("ZhaJinHua/togGroupGuess/togGuessRound2");
	self.jinTogGuessRound2Txt = self:Child("ZhaJinHua/togGroupGuess/togGuessRound2/txtRound2");

	self.jinTogGuessRound3 = self:Child("ZhaJinHua/togGroupGuess/togGuessRound3");
	self.jinTogGuessRound3Txt = self:Child("ZhaJinHua/togGroupGuess/togGuessRound3/txtRound3");

	self.jinBtnCreate = self:Child("ZhaJinHua/btnCreateJinHua");
	self.jinTxtDiamond = self:Child("ZhaJinHua/btnCreateJinHua/txtDiamondNumber");
	----炸金花以上

	----牛牛
	self.niuTog10Inning = self:Child("NiuNiu/togGroupInning/tog10Inning");
	self.niuTog20Inning = self:Child("NiuNiu/togGroupInning/tog20Inning");

	self.niuTogHave	    = self:Child("NiuNiu/togbaseScore/togHave");
	self.niuTogNone		= self:Child("NiuNiu/togbaseScore/togNone");

	self.niuTogMin5	    = self:Child("NiuNiu/togPlayMethod/togMin5");
	self.niuTogBoom	    = self:Child("NiuNiu/togPlayMethod/togBoom");
	self.niuTogHua5	    = self:Child("NiuNiu/togPlayMethod/togHua5");

	self.niuTogQiang    = self:Child("NiuNiu/togBanker/togNiuQiang");
	self.niuTogBank	    = self:Child("NiuNiu/togBanker/togNiuBank");
	self.niuTogLun	    = self:Child("NiuNiu/togBanker/togNiuLun");
	self.niuTogFang		= self:Child("NiuNiu/togBanker/togFang");


	self.niuTog10Inningtxt  = self:Child("NiuNiu/togGroupInning/tog10Inning/txt");
	self.niuTog20Inningtxt  = self:Child("NiuNiu/togGroupInning/tog20Inning/txt");

	self.niuTogHavetxt	    = self:Child("NiuNiu/togbaseScore/togHave/txt");
	self.niuTogNonetxt		= self:Child("NiuNiu/togbaseScore/togNone/txt");

	self.niuTogMin5txt	    = self:Child("NiuNiu/togPlayMethod/togMin5/txt");
	self.niuTogBoomtxt	    = self:Child("NiuNiu/togPlayMethod/togBoom/txt");
	self.niuTogHua5txt	    = self:Child("NiuNiu/togPlayMethod/togHua5/txt");

	self.niuTogQiangtxt	    = self:Child("NiuNiu/togBanker/togNiuQiang/txt");
	self.niuTogBanktxt	    = self:Child("NiuNiu/togBanker/togNiuBank/txt");
	self.niuTogLuntxt	   	= self:Child("NiuNiu/togBanker/togNiuLun/txt");
	self.niuTogFangtxt		= self:Child("NiuNiu/togBanker/togFang/txt");
	
	self.niuBtnCreate	    = self:Child("NiuNiu/btnCreateNiu");
	----牛牛以上

	----捉麻子
	self.zhuoTog8Inning = self:Child("ZhuoMaZi/togGroupInning/togzhuo8Inning");
	self.zhuoTog8InningTxt1 = self:Child("ZhuoMaZi/togGroupInning/togzhuo8Inning/txt8Inning");
	self.zhuoTog8InningTxt2 = self:Child("ZhuoMaZi/togGroupInning/togzhuo8Inning/txtDiamondNumber");

	self.zhuoTog16Inning = self:Child("ZhuoMaZi/togGroupInning/togzhuo16Inning");
	self.zhuoTog16InningTxt1 = self:Child("ZhuoMaZi/togGroupInning/togzhuo16Inning/txt16Inning");
	self.zhuoTog16InningTxt2= self:Child("ZhuoMaZi/togGroupInning/togzhuo16Inning/txtDiamondNumber");

	self.zhuoBtnCreate = self:Child("ZhuoMaZi/btnCreateCatch");
	self.zhuoTxtDiamond = self:Child("ZhuoMaZi/btnCreateCatch/txtDiamondNumber");
	--捉麻子以上

	--红中麻将
	self.redTog8Inning = self:Child("RedDragon/togGroupInning/togRed8Inning");
	self.redTog8InningTxt1 = self:Child("RedDragon/togGroupInning/togRed8Inning/txtRed8Inning");

	self.redTog16Inning = self:Child("RedDragon/togGroupInning/togRed16Inning");
	self.redTog16InningTxt1 = self:Child("RedDragon/togGroupInning/togRed16Inning/txtRed16Inning");

	self.redTogAA = self:Child("RedDragon/togGroupPay/togRedAA");
	self.redTogAATxt1 = self:Child("RedDragon/togGroupPay/togRedAA/txtRedTogAATxt1");
	self.redImgAA = self:Child("RedDragon/togGroupPay/togRedAA/imgRedDiamond");
	self.redTogAATxt2 = self:Child("RedDragon/togGroupPay/togRedAA/imgDiamond/txtRedDiamondNumber");

	self.redTogBoss = self:Child("RedDragon/togGroupPay/togRedBoss");
	self.redTogBossTxt1 = self:Child("RedDragon/togGroupPay/togRedBoss/txtredBossTxt1");
	self.redImgBoss = self:Child("RedDragon/togGroupPay/togRedBoss/imgRedDiamond");
	self.redTogBossTxt2= self:Child("RedDragon/togGroupPay/togRedBoss/imgRedDiamond/txtRedDiamondNumber");

	self.redTogXiayu0 = self:Child("RedDragon/togGroupXiaYu/togRedXiayu0");
	self.redTogXiayu0Txt = self:Child("RedDragon/togGroupXiaYu/togRedXiayu0/txtRedXiayu0");

	self.redTogXiayuNum = self:Child("RedDragon/togGroupXiaYu/togRedXiayuNum");
	self.redTogXiayuNumTxt = self:Child("RedDragon/togGroupXiaYu/togRedXiayuNum/txtRedXiayuNum");

	self.redTogDianpao = self:Child("RedDragon/togGroupPlayMethod/togRedDianpao");
	self.redTogDianpaoTxt = self:Child("RedDragon/togGroupPlayMethod/togRedDianpao/txtRedDianpao");

	self.redTogZimo = self:Child("RedDragon/togGroupPlayMethod/togRedZimo");
	self.redTogZimoTxt = self:Child("RedDragon/togGroupPlayMethod/togRedZimo/txtRedZimo");

	self.redTogBihu = self:Child("RedDragon/togGroupPlayMethod/togRedBihu");
	self.redTogBihuTxt = self:Child("RedDragon/togGroupPlayMethod/togRedBihu/txtRedBihu");
	self.redBtnBihu = self:Child("RedDragon/togGroupPlayMethod/togRedBihu/btnRedColor");
	self.redImgBihu = self:Child("RedDragon/togGroupPlayMethod/togRedBihu/imgRedColor");

	self.redTogFeng = self:Child("RedDragon/togRedFeng");
	self.redTogFengTxt = self:Child("RedDragon/togRedFeng/txtRedFeng");

	self.redTogHong = self:Child("RedDragon/togRedHong");
	self.redTogHongTxt = self:Child("RedDragon/togRedHong/txtRedHong");

	self.redTogNum3 = self:Child("RedDragon/togGroupPlayNum/togRedNum3");
	self.redTogNum3Txt = self:Child("RedDragon/togGroupPlayNum/togRedNum3/txtRedNum3");

	self.redTogNum4 = self:Child("RedDragon/togGroupPlayNum/togRedNum4");
	self.redTogNum4Txt = self:Child("RedDragon/togGroupPlayNum/togRedNum4/txtRedNum4");

	self.redTogRobot = self:Child("RedDragon/togGroupPlayNum/togRedRobot");
	self.redTogRobotTxt = self:Child("RedDragon/togGroupPlayNum/togRedRobot/txtRedRobot");
	
	self.redBtnCreate = self:Child("RedDragon/btnCreateRedDragon");
	--self.redTxtDiamond = self:Child("RedDragon/btnCreate/txtRedDiamondNumber");
	--红中麻将以上


	--斗地主
	self.togHappyGame = self:Child("Landlords/togFightGame/togHappyGame")
	self.togHappyGameTxt = self:Child("Landlords/togFightGame/togHappyGame/txtHappyTxt")
	self.togPersonGame = self:Child("Landlords/togFightGame/togPersonGame")
	self.togPersonGameTxt = self:Child("Landlords/togFightGame/togPersonGame/txtPersontxt")

	self.togFigPerson8 = self:Child("Landlords/togLandlordsPlaying/togFigPerson8")
	self.togFigPerson8Txt = self:Child("Landlords/togLandlordsPlaying/togFigPerson8/txtFigPerson8")
	self.togFigPerson16 = self:Child("Landlords/togLandlordsPlaying/togFigPerson16")
	self.togFigPerson16Txt = self:Child("Landlords/togLandlordsPlaying/togFigPerson16/txtFigPerson16")

	self.togFightAA = self:Child("Landlords/togFightPay/togFightAA")
	self.togFightAATxt = self:Child("Landlords/togFightPay/togFightAA/txtFightTogAATxt")

	self.togFightBoss = self:Child("Landlords/togFightPay/togFightBoss")
	self.togFightBossTxt = self:Child("Landlords/togFightPay/togFightBoss/txtFightBossTxt1")

	self.FightAARoomCard = self:Child("Landlords/togFightPay/togFightAA/imgFigAARoomCad")
	self.FigBossRoomCard = self:Child("Landlords/togFightPay/togFightBoss/imgFigBossRoomCad")
	self.FightAARoomNumber = self:Child("Landlords/togFightPay/togFightAA/imgFigAARoomCad/txtFigAARoomNumber")
	self.FigBossRoomNumber = self:Child("Landlords/togFightPay/togFightBoss/imgFigBossRoomCad/txtFigBossRoomNumber")

	self.togFightRob = self:Child("Landlords/togFightPlayMethod/togFightRob")
	self.togFightRobTxt = self:Child("Landlords/togFightPlayMethod/togFightRob/txtFightRob")

	self.togFightScore = self:Child("Landlords/togFightPlayMethod/togFightScore")
	self.togFightScoreTxt = self:Child("Landlords/togFightPlayMethod/togFightScore/txtFightScore")

	self.togFightAgainst32 = self:Child("Landlords/TogMulriple/togFightAgainst32")
	self.togFightAgainst32Txt = self:Child("Landlords/TogMulriple/togFightAgainst32/txtFightAgainst32")

	self.togFightAgainst64 = self:Child("Landlords/TogMulriple/togFightAgainst64")
	self.togFightAgainst64Txt = self:Child("Landlords/TogMulriple/togFightAgainst64/txtFightAgainst64")

	self.togFightAgainst128 = self:Child("Landlords/TogMulriple/togFightAgainst128")
	self.togFightAgainst128Txt = self:Child("Landlords/TogMulriple/togFightAgainst128/txtFightAgainst128")

	self.btnCreateFight = self:Child("Landlords/btnCreateFightDragon")

	----血战麻将
	self.BattleMahjong = self:Child("BattleMahjong")
	--局数
	self.battleTog4Inning = self:Child("BattleMahjong/togGroupInning/togBattle4ju");
	self.battleTog8Inning = self:Child("BattleMahjong/togGroupInning/togBattle8ju");
	--底分
	--self.battleTog1	    = self:Child("BattleMahjong/togbaseScore/togBattle1");
	--self.battleTog2	    = self:Child("BattleMahjong/togbaseScore/togBattle2");
	--self.battleTog5	    = self:Child("BattleMahjong/togbaseScore/togBattle5");
	--self.battleTog10	    = self:Child("BattleMahjong/togbaseScore/togBattle10");
	--番数
	self.battleTog2Num	    = self:Child("BattleMahjong/togFengDingFanShu/togBattle2Num");
	self.battleTog3Num		= self:Child("BattleMahjong/togFengDingFanShu/togBattle3Num");
	self.battleTog4Num	    = self:Child("BattleMahjong/togFengDingFanShu/togBattle4Num");
	--玩法
	self.battleTogZimojiadi			= self:Child("BattleMahjong/togPlayMethodZimo/togZimojiadi");
	self.battleTogZimojiafan	    = self:Child("BattleMahjong/togPlayMethodZimo/togZimojiafan");
	self.battleTogDiangangZimo	    = self:Child("BattleMahjong/togPlayMethodDiangang/togDiangangZimo");
	self.battleTogDiangangDianpao	= self:Child("BattleMahjong/togPlayMethodDiangang/togDiangangDianpao");
	--换三张
	--self.battleTogHuansanzhang	    = self:Child("BattleMahjong/togMaima/togHuansanzhang");
	--牌型
	self.battleTogR0	= self:Child("BattleMahjong/togPaixing/togBattleR0");
	self.battleTogR1	    = self:Child("BattleMahjong/togPaixing/togBattleR1");
	self.battleTogR2	    = self:Child("BattleMahjong/togPaixing/togBattleR2");
	self.btnCreateBattleMahjong	    = self:Child("BattleMahjong/btnCreateBattleMahjong");

	self.btnBattleMahjong 	= self:Child("imgCebian/btnBattleMahjong")
	self.btnThreeTwoMahjong = self:Child("imgCebian/btnThreeTwoMahjong")
	self.btnNiuNiu 			= self:Child("imgCebian/btnNiuNiu")

	self.imgBattleMahjong 	= self:Child("imgCebian/btnBattleMahjong/imgBattleMahjong")
	self.imgThreeTwoMahjong = self:Child("imgCebian/btnThreeTwoMahjong/imgThreeTwoMahjong")
	self.imgNiuNiu 			= self:Child("imgCebian/btnNiuNiu/imgNiuNiu")
end
