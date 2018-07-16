GameMatchSettlePanel = {};
setbaseclass(GameMatchSettlePanel, {BasePanel})

function GameMatchSettlePanel:InitPanel()
	self.imgTaoTai = self:Child("imgTaoTai");
	self.imgTaotaiBG = self:Child("imgTaoTai/imgTaotaiBG");
	self.txtTaotaiRoleName = self:Child("imgTaoTai/imgTaotaiBG/txtTaotaiRoleName");
	self.txtTaoTaiInfo = self:Child("imgTaoTai/imgTaotaiBG/txtTaoTaiInfo");
	self.imgJiangLi = self:Child("imgJiangLi");
	self.imgJiangliBG = self:Child("imgJiangLi/imgJiangliBG");
	self.txtJiangliRoleName = self:Child("imgJiangLi/imgJiangliBG/txtJiangliRoleName");
	self.txtJiangliInfo = self:Child("imgJiangLi/imgJiangliBG/txtJiangliInfo");
	self.imgFangka = self:Child("imgJiangLi/imgJiangliBG/imgFangka");
	self.btnFanhuidating = self:Child("btnFanhuidating");
	self.btnShareMatch = self:Child("btnShareMatch");
	self.btnJixucansai = self:Child("btnJixucansai");
end