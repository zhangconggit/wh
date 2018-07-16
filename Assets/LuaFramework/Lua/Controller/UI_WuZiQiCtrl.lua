UI_WuZiQiCtrl = {
RoomMsg = {},
playersData = {},
playerCount = 0,
myIndex = 0,
}
setbaseclass(UI_WuZiQiCtrl, {BaseCtrl})
local roomWuZiQiVo

--启动事件--
function UI_WuZiQiCtrl:OnCreate(obj)
    BaseCtrl.OnCreate(self, obj)
    self:AddClick(UI_WuZiQiPanel.btnPrepare,self.OnPrepareClick)
    self:AddClick(UI_WuZiQiPanel.btnStart,self.OnStartClick)
    self:AddClick(UI_WuZiQiPanel.btnSetting,self.OnInputNum)
    self:AddClick(UI_WuZiQiPanel.btnExitJieSuan,self.OnExit)

    self:AddClick(UI_WuZiQiPanel.btn0, self.OnNum0BtnClick)
	self:AddClick(UI_WuZiQiPanel.btn1, self.OnNum1BtnClick)
	self:AddClick(UI_WuZiQiPanel.btn2, self.OnNum2BtnClick)
	self:AddClick(UI_WuZiQiPanel.btn3, self.OnNum3BtnClick)
	self:AddClick(UI_WuZiQiPanel.btn4, self.OnNum4BtnClick)
	self:AddClick(UI_WuZiQiPanel.btn5, self.OnNum5BtnClick)
	self:AddClick(UI_WuZiQiPanel.btn6, self.OnNum6BtnClick)
	self:AddClick(UI_WuZiQiPanel.btn7, self.OnNum7BtnClick)
	self:AddClick(UI_WuZiQiPanel.btn8, self.OnNum8BtnClick)
	self:AddClick(UI_WuZiQiPanel.btn9, self.OnNum9BtnClick)
	self:AddClick(UI_WuZiQiPanel.btnDelent, self.OnDelentBtnClick)
	self:AddClick(UI_WuZiQiPanel.btnSure, self.OnSureBtnClick)

	self:AddClick(UI_WuZiQiPanel.btnOverSure, self.OnOverSureClick)
    self:AddClick(UI_WuZiQiPanel.btnShare, self.OnShareClick)
	self:AddClick(UI_WuZiQiPanel.btnExit, self.QuitRoom)

	self:AddClick(UI_WuZiQiPanel.btnType, self.OnTypeBtnClick)
	self:AddClick(UI_WuZiQiPanel.btnShezhi, self.OnShezhiBtnClick)
	self:AddClick(UI_WuZiQiPanel.btnSubmit, self.OnLose)

	self:AddClick(UI_WuZiQiPanel.btnInvitationWeChat, self.OnInvitationWeChatBtnClick)
	self:AddClick(UI_WuZiQiPanel.btnFuZhiRoomNum, self.OnFuZhiRoomNum)

	self:AddClick(UI_WuZiQiPanel.btnMask, self.OnHidePanelClick)
	self:AddClickNoChange(UI_WuZiQiPanel.QuitHideButton, self.OnHidePanelClick)
	self:AddClickNoChange(UI_WuZiQiPanel.btnHideUp, self.OnHidePanelClick)
	self:AddClick(UI_WuZiQiPanel.btnSettingGame, self.OnShowGameSettingClick)
    self:Init()
end

