--文件：活动界面
ActivityPanel = {};
setbaseclass(ActivityPanel, {BasePanel})

function ActivityPanel:InitPanel()
	self.btnClose = self:Child("btnClose");
	self.imgQiShuBG = self:Child("imgQiShuBG");
	self.txtCurrentQi = self:Child("imgQiShuBG/txtCurrentQi");
	self.barBg = self:Child("imgLeftBG/imgLeftBG2/barBg");
	self.txtZongRenShu = self:Child("imgLeftBG/imgLeftBG2/barBg/txtZongRenShu");
	self.txtCurrentRenShu = self:Child("imgLeftBG/imgLeftBG2/barBg/txtZongRenShu/txtCurrentRenShu"); 
	self.barCurrentRenShu = self:Child("imgLeftBG/imgLeftBG2/barBg/barBg/barCurrentRenShu");
	self.btnStart = self:Child("btnStart");
	self.txtFangkaCount = self:Child("btnStart/txtFangkaCount");
	self.btnNoStart = self:Child("btnNoStart");
	self.btnMathond = self:Child("btnMathond");

	--提示
	self.imgTips = self:Child("imgTips");
	self.imgTipsTanKuang = self:Child("imgTipsTanKuang");
	self.txtTips = self:Child("imgTipsTanKuang/txtTips");
	self.txtTips1 = self:Child("imgTipsTanKuang/txtTips1");
	self.txtRoleName = self:Child("imgTipsTanKuang/txtRoleName");
	self.txtQiShu = self:Child("imgTipsTanKuang/txtQiShu");
	self.txtFangKaShu = self:Child("imgTipsTanKuang/txtFangKaShu");

	self.imgMathond = self:Child("imgMathond");
	self.txtPlayerNum = self:Child("txtPlayerNum");
	self.txtNoAward = self:Child("txtNoAward");
	self.gridParent = self:Child("scrbPanel/Grid")

	self.txtDaoJiShi = self:Child("txtDaoJiShi")
	self.txtDapJiShiMiao = self:Child("txtDaoJiShi/txtDapJiShiMiao")

	self.imgRoleInfo = self:Child("imgRoleInfo")
	self.maskHead = self:Child("imgRoleInfo/maskHead");
	self.imgHeadIcon = self:Child("imgRoleInfo/maskHead/imgHeadIcon");
	self.txtRoleName1 = self:Child("imgRoleInfo/txtRoleName1");
	self.txtRoleID = self:Child("imgRoleInfo/txtRoleID");
	self.txtRoleIP = self:Child("imgRoleInfo/txtRoleIP");
end
