GameMatchRecordCtrl = {}
setbaseclass(GameMatchRecordCtrl, {BaseCtrl})

local selfVsMsg = {}
--启动事件--
function GameMatchRecordCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	self:AddClick(GameMatchRecordPanel.btnQuit,self.BtnQuit)
	selfVsMsg = {}
	self:InitPanel()
	self:VsLogReq()
end

--初始化面板--
function GameMatchRecordCtrl:InitPanel(objs)
	GameMatchRecordPanel.txtNull:SetActive(false)
end

--发送请求比赛记录的信息--
function GameMatchRecordCtrl:VsLogReq()
	BlockLayerCtrl:UsualOpen("BlockLayer")
	local VsLogInfo = VsLog_pb.VsLogReq()
	VsLogInfo.vsType = 1
	local msg = VsLogInfo:SerializeToString()
	Game.SendProtocal(Protocal.VsLog, msg)
end

--关闭事件--
function GameMatchRecordCtrl.BtnQuit(obj)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = GameMatchRecordCtrl
	self:Close()
end

function GameMatchRecordCtrl.VsInfo(objs)
	local parent = GameMatchRecordPanel.gridMahjongParent.transform
	local self = GameMatchRecordCtrl
	for i,v in ipairs(selfVsMsg) do
		local vsType = v.vsType
		local vsCount = v.vsCount
		local rank = v.rank
		local rewardCount = v.rewardCount
		local vsTime = getTimeFormat(v.vsTime)
		--生成预制--
		local go = newObject(objs[0])
		go.transform:SetParent(parent)
		go.transform.localScale = Vector3.one
		go.transform.localPosition = Vector3.zero

		--获取组件--
		local txtVsCount 		= GameMatchRecordPanel:GOChild(go,"txt2")
		local txtVsRank			= GameMatchRecordPanel:GOChild(go,"txt4")
		local txt3				= GameMatchRecordPanel:GOChild(go,"txt3")
		local txt5				= GameMatchRecordPanel:GOChild(go,"txt5")
		local txtRewardCount 	= GameMatchRecordPanel:GOChild(go,"txt6")
		local imgFangka 		= GameMatchRecordPanel:GOChild(go,"imgFangka")
		local txtTime 			= GameMatchRecordPanel:GOChild(go,"txtTime")
		imgFangka:SetActive(true)
		txtRewardCount:SetActive(true)
		txtVsRank:SetActive(true)
		txt5:SetActive(true)
		self:SetText(txtTime,vsTime)
		if rewardCount <= 0 then
			imgFangka:SetActive(false)
			txtRewardCount:SetActive(false)
			if rank == 0 then
				txtVsRank:SetActive(false)
				txt5:SetActive(false)
				self:SetText(txtVsCount,'<color=#8a8a8a>'..vsCount..'人快速赛'..'</color>')
				self:SetText(txt3,'中， 主动放弃比赛！  无房卡奖励！ ')
			else
				self:SetText(txtVsCount,'<color=#8a8a8a>'..vsCount..'人快速赛'..'</color>')
				self:SetText(txtVsRank,'<color=#8a8a8a>'..rank..'</color>')
				self:SetText(txt5,'    名!  无房卡奖励！')
			end
		else
			self:SetText(txtVsCount,'<color=#b41818>'..vsCount..'人快速赛'..'</color>')
			self:SetText(txtVsRank,'<color=#b41818>'..rank..'</color>')
			self:SetText(txt5,'名！  获得奖励')
			self:SetText(txtRewardCount,'<color=#b41818>'..'x '..rewardCount..'</color>')
		end
	end
	--关闭阻挡层
	BlockLayerCtrl:Close()
end

function GameMatchRecordCtrl.VsLogRes(buffer)
	self = GameMatchRecordCtrl
	local data   = buffer:ReadBuffer()
	local msg = VsLog_pb.VsLogRes()
	msg:ParseFromString(data)
	selfVsMsg = msg.vsLogInfo
	if #selfVsMsg == 0 then
		GameMatchRecordPanel.txtNull:SetActive(true)
		--关闭阻挡层
		BlockLayerCtrl:Close()
		return
	else
		resMgr:LoadPrefab('gamematchrecord',{'imgMatchRecoedInfo'},self.VsInfo)
	end
end

