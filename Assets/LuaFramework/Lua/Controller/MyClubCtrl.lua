MyClubCtrl={}
setbaseclass(MyClubCtrl, { BaseCtrl })

-- 启动事件--
function MyClubCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)

	self:AddClick(MyClubPanel.btnBack,self.OnBackClick)	--退出
	self:AddClick(MyClubPanel.btnxx,self.OnxxClick)		--消息
	self:AddClick(MyClubPanel.btnyq,self.OnyqClick)		--邀请
	self:AddClick(MyClubPanel.btnjj,self.OnjjClick)		--基金
	self:AddClick(MyClubPanel.btnsz,self.OnszClick)		--设置
	self:AddClick(MyClubPanel.btncy,self.OncyClick)		--成员

	self:AddClick(MyClubPanel.btnCreateCulbRoom,self.OnCreateCulbRoomClick)		--创建房间

	self:AddClick(MyClubPanel.btnjiahao,self.OnjiahaoClick)	--点击加号
	self:AddClick(MyClubPanel.btncj,self.OncjClick)	--创建俱乐部
	self:AddClick(MyClubPanel.btnjr,self.OnjrClick)	--加入俱乐部
	self:AddClick(MyClubPanel.btnjrfj,self.OnjrfjClick)	--加入房间

	self:AddClick(MyClubPanel.btnCreateClubyes,self.OnCreateClubyesClick)	--确认创建俱乐部
	self:AddClick(MyClubPanel.btnCreateClubno,self.OnCreateClubnoClick)	--取消创建俱乐部
	self:AddClick(MyClubPanel.btnJoinClubyes,self.OnJoinClubyesClick)	--确认加入俱乐部
	self:AddClick(MyClubPanel.btnJoinClubno,self.OnJoinClubnoClick)	--取消加入俱乐部

	self:AddClick(MyClubPanel.btntongyi,self.OntongyiClick)			--消息面板确认
	self:AddClick(MyClubPanel.btntjujiue,self.OnjujueClick)			--消息面板拒绝
	

	self:InitPanel()
end

-- 初始化面板--
function MyClubCtrl:InitPanel()
	MyClubPanel.imgxxdikuang:SetActive(false)
	MyClubPanel.jijinclubPanel:SetActive(false)
	MyClubPanel.jijinclubcxPanel:SetActive(false)
	MyClubPanel.clubSettingPanel:SetActive(false)
	MyClubPanel.clubmemberPanel:SetActive(false)
end


function MyClubCtrl.OnBackClick(go)
	local self = MyClubCtrl
	
end

--消息
function MyClubCtrl.OnxxClick(go)
	local self = MyClubCtrl
	MyClubPanel.imgxxdikuang:SetActive(true)
end

--消息面板显示
--[[function MyClubCtrl.RealNameRes(buffer)
	local self = MyClubCtrl
	local data = buffer:ReadBuffer()
	local self = RealName_pb.RealName()
	msg:ParseFromString(data)

	MyClubPanel.imgtouxiang = msg.imgtouxiang
	MyClubPanel.txtts = msg.txtts
	-- body
end--]]

--消息面板确认
function MyClubCtrl.OntongyiClick(go)
	local self = MyClubCtrl
	-- body
end

--消息面板拒绝
function MyClubCtrl.OnjujueClick(go)
	local self = MyClubCtrl
	-- body
end

--邀请
function MyClubCtrl.OnyqClick(go)
	local self = MyClubCtrl
	MyClubPanel.jijinclubPanel:SetActive(true)
end

--基金
function MyClubCtrl.OnjjClick(go)
	local self = MyClubCtrl
	MyClubPanel.jijinclubcxPanel:SetActive(true)
end

--设置
function MyClubCtrl.OnszClick(go)
	local self = MyClubCtrl
	MyClubPanel.clubSettingPanel:SetActive(true)
end

--成员
function MyClubCtrl.OncyClick(go)
	local self = MyClubCtrl
	MyClubPanel.clubmemberPanel:SetActive(true)
end

--创建房间
function MyClubCtrl.btnCreateCulbRoom(go)

	-- body
end

--点击加号
function MyClubCtrl.OnjiahaoClick(go)
	local self = MyClubCtrl
	MyClubPanel.imgwdjlb2:SetActive(true)
	-- body
end

--创建俱乐部界面显示
function MyClubCtrl.OncjClick(go)
	local self = MyClubCtrl
	MyClubPanel.imgwdjlb2:SetActive(false)
	MyClubPanel.wdjlbcj:SetActive(true)
	-- body
end

--确认创建俱乐部
function MyClubCtrl.OnCreateClubyesClick(go)
	local self = MyClubCtrl
	--local data 	= RealName_pb.RealNameReq()
    --data.txtClubName  = self:GetText(MyClubPanel.txtClubName)
    
    --local msg 	= data:SerializeToString()
    --Game.SendProtocal(Protocal.RealName, msg)
	-- body
end

--确认创建俱乐部返回
--[[function MyClubCtrl.RealNameRes(buffer)
	local self = MyClubCtrl
	local data   = buffer:ReadBuffer()
	local msg    = RealName_pb.RealNameRes()
	msg:ParseFromString(data)
end--]]

--取消创建俱乐部
function MyClubCtrl.OnCreateClubnoClick(go)
	local self = MyClubCtrl
	MyClubPanel.wdjlbcj:SetActive(false)
	-- body
end

--加入俱乐部界面显示
function MyClubCtrl.OnjrClick(go)
	local self = MyClubCtrl
	MyClubPanel.imgwdjlb2:SetActive(false)
	MyClubPanel.wdjlbjr:SetActive(true)
	-- body
end

--确认加入俱乐部
function MyClubCtrl.OnJoinClubyesClick(go)
	local self = MyClubCtrl
	--local data 	= RealName_pb.RealNameReq()
    --data.txtClubID  = self:GetText(MyClubPanel.txtClubID)
    
    --local msg 	= data:SerializeToString()
    --Game.SendProtocal(Protocal.RealName, msg)
	-- body
end

--确认加入俱乐部返回
--[[function MyClubCtrl.RealNameRes(buffer)
	local self = MyClubCtrl
	local data   = buffer:ReadBuffer()
	local msg    = RealName_pb.RealNameRes()
	msg:ParseFromString(data)
end--]]

--取消加入俱乐部
function MyClubCtrl.OnJoinClubnoClick(go)
	local self = MyClubCtrl
	MyClubPanel.wdjlbjr:SetActive(false)
	-- body
end

--加入房间
function MyClubCtrl.OnjrfjClick(go)
	MyClubPanel.imgwdjlb2:SetActive(false)
	--JoinRoomCtrl:Open('JoinRoom')
	-- body
end