PlayMethodPanel = {};
setbaseclass(PlayMethodPanel, {BasePanel})

function PlayMethodPanel:InitPanel()
logWarn("-----------------------------------------PlayMethodPanel");
	self.btnClose = self:Child("btnClose");

	self.togNiu = self:Child("togGroupLeft/Viewport/Content/togNiu");
	self.togXue = self:Child("togGroupLeft/Viewport/Content/togXue");
	self.togjinhua = self:Child("togGroupLeft/Viewport/Content/togjinhua");
	self.togRed = self:Child("togGroupLeft/Viewport/Content/togRed");
	self.togDou = self:Child("togGroupLeft/Viewport/Content/togDou");
	self.togMahjong = self:Child("togGroupLeft/Viewport/Content/togMahjong");
	self.togTenHalf = self:Child("togGroupLeft/Viewport/Content/togTenHalf");
	self.togMaZi = self:Child("togGroupLeft/Viewport/Content/togMaZi");
	self.togWu = self:Child("togGroupLeft/Viewport/Content/togWu");
		
	self.imgArrow = self:Child("imgArrowBg/imgArrow");

	self.MahjongPlayMethod = self:Child("MahjongPlayMethod");
	self.TenHalfPlayMethod = self:Child("TenHalfPlayMethod");
	self.JinHuaPlayMethod = self:Child("JinHuaPlayMethod");
	self.MaZiPlayMethod = self:Child("MaZiPlayMethod");
	self.NiuPlayMethod = self:Child("NiuPlayMethod");
	self.XuePlayMethod = self:Child("XuePlayMethod");
	self.RedPlayMethod = self:Child("RedPlayMethod");
	self.DouPlayMethod = self:Child("DouPlayMethod");
	self.WuPlayMethod = self:Child("WuPlayMethod");

	self.imgMask = self:Child("imgMask");
end

