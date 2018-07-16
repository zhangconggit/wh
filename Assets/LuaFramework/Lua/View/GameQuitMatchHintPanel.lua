GameQuitMatchHintPanel = {};
setbaseclass(GameQuitMatchHintPanel, {BasePanel})

function GameQuitMatchHintPanel:InitPanel()
	self.txtQuitMatchHint = self:Child("txtQuitMatchHint");
	self.btnConfirm = self:Child("btnConfirm");
	self.btnCancel = self:Child("btnCancel");
end