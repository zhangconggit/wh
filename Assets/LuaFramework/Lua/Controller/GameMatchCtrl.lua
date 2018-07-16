GameMatchCtrl = {}
setbaseclass(GameMatchCtrl, {BaseCtrl})

--启动事件--
function GameMatchCtrl:OnCreate(obj)
    BaseCtrl.OnCreate(self, obj)
	self:AddClick(GameMatchPanel.btnRoomCardMatch,self.OnRoomCardMatchBtnClick)
	self:AddClick(GameMatchPanel.btnGoldMatch,self.OnGoldMatchBtnClick)
	self:AddClick(GameMatchPanel.btnMatchDiamondPay,self.OnDiamondPayClick)
	self:AddClick(GameMatchPanel.btnMatchGoldPay,self.OnDiamondPayClick)
	self:AddClick(GameMatchPanel.btnMatchQuit,self.OnMatchQuitBtnClick)
	self:AddClick(GameMatchPanel.btnMatchHeadIcon,self.OnMatchHeadIconBtnClick)
	self:InitPanel(global.userVo)

end

--初始化面板--
function GameMatchCtrl:InitPanel(userInfo)
	local img = GameMatchPanel.imgHeadIcon
	if(AppConst.getCurrentPlatform() == "PC") then
		local url = "https://ps.ssl.qhimg.com/t01e9783b7417515cc0.jpg"
		weChatFunction.SetPic(img,global.userVo.roleId,url)
	else
		weChatFunction.SetPic(img,global.userVo.roleId,global.userVo.headImg)
	end
	self:RefreshPanel(userInfo,"InitPanel")
	GameMatchPanel.imgGoldBG:SetActive(false)
end

function GameMatchCtrl.OnRoomCardMatchBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	GameRoomCardMatchCtrl:Open("GameRoomCardMatch")
end

function GameMatchCtrl.OnGoldMatchBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
end

function GameMatchCtrl.OnMatchQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = GameMatchCtrl
	self:Close()
end

function GameMatchCtrl.OnMatchHeadIconBtnClick()
	local roleInfo = {}
	Game.MusicEffect(Game.Effect.joinRoom)
	roleInfo = {name = global.userVo.name,roleId = global.userVo.roleId, roleIp = global.userVo.roleIp,image = GameMatchPanel.imgHeadIcon}
	RoleInfoCtrl:Open("RoleInfo",function()
		RoleInfoCtrl:InitPanel(roleInfo)
	end)
end

function GameMatchCtrl.OnDiamondPayClick()
	Game.MusicEffect(Game.Effect.joinRoom)
	DiamondPayCtrl:Open("DiamondPay")
end

--刷新信息
function GameMatchCtrl:RefreshPanel(userInfo,name)
	print("===============RefreshPanel==========",name)
	self = GameMatchCtrl
	self:SetText(GameMatchPanel.txtMatchRoleID,"ID:" .. userInfo.roleId)
	self:SetText(GameMatchPanel.txtMatchRoleName,userInfo.name)
	self:SetText(GameMatchPanel.txtMatchRoomCardNum,userInfo.diamond)
end
