--文件：详细战绩界面控制

GradeDetailCtrl = {}
setbaseclass(GradeDetailCtrl, {BaseCtrl})

local masg

--启动事件--
function GradeDetailCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	self:AddClick(GradeDetailPanel.btnQuit,self.BtnQuit)
	self:InitPanel()
	self:ZhanJiDetailInfoReq()
end

--初始化面板--
function GradeDetailCtrl:InitPanel(objs)
	if GradeCtrl.clickType ~= 1 then
		--GradeDetailPanel.txtTime.transform.localPosition = Vector3.New(332,170,0);
		GradeDetailPanel.txtOperate.transform.localPosition = Vector3.New(512,170,0);
		GradeDetailPanel.imgLine7.transform.localPosition = Vector3.New(442,170,0);
		GradeDetailPanel.txtRoleNameTitle5:SetActive(true);
		GradeDetailPanel.imgLine6:SetActive(true);
	end
end

--发送详细战绩的信息--
function GradeDetailCtrl:ZhanJiDetailInfoReq()
	local zhanjiDetailInfo = ZhanJiDetailsInfo_pb.ZhanJiDetailsInfoReq()
	zhanjiDetailInfo.id = tonumber(GradeCtrl.clickID)
	local msg = zhanjiDetailInfo:SerializeToString()
	Game.SendProtocal(Protocal.ZhanJiDetailInfo, msg)
end

--战绩测试--
function GradeDetailCtrl.Test(objs)
	local parent = GradeDetailPanel.gridParent.transform
	local self = GradeDetailCtrl
	local txtRoleName1 = GradeDetailPanel.txtRoleNameTitle1
	local txtRoleName2 = GradeDetailPanel.txtRoleNameTitle2
	local txtRoleName3 = GradeDetailPanel.txtRoleNameTitle3
	local txtRoleName4 = GradeDetailPanel.txtRoleNameTitle4
	local txtRoleName5 = GradeDetailPanel.txtRoleNameTitle5
	--local txtRoleName6 = GradeDetailPanel.txtRoleNameTitle6
	local txtNameList = nil;
	if GradeCtrl.clickType == 1 then
		txtNameList = {txtRoleName1,txtRoleName2,txtRoleName3,txtRoleName4}
	else
		txtNameList = {txtRoleName1,txtRoleName2,txtRoleName3,txtRoleName4,txtRoleName5}
	end
	   

	for i,v in ipairs(masg) do
		local id = v.xuhao
		local startTime = getTimeFormat(v.startTime)
		local info = v.zhanJiDetailsRoleInfo
		--生成预制--
		local go = newObject(objs[0])
		go.name = id
		go.transform:SetParent(parent)
		go.transform.localScale = Vector3.one
		go.transform.localPosition = Vector3.zero
		
		--获取组件--
		local imgline5 			= BasePanel:GOChild(go,"imgline5")
		local imgline6 			= BasePanel:GOChild(go,"imgline6")

		local txtNum 			= BasePanel:GOChild(go,"txtNum")
		local txtTime 			= BasePanel:GOChild(go,"txtTime")
		local txtplayername1   = BasePanel:GOChild(go,"txtRoleName1")
		local txtplayername2   = BasePanel:GOChild(go,"txtRoleName2")
		local txtplayername3   = BasePanel:GOChild(go,"txtRoleName3")
		local txtplayername4   = BasePanel:GOChild(go,"txtRoleName4")
		local txtplayername5   = BasePanel:GOChild(go,"txtRoleName5")
		local txtplayername6   = BasePanel:GOChild(go,"txtRoleName6")
		local txtplayerScore1   = BasePanel:GOChild(go,"txtplayerScore1")
		local txtplayerScore2   = BasePanel:GOChild(go,"txtplayerScore2")
		local txtplayerScore3   = BasePanel:GOChild(go,"txtplayerScore3")
		local txtplayerScore4   = BasePanel:GOChild(go,"txtplayerScore4")
		local txtplayerScore5   = BasePanel:GOChild(go,"txtplayerScore5")
		local txtplayerScore6   = BasePanel:GOChild(go,"txtplayerScore6")
		local btnShare 			= BasePanel:GOChild(go,"btnShare")
		--[[txtplayername1=txtRoleName1
		txtplayername2=txtRoleName2
		txtplayername3=txtRoleName3
		txtplayername4=txtRoleName4
		txtplayername5=txtRoleName5--]]
        txtAllNameList = {txtplayername1,txtplayername2,txtplayername3,txtplayername4,txtplayername5,txtplayername6}
		btnShare.name = "btnShare" .. i
		local btnPlayBack 		= BasePanel:GOChild(go,"btnPlayBack")
		btnPlayBack.name = tostring(id)
		if GradeCtrl.clickType ~= 1 then
			--txtTime.transform.localPosition = Vector3.New(336,2,0)
			imgline5.transform.localPosition = Vector3.New(225,-1.5,0)
			btnPlayBack:SetActive(true)
			imgline6:SetActive(true)
			txtplayerScore5:SetActive(true)
		end
	
		--申请苹果审核
    	if IS_APP_STORE_CHECK then
    		btnShare:SetActive(false)
			btnPlayBack:SetActive(false)
    	end
		
		self:AddClick(btnShare,self.ShareBtnClick)
		self:AddClick(btnPlayBack,self.RePlayBtnClick)

		self:SetText(txtNum,id)
		self:SetText(txtTime,startTime)
		local txtScoreList = nil

		if GradeCtrl.clickType == 1 then
			txtScoreList = {txtplayerScore1,txtplayerScore2,txtplayerScore3,txtplayerScore4,txtplayerScore5,txtplayerScore6}
		else
			txtScoreList = {txtplayerScore1,txtplayerScore2,txtplayerScore3,txtplayerScore4,txtplayerScore5,txtplayerScore6}
		end
		for j =1,#info do
			self:SetText(txtAllNameList[j],info[j].name)
			if info[j].jifen > 0 then
				self:SetText(txtScoreList[j],"<color=#b41818><size=18>"..'+'..info[j].jifen .."</size></color>")
		    elseif info[j].jifen < 0 then
				self:SetText(txtScoreList[j],"<color=#318c09><size=18>"..info[j].jifen .. "</size></color>")	
			elseif	info[j].jifen == 0 then
			    self:SetText(txtScoreList[j],"<color=#4c0b0b><size=18>"..info[j].jifen .. "</size></color>")
			end	
		end
	end
