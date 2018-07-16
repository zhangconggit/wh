--文件：每局结算界面

SingleSettlementPanel = {};
setbaseclass(SingleSettlementPanel, {BasePanel})

function SingleSettlementPanel:InitPanel()
logWarn("-----------------------------------------SingleSettlementPanel");
	self.btnQuit 				= self:Child("btnQuit")
	self.btnStart 				= self:Child("btnStart")
	self.btnShare 				= self:Child("btnShare")
	self.btnTotalScore 			= self:Child("btnTotalScore")
	self.txtCurrentInningNum 	= self:Child("txtCurrentInningNum")
	self.txtCurrentRoomNum 		= self:Child("txtCurrentRoomNum")
	self.gridParent 			= self:Child("ScrollView/Grid")

	self.imgTitleA				= self:Child("imgTitleA")
	self.imgTitle 				= self:Child("imgTitle")
	--新添加
	self.btnQuitGame 			= self:Child("btnQuitGame")
	self.txtScoreTitle 			= self:Child("txtScoreTitle")
end

