GameRoomCardMatchCtrl = {}
setbaseclass(GameRoomCardMatchCtrl, {BaseCtrl})

--启动事件--
function GameRoomCardMatchCtrl:OnCreate(obj)
    BaseCtrl.OnCreate(self, obj)
	self:AddClick(GameRoomCardMatchPanel.btn16XiangQing,self.OnRoomCard16MatchBtnClick)
	self:AddClick(GameRoomCardMatchPanel.btn8XiangQing,self.OnRoomCard16MatchBtnClick)
	self:AddClick(GameRoomCardMatchPanel.btn4XiangQing,self.OnRoomCard16MatchBtnClick)
	self:AddClick(GameRoomCardMatchPanel.btn16TuiSai,self.OnTuiSaiBtnClick)
	self:AddClick(GameRoomCardMatchPanel.btn16BaoMing,self.OnBaoMingClick)
	self:AddClick(GameRoomCardMatchPanel.btn8TuiSai,self.OnTuiSaiBtnClick)
	self:AddClick(GameRoomCardMatchPanel.btn8BaoMing,self.OnBaoMingClick)
	self:AddClick(GameRoomCardMatchPanel.btn4TuiSai,self.OnTuiSaiBtnClick)
	self:AddClick(GameRoomCardMatchPanel.btn4BaoMing,self.OnBaoMingClick)

	self:AddClick(GameRoomCardMatchPanel.btnFangKaMatchDiamondPay,self.OnDiamondPayClick)
	self:AddClick(GameRoomCardMatchPanel.btnFangKaMatchGoldPay,self.OnDiamondPayClick)
	self:AddClick(GameRoomCardMatchPanel.btnRoomCardMatchQuit,self.OnRoomCardMatchQuitBtnClick)
	self:AddClick(GameRoomCardMatchPanel.btnRoomCardMatchHeadIcon,self.OnRoomCardMatchHeadIconBtnClick)
	self:AddClick(GameRoomCardMatchPanel.btnMatchRecord,self.OnMatchRecordBtnClick)
	--人机模式
	self:AddOnValueChanged(GameRoomCardMatchPanel.togRobot,self.OnTogRobotClick)
	--
	self:InitPanel(global.userVo)
	self:InvokeRepeat("VsGetJoinCount16",3,300000000)
end

--初始化面板--
function GameRoomCardMatchCtrl:InitPanel(userInfo)
	GameRoomCardMatchPanel.imgTips:SetActive(false)
	local img = GameRoomCardMatchPanel.imgHeadIcon
	if(AppConst.getCurrentPlatform() == "PC") then
		local url = "https://ps.ssl.qhimg.com/t01e9783b7417515cc0.jpg"
		weChatFunction.SetPic(img,global.userVo.roleId,url)
	else
		weChatFunction.SetPic(img,global.userVo.roleId,global.userVo.headImg)
	end
	self:RefreshPanel(userInfo,"InitPanel")
	self.isRobot = false
	self.isCanClick = true
	self.currentClickBtn = 0
	self.currentXiangQingBtn = 0
	--人机模式(发布版本时隐藏)
	GameRoomCardMatchPanel.togRobot:SetActive(false)
	GameRoomCardMatchPanel.btnRoomCard16Match.transform.localPosition = Vector3.New(390,-35,0)
	GameRoomCardMatchPanel.btnRoomCard4Match.transform.localPosition = Vector3.New(-390,-35,0)
	GameRoomCardMatchPanel.txtRoomCard8Tishi:SetActive(false)
	GameRoomCardMatchPanel.imgRoomCard8SuoBG:SetActive(false)
	GameRoomCardMatchPanel.txtRoomCard4Tishi:SetActive(false)
	GameRoomCardMatchPanel.imgRoomCard4SuoBG:SetActive(false)
	GameRoomCardMatchPanel.imgFangKaMatchGoldBG:SetActive(false)
end

function GameRoomCardMatchCtrl.OnTogRobotClick(go,bool)
	local self = GameRoomCardMatchCtrl 
	if bool  then
		self.isRobot = true
	else
		self.isRobot = false
	end
end

function GameRoomCardMatchCtrl:VsGetJoinCount16()
	self:CancelInvoke("VsGetJoinCount16")
	local vsJoinInfo = VsGetJoinCount_pb.VsGetJoinCountReq()
	vsJoinInfo.vsType = GameMatchType.RoomCardMatch
	vsJoinInfo.vsCount = 16
	local msg = vsJoinInfo:SerializeToString()
	Game.SendProtocal(Protocal.VsGetJoinCount,msg)
	self:InvokeRepeat("VsGetJoinCount8",3,300000000)
