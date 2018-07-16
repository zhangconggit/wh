GameMatchRankListPanel = {};
setbaseclass(GameMatchRankListPanel, {BasePanel})

function GameMatchRankListPanel:InitPanel()
	self.imgMatchRankListBg = self:Child("imgMatchRankListBg");
	self.txtCurrentRankList = self:Child("imgMatchRankListBg/txtCurrentRankList");
	self.img16jin8WaiGuang = self:Child("imgMatchRankListBg/img16jin8WaiGuang");
	self.img8jin4WaiGuang = self:Child("imgMatchRankListBg/img8jin4WaiGuang");

	self.imgMatch16jin8BG = self:Child("imgMatchRankListBg/imgMatch16jin8BG");
	self.img16jin8NeiGuang = self:Child("imgMatchRankListBg/imgMatch16jin8BG/img16jin8NeiGuang");
	self.img16jin8JinXingZhong = self:Child("imgMatchRankListBg/imgMatch16jin8BG/img16jin8JinXingZhong");
	self.txtJinXingZhong = self:Child("imgMatchRankListBg/imgMatch16jin8BG/txtJinXingZhong");

	self.imgMatch8jin4BG = self:Child("imgMatchRankListBg/imgMatch8jin4BG");
	self.img8jin4NeiGuang = self:Child("imgMatchRankListBg/imgMatch8jin4BG/img8jin4NeiGuang");
	self.img8jin4JingXingZhong = self:Child("imgMatchRankListBg/imgMatch8jin4BG/img8jin4JingXingZhong");

	self.imgMatchZongjuesai = self:Child("imgMatchRankListBg/imgMatchZongjuesai");
	self.txtSurplusInfo = self:Child("imgMatchRankListBg/txtSurplusInfo");
	self.btnFangQiMatch = self:Child("imgMatchRankListBg/btnFangQiMatch");
end