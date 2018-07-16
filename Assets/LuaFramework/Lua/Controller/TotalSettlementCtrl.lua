--文件：总结算界面控制

TotalSettlementCtrl = {}
setbaseclass(TotalSettlementCtrl, {BaseCtrl})
local playerList = {}
--启动事件--
function TotalSettlementCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	self:AddClick(TotalSettlementPanel.btnQuit,self.OnQuitBtnClick)
	self:AddClick(TotalSettlementPanel.btnShare,self.OnShareBtnClick)
	--生成预制--
	resMgr:LoadPrefab('totalsettlement',{'panelPlayerTotal'},self.InitPanel)
end

--初始化面板--
function TotalSettlementCtrl.InitPanel(objs)
		--申请苹果审核
	-- if IS_APP_STORE_CHECK or LoginCtrl.loginTypes == 2 then
	-- 	TotalSettlementPanel.btnShare:SetActive(false)
	-- end
	local parent = TotalSettlementPanel.gridParent.transform
	self = TotalSettlementCtrl
	local jifenTable = {}
	local msg = global.totalSettlementVo
	for i = 1, table.maxn(msg) do
		jifenTable[i] = msg[i].jiFen
	end
	local maxOfT = math.max(unpack(jifenTable))
	local minOfT = math.min(unpack(jifenTable))
	print("最高分--最低分"..maxOfT..'---'..minOfT)

	local txtRoomNum 		= TotalSettlementPanel.txtCurrentRoomNum
	local txtInning 		= TotalSettlementPanel.txtCurrentInningNum
	self:SetText(txtRoomNum,"房间:" .. global.roomVo.id)
	self:SetText(txtInning,gameRoom.curJushu..'/'..global.roomVo.total..' 局')
	print('self.endTime=====================',self.endTime)
    self:SetText(TotalSettlementPanel.txtCurrentTime,getTimeFormat(self.endTime))

	playerList = {}


	for i = 1,#msg do	
		--生成预制--
		local go = newObject(objs[0])
		go.name = msg[i].roleId
		go.transform:SetParent(parent)
		go.transform.localScale = Vector3.one
		go.transform.localPosition = Vector3.zero
		--获取组件--
		local imgBGWin 				= BasePanel:GOChild(go,"imgBGWin")
		local imgBGLose 			= BasePanel:GOChild(go,"imgBGLose")
		local imgBGDraw 			= BasePanel:GOChild(go,"imgBGDraw") 
		local imgBigWinner			= BasePanel:GOChild(go,"imgBigWinner") 
		local imgFangzhu 			= BasePanel:GOChild(go,"imgFangzhu") 
		
		local imgHeadIcon			= BasePanel:GOChild(go,"maskHead/imgHeadIcon")
		local txtRoleName			= BasePanel:GOChild(go,"txtRoleName")
		local txtRoleID				= BasePanel:GOChild(go,"txtRoleID")
		local txtZimoNum			= BasePanel:GOChild(go,"txtZimoNum")
		local txtJiepaoNum			= BasePanel:GOChild(go,"txtJiepaoNum")
		local txtDianpaoNum			= BasePanel:GOChild(go,"txtDianpaoNum")
		local txtAngangNum			= BasePanel:GOChild(go,"txtAngangNum")
		local txtMinggangNum		= BasePanel:GOChild(go,"txtMinggangNum")
		local txtScoreNum			= BasePanel:GOChild(go,"txtScoreNum")
		local txtchaNum 			= BasePanel:GOChild(go,"txtchaNum")

		local txtZimoTitle			= BasePanel:GOChild(go,"txtZimoTitle")
		local txtJiepaoTitle		= BasePanel:GOChild(go,"txtJiepaoTitle")
		local txtDianpaoTitle		= BasePanel:GOChild(go,"txtDianpaoTitle")
		local txtAngangTitle		= BasePanel:GOChild(go,"txtAngangTitle")
		local txtMinggangTitle		= BasePanel:GOChild(go,"txtMinggangTitle")
		local txtchaTitle 			= BasePanel:GOChild(go,"txtchaTitle")
		--赋值信息--
		if #global.joinRoomUserVos == 3 then
			if global.roleInfoTable[1][2] ==go.name then
				weChatFunction.GetSprite(imgHeadIcon,global.roleInfoTable[1][4])
			elseif global.roleInfoTable[2][2] ==go.name then
				weChatFunction.GetSprite(imgHeadIcon,global.roleInfoTable[2][4])
			elseif global.roleInfoTable[4][2] ==go.name then
				weChatFunction.GetSprite(imgHeadIcon,global.roleInfoTable[4][4])
			end
		else
			for i,v in ipairs(global.roleInfoTable) do
				if go.name == global.roleInfoTable[i][2] then
					weChatFunction.GetSprite(imgHeadIcon,global.roleInfoTable[i][4])
				end
			end
		end
	
		local jiFen = msg[i].jiFen
		if msg[i].roleId == 1 then
			imgFangzhu:SetActive(true)
		else
			imgFangzhu:SetActive(false)
		end
		--显示设置--
		if(jiFen == minOfT) then
			imgBGWin:SetActive(false)
			imgBGDraw:SetActive(true)
			imgBGLose:SetActive(false)
			imgBigWinner:SetActive(false)
			

			self:SetText(txtRoleName,"<color=#484848>" .. msg[i].name .. "</color>")
			self:SetText(txtRoleID,"<color=#484848>" .. "ID:" .. msg[i].roleId .. "</color>")
			self:SetText(txtZimoNum,"<color=#60625f>" .. msg[i].ziMoTime .. "</color>")
			self:SetText(txtJiepaoNum,"<color=#60625f>" .. msg[i].jiePaoTime .. "</color>")
			self:SetText(txtDianpaoNum,"<color=#60625f>" .. msg[i].dianPaoTime .. "</color>")
			self:SetText(txtAngangNum,"<color=#60625f>" .. msg[i].anGangTime .. "</color>")
			self:SetText(txtMinggangNum,"<color=#60625f>" .. msg[i].mingGangTime .. "</color>")
			self:SetText(txtchaNum,"<color=#60625f>" .. msg[i].chaTime .. "</color>")

			self:SetText(txtZimoTitle,"<color=#565656>" .. "自摸次数" .. "</color>")
			self:SetText(txtJiepaoTitle,"<color=#565656>" .. "接炮次数" .. "</color>")
			self:SetText(txtDianpaoTitle,"<color=#565656>" .. "点炮次数" .. "</color>")
			self:SetText(txtAngangTitle,"<color=#565656>" .. "暗杠次数" .. "</color>")
			self:SetText(txtMinggangTitle,"<color=#565656>" .. "明杠次数" .. "</color>")
			self:SetText(txtchaTitle,"<color=#565656>" .. "查大叫次数" .. "</color>")

			jiFen = jiFen-1000
			if jiFen > 0 then
				self:SetText(txtScoreNum,"<color=#efc05b><size=40>" .. "+" .. jiFen .. "</size></color>")
			elseif jiFen == 0 then
				self:SetText(txtScoreNum,"<color=#efc05b><size=40>" .. jiFen .. "</size></color>")
			elseif jiFen < 0 then
				self:SetText(txtScoreNum,"<color=#efc05b><size=40>" .. jiFen .. "</size></color>")
			end

		elseif(jiFen == maxOfT) then
			imgBGWin:SetActive(false)
			imgBGDraw:SetActive(true)
			imgBGLose:SetActive(false)
			--广电
			imgBigWinner:SetActive(true)
			--imgBigWinner:SetActive(false)

			self:SetText(txtRoleName,"<color=#484848>" .. msg[i].name .. "</color>")
			self:SetText(txtRoleID,"<color=#484848>" .. "ID:" .. msg[i].roleId .. "</color>")
			self:SetText(txtZimoNum,"<color=#60625f>" .. msg[i].ziMoTime .. "</color>")
			self:SetText(txtJiepaoNum,"<color=#60625f>" .. msg[i].jiePaoTime .. "</color>")
			self:SetText(txtDianpaoNum,"<color=#60625f>" .. msg[i].dianPaoTime .. "</color>")
			self:SetText(txtAngangNum,"<color=#60625f>" .. msg[i].anGangTime .. "</color>")
			self:SetText(txtMinggangNum,"<color=#60625f>" .. msg[i].mingGangTime .. "</color>")
			self:SetText(txtchaNum,"<color=#60625f>" .. msg[i].chaTime .. "</color>")

			self:SetText(txtZimoTitle,"<color=#565656>" .. "自摸次数" .. "</color>")
			self:SetText(txtJiepaoTitle,"<color=#565656>" .. "接炮次数" .. "</color>")
			self:SetText(txtDianpaoTitle,"<color=#565656>" .. "点炮次数" .. "</color>")
			self:SetText(txtAngangTitle,"<color=#565656>" .. "暗杠次数" .. "</color>")
			self:SetText(txtMinggangTitle,"<color=#565656>" .. "明杠次数" .. "</color>")
			self:SetText(txtchaTitle,"<color=#565656>" .. "查大叫次数" .. "</color>")

			jiFen = jiFen-1000
			if jiFen > 0 then
				self:SetText(txtScoreNum,"<color=#fff001><size=50>" .. "+" .. jiFen .. "</size></color>")
			elseif jiFen == 0 then
				self:SetText(txtScoreNum,"<color=#fff001><size=50>" .. jiFen .. "</size></color>")
			elseif jiFen < 0 then
				self:SetText(txtScoreNum,"<color=#fff001><size=50>" .. jiFen .. "</size></color>")
			end

		else
			imgBGWin:SetActive(false)
			imgBGDraw:SetActive(true)
			imgBGLose:SetActive(false)
			imgBigWinner:SetActive(false)

			self:SetText(txtRoleName,"<color=#484848>" .. msg[i].name .. "</color>")
			self:SetText(txtRoleID,"<color=#484848>" .. "ID:" .. msg[i].roleId .. "</color>")
			self:SetText(txtZimoNum,"<color=#60625f>" .. msg[i].ziMoTime .. "</color>")
			self:SetText(txtJiepaoNum,"<color=#60625f>" .. msg[i].jiePaoTime .. "</color>")
			self:SetText(txtDianpaoNum,"<color=#60625f>" .. msg[i].dianPaoTime .. "</color>")
			self:SetText(txtAngangNum,"<color=#60625f>" .. msg[i].anGangTime .. "</color>")
			self:SetText(txtMinggangNum,"<color=#60625f>" .. msg[i].mingGangTime .. "</color>")
			self:SetText(txtchaNum,"<color=#60625f>" .. msg[i].chaTime .. "</color>")

			self:SetText(txtZimoTitle,"<color=#565656>" .. "自摸次数" .. "</color>")
			self:SetText(txtJiepaoTitle,"<color=#565656>" .. "接炮次数" .. "</color>")
			self:SetText(txtDianpaoTitle,"<color=#565656>" .. "点炮次数" .. "</color>")
			self:SetText(txtAngangTitle,"<color=#565656>" .. "暗杠次数" .. "</color>")
			self:SetText(txtMinggangTitle,"<color=#565656>" .. "明杠次数" .. "</color>")
			self:SetText(txtchaTitle,"<color=#565656>" .. "查大叫次数" .. "</color>")

			jiFen = jiFen-1000
			if jiFen > 0 then
				self:SetText(txtScoreNum,"<color=#efc05b><size=40>" .. "+" .. jiFen .. "</size></color>")
			elseif jiFen == 0 then
				self:SetText(txtScoreNum,"<color=#efc05b><size=40>" .. jiFen .. "</size></color>")
			elseif jiFen < 0 then
				self:SetText(txtScoreNum,"<color=#efc05b><size=40>" .. jiFen .. "</size></color>")
			end

		end
		playerList[i] = go
	end
	DissolutionRoomCtrl.gameOver = false
