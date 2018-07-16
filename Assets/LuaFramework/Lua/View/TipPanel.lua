TipPanel = {}
setbaseclass(TipPanel, {BasePanel})

function TipPanel:InitPanel()
	self.txtTip = self:Child("imgTips/txtTip")
end