--初始化--
function UI_WuZiQiCtrl:Init()
	print("======初始化=======",UI_WuZiQiPanel.btnStart,UI_WuZiQiPanel.imgWhiteQiZi,UI_WuZiQiPanel.imgBlackQiZi)
	--房间状态 0准备 1游戏中
	self.roomState = 0
	UI_WuZiQiPanel.GameOver:SetActive(false)
	--格子列表
	self.tableList = {}
	--落子步数
	self.count = 0
    --棋盘行数
    self.line = 14
    --棋盘列数
    self.column = 14
	--获取白棋子图片
	self.whiteQi = UI_WuZiQiPanel.imgWhiteQiZi:GetComponent("Image")
	--获取黑棋子图片
	self.blackQi = UI_WuZiQiPanel.imgBlackQiZi:GetComponent("Image")
    print("======黑白棋================",self.whiteQi,self.blackQi)
    UI_WuZiQiPanel.imgQiPan:SetActive(false)
    --生成格子
	self:CreateGeZi()

	self:SetText(UI_WuZiQiPanel.txtinput,"")
	self.playerCount = #self.playersData
	--学费列表
	self.xuefeiList = {}
	self.player1 = {
	obj 			= UI_WuZiQiPanel.AimgPlayer,
	imgHead 		= UI_WuZiQiPanel.AimgHead,
	txtName 		= UI_WuZiQiPanel.AtxtName,
	txtID 			= UI_WuZiQiPanel.Atxtid,
	txtYuanbao 		= UI_WuZiQiPanel.AtxtYuanBaoShu,
	imgDaojishi 	= UI_WuZiQiPanel.AimgDaoJiShi,
	txtDjstime 		= UI_WuZiQiPanel.AtxtDaoJiShi,
	id 			= "",
	name 		= "",
	url 		= "",
	yuanbao 	= "",
	countTime 	= "",
    }
	self.player2 = {
	obj 			= UI_WuZiQiPanel.BimgPlayer,
	imgHead 		= UI_WuZiQiPanel.BimgHead,
	txtName 		= UI_WuZiQiPanel.BtxtName,
	txtID 			= UI_WuZiQiPanel.Btxtid,
	txtYuanbao 		= UI_WuZiQiPanel.BtxtYuanBaoShu,
	imgDaojishi 	= UI_WuZiQiPanel.BimgDaoJiShi,
	txtDjstime 		= UI_WuZiQiPanel.BtxtDaoJiShi,
	id 			= "",
	name 		= "",
	url 		= "",
	yuanbao 	= "",
	countTime 	= "",
    }
    --初始化房间信息
   	self:RoomInfo()
   	self:PlayerJoin()
   	UI_WuZiQiPanel.imgQuitRoom:SetActive(false)
end

----初始化玩家信息
function UI_WuZiQiCtrl:PlayerJoin()
	local self = UI_WuZiQiCtrl
	local playerNum = #self.playersData
   	local playerInfo = self.playersData[1]
   	--玩家信息赋值
   	if playerNum == 1 then
   		self.player1.id = playerInfo.roleId
   		self.player1.name = playerInfo.name
   		self.player1.url = playerInfo.headImg
   		self.player1.yuanbao = playerInfo.wing
   		--赋值完信息刷新界面
   		self:PlayerInit(self.player1)
   	else
   		for i,v in ipairs(self.playersData) do
   			local player = self["player"..i]
   			player.id = v.roleId
   			player.name = v.name
   			player.url = v.headImg
   			player.yuanbao = v.wing
   			--赋值完信息刷新界面
   			self:PlayerInit(player)
   		end
   	end
end

--准备开始
function UI_WuZiQiCtrl.OnPrepareClick(go)
	print("========准备游戏=======")
	local  msg = ""
	Game.SendProtocal(Protocal.WuZiQiReday, msg)

    UI_WuZiQiPanel.btnPrepare:SetActive(true)
    UI_WuZiQiPanel.btnStart:SetActive(false)
end