end

--退出--
function TotalSettlementCtrl.OnQuitBtnClick(go)
	DissolutionRoomCtrl.gameOver = false
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = TotalSettlementCtrl
		    --销毁
    for i=1,#playerList do
    	playerList[i]:Destroy()
    end
    gameRoom.curJushu = 0
    global.roomVo = {}
    global.joinRoomUserVos = {}
    global.gpsMsgInfo = {}
    MahjongRoom.players = {}
	Event.Brocast(MsgDefine.Room_Exit)
	self:Close()
	SingleSettlementCtrl:Close()
	self = GameMainCtrl
	self:CancelInvoke("CardTime")
	GameMainCtrl:Close()
	Network.ClearCtrs()
	Game.LoadScene("main")
end

--收到服务器总结算消息
function TotalSettlementCtrl.OnTotalSettlementRes(buffer)
	local self = TotalSettlementCtrl
	DissolutionRoomCtrl:Close()
	PlayCardRoleCtrl:Close()
	GameChatCtrl:Close()
	global.roleInfoTable[1][4] = GameMainPanel.btnHeadIconR:GetComponent("Image").sprite
	global.roleInfoTable[2][4] = GameMainPanel.btnHeadIconL:GetComponent("Image").sprite
	if #global.joinRoomUserVos == 4 then
		global.roleInfoTable[3][4] = GameMainPanel.btnHeadIconU:GetComponent("Image").sprite
	end
	global.roleInfoTable[4][4] = GameMainPanel.btnHeadIconD:GetComponent("Image").sprite

	log('收到服务器总结算消息')
	local data   = buffer:ReadBuffer()
	local msg    = BloodFightAllEndShow_pb.BloodFightAllEndShowRes()	
	msg:ParseFromString(data)
	log('-----------------总结算listCount'..table.maxn(msg.allEndInfos))
	global.totalSettlementVo = msg.allEndInfos
	self.endTime = msg.endTime
	log('-----------------全局listCount'..table.maxn(global.totalSettlementVo))

end

function  TotalSettlementCtrl.OnShareBtnClick()
	Game.MusicEffect(Game.Effect.joinRoom)
	if(AppConst.getCurrentPlatform() == 'PC') then
		MessageTipsCtrl:ShowInfo("当前不能分享！ ")
        return
	end
	weChatFunction.ShareBattleBtnClick()
end
