--分享界面
SharePanel = {};
setbaseclass(SharePanel, {BasePanel})

function SharePanel:InitPanel()
logWarn("-----------------------------------------SharePanel");
	self.btnCloseMask = self:Child("imgMaskBG");
	self.btnQuit = self:Child("btnQuit");

	self.btnFriend = self:Child("btnFriend");
	self.btnCircle = self:Child("btnCircle");
end