end

function GameRoomCardMatchCtrl:VsGetJoinCount8()
	self:CancelInvoke("VsGetJoinCount8")
	local vsJoinInfo = VsGetJoinCount_pb.VsGetJoinCountReq()
	vsJoinInfo.vsType = GameMatchType.RoomCardMatch
	vsJoinInfo.vsCount = 8
	local msg = vsJoinInfo:SerializeToString()
	Game.SendProtocal(Protocal.VsGetJoinCount,msg)
	self:InvokeRepeat("VsGetJoinCount4",3,300000000)
end

function GameRoomCardMatchCtrl:VsGetJoinCount4()
	self:CancelInvoke("VsGetJoinCount4")
	local vsJoinInfo = VsGetJoinCount_pb.VsGetJoinCountReq()
	vsJoinInfo.vsType = GameMatchType.RoomCardMatch
	vsJoinInfo.vsCount = 4
	local msg = vsJoinInfo:SerializeToString()
	Game.SendProtocal(Protocal.VsGetJoinCount,msg)
	self:InvokeRepeat("VsGetJoinCount16",3,300000000)
end

--比赛场获取加入人数回调
function GameRoomCardMatchCtrl.VsGetJoinCountRes(buffer)
	local self = GameRoomCardMatchCtrl
	local data   = buffer:ReadBuffer()
	local msg    = VsGetJoinCount_pb.VsGetJoinCountRes()	
	msg:ParseFromString(data)
	local vsCount = msg.vsCount
	print('GameRoomCardMatchCtrl.VsGetJoinCountRes1111111111111111',msg.vsCount,msg.vsType)
	if msg.vsType == GameMatchType.RoomCardMatch then
		if vsCount == 16 then
			if GameRoomCardMatchCtrl.isCreate then
				self:SetText(GameRoomCardMatchPanel.txtBaoMing,msg.vsJoinCount)
			end
		elseif vsCount == 8 then
			if GameRoomCardMatchCtrl.isCreate then
				self:SetText(GameRoomCardMatchPanel.txt8BaoMing,msg.vsJoinCount)
			end
		elseif vsCount == 4 then
			if GameRoomCardMatchCtrl.isCreate then
				self:SetText(GameRoomCardMatchPanel.txt4BaoMing,msg.vsJoinCount)
			end
		end
	end
end

function GameRoomCardMatchCtrl.OnRoomCard16MatchBtnClick(go)
	self = GameRoomCardMatchCtrl
	Game.MusicEffect(Game.Effect.joinRoom)
	if go.name == "btn16XiangQing" then
		self.currentXiangQingBtn = 16
	elseif go.name == "btn8XiangQing" then
		self.currentXiangQingBtn = 8
	elseif go.name == "btn4XiangQing" then
		self.currentXiangQingBtn = 4
	end
	GameMatchDetailCtrl:Open("GameMatchDetail")
end

function GameRoomCardMatchCtrl.OnTuiSaiBtnClick(go)
	self = GameRoomCardMatchCtrl
	Game.MusicEffect(Game.Effect.joinRoom)
	if self.isCanClick then
		if go.name == "btn16TuiSai" then
			self.currentClickBtn = 16
		elseif go.name == "btn8TuiSai" then
			self.currentClickBtn = 8
		elseif go.name == "btn4TuiSai" then
			self.currentClickBtn = 4
		end
		local msg = ""
		Game.SendProtocal(Protocal.VsQuit, msg)
		self.isCanClick = false
	end
end

function GameRoomCardMatchCtrl.OnMatchRecordBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	GameMatchRecordCtrl:Open("GameMatchRecord")
end

--退出比赛场回调
function GameRoomCardMatchCtrl.VsQuitRes(buffer)
	local self = GameRoomCardMatchCtrl
	self.isCanClick = true
	local data   = buffer:ReadBuffer()
	local msg    = IntTypeReturn_pb.IntTypeReturnRes()
	msg:ParseFromString(data)
	local baoMingCount = msg.intVal
	print('GameRoomCardMatchCtrl.VsQuitRes1111111111111111',baoMingCount)
	self.joinOK = false
	if self.currentClickBtn == 16 then
		if GameRoomCardMatchCtrl.isCreate then
			GameRoomCardMatchPanel.btn16TuiSai:SetActive(false)
			GameRoomCardMatchPanel.btn16BaoMing:SetActive(true)
			self:SetText(GameRoomCardMatchPanel.txtBaoMing,baoMingCount)
		end
	elseif self.currentClickBtn == 8 then
		if GameRoomCardMatchCtrl.isCreate then
			GameRoomCardMatchPanel.btn8TuiSai:SetActive(false)
			GameRoomCardMatchPanel.btn8BaoMing:SetActive(true)
			self:SetText(GameRoomCardMatchPanel.txt8BaoMing,baoMingCount)
		end
	elseif self.currentClickBtn == 4 then
		if GameRoomCardMatchCtrl.isCreate then
			GameRoomCardMatchPanel.btn4TuiSai:SetActive(false)
			GameRoomCardMatchPanel.btn4BaoMing:SetActive(true)
			self:SetText(GameRoomCardMatchPanel.txt4BaoMing,baoMingCount)
		end
	end