end
               
--关闭事件--
function GradeDetailCtrl.BtnQuit()
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = GradeDetailCtrl
	self:Close(true)
end


--查看战绩回调--
function GradeDetailCtrl.ZhanJiDetailInfoRes(buffer)
	self = GradeDetailCtrl
	log('----------------GetDetailInfo!!!')
	local data   = buffer:ReadBuffer()
	local msg  	 = ZhanJiDetailsInfo_pb.ZhanJiDetailsInfoRes()	
	msg:ParseFromString(data)
	masg = msg.zhanjiDetailsInfo
	if #masg == 0 then
		MessageTipsCtrl:ShowInfo("暂无详细战绩！");
		return
	end
	--生成预制--
	resMgr:LoadPrefab('gradedetail',{'gridPlayerInning'},self.Test)
end

--微信分享--
function GradeDetailCtrl.ShareBtnClick()
	Game.MusicEffect(Game.Effect.joinRoom)
	if(AppConst.getCurrentPlatform() == 'PC') then
		MessageTipsCtrl:ShowInfo("当前不能分享！ ")
        return
	end
	weChatFunction.ShareBattleBtnClick()
	log('------微信分享')
end

--战绩回放--
function GradeDetailCtrl.RePlayBtnClick(go)
	print("=================RePlayBtnClick==============")
	Game.MusicEffect(Game.Effect.joinRoom)
	local playBack = PlayBack_pb.PlayBackReq()
	playBack.id = tonumber(GradeCtrl.clickID)
	print("=================RePlayBtnClick=======playBack.id=======", GradeCtrl.clickID)
	playBack.jushu = tonumber(go.name)
	local msg = playBack:SerializeToString()
	print("=================RePlayBtnClick=======msg=======", msg)
	
	Game.SendProtocal(Protocal.PlayBack,msg)
end

--战绩回放回调--
function GradeDetailCtrl.OnZhanJiPlayBackRes(buffer)
	print("GradeDetailCtrl.OnZhanJiPlayBackRes战绩回放回调")
	local self = GradeDetailCtrl
	local data   = buffer:ReadBuffer()
	local msg  	 = PlayBack_pb.PlayBackRes()
	msg:ParseFromString(data)
	self.playBackInfoList = {}
	self.playBackInit = nil
	self.isPlayBack = true
	self.isPlayBackDealStatic = true
	self.isPlayBackTiShi = true
	self.isPlayBackOperate = true
	self.isPlayBackHideTuichuBtn = true
	self.isPlayBackCurrentJushu = true
	self.isPlayBackClickHead = true
	self.isPlayBackReload = true
	self.isPlayBackPlayEffect = true

	local backInfo = msg.playBackInfo
	local backInfoLen = table.maxn(backInfo)
	print('backInfoLen',backInfoLen)
	for i = 1,backInfoLen,1 do
		local info = {}
		data = {}
		info.buzhouId	 =  backInfo[i].buzhouId
		info.type        =  backInfo[i].type
		if info.type == 1 then
			data = PlayBack_pb.PlayBackInitChesses()
			data:ParseFromString(backInfo[i].data)
			self.playBackInit = data
		elseif info.type == 2 then
			data = MoChess_pb.MoChessesRes()
			data:ParseFromString(backInfo[i].data)
			info.data = data;
		elseif info.type == 3 then
			data = PushSign_pb.PushSignRes()
			data:ParseFromString(backInfo[i].data)
			info.data = data;
		elseif info.type == 4 then
			data = PushSignOperate_pb.PushSignOperateRes()
			data:ParseFromString(backInfo[i].data)
			info.data = data;
		elseif info.type == 5 then
			data = PlayChess_pb.PlayChessRes()
			data:ParseFromString(backInfo[i].data)
			info.data = data;
		end
		if info.type > 1 then
			table.insert(self.playBackInfoList,info)
		end
	end
	Game.LoadScene("mahjong")
	GameRoom.PlayBackInit(self.playBackInit)
	self.i = 1;
end

function GradeDetailCtrl:PlayBackOperate()
	if self.i > #self.playBackInfoList or GameMainCtrl.isPlayBackPlay == false then 
		return
	end
	if GameMainCtrl.isPlayBackPlay then
		local buzhouId = self.playBackInfoList[self.i].buzhouId;
		local playBackType     = self.playBackInfoList[self.i].type;
		local data = self.playBackInfoList[self.i].data;
		gameRoom.PlayBack(buzhouId,playBackType,data)
		local currentJinDu = self.i / #self.playBackInfoList
		GameMainCtrl:SetProgress(GameMainPanel.huiFangFillBar,currentJinDu)
		self.i = self.i + 1;
	end
end