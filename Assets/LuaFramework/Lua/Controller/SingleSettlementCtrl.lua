--文件：每局结算控制器

SingleSettlementCtrl = {}
setbaseclass(SingleSettlementCtrl, {BaseCtrl})

local  playerList = {}
local  masg = nil
local  winType = nil
local  winRole = nil

require "Logic/Room/OverBeard/GameRoom"
--启动事件--
function SingleSettlementCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	self:AddClick(SingleSettlementPanel.btnQuit,self.OnQuitBtnClick)
	self:AddClick(SingleSettlementPanel.btnStart,self.OnStartBtnClick)
	self:AddClick(SingleSettlementPanel.btnShare,self.OnShareBtnClick)
	self:AddClick(SingleSettlementPanel.btnTotalScore,self.OnTotalBtnClick)
	self:AddClick(SingleSettlementPanel.btnQuitGame,self.OnQuitGameBtnClick)
	self:InitPanel()
	self = GameMainCtrl
	self:CancelInvoke("CardTime")
end

--初始化面板--
function SingleSettlementCtrl:InitPanel(objs)
	--申请苹果审核
	-- if IS_APP_STORE_CHECK or LoginCtrl.loginTypes == 2 then
	-- 	SingleSettlementPanel.btnShare:SetActive(false)
	-- end

	--比赛场操作界面
	SingleSettlementPanel.btnQuit:SetActive(true)
	SingleSettlementPanel.btnStart:SetActive(true)
	SingleSettlementPanel.btnShare:SetActive(true)
	SingleSettlementPanel.btnTotalScore:SetActive(true)
	if global.roomVo.isFangzhu == 3 or  global.roomVo.vsRoomNum ~= 0 then
		SingleSettlementPanel.btnQuit:SetActive(false)
		SingleSettlementPanel.btnStart:SetActive(false)
		SingleSettlementPanel.btnShare:SetActive(false)
		SingleSettlementPanel.btnTotalScore:SetActive(false)
	end
end

function SingleSettlementCtrl.OnQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = SingleSettlementCtrl
	if DissolutionRoomCtrl.gameOver == true or gameRoom.curJushu == global.roomVo.total then 
		Game.MusicEffect(Game.Effect.joinRoom)
		TotalSettlementCtrl:Open("TotalSettlement")
		PlayCardRoleCtrl:Close()

	else
		local buffer = ByteBuffer.New()
    	buffer:WriteInt(tonumber(Protocal.StartGame))
    	networkMgr:SendMessage(buffer) 	

		self:Close()
		Game.isReloadBattle = false
		GameMainCtrl:CancelInvoke("CardTime")
		PlayCardRoleCtrl:Close()
	end
end

function SingleSettlementCtrl.OnQuitGameBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	Game.SendProtocal(tonumber(Protocal.QuitMateRoom))
end

function SingleSettlementCtrl.OnStartBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = SingleSettlementCtrl
	if DissolutionRoomCtrl.gameOver == true or gameRoom.curJushu == global.roomVo.total then 

	else
		local buffer = ByteBuffer.New()
    	buffer:WriteInt(tonumber(Protocal.StartGame))
    	networkMgr:SendMessage(buffer) 	
		self:Close()
		Game.isReloadBattle = false
		GameMainCtrl:CancelInvoke("CardTime")
		PlayCardRoleCtrl:Close()
	end
	GameRoom.OnInitRes()
	GameRoom.gameObjCardContainer:SetActive(false)
	GameMainCtrl:Close()
	WaitFriendsCtrl:Open("WaitFriends")
	GameRoom.txtCountDown:SetActive(false)
end


