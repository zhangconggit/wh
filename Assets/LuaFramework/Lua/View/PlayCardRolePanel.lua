
PlayCardRolePanel = { };
setbaseclass(PlayCardRolePanel, { BasePanel })

function PlayCardRolePanel:InitPanel()
	-- logWarn("-----------------------------------------PlayCardRolePanel");
	self.roleMan = self:Child("Big/imgMan")
	self.roleWoman = self:Child("Big/imgWoman")
	self.roleHead = self:Child("Big/imgHeadIcon")
	self.roleName = self:Child("Big/txtRoleName")
	self.roleID = self:Child("Big/txtID")
	self.roleIP = self:Child("Big/txtIP")
	self.roleDiamond = self:Child("Big/txtDiamond")

	self.SroleHead = self:Child("Small/imgHead")
	self.SroleMan = self:Child("Small/imgMan")
	self.SroleWoman = self:Child("Small/imgWoman")
	self.SroleName = self:Child("Small/txtName")
	self.SroleID = self:Child("Small/txtID")
	self.SroleIP = self:Child("Small/txtIP")
	self.Big = self:Child("Big")
	self.Small = self:Child("Small")
	self.txtInfoMine = self:Child("Big/txtInfoMine")
	self.btnMask = self:Child("imgMaskBG")
	self.btnE1 = self:Child("Big/scrbPanel/Viewport/Grid/imgE1")
	self.btnE2 = self:Child("Big/scrbPanel/Viewport/Grid/imgE2")
	self.btnE3 = self:Child("Big/scrbPanel/Viewport/Grid/imgE3")
	self.btnE4 = self:Child("Big/scrbPanel/Viewport/Grid/imgE4")
	self.btnE5 = self:Child("Big/scrbPanel/Viewport/Grid/imgE5")
	self.btnE6 = self:Child("Big/scrbPanel/Viewport/Grid/imgE6")
end