GameSettingPanel = {}
setbaseclass(GameSettingPanel, {BasePanel})

function GameSettingPanel:InitPanel()
	--GameSetting Panel
    self.QuitHideButton 		= self:Child("QuitHideButton")
    self.imgNotWaitQuitRoom 	= self:Child("imgHideBg/imgNotWaitQuitRoom")
    self.btnWaitQuitRoom 		= self:Child("imgHideBg/btnWaitQuitRoom")
    self.imgNotGameMainQuitRoom = self:Child("imgHideBg/imgNotGameMainQuitRoom")
    self.btnGameMainQuitRoom 	= self:Child("imgHideBg/btnGameMainQuitRoom")
    self.btnSettingSystem 		= self:Child("imgHideBg/btnSettingSystem")
    self.btnShowTips 			= self:Child("imgHideBg/btnShowTips")
    self.btnHideUp 				= self:Child("imgHideBg/btnHidePanelUp")
end