end

function GameRoomCardMatchCtrl.OnBaoMingClick(go)
	self = GameRoomCardMatchCtrl
	Game.MusicEffect(Game.Effect.joinRoom)
	print('GameRoomCardMatchCtrl.OnBaoMingClick1111111111',self.joinOK)
	if tonumber(global.userVo.diamond) < 6 then
		self.SetIconTips("房卡不足，无法报名！")
		return
	end

	if self.joinOK == true then
		self.SetIconTips("您已经报名，不能重复报名！")
		return
	end
	if self.isCanClick then
		local vsJoinInfo = VsJoin_pb.VsJoinReq()
		vsJoinInfo.vsType = GameMatchType.RoomCardMatch
		if go.name == "btn16BaoMing" then
			vsJoinInfo.vsCount = 16
		elseif go.name == "btn8BaoMing" then
			vsJoinInfo.vsCount = 8
		elseif go.name == "btn4BaoMing" then
			vsJoinInfo.vsCount = 4
		end

		vsJoinInfo.isRobot = self.isRobot
		local msg = vsJoinInfo:SerializeToString()
		Game.SendProtocal(Protocal.VsJoin,msg)
		self.isCanClick = false
	end
end

--加入比赛场回调
function GameRoomCardMatchCtrl.VsJoinRes(buffer)
	local self = GameRoomCardMatchCtrl
	self.isCanClick = true
	local data   = buffer:ReadBuffer()
	local msg    = VsJoin_pb.VsJoinRes()	
	msg:ParseFromString(data)
	local vsCount = msg.vsCount
	local roleId  = msg.roleId
	local joinCount = msg.joinCount
	if not GameMatchCtrl.isCreate then
		GameMatchCtrl:Open('GameMatch')
	end
	print('GameRoomCardMatchCtrl.VsJoinRes1111111111',self.joinOK,msg.vsCount,msg.joinCount,msg.vsType)
	if msg.vsType == 1 then
		self.joinOK = true
		print('GameRoomCardMatchCtrl.VsJoinRes2222222222222222',self.joinOK)
		if vsCount == 16 then
			if not GameRoomCardMatchCtrl.isCreate then
				GameRoomCardMatchCtrl:Open("GameRoomCardMatch",function()
					GameRoomCardMatchPanel.btn16TuiSai:SetActive(true)
					GameRoomCardMatchPanel.btn16BaoMing:SetActive(false)
					self:SetText(GameRoomCardMatchPanel.txtBaoMing,joinCount)
				end)
			else
				GameRoomCardMatchPanel.btn16TuiSai:SetActive(true)
				GameRoomCardMatchPanel.btn16BaoMing:SetActive(false)
				self:SetText(GameRoomCardMatchPanel.txtBaoMing,joinCount)
			end
		elseif vsCount == 8 then
			if not GameRoomCardMatchCtrl.isCreate then
				GameRoomCardMatchCtrl:Open("GameRoomCardMatch",function()
					GameRoomCardMatchPanel.btn8TuiSai:SetActive(true)
					GameRoomCardMatchPanel.btn8BaoMing:SetActive(false)
					self:SetText(GameRoomCardMatchPanel.txt8BaoMing,joinCount)
				end)
			else
				GameRoomCardMatchPanel.btn8TuiSai:SetActive(true)
				GameRoomCardMatchPanel.btn8BaoMing:SetActive(false)
				self:SetText(GameRoomCardMatchPanel.txt8BaoMing,joinCount)
			end
		elseif vsCount == 4 then
			if not GameRoomCardMatchCtrl.isCreate then
				GameRoomCardMatchCtrl:Open("GameRoomCardMatch",function()
					GameRoomCardMatchPanel.btn4TuiSai:SetActive(true)
					GameRoomCardMatchPanel.btn4BaoMing:SetActive(false)
					self:SetText(GameRoomCardMatchPanel.txt4BaoMing,joinCount)
				end)
			else
				GameRoomCardMatchPanel.btn4TuiSai:SetActive(true)
				GameRoomCardMatchPanel.btn4BaoMing:SetActive(false)
				self:SetText(GameRoomCardMatchPanel.txt4BaoMing,joinCount)
			end
		end	
	end
	print('GameRoomCardMatchCtrl.VsJoinRes3333333333333333',self.joinOK)