--结算--
function SingleSettlementCtrl.CreatePlayerPanel(objs)
	MahjongRoom.players = {}
	for i = 1, #playerList do
		playerList[i]:Destroy()
	end
	playerList = {}
	local self = SingleSettlementCtrl

	SingleSettlementPanel.imgTitle:SetActive(true)
	SingleSettlementPanel.imgTitleA:SetActive(true)
	if winType == 3 then 
		Game.MusicEffect(Game.Effect.meihu)
		SingleSettlementPanel.imgTitle:SetActive(false)
	else
		Game.MusicEffect(Game.Effect.danju)
		SingleSettlementPanel.imgTitleA:SetActive(false)
	end
	local parent = SingleSettlementPanel.gridParent.transform
	local txtRoomNum 		= SingleSettlementPanel.txtCurrentRoomNum
	local txtInning 		= SingleSettlementPanel.txtCurrentInningNum
	SingleSettlementPanel.txtCurrentRoomNum:SetActive(true)
	self:SetText(txtRoomNum,"房号:" .. global.roomVo.id)
	self:SetText(txtInning, gameRoom.curJushu..'/'..global.roomVo.total .. " 局")
	if global.roomVo.isFangzhu == 3 or  global.roomVo.vsRoomNum ~= 0 then
		SingleSettlementPanel.txtCurrentRoomNum:SetActive(false)
	end
	--新添加
	SingleSettlementPanel.txtCurrentInningNum:SetActive(false)
	SingleSettlementPanel.btnTotalScore:SetActive(false)
	SingleSettlementPanel.btnQuit:SetActive(false)
	SingleSettlementPanel.btnQuitGame:SetActive(false)
	SingleSettlementPanel.txtCurrentRoomNum:SetActive(false)
	if global.roomVo.moneyType == RoomMode.roomCardMode then
		SingleSettlementPanel.txtCurrentInningNum:SetActive(true)
		SingleSettlementPanel.btnTotalScore:SetActive(true)
		SingleSettlementPanel.btnQuit:SetActive(true)
		SingleSettlementPanel.txtCurrentRoomNum:SetActive(true)
		SingleSettlementPanel.btnShare.transform.localPosition = Vector3.New(-300,-300,-50);
		SingleSettlementPanel.btnStart.transform.localPosition = Vector3.New(250,-300,-50);
		self:SetText(SingleSettlementPanel.txtScoreTitle,'总分')
	else
		if global.roomVo.moneyType == RoomMode.goldMode then
			self:SetText(SingleSettlementPanel.txtScoreTitle,'金币')
		elseif global.roomVo.moneyType == RoomMode.wingMode then
			self:SetText(SingleSettlementPanel.txtScoreTitle,'元宝')
		end
		SingleSettlementPanel.btnQuitGame:SetActive(true)
		SingleSettlementPanel.btnShare.transform.localPosition = Vector3.New(-300,-300,-50);
		SingleSettlementPanel.btnStart.transform.localPosition = Vector3.New(0,-300,-50);
	end

	if GameMainCtrl.isCreate then
		global.roleInfoTable[1][4] = GameMainPanel.btnHeadIconR:GetComponent("Image").sprite
		global.roleInfoTable[2][4] = GameMainPanel.btnHeadIconL:GetComponent("Image").sprite
		if #global.joinRoomUserVos == 4 then
			global.roleInfoTable[3][4] = GameMainPanel.btnHeadIconU:GetComponent("Image").sprite
		end
		global.roleInfoTable[4][4] = GameMainPanel.btnHeadIconD:GetComponent("Image").sprite
	else
		self:Close()
		return
	end

	for i = 1,table.maxn(masg) do
		local id = masg[i].roleId
		local fanfen = masg[i].fanRate
		local oneGangjifen = masg[i].oneGangjifen
		local oneSumjifen = masg[i].oneSumjifen
		local name = GetShortName(getOtherRoleInfo(masg[i].roleId).name)

		--生成预制--
		local go = newObject(objs[0])
		go.name = id
		go.transform:SetParent(parent)
		go.transform.localScale = Vector3.one
		go.transform.localPosition = Vector3.zero
        self:AddClick(go,self.GradeDetailClick)
		
		--获取组件--
		local imgPlayWin 			= BasePanel:GOChild(go,"imgPlayWin")
		local imgPlayLose 			= BasePanel:GOChild(go,"imgPlayLose")
		local imgPlayDrew 			= BasePanel:GOChild(go,"imgPlayDrew")
		local imgPlayWinSelf		= BasePanel:GOChild(go,"imgWinSelf")
		local imgWinHu				= BasePanel:GOChild(go,"imgWinHu")
		
		local imgHeadIcon			= BasePanel:GOChild(go,"MaskHead/imgHeadIcon")
		local txtFan				= BasePanel:GOChild(go,"txtFan")
		local txtGang				= BasePanel:GOChild(go,"txtGang")
		local txtScore				= BasePanel:GOChild(go,"txtScore")

		local txtName				= BasePanel:GOChild(go,"txtName")
		--赋值信息--
		self:SetText(txtFan,fanfen)
		self:SetText(txtGang,oneGangjifen)

		self:SetText(txtName,name)

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
		--显示设置--
		if(oneSumjifen > 0) then
			imgPlayLose:SetActive(false)
			imgPlayDrew:SetActive(false)
			self:SetText(txtScore,"<color=#FF182C>" .. '+' .. oneSumjifen .. "</color>")
			
		elseif(oneSumjifen < 0) then
			imgPlayWin:SetActive(false)
			imgPlayDrew:SetActive(false)
			self:SetText(txtScore,"<color=#797979>" .. '-' .. (-oneSumjifen) .. "</color>")
		elseif(oneSumjifen == 0) then
			imgPlayWin:SetActive(false)
			imgPlayLose:SetActive(false)
			self:SetText(txtScore,"<color=#EEEEEE>" .. oneSumjifen .. "</color>")
		end
		if DissolutionRoomCtrl.gameOver == true or gameRoom.curJushu == global.roomVo.total then
			imgPlayWinSelf:SetActive(false)
			imgWinHu:SetActive(false)
			SingleSettlementPanel.btnStart:SetActive(false)
			SingleSettlementPanel.btnTotalScore:SetActive(true)
			if global.roomVo.isFangzhu == 3 or  global.roomVo.vsRoomNum ~= 0 then
				SingleSettlementPanel.btnTotalScore:SetActive(false)
			end
		else
			SingleSettlementPanel.btnTotalScore:SetActive(false)
			SingleSettlementPanel.btnStart:SetActive(true)
			if global.roomVo.isFangzhu == 3 or  global.roomVo.vsRoomNum ~= 0 then
				SingleSettlementPanel.btnStart:SetActive(false)
			end
		end
		--胡牌类型--
		imgWinHu:SetActive(false)
		imgPlayWinSelf:SetActive(false)
		if winType == 3 or winType == 4 then
			imgWinHu:SetActive(false)
			imgPlayWinSelf:SetActive(false)
		else
			for i=1,#winRole do
				if winRole[i] == id then
					if winType == 2 then
						imgWinHu:SetActive(true)
						imgPlayWinSelf:SetActive(false)
					elseif winType == 1 then
						imgWinHu:SetActive(false)
						imgPlayWinSelf:SetActive(true)
					else
						imgWinHu:SetActive(false)
						imgPlayWinSelf:SetActive(false)
					end
				end 
			end
		end
			table.insert(playerList,go)
			self:LoadCard(i,masg[i].chessInfo)
	end
