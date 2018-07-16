--分享界面
ShareCtrl = {};
setbaseclass(ShareCtrl,{BaseCtrl});

--启动事件--
function ShareCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj);
	self:AddClickNoChange(SharePanel.btnCloseMask, self.OnQuitBtnClick);
	self:AddClick(SharePanel.btnQuit, self.OnQuitBtnClick);
	self:AddClick(SharePanel.btnFriend, self.OnFriendClick);
	self:AddClick(SharePanel.btnCircle, self.OnCircleClick);
	self:InitPanel()
end

--初始化面板--
function ShareCtrl:InitPanel(objs)
	self:SetText(SharePanel.setFriendText,"1")
	self:SetText(SharePanel.setCircleText,"2")
end

function ShareCtrl.OnQuitBtnClick(go)
	--Game.MusicEffect(Game.Effect.buttonBack)
	local self = ShareCtrl;
	self:Close();
end

function ShareCtrl.OnFriendClick(go)
	print("微信分享！")
	local self = ShareCtrl;
	self.isClickFriend = true
	--Game.MusicEffect(Game.Effect.joinRoom)
	if(AppConst.getCurrentPlatform() == 'PC') then
		MessageTipsCtrl:ShowInfo("当前不能分享！ ")
        return
	end
	local shareContent = "三川娱乐"
	local imageUrl = 'file:///C:/Users/Administrator/Desktop/icon_520.png'
	local title = "游戏"
	local downUrl = 'https://fir.im/s1hn'
	weChatFunction.weChatInviteFriendBtnClick(shareContent,imageUrl,title,downUrl)
end

function ShareCtrl.OnCircleClick(go)
	local self = ShareCtrl;
	self.isClickFriend = true
	--Game.MusicEffect(Game.Effect.joinRoom)
	if(AppConst.getCurrentPlatform() == 'PC') then
		MessageTipsCtrl:ShowInfo("当前不能分享！ ")
        return
	end
	local shareContent = "三川娱乐"
	local imageUrl = 'file:///C:/Users/Administrator/Desktop/icon_520.png'
	local title = "游戏"
	local downUrl = 'https://fir.im/s1hn'
	weChatFunction.shareWeChatMomentsBtnClick(shareContent,imageUrl,title,downUrl)
end

function ShareCtrl.OnShareFriendSend()
	local self = ShareCtrl
	if self.isClickFriend then
		local data = ShareFriendster_pb.ShareFriendsterReq()
		data.shareType = 1
		local msg = data:SerializeToString()
		Game.SendProtocal(Protocal.ShareFriendster, msg)
		self.isClickFriend = false
	end
end

function ShareCtrl.OnShareFriendCircleSend()
	local self = ShareCtrl
	if self.isClickFriend then
		local data = ShareFriendster_pb.ShareFriendsterReq()
		data.shareType = 2
		local msg = data:SerializeToString()
		Game.SendProtocal(Protocal.ShareFriendster, msg)
		self.isClickFriend = false
	end
end

--分享状态回调
function ShareCtrl.ShareStateRes(buffer)
	local self = ShareCtrl
	local data   = buffer:ReadBuffer()
	local msg    = IntTypeReturn_pb.IntTypeReturnRes()
	msg:ParseFromString(data)
	print('ShareCtrl.ShareStateRes===',msg.intVal)
	if msg.intVal == 1 or msg.intVal == 2 then
		self:Close();
	end
end

