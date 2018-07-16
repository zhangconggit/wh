LoginPanel = {}
setbaseclass(LoginPanel, {BasePanel})

function LoginPanel:InitPanel()
	logWarn("-----------------------------------------LoginPanel")
	self.btnTouristLogin = self:Child("btnTouristLogin")
	self.btnWeChatLogin = self:Child("btnWeChatLogin")
	self.togUserArgeement = self:Child("togUserArgeement")
	-- self.inputIP = self:Child("inputMyIP")
	-- self.inputPort = self:Child("inputPort")
	-- self.btnMobIP = self:Child("btnMobIP")

	-- self:SetVars({"btnTouristLogin", "btnWeChatLogin"})
	self.btnxieyi = self:Child("btnxieyi")
	self.xieyibg = self:Child("xieyibg")
	self.btnxieyishow = self:Child("xieyibg/btnxieyishow")
end