end

function GameRoomCardMatchCtrl.OnRoomCardMatchQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = GameRoomCardMatchCtrl
	if self.joinOK == true then
		GameRoomCardMatchPanel.btn16TuiSai:SetActive(false)
		GameRoomCardMatchPanel.btn16BaoMing:SetActive(true)
		GameRoomCardMatchPanel.btn8TuiSai:SetActive(false)
		GameRoomCardMatchPanel.btn8BaoMing:SetActive(true)
		GameRoomCardMatchPanel.btn4TuiSai:SetActive(false)
		GameRoomCardMatchPanel.btn4BaoMing:SetActive(true)
		local msg = ""
		Game.SendProtocal(Protocal.VsQuit, msg)
		self.joinOK = false
	end
	self:CancelInvoke("VsGetJoinCount16")
	self:CancelInvoke("VsGetJoinCount8")
	self:CancelInvoke("VsGetJoinCount4")
	self:Close(true)
end

function GameRoomCardMatchCtrl.OnRoomCardMatchHeadIconBtnClick()
	local roleInfo = {}
	Game.MusicEffect(Game.Effect.joinRoom)
	roleInfo = {name = global.userVo.name,roleId = global.userVo.roleId, roleIp = global.userVo.roleIp,image = GameRoomCardMatchPanel.imgHeadIcon}
	RoleInfoCtrl:Open("RoleInfo",function()
		RoleInfoCtrl:InitPanel(roleInfo)
	end)
end

function GameRoomCardMatchCtrl.OnDiamondPayClick()
	Game.MusicEffect(Game.Effect.joinRoom)
	DiamondPayCtrl:Open("DiamondPay")
end

--刷新信息
function GameRoomCardMatchCtrl:RefreshPanel(userInfo,name)
	print("===============RefreshPanel==========",name)
	self = GameRoomCardMatchCtrl
	self:SetText(GameRoomCardMatchPanel.txtRoomCardMatchRoleID,"ID:" .. userInfo.roleId)
	self:SetText(GameRoomCardMatchPanel.txtRoomCardMatchRoleName,userInfo.name)
	self:SetText(GameRoomCardMatchPanel.txtFangKaMatchRoomCardNum,userInfo.diamond)
end

--提示
function GameRoomCardMatchCtrl.ChatTips()
	self = GameRoomCardMatchCtrl
	GameRoomCardMatchPanel.imgTips:SetActive(true)
	coroutine.start(self.ChatWait)
end
function GameRoomCardMatchCtrl.ChatWait()
	coroutine.wait(1.8)
	if GameRoomCardMatchCtrl.isCreate then
		GameRoomCardMatchPanel.imgTips:SetActive(false)
	end
end

function GameRoomCardMatchCtrl.SetIconTips(str,bool)
	self = GameRoomCardMatchCtrl
	if bool == nil then
		if GameRoomCardMatchPanel.imgTips.activeSelf == true then return end
		self.ChatTips()
		local tipsText =  BasePanel:GOChild(GameRoomCardMatchPanel.imgTips,"Name")
		local tipsPos = Vector3.New(0,-172.8,3782)
		local sequence = DG.Tweening.DOTween.Sequence()
		sequence:Append(GameRoomCardMatchPanel.imgTips.transform:DOLocalMoveY(tipsPos.y+50, 2, false))
				:OnComplete(function()
				GameRoomCardMatchPanel.imgTips.transform.localPosition = tipsPos
				end)
		self:SetText(tipsText,str)
	elseif bool == true then
		local tipsText =  BasePanel:GOChild(GameRoomCardMatchPanel.imgTips,"Name")
		local tipsPos = Vector3.New(0,-130,3782)
		GameRoomCardMatchPanel.imgTips.transform.localPosition = tipsPos
		GameRoomCardMatchPanel.imgTips:SetActive(true)
		self:SetText(tipsText,str)
	else
		GameRoomCardMatchPanel.imgTips:SetActive(false)
	end
end