end
--每局结束服务器回调--
function SingleSettlementCtrl.OnOneEndShowRes(buffer)
	GameMainPanel.imgPengGangHuBG:SetActive(false)
	if global.roomVo.isFangzhu == 3 or  global.roomVo.vsRoomNum ~= 0 then
		GameMainPanel.imgTuoGuanBG:SetActive(false)
		gameRoom.trusteeshipRoleIDS = {}
		if next(gameRoom.trusteeshipRoleIDS) ~= nil then
			local len = table.maxn(gameRoom.trusteeshipRoleIDS)
			for i= len,1,-1 do
				table.remove(gameRoom.trusteeshipRoleIDS,i)
			end
		end
		for i,v in ipairs(global.joinRoomUserVos) do  --遍历玩家id
			if v.roleId == global.userVo.roleId then
				if v.isTrusteeship  then  --如果是托管状态
					v.isTrusteeship = false --托管状态设为false
				end
			end
		end
	end

	masg = nil
	winType = nil
	winRole = nil
	gameRoom.isOnes = false
	gameRoom.lastIndex = nil
	gameRoom.lastType = nil
	--解析
	local data   = buffer:ReadBuffer()
	local msg    = BloodFightOneEndShow_pb.BloodFightOneEndShowRes()	
	msg:ParseFromString(data)
	masg = msg.oneEndInfos
	winType = msg.endType
	--winRole = msg.winRoleIds
	local huType = msg.huTypes
	print("=======BloodFightOneEndShowRes=====",winType,#masg)
	if winType == 1 or winType == 2 then --自摸或者胡
		for i,v in ipairs(masg) do
			local index = getRoleIndexById(v)
			local location = getOtherPlayerLocation(index)
			if v.huType[i] == 4 then
				GameMainCtrl.ShowTableEffect(location,"effect_ganghu")
			--[[else
				if #winRole >1 then
					GameMainCtrl.EffectMgr("effect_duoxiang")		
				end--]]
			end
		end
	end

	--if SingleSettlementCtrl.isClose == true then
	--if not SingleSettlementCtrl then
		--设置game界面的分数
		for i,v in ipairs(masg) do
			for i,c in ipairs(global.joinRoomUserVos) do
				if c.roleId == v.roleId then
					c.jifen = v.jifen
				end
			end
		end
		GameMainCtrl:RefrshScore()

		if #masg == 0 then
			MessageTipsCtrl:ShowInfo("无结算信息")
			return
		end
		DissolutionRoomCtrl:Close()
		PlayCardRoleCtrl:Close()
		GameChatCtrl:Close()
		
    	if winType == 4 then --解散房间
    		print("----------DissolutionRoom")
    		gameRoom.changeStatic(RoomStatic.SettlementStatic)
			--生成预制--
			resMgr:LoadPrefab('singlesettlement',{'panelPlayer'},SingleSettlementCtrl.CreatePlayerPanel)
    	else
			if winType == 3 then  --摸牌摸完了
				coroutine.start(GameMainCtrl.NoWin)
			end
    		for i = 1,table.maxn(masg) do
    			SingleSettlementCtrl.GetChessData(masg[i].chessInfo,masg[i].roleId,winRole[i])
    		end
			local co = coroutine.start(SingleSettlementCtrl.Wait)--/************/
			table.insert(Network.crts, co)
    	end

    	local co = coroutine.start( function()
    		coroutine.wait(5)
    	      if not SingleSettlementPanel then --
                  resMgr:LoadPrefab('singlesettlement',{'panelPlayer'},SingleSettlementCtrl.CreatePlayerPanel)
    	      end
        end)
    	
	--end
	--比赛场显示5秒自后自动关闭
	if global.roomVo.isFangzhu == 3 or  global.roomVo.vsRoomNum ~= 0 then
		local co = coroutine.start(SingleSettlementCtrl.CloseSingleSettlement)
		table.insert(Network.crts, co)
	end
end

function SingleSettlementCtrl.CloseSingleSettlement()
	local self = SingleSettlementCtrl
	if gameRoom.curJushu == 2 then
		return
	end
	coroutine.wait(5)
	Game.isReloadBattle = false
	self:Close()
	GameMainCtrl:CancelInvoke("CardTime")
	PlayCardRoleCtrl:Close()
end

function SingleSettlementCtrl.Wait()
	if global.roomVo.isFangzhu == 3 or  global.roomVo.vsRoomNum ~= 0 then --比赛场
	else  --非比赛场
		coroutine.wait(2)
	end
	gameRoom.changeStatic(RoomStatic.SettlementStatic)
		--生成预制--
	resMgr:LoadPrefab('singlesettlement',{'panelPlayer'},SingleSettlementCtrl.CreatePlayerPanel)
end

--加载牌
function SingleSettlementCtrl:LoadCard(index,chessInfo)
	--加载牌型--
	local  pengGangList = {}
	local  zimoHuList = {}
	local colorList = {}
	local strNum = ''
	local k = 0
	local used = 0
	local name = ''

	for i = 1, #chessInfo do	
		if chessInfo[i].num < 10 then
			strNum = '0' .. tostring(chessInfo[i].num)
		else
			strNum = tostring(chessInfo[i].num)
		end
		name =  'color_'..  chessInfo[i].color  .. '_' ..strNum

		if chessInfo[i].used == 0 then
			k = k + 1
			local obj = Game.GetUICard(name)
			SingleSettlementCtrl.LoadUICard(obj,index,k)
		elseif chessInfo[i].used == 6 or chessInfo[i].used == 5 then
			table.insert(zimoHuList,name)
		else  
			table.insert(colorList,chessInfo[i])
		end
	end
	table.sort(colorList, SingleSettlementCtrl.sort_)
	for i,v in ipairs(colorList) do
		local strNum 
		local name 
		if v.num < 10 then
			strNum = '0' .. tostring(v.num)
		else
			strNum = tostring(v.num)
		end
		name =  'color_'..  v.color  .. '_' ..strNum
		table.insert(pengGangList,name)
	end

	for i=1,#zimoHuList do
		table.insert(pengGangList,zimoHuList[i])
	end
	for i=1,#pengGangList do
		k = k + 1
		if pengGangList[i-1] ~= pengGangList[i] then
			used= used+8
		end
		local obj = Game.GetUICard(pengGangList[i])
		SingleSettlementCtrl.LoadUICard(obj,index,k,used)
	end
end

--加载牌位置
function SingleSettlementCtrl.LoadUICard( objs,index,i,add)
	if objs == nil then 
		return
	end
	local self = SingleSettlementCtrl
	if self.isClose then return end
	local parent = BasePanel:GOChild(playerList[index],"gridPlayerCards")
	if not parent then return end
	local go = newObject(objs)
	-- go.transform:SetParent(parent.transform)
	-- go.transform.localScale =Vector3.one
	-- go.transform.localPosition = Vector3.zero
	local pos = -400
	local posWidth = 40
	go.transform:SetParent(parent.transform)
	go.transform.localScale = Vector3.New(0.5,0.5,0.5)
	if add ~= nil then
		go.transform.localPosition = Vector3.New(pos+i*posWidth+add,0,0)
	else
		go.transform.localPosition = Vector3.New(pos+i*posWidth,0,0)
	end
end

function SingleSettlementCtrl.GetChessData(chess,roleId,winId)
	local strNum = " "
	local obj = nil
	local index = getRoleIndexById(roleId)
	local pos = getOtherPlayerLocation(index)
	local rotation = nil
	local  objList = {}
	if pos == "D" then return end
	for i = 1,table.maxn(chess) do
		if chess[i].used == 0 then
			table.insert(objList,chess[i])
		end
	end
	--table.sort(objList, SingleSettlementCtrl.sort_)

	for i=1,table.maxn(chess) do
		if chess[i].used == 5 or chess[i].used == 6 then
			table.insert(objList,chess[i])
		end
	end
	for i = 1,table.maxn(objList) do
		if objList[i].num < 10 then
			strNum = '0' .. tostring(objList[i].num)
		else
			strNum = tostring(objList[i].num)
		end
		local name =  'color_'.. objList[i].color .. '_' ..strNum
		obj = Game.GetObjCard(name)

		if pos == "R" then
			local len = #gameRoom.rightModelChardMap
		    if gameRoom.rightModelChardMap[i] ~= nil then
			   local transPos = gameRoom.rightModelChardMap[i].transform.position --/******************/
			   gameRoom.rightModelChardMap[i].gameObject:SetActive(false)
			   rotation = Quaternion.Euler(Vector3.New(90,0,90))
			   if i == len and len ~= 1 then
				   if winId == roleId then
					   transPos = gameRoom.rightModelChardMap[i-1].transform.position
					   transPos.z = transPos.z + 0.5
				   end
			   end
			   SingleSettlementCtrl.LoadObjCard(obj,transPos,rotation)
		    end
		
		elseif pos == "U" then
			local len = #gameRoom.upModelChardMap

			if gameRoom.upModelChardMap[i] ~= nil then  --/********先判断是否为空，有时候会闪退到大厅**********/
			   local transPos = gameRoom.upModelChardMap[i].transform.position 
			    gameRoom.upModelChardMap[i].gameObject:SetActive(false)
			    rotation = Quaternion.Euler(Vector3.New(90,0,180))
			    if i == len and len ~= 1 then	
				    if winId == roleId then
					    transPos = gameRoom.upModelChardMap[i-1].transform.position					
					    transPos.x = transPos.x - 0.5
				    end
			    end
			    SingleSettlementCtrl.LoadObjCard(obj,transPos,rotation)
			end
		elseif pos == "L" then
			local len = #gameRoom.leftModelChardMap           
            if gameRoom.leftModelChardMap[i] ~= nil then--/********先判断是否为空，有时候会闪退到大厅**********/ 
               	local transPos = gameRoom.leftModelChardMap[i].transform.position 
			    gameRoom.leftModelChardMap[i].gameObject:SetActive(false)
			    rotation = Quaternion.Euler(Vector3.New(90,90,0)) 
			    if i == len and len ~= 1  then
				    if winId == roleId then
					    transPos = gameRoom.leftModelChardMap[i-1].transform.position					
					    transPos.z = transPos.z - 0.5
				    end
			    end
			    SingleSettlementCtrl.LoadObjCard(obj,transPos,rotation)
            end

		end
	end
end

--加载牌位置
function SingleSettlementCtrl.LoadObjCard( objs,transPos,euler)
	
	local scal = Vector3.New(1.1,1.1,1.1)
	if objs == nil then 
		return
	end
	local go = newObject(objs)
	go.transform.localScale = scal
	go.transform.rotation = euler
	go.transform.parent = gameRoom.gameObjCardContainer.transform
	go.transform.position = transPos
	table.insert(gameRoom.downCardList,go)
end

--查看总成绩--
function SingleSettlementCtrl.OnTotalBtnClick()
	Game.MusicEffect(Game.Effect.joinRoom)
	TotalSettlementCtrl:Open("TotalSettlement")
end

--分享--
function SingleSettlementCtrl.OnShareBtnClick()
	Game.MusicEffect(Game.Effect.joinRoom)
	if(AppConst.getCurrentPlatform() == 'PC') then
		MessageTipsCtrl:ShowInfo("当前不能分享！ ")
        return
	end
	weChatFunction.ShareBattleBtnClick()
end

function SingleSettlementCtrl.sort_(a,b)
	local r
	local ac = a.color
	local bc = b.color
	local an = a.num
	local bn = b.num
	if  ac == bc then
		r = an < bn
	else
		r = ac < bc
	end
	return r
end