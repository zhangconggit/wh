DiamondPayPanel = {};
setbaseclass(DiamondPayPanel, {BasePanel})

function DiamondPayPanel:InitPanel()
	self.btnClose = self:Child("btnClose")
	self.btnCopy1 = self:Child("btnCopy1")
	self.btnCopy2 = self:Child("btnCopy2")
	self.btnCopy3 = self:Child("btnCopy3")
	
	self.btnQuit  = self:Child("btnQuit")
	self.btnDiamondMaskBG = self:Child("imgDiamondMaskBG")


	self.text2 = self:Child("text2/txt2")
	self.text3 = self:Child("text3/txt3")
	self.text4 = self:Child("text4/txt4")

	self.imgshow = self:Child("imgshow")
	self.txtshow = self:Child("imgshow/txtshow")

	--新添加
	self.btnOpenWeb = self:Child("btnOpenWeb")  --点击二维码按钮监听
	self.buttomImg = self:Child("buttomImg")
end