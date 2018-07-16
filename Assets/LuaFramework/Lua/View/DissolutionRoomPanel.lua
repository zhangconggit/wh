--文件：申请解散房间界面

DissolutionRoomPanel = {};
setbaseclass(DissolutionRoomPanel, {BasePanel})

function DissolutionRoomPanel:InitPanel()
logWarn("-----------------------------------------DissolutionRoomPanel");
	self.btnApplyConfrim 		= self:Child("btnApplyConfrim")
	self.btnApplyCancel 		= self:Child("btnApplyCancel")

	self.txtDissolutionRoom 	= self:Child("txtDissolutionRoom")
	self.txtPlayerOne 			= self:Child("txtPlayerOne")
	self.txtPlayerTwo 			= self:Child("txtPlayerTwo")
	self.txtPlayerThree 		= self:Child("txtPlayerThree")
	self.txtPlayerFour 			= self:Child("txtPlayerFour")
	self.timeTxt 				= self:Child("timeTxt")
end
