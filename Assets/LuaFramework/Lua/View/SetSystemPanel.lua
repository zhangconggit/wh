
SetSystemPanel = { }
setbaseclass(SetSystemPanel, { BasePanel })

function SetSystemPanel:InitPanel()

	logWarn("-----------------------------------------SetSystemPanel")
	self.btnClose = self:Child("btnClose")
	self.btnSetMaskBG = self:Child("imgSetMaskBG")
	self.btnFanKui = self:Child("btnFankui")
	self.btnGuanYu = self:Child("btnGuanYu")
	self.btnChangeNumber = self:Child("btnChange")
	self.btnMusic = self:Child("imgMusic/btnMusic")
	self.btnMusicEffect = self:Child("imgMusic/btnMusicEffect")
	self.imgGame = self:Child("imgGame")
	self.imgMusic = self:Child("imgMusic")
	self.btnShake = self:Child("imgGame/btnShake")
	self.btnBigCard = self:Child("imgGame/btnBigCard")
	self.btnFangYan = self:Child("imgNXFY")

	self.btnMusicOff = self:Child("imgMusic/btnMusicOff")
	self.btnMusicEffectOff = self:Child("imgMusic/btnMusicEffectOff")
	self.btnShakeOff = self:Child("imgGame/btnShakeOff")
	self.btnBigCardOff = self:Child("imgGame/btnBigCardOff")
	self.btnFangYanOff = self:Child("imgNXFYOff")

	self.imgPlayerIcon = self:Child("imgChangeUser/imgHeadIcon")
	self.txtPlayerName = self:Child("imgRoleName")
	self.txtWeiXin = self:Child("txtWeiXin")

	self.togGPSOff = self:Child("togGPSOff")
	self.togGPSOn = self:Child("togGPSOn")

	self.imgTitle1 = self:Child("imgGame/imgTitle1")
	self.imgLine = self:Child("imgLine")


end
