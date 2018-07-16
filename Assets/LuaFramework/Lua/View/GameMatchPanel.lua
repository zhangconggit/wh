
GameMatchPanel = {};
setbaseclass(GameMatchPanel, {BasePanel})

function GameMatchPanel:InitPanel()
	self.imgMatchBg2 = self:Child("imgMatchBg2");
	self.btnRoomCardMatch = self:Child("imgMatchBg2/btnRoomCardMatch");
	self.btnGoldMatch = self:Child("imgMatchBg2/btnGoldMatch");
	self.imgRoomCardBG = self:Child("imgRoomCardBG");
	self.txtMatchRoomCardNum = self:Child("imgRoomCardBG/txtMatchRoomCardNum");
	self.btnMatchDiamondPay = self:Child("imgRoomCardBG/btnMatchDiamondPay");
	self.imgGoldBG = self:Child("imgGoldBG");
	self.txtMatchGoldNum = self:Child("imgGoldBG/txtMatchGoldNum");
	self.btnMatchGoldPay = self:Child("imgGoldBG/btnMatchGoldPay");

	self.btnMatchHeadIcon = self:Child("btnMatchHeadIcon");
	self.imgHeadIcon = self:Child("btnMatchHeadIcon/imgMask/Image");
	self.btnMatchQuit = self:Child("btnMatchQuit");
	self.txtMatchRoleID = self:Child("txtMatchRoleID");
	self.txtMatchRoleName = self:Child("txtMatchRoleName");
end