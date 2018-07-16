ActivityCtrl = {};
setbaseclass(ActivityCtrl,{BaseCtrl});

local qiId = 0
local joinCount = 0
local sumCount = 0
local costCard = 0
local reward = 0
local joinMy = false
local activityMasg = {}	--进三期获奖人信息获奖
local ActivityInfoList = {}

--启动事件--
function ActivityCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj);
	self:AddClick(ActivityPanel.btnClose, self.OnQuitBtnClick);
	self:AddClick(ActivityPanel.btnStart, self.OnStartClick);
	self:AddClick(ActivityPanel.btnNoStart, self.OnNoStartClick);
	self:AddClick(ActivityPanel.imgTipsTanKuang, self.OnImgTipsTanKuangtClick);
	self:AddClick(ActivityPanel.imgRoleInfo,self.OnImgRoleInfoClick);
	self:InitPanel();
	self:CardIndianaInfoReq();
end


--发送请求活动信息--
function ActivityCtrl:CardIndianaInfoReq()
	--打开阻挡层
	BlockLayerCtrl:UsualOpen("BlockLayer")
	local msg = ''
	Game.SendProtocal(Protocal.CardIndianaInfo, msg)
end

--查看活动信息--
function ActivityCtrl.CardIndianaInfoRes(buffer)
	self = ActivityCtrl
	activityMasg = {}
	local data   = buffer:ReadBuffer()
	local msg = CardIndiana_pb.CardIndianaInfoRes()
	msg:ParseFromString(data)
	qiId = msg.qiId
	joinCount = msg.joinCount
	sumCount = msg.sumCount
	costCard = msg.costCard
	reward = msg.reward
	joinMy = msg.joinMy
	activityMasg = msg.rewardRoleInfo
	print('ActivityCtrl.CardIndianaInfoRes====',qiId,joinCount,sumCount,costCard,reward,joinMy,#activityMasg)
	if ActivityCtrl.isCreate then
		ActivityPanel.txtDaoJiShi:SetActive(false)
		ActivityPanel.imgQiShuBG:SetActive(true)
		ActivityPanel.barBg:SetActive(true)
		self:CancelInvoke("DaojishiTime")
		if joinMy then
			ActivityPanel.btnStart:SetActive(false)
			ActivityPanel.btnNoStart:SetActive(true)
		else
			ActivityPanel.btnStart:SetActive(true)
			ActivityPanel.btnNoStart:SetActive(false)
		end
		self:SetText(ActivityPanel.txtCurrentQi,qiId)
		self:SetText(ActivityPanel.txtCurrentRenShu,joinCount)
		self:SetText(ActivityPanel.txtZongRenShu,'/ '..sumCount)
		self:SetText(ActivityPanel.txtFangkaCount,costCard)
		--ActivityPanel.imgQiShuBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(326 + ActivityPanel.txtCurrentQi:GetComponent("Text").rectTransform.sizeDelta.x ,31)
		ActivityPanel.barCurrentRenShu:GetComponent("Image").fillAmount = joinCount / sumCount 

		if #activityMasg == 0 then
			ActivityPanel.txtPlayerNum:SetActive(false)
			ActivityPanel.txtNoAward:SetActive(true)
			--关闭阻挡层
			BlockLayerCtrl:Close()
			return
		else
			ActivityPanel.txtPlayerNum:SetActive(true)
			ActivityPanel.txtNoAward:SetActive(false)
			resMgr:LoadPrefab('activity',{'playerInfo'},self.ActivityInfo)
		end	
	end
end

--房卡夺宝显示
function ActivityCtrl.ActivityInfo(objs)
	for i = 1, #ActivityInfoList do
		ActivityInfoList[i]:Destroy()
	end
	ActivityInfoList = {}
	local parent = ActivityPanel.gridParent.transform
	local self = ActivityCtrl
	for i = 1,#activityMasg do
		local qiId 		= activityMasg[i].qiId
		local winRoleId = activityMasg[i].winRoleId
		local winName 	= activityMasg[i].winName
		local winReward = activityMasg[i].winReward
		local winIp		= activityMasg[i].winIp
		local winImg    = activityMasg[i].winImg

		--生成预制--
		local go = newObject(objs[0])
		go.transform:SetParent(parent)
		go.transform.localScale = Vector3.one
		go.transform.localPosition = Vector3.zero

		winName = self:GetShortName(10,winName)
		--获取组件--
		local imgHead = ActivityPanel:GOChild(go,"Image/imgHead")
		imgHead.name = "imgHead" .. i.."_"..winRoleId
		local txtMsg  = ActivityPanel:GOChild(go,"txtMsg")
		self:RemoveClick(imgHead)
		self:AddClick(imgHead,self.imgHeadClick)
		
		--赋值信息--
		if(AppConst.getCurrentPlatform() == "PC") then
			local url = "http://pic.qqtn.com/up/2017-4/2017041016062719079.jpg"
			weChatFunction.SetPic(imgHead,winRoleId,url)
		else
			weChatFunction.SetPic(imgHead,winRoleId,winImg)
		end
		self:SetText(txtMsg,"恭喜玩家<color=#e74606>  " .. winName .. "  </color>夺得第<color=#e74606> " .. qiId .. " </color>期宝贝<color=#e74606> "..winReward.." </color>张房卡")
		table.insert(ActivityInfoList,go)
	end
	--关闭阻挡层
	BlockLayerCtrl:Close()
end

--初始化面板--
function ActivityCtrl:InitPanel(objs)
	ActivityPanel.imgTips:SetActive(false)
	ActivityPanel.imgTipsTanKuang:SetActive(false)
	ActivityPanel.imgRoleInfo:SetActive(false)
	self.isCanClick = true
end

function ActivityCtrl.imgHeadClick(go)
	local self = ActivityCtrl
	Game.MusicEffect(Game.Effect.joinRoom)
	ActivityPanel.imgRoleInfo:SetActive(true)
	local strAr = string_split(go.name,'_')
	local headRoleId = tonumber(strAr[2])
	for j = 1,#activityMasg do
		if headRoleId == tonumber(activityMasg[j].winRoleId) then
			self:SetText(ActivityPanel.txtRoleName1,activityMasg[j].winName);
			self:SetText(ActivityPanel.txtRoleID,"ID：" .. activityMasg[j].winRoleId);
			self:SetText(ActivityPanel.txtRoleIP,"IP：" .. activityMasg[j].winIp);
			if(AppConst.getCurrentPlatform() == "PC") then
				local url = "http://pic.qqtn.com/up/2017-4/2017041016062719079.jpg"
				weChatFunction.SetPic(ActivityPanel.imgHeadIcon,activityMasg[j].winRoleId,url)
			else
				weChatFunction.SetPic(ActivityPanel.imgHeadIcon,activityMasg[j].winRoleId,activityMasg[j].winImg)
			end
			break
		end
	end
end

function ActivityCtrl.OnImgRoleInfoClick(go)
	ActivityPanel.imgRoleInfo:SetActive(false)
end

function ActivityCtrl.OnImgTipsTanKuangtClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	ActivityPanel.imgTipsTanKuang:SetActive(false)
end

function ActivityCtrl.OnQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	self:CancelInvoke("DaojishiTime")
	local msg = ''
	Game.SendProtocal(Protocal.CloseCardIndiana, msg)
end

function ActivityCtrl.OnStartClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = ActivityCtrl;
	if tonumber(global.userVo.diamond) < costCard then
		self.SetIconTips("房卡不足，无法参夺！")
		return
	end

	if self.isCanClick then
		local msg = ''
		Game.SendProtocal(Protocal.StartIndiana, msg)
		self.isCanClick = false
	end
end

function ActivityCtrl.OnNoStartClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = ActivityCtrl;
	self.SetIconTips("您已参加活动，请耐心等待开奖信息！")
end

function ActivityCtrl.ShowMathond(obj)
	ActivityPanel.imgMathond:SetActive(true)
end

function ActivityCtrl.HideMathond(obj)
	ActivityPanel.imgMathond:SetActive(false)
end

--提示
function ActivityCtrl.ChatTips()
	self = ActivityCtrl
	ActivityPanel.imgTips:SetActive(true)
	coroutine.start(self.ChatWait)
end

function ActivityCtrl.ChatWait()
	coroutine.wait(1.8)
	if ActivityCtrl.isCreate then
		ActivityPanel.imgTips:SetActive(false)
	end
end

function ActivityCtrl.SetIconTips(str,bool)
	self = ActivityCtrl
	if bool == nil then
		if ActivityPanel.imgTips.activeSelf == true then return end
		self.ChatTips()
		local tipsText =  BasePanel:GOChild(ActivityPanel.imgTips,"Name")
		local tipsPos = Vector3.New(0,-172.8,3782)
		local sequence = DG.Tweening.DOTween.Sequence()
		sequence:Append(ActivityPanel.imgTips.transform:DOLocalMoveY(tipsPos.y+50, 2, false))
				:OnComplete(function()
				ActivityPanel.imgTips.transform.localPosition = tipsPos
				end)
		self:SetText(tipsText,str)
	elseif bool == true then
		local tipsText =  BasePanel:GOChild(ActivityPanel.imgTips,"Name")
		local tipsPos = Vector3.New(0,-130,3782)
		ActivityPanel.imgTips.transform.localPosition = tipsPos
		ActivityPanel.imgTips:SetActive(true)
		self:SetText(tipsText,str)
	else
		ActivityPanel.imgTips:SetActive(false)
	end
end

--开始夺宝回调--
function ActivityCtrl.StartIndianaRes(buffer)
	self = ActivityCtrl
	self.isCanClick = true
	local data   = buffer:ReadBuffer()
	local msg = CardIndiana_pb.StartIndianaRes()
	msg:ParseFromString(data)
	local curQiId = msg.curQiId
	local joinCount = msg.joinCount
	local isEnd = msg.isEnd
	local indianaRoleId = msg.indianaRoleId
	print('ActivityCtrl.StartIndianaRes=======',curQiId,joinCount,isEnd)
	if ActivityCtrl.isCreate then
		ActivityPanel.barCurrentRenShu:GetComponent("Image").fillAmount = joinCount / sumCount
		self:SetText(ActivityPanel.txtCurrentRenShu,joinCount)
		if indianaRoleId == global.userVo.roleId then
			ActivityPanel.btnStart:SetActive(false)
			ActivityPanel.btnNoStart:SetActive(true)
		end
	end
	if isEnd and ActivityCtrl.isCreate then
		ActivityPanel.btnStart:SetActive(false)
		ActivityPanel.btnNoStart:SetActive(false)
		ActivityPanel.barBg:SetActive(false)
		ActivityPanel.txtDaoJiShi:SetActive(true)
		ActivityPanel.imgQiShuBG:SetActive(false)
		ActivityPanel.txtDapJiShiMiao:GetComponent("Text").text = tostring(3)
		self:InvokeRepeat("DaojishiTime",1,300000000)
		local co = coroutine.start(ActivityCtrl.RefreshActivityInfo)
		table.insert(Network.crts, co)
	end
end

function ActivityCtrl.DaojishiTime()
	if ActivityPanel.txtDapJiShiMiao:GetComponent("Text").text < tostring(1) then
	else
		ActivityPanel.txtDapJiShiMiao:GetComponent("Text").text = ActivityPanel.txtDapJiShiMiao:GetComponent("Text").text - tostring(1)
	end
end

function ActivityCtrl.RefreshActivityInfo()
	coroutine.wait(3)
	local msg = ''
	Game.SendProtocal(Protocal.CardIndianaInfo, msg)
end

local rewardRoleId = 0
local roleName = ''
local rewardQiId = 0
local rewardCount = 0
--玩家参与那期的通知回调--
function ActivityCtrl.JoinRoleNoticeRes(buffer)
	self = ActivityCtrl
	local data   = buffer:ReadBuffer()
	local msg = CardIndiana_pb.JoinRoleNoticeRes()
	msg:ParseFromString(data)
	rewardRoleId = msg.rewardRoleId
	roleName = msg.roleName
	rewardQiId = msg.rewardQiId
	rewardCount = msg.rewardCount
	print('ActivityCtrl.JoinRoleNoticeRes=====',rewardRoleId,roleName,rewardQiId,rewardCount,global.userVo.roleId)
	if rewardCount > 0 then
		local co = coroutine.start(ActivityCtrl.RefreshTishiInfo)
		table.insert(Network.crts, co)
	end
end

function ActivityCtrl.RefreshTishiInfo()
	coroutine.wait(1)
	if ActivityCtrl.isCreate then
		ActivityPanel.imgTipsTanKuang:SetActive(true)
		ActivityPanel.txtTips:SetActive(true)
		ActivityPanel.txtTips1:SetActive(true)
		if rewardRoleId == global.userVo.roleId then
			ActivityPanel.txtTips:SetActive(false)
			self:SetText(ActivityPanel.txtRoleName,roleName);
			self:SetText(ActivityPanel.txtQiShu,rewardQiId);
			self:SetText(ActivityPanel.txtFangKaShu,rewardCount);
			ActivityPanel.txtRoleName.transform.localPosition = Vector3.New(-178,-50,0)
			ActivityPanel.txtQiShu.transform.localPosition = Vector3.New(-20,-50,0)
			ActivityPanel.txtFangKaShu.transform.localPosition = Vector3.New(252,-50,0)
		else
			ActivityPanel.txtTips1:SetActive(false)
			self:SetText(ActivityPanel.txtRoleName,roleName);
			self:SetText(ActivityPanel.txtQiShu,rewardQiId);
			self:SetText(ActivityPanel.txtFangKaShu,rewardCount);
			ActivityPanel.txtRoleName.transform.localPosition = Vector3.New(-178,14,0)
			ActivityPanel.txtQiShu.transform.localPosition = Vector3.New(-20,14,0)
			ActivityPanel.txtFangKaShu.transform.localPosition = Vector3.New(252,14,0)
		end
	end
end

--开始夺宝回调--
function ActivityCtrl.CloseCardIndianaRes(buffer)
	self = ActivityCtrl
	local data   = buffer:ReadBuffer()
	local msg = IntTypeReturn_pb.IntTypeReturnRes()
	msg:ParseFromString(data)
	self:Close(true)
end

--@brief 切割字符串，并用“...”替换尾部
 --@param sName:要切割的字符串
 --@return nMaxCount，字符串上限,中文字为2的倍数
 --@param nShowCount：显示英文字个数，中文字为2的倍数,可为空
 --@note         函数实现：截取字符串一部分，剩余用“...”替换
function ActivityCtrl:GetShortName(long,sName)
	local nMaxCount = long
	local nShowCount = long
     if sName == nil or nMaxCount == nil then
         return
     end
     local sStr = sName
     local tCode = {}
     local tName = {}
     local nLenInByte = #sStr
     local nWidth = 0
     if nShowCount == nil then
        nShowCount = nMaxCount - 3
     end
     for i=1,nLenInByte do
         local curByte = string.byte(sStr, i)
         local byteCount = 0
         if curByte>0 and curByte<=127 then
             byteCount = 1
         elseif curByte>=192 and curByte<223 then
             byteCount = 2
         elseif curByte>=224 and curByte<239 then
             byteCount = 3
         elseif curByte>=240 and curByte<=247 then
             byteCount = 4
         end
         local char = nil
         if byteCount > 0 then
             char = string.sub(sStr, i, i+byteCount-1)
             i = i + byteCount -1
         end
         if byteCount == 1 then
             nWidth = nWidth + 1
             table.insert(tName,char)
             table.insert(tCode,1)
             
        elseif byteCount > 1 then
             nWidth = nWidth + 2
             table.insert(tName,char)
             table.insert(tCode,2)
         end
     end
     
    if nWidth > nMaxCount then
         local _sN = ""
         local _len = 0
         for i=1,#tName do
             _sN = _sN .. tName[i]
             _len = _len + tCode[i]
             if _len >= nShowCount then
                 break
             end
         end
         sName = _sN .. "..."
     end
     return sName
 end