TipCtrl = {msg = ""}
setbaseclass(TipCtrl, {BaseCtrl})

function TipCtrl:Show(msg)
	if msg == self.msg then
		return
	end
	self:UsualOpen("Tip", function()
		if msg == "" then
			self:Close()
		else
			self:SetText(TipPanel.txtTip, msg)
		end
		self.msg = msg
	end)
end