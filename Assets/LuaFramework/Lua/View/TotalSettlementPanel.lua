--文件：总结算界面

TotalSettlementPanel = {};
setbaseclass(TotalSettlementPanel, {BasePanel})

function TotalSettlementPanel:InitPanel()
logWarn("-----------------------------------------TotalSettlementPanel");
	self.btnQuit 				= self:Child("btnQuit")
	self.btnShare 				= self:Child("btnShare")

	self.txtCurrentInningNum 	= self:Child("txtCurrentInningNum")
	self.txtCurrentRoomNum 		= self:Child("txtCurrentRoomNum")
	self.txtCurrentTime 		= self:Child("txtCurrentTime")
	self.gridParent 			= self:Child("ScrollView/Grid")
end
