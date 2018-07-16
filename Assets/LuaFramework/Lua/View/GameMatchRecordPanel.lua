GameMatchRecordPanel = {};
setbaseclass(GameMatchRecordPanel, {BasePanel})

function GameMatchRecordPanel:InitPanel()
	self.btnQuit 			= self:Child("btnQuit")
	self.txtNull 		= self:Child("txtNull")
	self.gridMahjongPanel = self:Child("scrbMahjongPanel")
	self.gridMahjongParent = self:Child("scrbMahjongPanel/Grid")
end