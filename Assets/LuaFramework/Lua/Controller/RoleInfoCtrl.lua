--文件：角色信息控制

RoleInfoCtrl = {};
setbaseclass(RoleInfoCtrl, {BaseCtrl})

--启动事件--
function RoleInfoCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self,obj);
	self:AddClick(RoleInfoPanel.btnBack,self.OnQuitBtnClick);
	self:AddClickNoChange(RoleInfoPanel.imgMaskBG,self.OnQuitBtnClick);
	self:AddOnEndEdit(RoleInfoPanel.inputField,self.OnInputFiledWriteEnd);--签名输入结束的时候调用	
	self:SetInputText(RoleInfoPanel.inputField,global.userVo.signature); --获取到,然后设置为
	self:AddClick(RoleInfoPanel.btnChangNum,self.OnChangNumBtnClick);
	self:ShowSex()
    print("***********************"..global.userVo.gender.."**************************")
end

--初始化面板--
function RoleInfoCtrl:InitPanel(info)
	--广电
	-- RoleInfoPanel.txtRoleName.transform.localPosition = Vector3.New(70,102,0);
	-- RoleInfoPanel.imgHead.transform.localPosition = Vector3.New(-7,-4,0);
	-- RoleInfoPanel.imgHeadBG.transform.localPosition = Vector3.New(-7,-3,0);
	-- RoleInfoPanel.txtRoleID:SetActive(false)
	-- RoleInfoPanel.txtRoleIP:SetActive(false)
	--以上
	--苹果审核版本
	if IS_APP_STORE_CHECK then
		RoleInfoPanel.txtRoleIP:SetActive(false)
	end
	local image	= RoleInfoPanel.imgHeadIcon
	self:SetText(RoleInfoPanel.txtRoleName,info.name);
	self:SetText(RoleInfoPanel.txtRoleID,"ID：" .. info.roleId);
	self:SetText(RoleInfoPanel.txtRoleIP,"IP：" .. info.roleIp);
	
	--玩家个人财产的显示
	self:SetText(RoleInfoPanel.txtJinBiNumber,info.goldcoin);
	self:SetText(RoleInfoPanel.txtYuanBaoNumber,info.wing);
	self:SetText(RoleInfoPanel.txtFangKaNumber,info.diamond);
	local sprite = info.image:GetComponent("Image").sprite;
	weChatFunction.GetSprite(image,sprite);

end


function RoleInfoCtrl:GetInfo(a,b,c,d,e,f,g)
	self.roleInfo = {name = a,roleId = b, roleIp = c,image = d,wing = e ,goldcoin = f ,diamond = g   }
end


--点击返回按钮
function RoleInfoCtrl.OnQuitBtnClick(go)
	local self = RoleInfoCtrl;	
	self:Close();
end

--输入签名结束后会调用这个方法,向服务器发送自己写的东西
function RoleInfoCtrl.OnInputFiledWriteEnd()
	local info = ChangeRoleInfo_pb.ChangeRoleInfoReq()
    info.shortDesc = self:GetInputText(RoleInfoPanel.inputField,global.userVo.signature);  --取到玩家输入的个性签名
	local msg = info:SerializeToString()
	Game.SendProtocal(Protocal.ChangeRoleInfo, msg)  --向服务器发送请求修改信息的协议
end

function RoleInfoCtrl.ShowSex()
	if global.userVo.gender == 1 then
       RoleInfoPanel.imgMan:SetActive(true)
       RoleInfoPanel.imgWomen:SetActive(false)
    else
       RoleInfoPanel.imgMan:SetActive(false)
       RoleInfoPanel.imgWomen:SetActive(true)
    end
end

function RoleInfoCtrl.OnChangNumBtnClick(go)
	global.systemVo.TalkSource:Stop()
	Game.MusicEffect(Game.Effect.buttonBack)
	AppConst.DeleteKey('userID')
	local self = MainSenceCtrl
	self:Close()
	Game.LoadScene("login")
	log(tostring(networkMgr.isConnect))
end


