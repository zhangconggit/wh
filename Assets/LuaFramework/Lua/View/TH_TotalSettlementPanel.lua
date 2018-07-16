TH_TotalSettlementPanel = {}
setbaseclass(TH_TotalSettlementPanel, {BasePanel})

function TH_TotalSettlementPanel:InitPanel()
logWarn("-----------------------------------------TH_TotalSettlementPanel");
	self.btnClose 				= self:Child("btnClose")
	self.btnShare 				= self:Child("btnShare")

	self.txtRoomNum 			= self:Child("txtRoomNum")
	self.txtRoomTime 			= self:Child("txtRoomTime")
	self.txtCurrentTime 		= self:Child("txtCurrentTime")
	self.gridParent 			= self:Child("Grid")
	self.niuGrid				= self:Child("niuGrid")
	self.txtInning				= self:Child("txtInning")
end