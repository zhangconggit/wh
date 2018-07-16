--文件：查看战绩界面

GradePanel = {};
setbaseclass(GradePanel, {BasePanel})

function GradePanel:InitPanel()

	self.btnQuit = self:Child("btnQuit")
	self.txtNull = self:Child("txtNull")
	self.btnShop = self:Child("btnShop")

	self.gridJinBiPanel = self:Child("gridJinBiPanel")
	self.gridJinBiParent = self:Child("gridJinBiPanel/Grid")

	self.gridYuanBaoPanel = self:Child("gridYuanBaoPanel")
	self.gridYuanBaoParent = self:Child("gridYuanBaoPanel/Grid")

	self.gridCardPanel = self:Child("gridCardParent")
	self.gridCardParent = self:Child("gridCardParent/Grid")

	self.btnJinBi = self:Child("imgLeftBG/togGroupLeft/JinBi");
	self.btnYuanBao = self:Child("imgLeftBG/togGroupLeft/YuanBao");
	self.btnFangKa = self:Child("imgLeftBG/togGroupLeft/FangKa");
	--self.togZhajinhua = self:Child("imgLeftBG/togGroupLeft/ZhaJinHua");
	--self.togNiuniu = self:Child("imgLeftBG/togGroupLeft/NiuNiu");

	self.imgMask = self:Child("imgMask");

end
