
RoleInfoPanel = {};
setbaseclass(RoleInfoPanel, {BasePanel})

function RoleInfoPanel:InitPanel()

logWarn("-----------------------------------------RoleInfoPanel");

    self.imgMaskBG = self:Child("imgMaskBG");                    --遮罩
	self.imgHeadIcon = self:Child("aboutPersonMessage/maskHead/imgHeadIcon");       --头像
	--广电
	self.imgHead = self:Child("aboutPersonMessage/maskHead");
	self.imgHeadBG = self:Child("aboutPersonMessage/imgHeadBG");
	--以上
	self.txtRoleName = self:Child("aboutPersonMessage/txtRoleName");
	self.txtRoleID = self:Child("aboutPersonMessage/txtRoleID");

	self.btnChangNum = self:Child("btnChangNum");
    
    --玩家的个人财产
	self.txtYuanBaoNumber = self:Child("aboutPersonMessage/txtCaiCan/imgYuanBao/txtYuanBaoNumber");
	self.txtJinBiNumber = self:Child("aboutPersonMessage/txtCaiCan/imgJinBi/txtJinBiNumber");
	self.txtFangKaNumber = self:Child("aboutPersonMessage/txtCaiCan/imgFangKa/txtFangKaNumber");
	self.btnBack = self:Child("btnBack");
	
	self.inputField = self:Child("aboutPersonMessage/textQianMing/InputField");  --InputFiled
	self.txtPlaceholder = self:Child("aboutPersonMessage/textQianMing/InputField/txtPlaceholder"); --holder
    
    --玩家的性别
	self.imgMan = self:Child("aboutPersonMessage/imgSex/imgMan")    --男
	self.imgWomen = self:Child("aboutPersonMessage/imgSex/imgWomen")  --女
	
end