
GameRoomCardMatchPanel = {};
setbaseclass(GameRoomCardMatchPanel, {BasePanel})

function GameRoomCardMatchPanel:InitPanel()
	self.imgRoomCardMatchBg2 = self:Child("imgRoomCardMatchBg2");
	self.btnRoomCard16Match = self:Child("imgRoomCardMatchBg2/btnRoomCard16Match");
	self.txtBaoMing = self:Child("imgRoomCardMatchBg2/btnRoomCard16Match/txtBaoMing");
	self.btn16TuiSai = self:Child("imgRoomCardMatchBg2/btnRoomCard16Match/btn16TuiSai");
	self.btn16BaoMing = self:Child("imgRoomCardMatchBg2/btnRoomCard16Match/btn16BaoMing");
	self.btn16XiangQing = self:Child("imgRoomCardMatchBg2/btnRoomCard16Match/btn16XiangQing");

	self.btnRoomCard8Match = self:Child("imgRoomCardMatchBg2/btnRoomCard8Match");
	self.txtRoomCard8Tishi = self:Child("imgRoomCardMatchBg2/btnRoomCard8Match/txtRoomCard8Tishi");
	self.txt8BaoMing = self:Child("imgRoomCardMatchBg2/btnRoomCard8Match/txt8BaoMing");
	self.btn8TuiSai = self:Child("imgRoomCardMatchBg2/btnRoomCard8Match/btn8TuiSai");
	self.btn8BaoMing = self:Child("imgRoomCardMatchBg2/btnRoomCard8Match/btn8BaoMing");
	self.imgRoomCard8SuoBG = self:Child("imgRoomCardMatchBg2/btnRoomCard8Match/imgRoomCard8SuoBG");
	self.btn8XiangQing = self:Child("imgRoomCardMatchBg2/btnRoomCard8Match/btn8XiangQing");
	
	self.btnRoomCard4Match = self:Child("imgRoomCardMatchBg2/btnRoomCard4Match");
	self.txtRoomCard4Tishi = self:Child("imgRoomCardMatchBg2/btnRoomCard4Match/txtRoomCard4Tishi");
	self.txt4BaoMing = self:Child("imgRoomCardMatchBg2/btnRoomCard4Match/txt4BaoMing");
	self.btn4TuiSai = self:Child("imgRoomCardMatchBg2/btnRoomCard4Match/btn4TuiSai");
	self.btn4BaoMing = self:Child("imgRoomCardMatchBg2/btnRoomCard4Match/btn4BaoMing");
	self.imgRoomCard4SuoBG = self:Child("imgRoomCardMatchBg2/btnRoomCard4Match/imgRoomCard4SuoBG");
	self.btn4XiangQing = self:Child("imgRoomCardMatchBg2/btnRoomCard4Match/btn4XiangQing");

	self.imgFangKaMatchRoomCardBG = self:Child("imgFangKaMatchRoomCardBG");
	self.txtFangKaMatchRoomCardNum = self:Child("imgFangKaMatchRoomCardBG/txtFangKaMatchRoomCardNum");
	self.btnFangKaMatchDiamondPay = self:Child("imgFangKaMatchRoomCardBG/btnFangKaMatchDiamondPay");
	self.imgFangKaMatchGoldBG = self:Child("imgFangKaMatchGoldBG");
	self.txtFangKaMatchGoldNum = self:Child("imgFangKaMatchGoldBG/txtFangKaMatchGoldNum");
	self.btnFangKaMatchGoldPay = self:Child("imgFangKaMatchGoldBG/btnFangKaMatchGoldPay");

	self.btnRoomCardMatchHeadIcon = self:Child("btnRoomCardMatchHeadIcon");
	self.imgHeadIcon = self:Child("btnRoomCardMatchHeadIcon/imgMask/Image");
	self.btnRoomCardMatchQuit = self:Child("btnRoomCardMatchQuit");
	self.txtRoomCardMatchRoleID = self:Child("txtRoomCardMatchRoleID");
	self.txtRoomCardMatchRoleName = self:Child("txtRoomCardMatchRoleName");
	self.btnMatchRecord = self:Child("btnMatchRecord");

	--提示
	self.imgTips = self:Child("imgTips")
	self.togRobot = self:Child("togRobot")
end