--准备开始游戏回调
function UI_WuZiQiCtrl.OnWuziqiPrepareRes(buffer)
    print("=====ReadyGame=====1")
    local self	 = UI_WuZiQiCtrl
    local data   = buffer:ReadBuffer()
    local msg    = RoleReady_pb.RoleReadyRes()
    msg:ParseFromString(data)
    print("=====ReadyGame=====2",#msg.alreadyIndex,self.myIndex)
    local roleIndex     = msg.roleIndex
    local leaderIndex 	= msg.leaderIndex
    local allReady   	= msg.allReady
    local readyIndex	= msg.alreadyIndex
    print("=====准备游戏回调接收=====",roleIndex,leaderIndex,allReady,readyIndex)
    if roleIndex == self.myIndex then
		if self.myIndex == 1 then
			print("===========如果是房主================",v,self.myIndex)
			UI_WuZiQiPanel.btnPrepare:SetActive(false)		--准备隐藏
	    	UI_WuZiQiPanel.btnStart:SetActive(true)			--开始显示
		else
			print("===========如果是玩家================",v,self.myIndex)
			UI_WuZiQiPanel.btnSetting:SetActive(false)		--设置学费按钮隐藏
			UI_WuZiQiPanel.btnPrepare:SetActive(false)		--准备隐藏
			UI_WuZiQiPanel.btnStart:SetActive(false)	    --开始按钮隐藏
	    	UI_WuZiQiPanel.imgWattingMessage:SetActive(true)--等待开始显示
	    	UI_WuZiQiPanel.btnSubmit:SetActive(false)		--认输按钮隐藏
		end
	end
end

--开始游戏
function UI_WuZiQiCtrl.OnStartClick(go)
	print("========开始游戏=======")
	local self = UI_WuZiQiCtrl
	if self.playerCount == 1 then
		local msg = "一个人不能开始游戏!"
		MessageTipsCtrl:ShowInfo(msg)
		return
	end
	local  msg = ""
	Game.SendProtocal(Protocal.WuZiQiStay, msg)
end

--收到服务器开始游戏
function UI_WuZiQiCtrl.OnWuZiQiStartGameRes(buffer)
    print("---------------!!!")
    local self = UI_WuZiQiCtrl
    local data   = buffer:ReadBuffer()
    local msg    = GameStart_pb.GameStartRes()
    msg:ParseFromString(data)
    if msg.gameStart == true then
    	self:WuZiQiStart()
    	self.roomState = 1
	end
end

function UI_WuZiQiCtrl:WuZiQiStart()
	UI_WuZiQiPanel.btnPrepare:SetActive(false)			--准备隐藏
    UI_WuZiQiPanel.btnStart:SetActive(false)			--房主开始隐藏
    UI_WuZiQiPanel.imgWattingMessage:SetActive(false)	--玩家等待隐藏
    UI_WuZiQiPanel.imgQiPan:SetActive(true)				--棋盘显示 现在开始游戏棋牌不显示
    UI_WuZiQiPanel.btnSetting:SetActive(false)			--设置学费按钮隐藏
    UI_WuZiQiPanel.btnSubmit:SetActive(true)			--认输按钮显示
end

--输入学费
function UI_WuZiQiCtrl.OnInputNum(go)
	local self = UI_WuZiQiCtrl
	print("=======输入学费=======",self.myIndex)
	if self.myIndex ~= 1 then
		local msg = "你不是房主,不能设置"
		MessageTipsCtrl:ShowInfo(msg)
	else
		UI_WuZiQiPanel.imgshurubg:SetActive(true)
	end
end

--输入数字0
function UI_WuZiQiCtrl.OnNum0BtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = UI_WuZiQiCtrl
	self:InputRoomNum('0')
end

--输入数字1
function UI_WuZiQiCtrl.OnNum1BtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = UI_WuZiQiCtrl
	self:InputRoomNum('1')
end

--输入数字2
function UI_WuZiQiCtrl.OnNum2BtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = UI_WuZiQiCtrl
	self:InputRoomNum('2')
end

--输入数字3
function UI_WuZiQiCtrl.OnNum3BtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = UI_WuZiQiCtrl
	self:InputRoomNum('3')
end

--输入数字4
function UI_WuZiQiCtrl.OnNum4BtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = UI_WuZiQiCtrl
	self:InputRoomNum('4')
end

--输入数字5
function UI_WuZiQiCtrl.OnNum5BtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = UI_WuZiQiCtrl
	self:InputRoomNum('5')
end

--输入数字6
function UI_WuZiQiCtrl.OnNum6BtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = UI_WuZiQiCtrl
	self:InputRoomNum('6')
end

--输入数字7
function UI_WuZiQiCtrl.OnNum7BtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = UI_WuZiQiCtrl
	self:InputRoomNum('7')
end

--输入数字8
function UI_WuZiQiCtrl.OnNum8BtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = UI_WuZiQiCtrl
	self:InputRoomNum('8')
end

--输入数字9
function UI_WuZiQiCtrl.OnNum9BtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = UI_WuZiQiCtrl
	self:InputRoomNum('9')
end

--显示输入的学费内容
function UI_WuZiQiCtrl:InputRoomNum(roomNum)
	local inputText = self:GetText(UI_WuZiQiPanel.txtinput)
	local testNumber = self:GetText(UI_WuZiQiPanel.txtinput)
	testNumber = testNumber..roomNum
	if inputText == '' then
		self:SetText(UI_WuZiQiPanel.txtinput,testNumber)
	else
		self:SetText(UI_WuZiQiPanel.txtinput,testNumber)
	end
end

--删除学费
function UI_WuZiQiCtrl.OnDelentBtnClick( go)
	local self = UI_WuZiQiCtrl
	local testNumber = self:GetText(UI_WuZiQiPanel.txtinput)
	self:SetText(UI_WuZiQiPanel.txtinput,string.sub(testNumber,1,-2))
end

--确认学费
function UI_WuZiQiCtrl.OnSureBtnClick(go)
	print("=========OnSureBtnClick==========")
	local self = UI_WuZiQiCtrl
	local txt = self:GetText(UI_WuZiQiPanel.txtinput)

	print("==========元宝数,学费=============",txt,self.player1.yuanbao)

	if tonumber(txt) > tonumber(self.player1.yuanbao) then
		local msg = "元宝数量不够"
		MessageTipsCtrl:ShowInfo(msg)
	else
		self:SetText(UI_WuZiQiPanel.txtTuition,"学费: ".. txt)
		UI_WuZiQiPanel.imgshurubg:SetActive(false)
	end	
	local data = WuziqiBet_pb.WuziqiBetReq()
    data.betConut = tonumber(txt)
    local msg = data:SerializeToString()
    Game.SendProtocal(Protocal.WuZiQiBet, msg)
end

--设置学费回调
function UI_WuZiQiCtrl.OnWuziqiBetRes(buffer)
    print("--------WuziqiBetRes-------")
    local self = UI_WuZiQiCtrl
    local data   = buffer:ReadBuffer()
    local msg    = WuziqiBet_pb.WuziqiBetRes()
    msg:ParseFromString(data)
    local roleIndex = msg.roleIndex
    local betConut = msg.betConut
    print("--------WuziqiBetRes-------",roleIndex,betConut)

    self:SetText(UI_WuZiQiPanel.txtTuition,"学费: ".. betConut)   
end

--退出学费输入框
function UI_WuZiQiCtrl.OnExit(go)
	UI_WuZiQiPanel.imgshurubg:SetActive(false)
	-- body
end

--生成格子
function UI_WuZiQiCtrl:CreateGeZi()
	local go = UI_WuZiQiPanel.btnGeZi
	local p = 49
	local q = 48
	for i=0,self.column do
		for j=0,self.line do
			local obj = newObject(go)
		    table.insert(self.tableList,obj)
		    obj.transform:SetParent(UI_WuZiQiPanel.imgQiPan.transform)
		    obj.transform.localPosition = Vector3.New(-345+p*i,345-q*j,0)
		    obj:GetComponent("Image").color = Color.New(0,0,0,0)
		    obj.transform.localScale = Vector3.one
		end
	end
	print("==========CreateGeZi===========",#self.tableList)
	for i,v in ipairs(self.tableList) do
		v.name = i
		 self:AddClick(v,self.OnClickGeZi)
	end
	print("==========CreateGeZi===========",self.tableList[1].name)
end

--点击格子
function UI_WuZiQiCtrl.OnClickGeZi(go)
	local self = UI_WuZiQiCtrl
	-- self.count = self.count + 1
	
	-- local curObj = go:GetComponent("Image")
	-- local btnqizi = go:GetComponent("Button")
	-- print("==========OnClickGeZi===========",go.name,curObj.sprite.name,btnqizi.name)
	-- if(self.count % 2 == 0) then
	--     curObj.sprite = self.whiteQi.sprite
	--     curObj.color = Color.New(1,1,1,1)
	--     btnqizi.enabled = false
	--     self:JudgeChess()
 --    else
	--     curObj.sprite = self.blackQi.sprite
	--     curObj.color = Color.New(1,1,1,1)
	--     btnqizi.enabled = false
	--     self:JudgeChess()
	-- end
end

--判断棋局(黑胜,白胜,平局)
function UI_WuZiQiCtrl:JudgeChess()
    if(true) then
		if(true) then
		  print("Game over.Black win!")
        else
	      print("Game over.White win!")
	    end
    else
    	print("Tie game!")
    end
end

--玩家认输
function UI_WuZiQiCtrl.OnLose()
	print("========玩家认输=======")
	local self = UI_WuZiQiCtrl
	if self.playerCount == 1 then
		local msg = "一个人不能认输!"
		MessageTipsCtrl:ShowInfo(msg)
		return
	end
	local  msg = ""
	Game.SendProtocal(Protocal.WuZiQiPlayLose, msg)
end

--收到服务器认输
function UI_WuZiQiCtrl.PlayLoseRes(buffer)
	local self = UI_WuZiQiCtrl
    local data   		= buffer:ReadBuffer()
    local msg   	 	= RoleLose_pb.RoleLoseRes()
    msg:ParseFromString(data)
    local roleIndex		= msg.roleIndex
    local winIndex		= msg.winIndex
    local loseIndex 	= msg.loseIndex
    local bet			= msg.bet
    print("----------------PlayLoseRes------------->>>>>",roleIndex,winIndex,loseIndex,bet)

    if self.myIndex == roleIndex then
    	self:GameOverLoseShow()
    	if self.myIndex == 1 then
    		local coin1 = tonumber(self.player1.yuanbao) - bet
    		local coin2 = tonumber(self.player2.yuanbao) + bet
    		self.player1.yuanbao = coin1..""
    		self.player2.yuanbao = coin2..""
    		self:SetText(self.player1.txtYuanbao,self.player1.yuanbao)
    		self:SetText(self.player2.txtYuanbao,self.player2.yuanbao)
    	else
    		--self.player2.txtYuanbao
    		local coin1 = tonumber(self.player1.yuanbao) + bet
    		local coin2 = tonumber(self.player2.yuanbao) - bet
    		self.player1.yuanbao = coin1..""
    		self.player2.yuanbao = coin2..""
    		self:SetText(self.player1.txtYuanbao,self.player1.yuanbao)
    		self:SetText(self.player2.txtYuanbao,self.player2.yuanbao)
    	end
    else
    	self:GameOverWinShow()
    	if self.myIndex == 1 then
    		--self.player1.txtYuanbao
    		local coin1 = tonumber(self.player1.yuanbao) + bet
    		local coin2 = tonumber(self.player2.yuanbao) - bet
    		self.player1.yuanbao = coin1..""
    		self.player2.yuanbao = coin2..""
    		self:SetText(self.player1.txtYuanbao,self.player1.yuanbao)
    		self:SetText(self.player2.txtYuanbao,self.player2.yuanbao)
    	else
    		--self.player2.txtYuanbao
    		local coin1 = tonumber(self.player1.yuanbao) - bet
    		local coin2 = tonumber(self.player2.yuanbao) + bet
    		self.player1.yuanbao = coin1..""
    		self.player2.yuanbao = coin2..""
    		self:SetText(self.player1.txtYuanbao,self.player1.yuanbao)
    		self:SetText(self.player2.txtYuanbao,self.player2.yuanbao)
    	end
    end
    if roleIndex ~= 1 then
    	UI_WuZiQiPanel.imgWinHead:GetComponent("Image").sprite= self.player1.imgHead:GetComponent("Image").sprite
	    self:SetText(UI_WuZiQiPanel.txtWinName,self.player1.name)
	
	    UI_WuZiQiPanel.imgLoseHead:GetComponent("Image").sprite= self.player2.imgHead:GetComponent("Image").sprite
	    self:SetText(UI_WuZiQiPanel.txtLoseName,self.player2.name)
	else
		UI_WuZiQiPanel.imgWinHead:GetComponent("Image").sprite= self.player2.imgHead:GetComponent("Image").sprite
	    self:SetText(UI_WuZiQiPanel.txtWinName,self.player2.name)
	
	    UI_WuZiQiPanel.imgLoseHead:GetComponent("Image").sprite= self.player1.imgHead:GetComponent("Image").sprite
	    self:SetText(UI_WuZiQiPanel.txtLoseName,self.player1.name)
	end

	UI_WuZiQiPanel.btnSetting:SetActive(false)

    self:SetText(UI_WuZiQiPanel.txtWinFenshu,"+".. bet)
    self:SetText(UI_WuZiQiPanel.txtLoseFenshu,"-".. bet)
    self.roomState = 0 
end

--游戏输了的弹窗
function UI_WuZiQiCtrl:GameOverLoseShow()
	UI_WuZiQiPanel.GameOver:SetActive(true)
	UI_WuZiQiPanel.imgMyLose:SetActive(true)
	UI_WuZiQiPanel.imgMyWin:SetActive(false)
	UI_WuZiQiPanel.btnSubmit:SetActive(false)	
end
--游戏赢了的弹窗
function UI_WuZiQiCtrl:GameOverWinShow()
	UI_WuZiQiPanel.GameOver:SetActive(true)
	UI_WuZiQiPanel.imgMyWin:SetActive(true)
	UI_WuZiQiPanel.imgMyLose:SetActive(false)
	UI_WuZiQiPanel.btnSubmit:SetActive(false)
end


--初始化房间信息
function UI_WuZiQiCtrl:CreateRoom()
	CreateRoomCtrl.PlayEffectMusic()
	global.systemVo.TalkSource:Stop() 

	local roomInfo = CreateWuziqiRoot_pb.CreateWuziqiRoomReq()
	roomInfo.wuZiqiTotal = 1
	local msg = roomInfo:SerializeToString()
	Game.SendProtocal(Protocal.CreateWuziqiRoom, msg)
	print("----------------CreateWuZiQiRoomCtrl------------->>>>>",Protocal.CreateWuziqiRoom)
end

function UI_WuZiQiCtrl:RoomInfo()
	
	print("--------------->>>",self.RoomMsg.id)
	print("--------------->>>",#self.playersData)
	print("--------------->>>",self.playerCount)
	print("--------------->>>",self.myIndex)
	--房间信息初始
	print("=====UI_WuZiQiCtrl:RoomInf=====self.RoomMsg.id===",self.RoomMsg.id)
	self:SetText(UI_WuZiQiPanel.txtRoomNum,"房间号: ".. self.RoomMsg.id)
	self:SetText(UI_WuZiQiPanel.txtTuition,"学费: ".. 0)
	self.player1.obj:SetActive(false)
	self.player2.obj:SetActive(false)
end

--初始化玩家信息 --元宝信息
function UI_WuZiQiCtrl:PlayerInit(player,i)
	--玩家名字
	self:SetText(player.txtName,player.name)
	--玩家ID
	self:SetText(player.txtID,player.id)
	--玩家元宝
	self:SetText(player.txtYuanbao,player.yuanbao)
	--玩家头像
	if player.imgHead then
		player.imgHead.name   = player.id
		if player.url ~= "" then
			weChatFunction.SetPic(player.imgHead,player.id,player.url)
		end
	else
		player.imgHead = BasePanel:GOChild(player.obj,"imgPlay"..i.."/"..player.id)
	end

	--界面显示完成
	player.obj:SetActive(true)
end

--设置
function UI_WuZiQiCtrl.OnShezhiBtnClick(go)
	print("======设置==========")
	local self = UI_WuZiQiCtrl
	local touxiang = nil
	if self.myIndex == 1 then
		touxiang = self.player1.obj
	else
		touxiang = self.player2.obj
	end
	SetSystemCtrl:GetInfo(global.userVo.name,global.userVo.roleId,global.userVo.roleIp,
         BasePanel:GOChild(touxiang,global.userVo.roleId))
    SetSystemCtrl:Open('SetSystem')
	-- body
end

--文字
function UI_WuZiQiCtrl.OnTypeBtnClick(go)
	print("======文字==========")
	Game.MusicEffect(Game.Effect.joinRoom)
    GameChatCtrl:Open('GameChat')
end

--收到断线重连消息
function UI_WuZiQiCtrl.OfflinePush(msg)
    if not UI_WuZiQiCtrl.isCreate then return end
    -- local roleId  = msg.roleId --断线（重连）roleId
    -- local state   = msg.state  --true=上线  false=离线
    -- for i,v in ipairs(self.playersData) do
    --     if v.id == roleId then
    --         v.imgOffLine:SetActive(not state)
    --         break
    --     end
    -- end
    local self = UI_WuZiQiCtrl
    self:Close(true)
	MainSenceCtrl:Open("MainSence")
end

--退出房间
function UI_WuZiQiCtrl.QuitRoom(go)
	print("======退出游戏==========")
	local self = UI_WuZiQiCtrl
	--if self.roomState == 1 then
		--local msg = "游戏进行中,不能退出!"
		--MessageTipsCtrl:ShowInfo(msg)
		--return
	--else
		DissolutionRoomTipsCtrl:Open('DissolutionRoomTips')
	--end
end

--退出房间清理
function UI_WuZiQiCtrl:ClearRoomInfo()
	self.playersData = {}
	self.playerCount = 0
	self:Close(true)
	MainSenceCtrl:Open("MainSence")
end

--结算界面弹窗分享按钮
function UI_WuZiQiCtrl.OnShareClick(go)
	print("==========游戏分享=============")
	local self = UI_WuZiQiCtrl;
	self.isClickFriend = true
	Game.MusicEffect(Game.Effect.joinRoom)
	if(AppConst.getCurrentPlatform() == 'PC') then
		MessageTipsCtrl:ShowInfo("当前不能分享！ ")
        return
	end
	local shareContent = "俺们大厅看过来,十点半、麻将、拼三张、跑得快、牛牛,五子棋,一键下载都能玩!"
	local imageUrl = 'http://download.hzjiuyou.com/shareicon/shareIcon.png'
	local title = "大厅"
	local downUrl = 'http://download.hzjiuyou.com/dl/hzdownload.htm'
	weChatFunction.weChatInviteFriendBtnClick(shareContent,imageUrl,title,downUrl)
end

--结算界面弹窗确认按钮
function UI_WuZiQiCtrl.OnOverSureClick(go)
	print("-----OnOverSureClick->>")
	local self = UI_WuZiQiCtrl
	UI_WuZiQiPanel.GameOver:SetActive(false)
	self:ClearTable()
end

--清理桌面,回到等待状态
function UI_WuZiQiCtrl:ClearTable()
	local self = UI_WuZiQiCtrl
	for i,v in ipairs(self.tableList) do
		local curObj = v:GetComponent("Image")
		local btnqizi = v:GetComponent("Button")
		curObj.sprite = self.whiteQi.sprite
	    curObj.color = Color.New(0,0,0,0)
	    btnqizi.enabled = true
	end
	UI_WuZiQiPanel.imgQiPan:SetActive(false)
	UI_WuZiQiPanel.btnPrepare:SetActive(true)
	self:SetText(UI_WuZiQiPanel.txtTuition,"学费: ".. 0)
	UI_WuZiQiPanel.btnSetting:SetActive(true)  
end

function UI_WuZiQiCtrl.OnHidePanelClick(go)
	UI_WuZiQiPanel.PanelGameSetting:SetActive(false)
	UI_WuZiQiPanel.btnHideUp:SetActive(false)
	UI_WuZiQiPanel.btnSettingGame:SetActive(true)
end

function UI_WuZiQiCtrl.OnShowGameSettingClick(go)
	UI_WuZiQiPanel.PanelGameSetting:SetActive(true)
	UI_WuZiQiPanel.btnSettingGame:SetActive(false)
	UI_WuZiQiPanel.btnHideUp:SetActive(true)
end

function UI_WuZiQiCtrl.OnInvitationWeChatBtnClick(go)
	local self = UI_WuZiQiCtrl
	Game.MusicEffect(Game.Effect.joinRoom)
	if(AppConst.getCurrentPlatform() == 'PC') then
		MessageTipsCtrl:ShowInfo("当前不能邀请!")
		print("===========================当前不能邀请!====================",self.RoomMsg.id)
        return
	else
		local shareContent = "房号:"..self.RoomMsg.id..",速度来啊!【五子棋】"
		local imageUrl = 'http://download.hzjiuyou.com/shareicon/wuziq.png'
		local title = "五子棋-"..self.RoomMsg.id
		local downUrl = 'http://download.hzjiuyou.com/dl/hzdownload.htm'
		weChatFunction.weChatInviteFriendBtnClick(shareContent,imageUrl,title,downUrl)
	end
end

-- 复制房间号
function UI_WuZiQiCtrl.OnFuZhiRoomNum(go)
	local self = UI_WuZiQiCtrl
	Game.MusicEffect(Game.Effect.joinRoom)
	Util.CopyText(self.RoomMsg.id)
	UI_WuZiQiPanel.imgShowNum:SetActive(true)
	local co = coroutine.start(function()
        coroutine.wait(3)
		UI_WuZiQiPanel.imgShowNum:SetActive(false)
    end)
    table.insert(Network.crts, co)
	--UI_WuZiQiCtrl.SetIconTips("已复制成功房号到粘贴板")
end

