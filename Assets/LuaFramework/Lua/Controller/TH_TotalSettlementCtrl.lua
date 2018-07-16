--文件：总结算界面控制

TH_TotalSettlementCtrl = {}

setbaseclass(TH_TotalSettlementCtrl, {BaseCtrl})
local playerList = {}
local titleObjList = {}
local titleMsgList = {"",{"单局最高：","最大牌型：","胜利局数：","失败局数："},{"单局最高：","最大牌型：","胜利局数：","失败局数："},
						 {"单局最高：","炸弹数量：","胜利局数：","失败局数："},{"","","",""}}
--启动事件--
function TH_TotalSettlementCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	print("----------------------------",TH_TotalSettlementPanel.btnClose,TH_TotalSettlementPanel.btnShare)
	self:AddClick(TH_TotalSettlementPanel.btnClose,self.OnQuitBtnClick)
	self:AddClick(TH_TotalSettlementPanel.btnShare,self.OnShareBtnClick)
end

--初始化面板--
function TH_TotalSettlementCtrl:InitPanel(objs,info)
	local self = TH_TotalSettlementCtrl
	DissolutionRoomCtrl.gameOver = false
	Game.isReloadBattle = false
	--Game.MusicEffect(Game.Effect.gameStart)
    local roomNum = info.roomNum
    local totalJushu = info.totalJushu
    local msg = info.totalSettlementInfo
    local endTime = info.endTime
	local parent = TH_TotalSettlementPanel.gridParent.transform
	self = TH_TotalSettlementCtrl
	self:SetText(TH_TotalSettlementPanel.txtCurrentTime,getTimeFormat(endTime))

	local jifenTable = {}
	
	for i = 1, table.maxn(msg) do
		jifenTable[i] = msg[i].roleFenShu
	end
	local maxOfT = math.max(unpack(jifenTable))
	local minOfT = math.min(unpack(jifenTable))
	print("maxOfT--minOfT"..maxOfT..'---'..minOfT)

	local txtRoomNum 		= TH_TotalSettlementPanel.txtRoomNum

	self:SetText(txtRoomTime,getTimeFormat(endTime))
	self:SetText(txtRoomNum,"房间:" .. roomNum)
	local room = nil
	if Room.gameType == RoomType.GoldFlower then
		room = GoldFlowerRoom
	elseif Room.gameType == RoomType.Tenharf then
		room = TenharfRoom
	elseif Room.gameType == RoomType.CatchPock then
		room = CatchPockRoom
	elseif Room.gameType == RoomType.NiuNiu then
		room = NiuNiuRoom
		parent = TH_TotalSettlementPanel.niuGrid.transform
	end
	self:SetText(txtInning,room.curJushu..'/'..totalJushu..' 局')
	playerList = {}

	for i = 1,#msg do	
		--生成预制--
		local go = newObject(objs[0])
		go.name = msg[i].roleId
		go.transform:SetParent(parent)
		go.transform.localScale = Vector3.one
		go.transform.localPosition = Vector3.zero
		--获取组件--
		-- local imgFangzhu 			= BasePanel:GOChild(go,"imgFangzhu") 
		local imgHeadIcon			= BasePanel:GOChild(go,"imgHead")
		local txtRoleName			= BasePanel:GOChild(go,"txtName")
		local txtRoleID				= BasePanel:GOChild(go,"txtScore")
		local txtHighScore			= BasePanel:GOChild(go,"txtHighScore")
		local txtCardColor			= BasePanel:GOChild(go,"txtCardColor")
		local txtWinNum				= BasePanel:GOChild(go,"txtWinNum")
		local txtLoseNum			= BasePanel:GOChild(go,"txtLoseNum")
		local txtSumScore			= BasePanel:GOChild(go,"txtSumScore")
		local imgBigWinner			= BasePanel:GOChild(go,"imgBigWinner")
		local txtTitle1				= BasePanel:GOChild(go,"txtTitle1")
		local txtTitle2				= BasePanel:GOChild(go,"txtTitle2")
		local txtTitle3				= BasePanel:GOChild(go,"txtTitle3")
		local txtTitle4				= BasePanel:GOChild(go,"txtTitle4")
		titleObjList = {txtTitle1,txtTitle2,txtTitle3,txtTitle4}
		--赋值信息--
		self:SetTitleText(Room.gameType)
		local jifen = msg[i].roleFenShu
		if Room.gameType == RoomType.CatchPock then
			danju = msg[i].boomNum
		else
			danju = msg[i].maxCardType
		end
		local text = ""
		print("====================================123=",msg[i].roleId,danju,RoomType.gameType)
		local touxiang = nil
		if Room.gameType == RoomType.GoldFlower then
			touxiang = GoldFlowerRoom:GetPlayerById(msg[i].roleId)
			if danju == 1 then
				text = "高牌"
			elseif danju == 2 then
				text = "对子"
			elseif danju == 3 then
				text = "顺子"
			elseif danju == 4 then
				text = "金花"
			elseif danju == 5 then
				text = "顺金"
			elseif danju == 6 then
				text = "豹子"
			else
				text = "高牌"
			end
		elseif Room.gameType == RoomType.Tenharf then
			touxiang = TenharfRoom:GetPlayerById(msg[i].roleId)
			if danju == 3 then
				text = "十点半"
			elseif danju == 4 then
				text = "五雷"
			elseif danju == 5 then
				text = "五花雷"
			elseif danju == 6 then
				text = "十点半雷"
			else
				text = "普通"
			end
		elseif Room.gameType == RoomType.CatchPock then
			touxiang = CatchPockRoom:GetPlayerById(msg[i].roleId)
			text = tostring(danju)
		elseif Room.gameType == RoomType.NiuNiu then 
			touxiang = NiuNiuRoom:GetPlayerById(msg[i].roleId)
			print("------------gameType-------------",Room.gameType)
			text = tostring(danju)
		end
		
		--local sprite = touxiang.imgHead:GetComponent("Image").sprite
		--imgHeadIcon:GetComponent("Image").sprite = sprite
		self:SetText(txtRoleName,	 msg[i].roleName 		)
		self:SetText(txtRoleID,		 "ID:" .. msg[i].roleId )	
		self:SetText(txtWinNum,		 msg[i].winJuShu 		)
		self:SetText(txtLoseNum,	 msg[i].lostJuShu 		)	
		self:SetText(txtHighScore,	 msg[i].danJuMax		)
		self:SetText(txtInning,(msg[i].winJuShu + msg[i].lostJuShu)..'/'..totalJushu..' 局')
		--显示设置--

		local greenColor = Color.New(0,1,0,1)
		local redColor = Color.New(0.84,0.23,0.2,1)
		self:SetText(txtCardColor,text)
		if jifen > 0 then
			self:SetText(txtSumScore,"<color=#FF182C>".."+"..jifen.."</color>")
		elseif jifen == 0 then
			self:SetText(txtSumScore,"<color=#eeeeee>"..jifen.."</color>")
		elseif jifen < 0 then
			self:SetText(txtSumScore,"<color=#797979>".."-"..(-jifen).."</color>")
		end
		if jifen == maxOfT and jifen ~= 0 then	
			imgBigWinner:SetActive(true)
	else
			imgBigWinner:SetActive(false)
		end
		playerList[i] = go
	end
	TenharfRoom:ClearRoomInfo()
	GoldFlowerRoom:ClearRoomInfo()
	CatchPockRoom:ClearRoomInfo()
	NiuNiuRoom:ClearRoomInfo()
end

--退出--
function TH_TotalSettlementCtrl.OnQuitBtnClick(go)
	DissolutionRoomCtrl.gameOver = false
	--Game.MusicEffect(Game.Effect.buttonBack)
	local self = TH_TotalSettlementCtrl
		    --销毁
    for i=1,#playerList do
    	playerList[i]:Destroy()
    end
    global.roomVo = {}
    global.joinRoomUserVos = {}
    global.gpsMsgInfo = {}
	self:Close()
	--SingleSettlementCtrl:Close()
	if Room.gameType == RoomType.CatchPock then
		self = CH_GameMainCtrl
		self:CancelInvoke("CardTime")
		CH_GameMainCtrl:Close()
	else
		self = TH_GameMainCtrl
		self:CancelInvoke("CardTime")
		TH_GameMainCtrl:Close()
	end
	Network.ClearCtrs()
	Game.LoadScene("main")
end

function TH_TotalSettlementCtrl.OnShareBtnClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	weChatFunction.ShareBattleBtnClick()
end

--动态显示结算信息
function TH_TotalSettlementCtrl:SetTitleText(roomType)
	for i,v in ipairs(titleObjList) do
		self:SetText(titleObjList[i],titleMsgList[roomType][i])
	end
end