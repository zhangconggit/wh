--文件：查看详细战绩

GradeDetailPanel = {};
setbaseclass(GradeDetailPanel, {BasePanel})

function GradeDetailPanel:InitPanel()
logWarn("-----------------------------------------GradeDetailPanel");
	self.btnQuit 			= self:Child("btnQuit")
	self.gridParent 		= self:Child("scrbView/Grid")
	self.txtRoleNameTitle1 	= self:Child("txtRoleNameTitle1")
	self.txtRoleNameTitle2 	= self:Child("txtRoleNameTitle2")
	self.txtRoleNameTitle3 	= self:Child("txtRoleNameTitle3")
	self.txtRoleNameTitle4 	= self:Child("txtRoleNameTitle4")
	self.txtRoleNameTitle5 	= self:Child("txtRoleNameTitle5")
	self.txtTime 	= self:Child("txtTime")
	self.txtOperate 	= self:Child("txtOperate")
	self.imgLine6 	= self:Child("imgLine6")
	self.imgLine7 	= self:Child("imgLine7")
end