--比赛场开始回调
function GameRoomCardMatchCtrl.VsStartRes(buffer)
	local data   = buffer:ReadBuffer();
	local msg    = VsCacheData_pb.VsCacheDataRes();	
	msg:ParseFromString(data);
	Room.gameType = msg.gameType

	if msg.gameType == 1 then
		data = VsCacheData_pb.VsMahjongInfo()
		data:ParseFromString(msg.dataRes)

		global.roomVo = RoomVo:New();
		global.roomVo.id = data.roomNum;
		global.roomVo.total = data.jushu;
		global.roomVo.isPlayNum = #data.vsCacheDataInfo;
		global.roomVo.lun	   = data.lun
		global.roomVo.vscount  = data.vscount
		--这个标记是用来识别比赛场的
		global.roomVo.isFangzhu  = 3
		if data.zimohu == true then
			global.roomVo.isSelf = 1
		elseif data.zimohu == false then
			global.roomVo.isSelf = 2
		end

		if data.feng == true then
			global.roomVo.isFeng = 1
		elseif data.feng == false then
			global.roomVo.isFeng = 2
		end

		if data.hongzhong == true then
			global.roomVo.isRed = 1
		elseif data.hongzhong == false then
			global.roomVo.isRed = 2
		end

		global.roomVo.isFishNum = data.yu;

		local text4,text3,text2,text1

		if global.roomVo.isFishNum == 0 then
			text4 = '不下鱼'
		else 
			text4 = global.roomVo.isFishNum.."条鱼"
		end

		if global.roomVo.isSelf == 1 then
			text3 = "自摸胡"
		else
			text3 = '点炮胡'
		end
		if global.roomVo.isFeng == 1 then
			text2 = "无风牌"
		else
			text2 = '有风牌'
		end
		if global.roomVo.isRed == 1 then
			text1 = '红中麻将'
			
		else
			text1 = "推倒胡"
		end

		global.roomVo.playMethod = text1.."  "..text2.."  "..text3.."\n".."\t\t      "..text4.."  鱼吃鱼"

		local userInfos = data.vsCacheDataInfo;
		global.joinRoomUserVos = {}
		global.setPosition = {}
		for _,v in ipairs(userInfos) do
			local joinRoomUserVo     = JoinRoomUserVo:New();
			joinRoomUserVo.index     = v.index;
			joinRoomUserVo.roleId    = v.roleId;
			joinRoomUserVo.name      = v.name;
			joinRoomUserVo.ip        = v.ip;
			joinRoomUserVo.headImg   = v.headImg;	
			joinRoomUserVo.jifen     = v.jifen
			joinRoomUserVo.diamond	 = v.diamond
			joinRoomUserVo.gender 	 = v.gender
			joinRoomUserVo.curPaiMing 	 = v.curPaiMing
			global.joinRoomUserVos[v.index] = joinRoomUserVo;
			global.setPosition[v.index] = joinRoomUserVo
			print("global.joinRoomUserVo=curPaiMing===",joinRoomUserVo.curPaiMing,v.curPaiMing)
		end

		local self = GameRoomCardMatchCtrl;
		self:OnVSStartInfoShow();
		local co = coroutine.start(self.CloseMatchRankList)
		table.insert(Network.crts, co)

		if GameQuitMatchHintCtrl.isCreate then
			GameQuitMatchHintCtrl:Close()
		end

		local co = coroutine.start(self.CloseSingleSettlement)
		table.insert(Network.crts, co)

		Game.MusicEffect(Game.Effect.joinRoom)
		Game.LoadScene("mahjong")
	elseif msg.gameType == 2 then
	end
end

function GameRoomCardMatchCtrl:OnVSStartInfoShow()
	if Game.GetSceneName() == "main" then
		self:Close();
		GameMatchCtrl:Close()
		MainSenceCtrl:Close()
		RoleInfoCtrl:Close()
		Game.LoadScene("mahjong")
	end
	local isPlayNum = global.roomVo.isPlayNum
	if #global.joinRoomUserVos == isPlayNum then
		if global.joinRoomUserVos[isPlayNum].roleId == global.userVo.roleId then
			Mahjong.isLastJoin = true
		end
	end
end

function GameRoomCardMatchCtrl:CloseMatchRankList()
	coroutine.wait(2)
	if GameMatchRankListCtrl.isCreate then
		GameMatchRankListCtrl:Close()
	end
end

function GameRoomCardMatchCtrl:CloseSingleSettlement()
	local co = coroutine.start(function ()
		while not SingleSettlementCtrl.isCreate do
			coroutine.step()
		end
		coroutine.wait(5)
		SingleSettlementCtrl:Close()
	end)
end


