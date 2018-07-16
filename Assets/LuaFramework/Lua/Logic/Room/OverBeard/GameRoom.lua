require "Common/define"
require "Common/msgDefine"
require "Common/functions"
require "Logic/Room/Mahjong/MahjongCard"
require "3rd/pblua/ChessInfo_pb"
require "3rd/pblua/InitChesses_pb"
require "3rd/pblua/MoChess_pb"

require "Model/Vo/ChessInfoVo"
require "Model/Vo/MoChess"
require "Logic/Room/RoomStatic/RoomInitStatic"
require "Logic/Room/RoomStatic/RoomDealStatic"
require "Logic/Room/RoomStatic/RoomRunStatic"
require "Logic/Room/RoomStatic/RoomSettlementStatic"

GameRoom = {
	gameObjContainer = nil,
	-- 游戏对象容器；
	gameObjTable = nil,
	-- 桌子对象
	gameObjShaizi = nil,
	-- 骰子
	gameObjHand = { },
	-- 手
	gameObjCardContainer = nil,
	-- 牌容器；
	publicCards = { },
	-- 公共牌列表；
	myCards = { },
	-- 我的牌列表；
	-- 用于回放
	rightCards = { },
	-- 右边的牌列表
	upCards = { },
	-- 对面的牌列表
	leftCards = { },
	-- 左边的牌列表

	curStatic = 0,
	-- 0，1初始化 2发牌 3摸牌，打牌，碰杠胡 4结算
	fms = { },
	initInfo = { },
	posIndex = { },
	-- 角色索引，对应的公共牌基础索引；

	myPosIndex = 1,
	-- 主角位置索引；
	cardTotal = 0,
	-- 牌总数；
	canvas = nil,
	-- 画布；
	colorCardList = { },
	-- 选牌变色的列表
	cardColor = nil,
	-- 牌原来的颜色
	changeCard = { },
	-- 牌颜色要还原的列表
	myUiCards = { },
	ModelList = { },
	-- 手的实体列表
	HandPos = nil,
	myPlayCards = { },
	-- 我打下去的牌列表
	LPlayCards = { },
	-- 左边打下去的牌
	RPlayCards = { },
	-- 右边打下去的牌
	UPlayCards = { },
	-- 对面打下去的牌

	Container = nil,
	-- 所有实体牌的容器
	playGameObjContainer = nil,
	-- 打下去牌容器
	curMoCardStatic = 0,
	-- 当前摸牌的状态
	curSignType = { },
	-- 当前标签类型

	myPengGangCards = { },
	-- 我碰杠的牌列表
	leftPengGangCards = { },
	rightPengGangCards = { },
	oppsPengGangCards = { },

	myPengGangCardCountTable = { },
	-- 我碰杠牌的次数列表（初始化要删除）

	PengGangCards = { },
	-- 所有碰杠的牌列表(初始化要删除)
	pengGangGameObjContainer = nil,
	-- 碰杠的牌容器

	myContainer = nil,
	-- 我打下去牌容器
	LContainer = nil,
	-- 左边容器
	RContainer = nil,
	-- 右边容器
	UContainer = nil,
	-- 对面容器

	curCardIndex = 0,
	-- 当前卡片索引
	lastCardIndex = 0,
	-- 最后一张牌的索引
	selfEmoticonObject = nil,
	-- 自己表情对象
	rightEmoticonObject = nil,
	-- 右边表情对象
	upEmoticonObject = nil,
	-- 上边表情对象
	leftEmoticonObject = nil,
	-- 左边表情对象
	curJushu = 0,
	-- 当前局数
	isOnes = false,
	-- 是否第一局

	PlayModelCardDMap = { },
	-- 自己打下去的模型列表
	PlayModelCardRMap = { },
	-- 右边打下去的模型列表
	PlayModelCardLMap = { },
	-- 左边打下去的模型列表
	PlayModelCardUMap = { },
	-- 对面打下去的模型列表

	myPengGangModelChardMap = { },
	-- 自己碰杠的模型列表
	leftPengGangModelChardMap = { },
	-- 左边碰杠的模型列表
	rightPengGangModelChardMap = { },
	-- 右边碰杠的模型列表
	oppsPengGangModelChardMap = { },
	-- 对面碰杠的模型列表

	HandAnList = { D = { }, R = { }, U = { }, L = { } },
	-- 按骰子
	ShaiziPos = { },
	-- 骰子点数

	moPaiLeftPos = Vector3.New(29.15,- 8,- 1.13),
	-- 0   90  0
	moPaiRightPos = Vector3.New(37.6,- 8,3.742),
	-- 180 90  180
	moPaiOppsPos = Vector3.New(30.78,- 8,4.5),
	-- 0   180 0
	myModelChardMap = { },
	-- 自己手里的模型列表
	leftModelChardMap = { },
	-- 左边手里的模型列表
	rightModelChardMap = { },
	-- 右边手里的模型列表
	upModelChardMap = { },
	-- 对面手里的模型列表

	downCardList = { },
	-- 牌局结束列表
	canPlayCardTingCardTable = { },
	-- 听牌提示(可以打掉的牌)
	huCardTingCardTable = { },
	-- 听牌提示（具体胡牌）
	TingCardSignObject = { },
	TingCardNeiKuangObject = { },
	TingCardCanHuObject = { },
	animatorList = { },
	lastType = nil,
	lastIndex = nil,
	uiCardGrid = nil,
	tingCardSign = nil,
	objMoCard = nil,
	objDaCard = nil,
	mahjongObjList = { },
	resCount = 0,
	needResCount = 7,
	isWin = 0,
	objtxtTitle = nil,
	objtxtRoomNum = nil,
	objtxtMethod = nil,
	loadObjCount = 0,
	needLoadObjCount = 5,
	objDNXB = nil,
	DDong = nil,
	DXi = nil,
	DNan = nil,
	DBei = nil,
	DOpen = nil,
	DClose = nil,
	txtCountDown = nil,
	objLight = nil,
	objSanren = nil,
	objHuCard = nil,
	objtxtTuoguan = nil,
	objtxtDiZhuAndJinrutiaojian = nil,
	trusteeshipRoleIDS = { },
	-- 血战麻将
	referCards = { },
	-- 推荐牌组
	noReferCards = { },-- 不可用牌组
}

local this = GameRoom

function GameRoom.New()
	-- 初始化索引
	this.posIndex[1] = 0
	this.posIndex[2] = 0
	this.posIndex[3] = 0
	this.posIndex[4] = 0

	-- 获取组件
	this.gameObjContainer = find('Container/GameObjContainer')
	this.gameObjContainer.transform.position = Vector3.New(1000, 1000, 1000)
	this.canvas = find('Canvas')

	this.gameObjCardContainer = find("GameObjContainer/CardContainer")
	this.Container = find('Container')
	this.playGameObjContainer = find('Container/PlayGameObjContainer')
	this.pengGangGameObjContainer = find('Container/pengGangGameObjContainer')


	this.myContainer = find('Container/myContainer')
	this.LContainer = find('Container/LContainer')
	this.RContainer = find('Container/RContainer')
	this.UContainer = find('Container/UContainer')
	this.HandPos = find('Container/HandPos')
	-- 按骰子手的坐标
	this.HandAnList.D[1] = Vector3.New(33.8, -5.5, -12)
	this.HandAnList.D[2] = Vector3.New(33.8, -6.5, -6.33)
	this.HandAnList.R[1] = Vector3.New(46, -5.5, 1.08)
	this.HandAnList.R[2] = Vector3.New(40.25, -6.5, 1.08)
	this.HandAnList.U[1] = Vector3.New(33, -5.5, 12)
	this.HandAnList.U[2] = Vector3.New(33, -6.5, 7.6)
	this.HandAnList.L[1] = Vector3.New(20, -5.5, 0.3)
	this.HandAnList.L[2] = Vector3.New(26.6, -6.5, 0.3)
	this.uiCardGrid = find('Canvas/GuiCamera')

	-- 监听事件
	Event.AddListener(MsgDefine.Room_Enter, this.OnEnter)
	Event.AddListener(MsgDefine.Room_Exit, this.Exit)

	this.isPrefabLoaded = false
	GameRoom.SaveLoadPrefab()
	print('GameRoom.SaveLoadPrefab======', this.resCount, this.needResCount)
	if this.resCount == this.needResCount then
		GameRoom.LoadRoomPrefab()
	end
	print("=======time1", os.time())

	-- 初始化状态机
	this.fms[RoomStatic.InitStatic] = RoomInitStatic.New()
	this.fms[RoomStatic.DealStatic] = RoomDealStatic.New()
	this.fms[RoomStatic.RunStatic] = RoomRunStatic.New()
	this.fms[RoomStatic.SettlementStatic] = RoomSettlementStatic.New()
	this.changeStatic(RoomStatic.NoneStatic)
	if GradeDetailCtrl.isPlayBackCurrentJushu then
		GradeDetailCtrl.isPlayBackCurrentJushu = false
	else
		this.curJushu = 0
	end
	this.trusteeshipRoleIDS = { }
	this.isOnes = true
	DissolutionRoomCtrl.gameOver = false
	return this
end

-- 改变状态
function GameRoom.changeStatic(static, ...)
	print('=====GameRoom.changeStatic', static)
	this.curStatic = static
	if not this.fms[static] then return end
	local isCanEnter = this.fms[static].isEnter(...)
	if isCanEnter == false then
		return
	end
	local oldStatic = this.fms[this.curStatic]
	if oldStatic ~= nil then
		oldStatic.Exit()
	end
	this.fms[this.curStatic].Enter()
end

-- 进入房间；
function GameRoom.OnEnter()
	print('GameRoom.OnEnter111111111')
	this.moPaiLeftPos = Vector3.New(29.15, -9, -1.13)
	-- 0   90  0
	this.moPaiRightPos = Vector3.New(37.6, -9, 3.742)
	-- 180 90  180
	this.moPaiOppsPos = Vector3.New(30.78, -9, 4.5),
	-- 0   180 0
	this.changeStatic(RoomStatic.InitStatic)
end

function GameRoom.Update()
	local curStaticCls = this.fms[this.curStatic]
	if curStaticCls ~= nil then
		curStaticCls.Update()
	end
end

-- 退出
function GameRoom.Exit()
	print('GameRoom.Exit111111111')
	Event.RemoveListener(MsgDefine.Room_Enter, this.OnEnter)
	Event.RemoveListener(MsgDefine.Room_Exit, this.Exit)

	if RoomInitStatic.shaiziCo then
		coroutine.stop(RoomInitStatic.shaiziCo)
		RoomInitStatic.shaiziCo = nil
	end

	Game.isReloadBattle = false
end

function GameRoom.GetRoomObj(name)
	for k, v in pairs(this.mahjongObjList) do
		if name == k then
			return v
		end
	end
end

-- 缓存物体
function GameRoom.SaveLoadPrefab()
	print("------------Save---------------mahjongObjList")
	if not this.mahjongObjList["MahjongTableObj"] then
		print("====SaveLoadPrefab111====:")
		resMgr:LoadPrefab('mahjongtable', { "MahjongTableObj" }, function(objs)
			this.OnCreateTable(objs, "MahjongTableObj")
		end )
	end

	if not this.mahjongObjList["ShaiziObj"] then
		print("====SaveLoadPrefab222===:")
		resMgr:LoadPrefab('mahjongtable', { "ShaiziObj" }, function(objs)
			this.OnCreateShaizi(objs, "ShaiziObj")
		end )
	end

	if not this.mahjongObjList["Hand"] then
		print("====SaveLoadPrefab3333===:")
		resMgr:LoadPrefab('mahjongtable', { "Hand" }, function(objs)
			this.OnCreateHand(objs, "Hand")
		end )
	end

	if not this.mahjongObjList["MahjongCardObj"] then
		print("====SaveLoadPrefab444===:")
		resMgr:LoadPrefab('mahjongcard', { "MahjongCardObj" }, function(objs)
			this.OnCreateCard(objs, "MahjongCardObj")
		end )
	end

	if not this.mahjongObjList["tingSign"] then
		print("====SaveLoadPrefab5555===:")
		resMgr:LoadPrefab('uimahjongprefabs', { "tingSign" }, function(objs)
			this.OnCreateTingCardSign(objs, "tingSign")
		end )
	end
	Game.UICardList()
end

-- 加载物体
function GameRoom.LoadRoomPrefab()
	print("====LoadRoomPrefab====")
	-- 加载桌子
	this.LoadTable(this.GetRoomObj("MahjongTableObj"))
	-- 加载骰子
	this.LoadShaizi(this.GetRoomObj("ShaiziObj"))
	-- 加载手
	this.LoadHand(this.GetRoomObj("Hand"))
	-- 加载公共牌
	this.LoadMajongCard(this.GetRoomObj("MahjongCardObj"))
	-- 加载听牌提示
	this.LoadTingPai(this.GetRoomObj("tingSign"))
	if OB_GameMainCtrl.isCreate then
		OB_GameMainCtrl.SetTableText()
	end

	local co = coroutine.start( function()
		while this.loadObjCount < this.needLoadObjCount do
			print('LoadRoomPrefab===11111111', this.loadObjCount, this.needLoadObjCoun)
			coroutine.step()
		end
		print('LoadRoomPrefab===333333333', this.loadObjCount, this.needLoadObjCoun)
		print("LoadRoomPrefab===", GradeDetailCtrl.isPlayBack, Game.isReloadBattle, Mahjong.isLastJoin)
		if GradeDetailCtrl.isPlayBack == true then
			GradeDetailCtrl.isPlayBack = false
		else
			print("<color=#fffc16>-------LoadRoomPrefab==-------</color>", Room.gameType, GradeDetailCtrl.isPlayBack, Game.isReloadBattle, Mahjong.isLastJoin)
			if not Game.isReloadBattle and(not Mahjong.isLastJoin) then
				if Room.gameType == RoomType.Mahjong then
					OB_GameMainCtrl:Open("OB_GameMain")
				elseif Room.gameType == RoomType.BattleMahjong then
					XZ_GameMainCtrl:Open("XZ_GameMain")
				else
					RM_GameMainCtrl:Open("RM_GameMain")
				end
				this.loadObjCount = 0
			end
		end
	end )
	table.insert(Network.crts, co)
	Mahjong.isLastJoin = false
	this.isPrefabLoaded = true
end
-- 缓存
function GameRoom.OnCreateTable(objs, name)
	print("====OnCreateTable====:", this.mahjongObjList[name])
	if this.mahjongObjList[name] then return end
	this.mahjongObjList[name] = objs[0]
	this:ResourceCheckOver(name)
	print("====OnCreateTable====:", this.mahjongObjList[name].name)
end

function GameRoom.OnCreateShaizi(objs, name)
	if this.mahjongObjList[name] then return end
	this.mahjongObjList[name] = objs[0]
	this:ResourceCheckOver(name)
end

function GameRoom.OnCreateHand(objs, name)
	if this.mahjongObjList[name] then return end
	this.mahjongObjList["Hand"] = objs[0]
	this:ResourceCheckOver(name)
end

function GameRoom.OnCreateCard(objs, name)
	if this.mahjongObjList[name] then return end
	this.mahjongObjList["MahjongCardObj"] = objs[0]
	this:ResourceCheckOver(name)
end

function GameRoom.OnCreateTingCardSign(objs, name)
	if this.mahjongObjList[name] then return end
	this.mahjongObjList[name] = objs[0]
	this:ResourceCheckOver(name)
end

function GameRoom:ResourceCheckOver(name)
	self.resCount = self.resCount + 1
	print("============ResourceCheckOver", self.resCount, name)
	if self.resCount == self.needResCount then
		-- if not Game.isReloadBattle then
		-- 	Game.SendProtocal(Protocal.ResLoaded)
		-- end
		GameRoom.LoadRoomPrefab()
	end
end

function GameRoom:LoadPrefabOver(name)
	self.loadObjCount = self.loadObjCount + 1
	print("============LoadObjCheckOver", self.loadObjCount, name)
end
-- 加载
function GameRoom.LoadTable(objs)
	this.gameObjTable = newObject(objs)
	this.gameObjTable.transform:SetParent(this.gameObjContainer.transform)
	this.gameObjTable.name = 'MahjongTableObj'
	this.gameObjTable.transform.localScale = Vector3.New(1.2, 1.2, 1.2)
	this.gameObjTable.transform.position = Vector3.New(33.35, -9.39, 1.08)
	this.objtxtTitle = find("Container/GameObjContainer/MahjongTableObj/Canvas/txtTitle")
	this.objtxtRoomNum = find("Container/GameObjContainer/MahjongTableObj/Canvas/txtRoomNum")
	this.objtxtMethod = find("Container/GameObjContainer/MahjongTableObj/Canvas/txtPlayMethod")
	this.objDNXB = find("Container/GameObjContainer/MahjongTableObj/Canvas/imgDXNBBG")
	this.DDong = find("Container/GameObjContainer/MahjongTableObj/Canvas/imgDXNBBG/DDong")
	this.DXi = find("Container/GameObjContainer/MahjongTableObj/Canvas/imgDXNBBG/DXi")
	this.DNan = find("Container/GameObjContainer/MahjongTableObj/Canvas/imgDXNBBG/DNan")
	this.DBei = find("Container/GameObjContainer/MahjongTableObj/Canvas/imgDXNBBG/DBei")
	this.DOpen = find("Container/GameObjContainer/MahjongTableObj/Canvas/imgDXNBBG/DOpen")
	this.DClose = find("Container/GameObjContainer/MahjongTableObj/Canvas/imgDXNBBG/DClose")
	this.txtCountDown = find("Container/GameObjContainer/MahjongTableObj/Canvas/txtCountDown")
	this.objLight = find("Container/GameObjContainer/MahjongTableObj/Canvas/imgDXNBBG/Light")
	this.objSanren = find("Container/GameObjContainer/MahjongTableObj/Canvas/imgDXNBBG/Sanren")
	-- 新添加
	this.objtxtTuoguan = find("Container/GameObjContainer/MahjongTableObj/Canvas/txtTuoguan")
	this.objtxtDiZhuAndJinrutiaojian = find("Container/GameObjContainer/MahjongTableObj/Canvas/txtDiZhuAndJinrutiaojian")
	GameRoom:LoadPrefabOver("LoadTable")
end

function GameRoom.LoadShaizi(objs)
	this.gameObjShaizi = newObject(objs)
	this.gameObjShaizi.name = 'Shaizi'
	if this.gameObjShaizi ~= nil and this.gameObjContainer ~= nil then
		this.gameObjShaizi.transform:SetParent(this.gameObjContainer.transform)
		this.gameObjShaizi.transform.localScale = Vector3.New(1.3, 1.3, 1.3)
		this.gameObjShaizi.transform.localPosition = Vector3.zero
		this.ShaiziPos[1] = Vector3.New(-90, 0, 0)
		this.ShaiziPos[2] = Vector3.New(180, 0, 90)
		this.ShaiziPos[3] = Vector3.New(0, 0, 0)
		this.ShaiziPos[4] = Vector3.New(180, 0, 0)
		this.ShaiziPos[5] = Vector3.New(0, 0, 90)
		this.ShaiziPos[6] = Vector3.New(90, 0, 0)
	end
	GameRoom:LoadPrefabOver("LoadShaizi")
end

function GameRoom.LoadHand(objs)
	for i = 1, 4 do
		this.gameObjHand[i] = newObject(objs)
		this.gameObjHand[i].name = 'Hand' .. i
		this.gameObjHand[i].transform:SetParent(this.HandPos.transform)
		this.gameObjHand[i].transform.localScale = Vector3.New(1000, 1000, 1000)
		this.animatorList[i] = this.gameObjHand[i].transform:GetComponent('Animator')
	end
	this.gameObjHand[1].transform.rotation = Quaternion.Euler(Vector3.New(0, -90, 0))
	this.gameObjHand[1].transform.localPosition = this.HandAnList.D[1]
	this.gameObjHand[2].transform.rotation = Quaternion.Euler(Vector3.New(0, -180, 0))
	this.gameObjHand[2].transform.localPosition = this.HandAnList.R[1]
	this.gameObjHand[3].transform.rotation = Quaternion.Euler(Vector3.New(0, 90, 0))
	this.gameObjHand[3].transform.localPosition = this.HandAnList.U[1]
	this.gameObjHand[4].transform.rotation = Quaternion.Euler(Vector3.New(0, 0, 0))
	this.gameObjHand[4].transform.localPosition = this.HandAnList.L[1]
	GameRoom:LoadPrefabOver("LoadHand")
end

function GameRoom.LoadMajongCard(objs)
	this.gameObjCardContainer:SetActive(true)
	this.objHuCard = newObject(objs)
	this.objHuCard.transform.parent = this.gameObjCardContainer.transform
	this.objHuCard.transform.localScale = Vector3.New(1.1, 1.1, 1.1)
	this.objHuCard.transform.localPosition = Vector3.New(1000, 1000, 1000)
	this.objHuCard.name = "huCard"
	for i = 0, 139 do
		local obj = newObject(objs)
		local card = MahjongCard:New()
		card.static = 0
		card.gameObject = obj
		card.transform = obj.transform
		card.index = i
		card.transform.parent = this.gameObjCardContainer.transform
		-- 将层级设置为Card层
		card.gameObject.layer = LayerMask.NameToLayer("Card")
		card.transform.localScale = Vector3.New(1.1, 1.1, 1.1)
		obj:SetActive(false)
		this.publicCards[i] = card
	end
	GameRoom:LoadPrefabOver("LoadMajongCard")
end

function GameRoom.LoadTingPai(objs)
	local obj = newObject(objs)
	obj.transform:SetParent(this.uiCardGrid.transform)
	obj.transform.localPosition = Vector3.New(300, 500, 0)
	obj.transform.localScale = Vector3.New(1, 1, 1)
	this.tingCardSign = obj
	GameRoom:LoadPrefabOver("LoadTingPai")
end

-- 初始化牌回调
function GameRoom.OnInitRes(buffer)
	DissolutionRoomTipsCtrl:Close(true)
	-- 清理初始化牌数据
	this.colorCardList = { }
	this.changeCard = { }
	this.canPlayCard = false
	RoomRunStatic.IsBiHu = false
	if next(this.myCards) ~= nil then
		local len = table.maxn(this.myCards)
		for i = len, 1, -1 do
			table.remove(this.myCards, i)
		end
	end

	if next(this.myModelChardMap) ~= nil then
		local len = table.maxn(this.myModelChardMap)
		for i = len, 1, -1 do
			if this.myModelChardMap[i].gameObject then
				this.myModelChardMap[i].gameObject:Destroy()
			end
			table.remove(this.myModelChardMap, i)
		end
	end

	-- 清理UI牌数据以及对象
	if next(gameRoom.myUiCards) ~= nil then
		local len = table.maxn(gameRoom.myUiCards)
		for i = len, 1, -1 do
			if gameRoom.myUiCards[i].gameObject then
				-- local luaBehavi = gameRoom.canvas.transform:GetComponent('LuaBehaviour')
				-- luaBehavi:RemoveClick(gameRoom.myUiCards[i].gameObject)
				gameRoom.myUiCards[i].gameObject:Destroy()
			end
			table.remove(gameRoom.myUiCards, i)
		end
	end


	-- 清理打下去的牌数据
	if next(this.myPlayCards) ~= nil then
		local len = table.maxn(this.myPlayCards)
		for i = len, 1, -1 do
			table.remove(this.myPlayCards, i)
		end
	end

	if next(this.LPlayCards) ~= nil then
		local len = table.maxn(this.LPlayCards)
		for i = len, 1, -1 do
			table.remove(this.LPlayCards, i)
		end
	end

	if next(this.RPlayCards) ~= nil then
		local len = table.maxn(this.RPlayCards)
		for i = len, 1, -1 do
			table.remove(this.RPlayCards, i)
		end
	end

	if next(this.UPlayCards) ~= nil then
		local len = table.maxn(this.UPlayCards)
		for i = len, 1, -1 do
			table.remove(this.UPlayCards, i)
		end
	end

	-- 清理打下去的牌模型
	if next(this.PlayModelCardDMap) ~= nil then
		local len = table.maxn(this.PlayModelCardDMap)
		for i = len, 1, -1 do
			if this.PlayModelCardDMap[i].gameObject then
				this.PlayModelCardDMap[i].gameObject:Destroy()
			end
			table.remove(this.PlayModelCardDMap, i)
		end
	end

	if next(this.PlayModelCardRMap) ~= nil then
		local len = table.maxn(this.PlayModelCardRMap)
		for i = len, 1, -1 do
			if this.PlayModelCardRMap[i].gameObject then
				this.PlayModelCardRMap[i].gameObject:Destroy()
			end
			table.remove(this.PlayModelCardRMap, i)
		end
	end

	if next(this.PlayModelCardLMap) ~= nil then
		local len = table.maxn(this.PlayModelCardLMap)
		for i = len, 1, -1 do
			if this.PlayModelCardLMap[i].gameObject then
				this.PlayModelCardLMap[i].gameObject:Destroy()
			end
			table.remove(this.PlayModelCardLMap, i)
		end
	end

	if next(this.PlayModelCardUMap) ~= nil then
		local len = table.maxn(this.PlayModelCardUMap)
		for i = len, 1, -1 do
			if this.PlayModelCardUMap[i].gameObject then
				this.PlayModelCardUMap[i].gameObject:Destroy()
			end
			table.remove(this.PlayModelCardUMap, i)
		end
	end

	if next(this.leftModelChardMap) ~= nil then
		local len = #this.leftModelChardMap
		for i = len, 1, -1 do
			table.remove(this.leftModelChardMap, i)
		end
	end

	if next(this.rightModelChardMap) ~= nil then
		local len = #this.rightModelChardMap
		for i = len, 1, -1 do
			table.remove(this.rightModelChardMap, i)
		end
	end

	if next(this.upModelChardMap) ~= nil then
		local len = #this.upModelChardMap
		for i = len, 1, -1 do
			table.remove(this.upModelChardMap, i)
		end
	end

	-- 清理碰杠牌数据
	if next(this.myPengGangCards) ~= nil then
		local len = table.maxn(this.myPengGangCards)
		for i = len, 1, -1 do
			table.remove(this.myPengGangCards, i)
		end
	end

	if next(this.leftPengGangCards) ~= nil then
		local len = table.maxn(this.leftPengGangCards)
		for i = len, 1, -1 do
			table.remove(this.leftPengGangCards, i)
		end
	end

	if next(this.rightPengGangCards) ~= nil then
		local len = table.maxn(this.rightPengGangCards)
		for i = len, 1, -1 do
			table.remove(this.rightPengGangCards, i)
		end
	end

	if next(this.oppsPengGangCards) ~= nil then
		local len = table.maxn(this.oppsPengGangCards)
		for i = len, 1, -1 do
			table.remove(this.oppsPengGangCards, i)
		end
	end

	if next(gameRoom.PengGangCards) ~= nil then
		local len = table.maxn(gameRoom.PengGangCards)
		for i = len, 1, -1 do
			table.remove(gameRoom.PengGangCards, i)
		end
	end

	if next(gameRoom.myPengGangCardCountTable) ~= nil then
		local len = table.maxn(gameRoom.myPengGangCardCountTable)
		for i = len, 1, -1 do
			table.remove(gameRoom.myPengGangCardCountTable, i)
		end
	end

	-- 清理碰杠牌模型
	if next(this.myPengGangModelChardMap) ~= nil then
		local len = table.maxn(this.myPengGangModelChardMap)
		for i = len, 1, -1 do
			if this.myPengGangModelChardMap[i].gameObject then
				this.myPengGangModelChardMap[i].gameObject:Destroy()
			end
			table.remove(this.myPengGangModelChardMap, i)
		end
	end

	if next(this.leftPengGangModelChardMap) ~= nil then
		local len = table.maxn(this.leftPengGangModelChardMap)
		for i = len, 1, -1 do
			if this.leftPengGangModelChardMap[i].gameObject then
				this.leftPengGangModelChardMap[i].gameObject:Destroy()
			end
			table.remove(this.leftPengGangModelChardMap, i)
		end
	end

	if next(this.rightPengGangModelChardMap) ~= nil then
		local len = table.maxn(this.rightPengGangModelChardMap)
		for i = len, 1, -1 do
			if this.rightPengGangModelChardMap[i].gameObject then
				this.rightPengGangModelChardMap[i].gameObject:Destroy()
			end
			table.remove(this.rightPengGangModelChardMap, i)
		end
	end

	if next(this.oppsPengGangModelChardMap) ~= nil then
		local len = table.maxn(this.oppsPengGangModelChardMap)
		for i = len, 1, -1 do
			if this.oppsPengGangModelChardMap[i].gameObject then
				this.oppsPengGangModelChardMap[i].gameObject:Destroy()
			end
			table.remove(this.oppsPengGangModelChardMap, i)
		end
	end
	this.colorCardList = { }
	global.signOperateChess = { }
	this.huCardTingCardTable = { }
	this.canPlayCardTingCardTable = { }
	if next(gameRoom.TingCardSignObject) ~= nil then
		local len = table.maxn(gameRoom.TingCardSignObject)
		for i = len, 1, -1 do
			if gameRoom.TingCardSignObject[i].gameObject then
				gameRoom.TingCardSignObject[i].gameObject:Destroy()
			end
			table.remove(gameRoom.TingCardSignObject, i)
		end
	end
	if next(gameRoom.TingCardNeiKuangObject) ~= nil then
		local len = table.maxn(gameRoom.TingCardNeiKuangObject)
		for i = len, 1, -1 do
			if gameRoom.TingCardNeiKuangObject[i].gameObject then
				gameRoom.TingCardNeiKuangObject[i].gameObject:Destroy()
			end
			table.remove(gameRoom.TingCardNeiKuangObject, i)
		end
	end
	if next(gameRoom.TingCardCanHuObject) ~= nil then
		local len = table.maxn(gameRoom.TingCardCanHuObject)
		for i = len, 1, -1 do
			if gameRoom.TingCardCanHuObject[i].gameObject then
				gameRoom.TingCardCanHuObject[i].gameObject:Destroy()
			end
			table.remove(gameRoom.TingCardCanHuObject, i)
		end
	end

	-- 清理倒牌数据模型
	if next(this.downCardList) ~= nil then
		local len = table.maxn(this.downCardList)
		for i = len, 1, -1 do
			if this.downCardList[i].gameObject then
				this.downCardList[i].gameObject:Destroy()
			end
			table.remove(this.downCardList, i)
		end
	end

	-- 比赛场每局结算打开的情况下5秒后关闭
	if global.roomVo.isFangzhu == 3 or global.roomVo.vsRoomNum ~= 0 then
		if SingleSettlementCtrl.isCreate then
			local co = coroutine.start(GameRoom.CloseSingleSettlement)
			table.insert(Network.crts, co)
		end
	end
	if not buffer then return end
	print('11111111111--初始化牌回调')
	-- 当前局数
	this.curJushu = this.curJushu + 1

	Game.isReloadBattle = false
	this.hasReload = false

	local data = buffer:ReadBuffer()
	print('4444444444444444444444444444444444444',data)
	print('66666666666666666666666666666666666666666',buffer:ReadBuffer())
	print('66666666666666666666666666666666666666666',buffer)
	local msg = InitChesses_pb.InitChessesRes()
	print('4444444444444444444444444444444444444', msg)
	print('55555555555555555555555555555555555555', #msg)
	msg:ParseFromString(data)

	print('3333333333333333333333333333333--初始化牌回调', msg.zhuang, msg.zhuaIndex, msg.shaiziMin, #msg.chessInfo)

	this.initInfo.bankerIndex = msg.zhuang
	-- 庄的索引
	this.initInfo.startDrawIndex = msg.zhuaIndex
	-- 在谁那开始抓牌索引
	this.initInfo.diceMin = msg.shaiziMin
	-- 骰子最小数（从第几个开始抓牌）
	this.initInfo.diceMax = msg.shaiziMax
	-- 骰子最大点数；	
	print('2222222222222222--初始化牌回调', msg.zhuang, msg.zhuaIndex, msg.shaiziMin, #msg.chessInfo)

	local len = table.maxn(msg.chessInfo)
	for i = 1, len, 1 do
		local info = ChessInfoVo:New()
		local v = msg.chessInfo[i]
		info.id = v.id
		-- 牌的唯一id
		info.color = v.color
		-- 牌的花色
		info.num = v.num
		-- 牌的数值
		info.used = v.used
		-- 牌是否被使用 0=没被用   1=被碰  2=被明杠 3=被暗杠 4=过路杠
		logWarn('----------------------------> id:' .. info.id .. ' color:' .. info.color .. ' num:' .. info.num)
		table.insert(this.myCards, i, info)
	end

	print("----------------------------------------------------------------",Room.gameType)
	Event.Brocast(MsgDefine.Room_Enter)
	if Room.gameType == RoomType.Mahjong then
		coroutine.start(this.MahjongRoomEnter)
	elseif Room.gameType == RoomType.Mahjong then
		coroutine.start(this.RedRoomEnter)
	elseif Room.gameType == RoomType.Mahjong then
		coroutine.start(this.BloodFightRoomEnter)
	end

end

function GameRoom.CloseSingleSettlement()
	coroutine.wait(5)
	SingleSettlementCtrl:Close()
end

-- 摸牌回调
function GameRoom.OnCardGet(buffer)
	gameRoom.cardTotal = gameRoom.cardTotal - 1
	log('摸到牌了')
	local data = buffer:ReadBuffer()
	local msg = MoChess_pb.MoChessesRes()
	msg:ParseFromString(data)

	local moChess = MoChess.New()

	--moChess.roleId = msg.roleId
	-- 摸牌人roleId
	moChess.roleIndex = msg.roleIndex
	-- 摸牌人Index
	moChess.moOrder = msg.moOrder
	-- 摸牌的顺序 1=从前面开始摸 2=从后面开始摸
	moChess.moChessInfo = msg.chessInfo
	-- 牌的列表

	global.firstMoChess = moChess

	local myRoleId = global.userVo.roleId
	local moCardRoleId = global.firstMoChess.roleId
	if myRoleId == moCardRoleId then
		this.curMoCardStatic = 1
		-- gameRoom.canPlayCard = false
		-- this.canPlayCard = true
	end
	print("====GameRoom====OnCardGet=:", moChess.roleId)
	local location = getOtherPlayerLocation(msg.roleIndex)


	-- 摸到的牌可以让别人看见并且减少桌面上的牌
	local location = getOtherPlayerLocation(moChess.roleIndex)
	local publicCard
	if moChess.moOrder == 1 then
		publicCard = gameRoom.publicCards[gameRoom.curCardIndex]
		if publicCard.hasMo then
			gameRoom.curCardIndex = gameRoom.curCardIndex - 1
			publicCard = gameRoom.publicCards[gameRoom.curCardIndex]
		end
		gameRoom.curCardIndex = gameRoom.curCardIndex - 1
		if gameRoom.curCardIndex < 0 then
			gameRoom.curCardIndex = gameRoom.CARD_TOTOAL - 1
		end
	else
		publicCard = gameRoom.publicCards[gameRoom.lastCardIndex]
		if gameRoom.lastCardIndex % 2 == 0 then
			gameRoom.lastCardIndex = gameRoom.lastCardIndex + 3
			if gameRoom.lastCardIndex >= gameRoom.CARD_TOTOAL then
				gameRoom.lastCardIndex = gameRoom.lastCardIndex - gameRoom.CARD_TOTOAL
			end
		else
			gameRoom.lastCardIndex = gameRoom.lastCardIndex - 1
		end
	end

	if location == 'D' then
		publicCard.gameObject:SetActive(false)
		if OB_GameMainPanel.imgLouHu.activeSelf then
			local co = coroutine.start(OB_GameMainPanel.LouhuShow)
			table.insert(Network.crts, co)
		end
	elseif location == 'L' then
		local pos = gameRoom.leftModelChardMap[#gameRoom.leftModelChardMap].transform.position
		pos.z = pos.z - 0.5
		publicCard.transform.position = pos
		-- Vector3.New(10,10,1)
		publicCard:setStatic(2)
		table.insert(gameRoom.leftModelChardMap, publicCard)
	elseif location == 'R' then
		local pos = gameRoom.rightModelChardMap[#gameRoom.rightModelChardMap].transform.position
		pos.z = pos.z + 0.5
		publicCard.transform.position = pos
		publicCard:setStatic(3)
		table.insert(gameRoom.rightModelChardMap, publicCard)
	elseif location == 'U' then
		local pos = gameRoom.upModelChardMap[#gameRoom.upModelChardMap].transform.position
		pos.x = pos.x - 0.5
		publicCard.transform.position = pos
		publicCard:setStatic(4)
		table.insert(gameRoom.upModelChardMap, publicCard)
	end
	publicCard.hasMo = true
	if OB_GameMainCtrl.isCreate then
		OB_GameMainCtrl:HeadIcon(moChess.roleIndex)
		OB_GameMainCtrl.CountDown(true)
	end
end

function GameRoom.BloodFightRoomEnter()
	if global.roomVo.isFangzhu == 3 or global.roomVo.vsRoomNum ~= 0 then
		if XZ_GameMainCtrl.isCreate then
			XZ_GameMainCtrl:InitPanel()
		else
			XZ_GameMainCtrl:Close()
			DissolutionRoomTipsCtrl:Close(true)
			XZ_GameMainCtrl:Open("RM_GameMain")
		end
	else
		if this.curJushu == 1 then
			-- OB_GameMainCtrl:Close()
			DissolutionRoomTipsCtrl:Close(true)
			-- OB_GameMainCtrl:Open("OB_GameMain")
			print("===============GameRoom.RoomEnter(1)")
		else
			XZ_GameMainCtrl:InitPanel()
			print("===============GameRoom.RoomEnter(2)")
		end
		XZ_GameMainCtrl:GameStarting()
	end
end

function GameRoom.RedRoomEnter()
	if global.roomVo.isFangzhu == 3 or global.roomVo.vsRoomNum ~= 0 then
		if RM_GameMainCtrl.isCreate then
			RM_GameMainCtrl:InitPanel()
		else
			RM_GameMainCtrl:Close()
			DissolutionRoomTipsCtrl:Close(true)
			RM_GameMainCtrl:Open("RM_GameMain")
		end
	else
		if this.curJushu == 1 then
			-- OB_GameMainCtrl:Close()
			DissolutionRoomTipsCtrl:Close(true)
			-- OB_GameMainCtrl:Open("OB_GameMain")
			print("===============GameRoom.RoomEnter(1)")
		else
			RM_GameMainCtrl:InitPanel()
			print("===============GameRoom.RoomEnter(2)")
		end
		RM_GameMainCtrl:GameStarting()
	end
end

function GameRoom.MahjongRoomEnter()
	if global.roomVo.isFangzhu == 3 or global.roomVo.vsRoomNum ~= 0 then
		if OB_GameMainCtrl.isCreate then
			OB_GameMainCtrl:InitPanel()
		else
			OB_GameMainCtrl:Close()
			DissolutionRoomTipsCtrl:Close(true)
			OB_GameMainCtrl:Open("OB_GameMain")
		end
	else
		if this.curJushu == 1 then
			-- OB_GameMainCtrl:Close()
			DissolutionRoomTipsCtrl:Close(true)
			-- OB_GameMainCtrl:Open("OB_GameMain")
			print("===============GameRoom.RoomEnter(1)")
		else
			OB_GameMainCtrl:InitPanel()
			print("===============GameRoom.RoomEnter(2)")
		end
		OB_GameMainCtrl:GameStarting()
	end
end


function GameRoom.Reload(data)
	if Game.isReloadBattle then
		local roomVo = RoomVo:New()
		roomVo.id = data.roomNum
		-- data.出来的东西都是Reload.proto里面传来的数据
		roomVo.total = data.jushu
		roomVo.isSelf = data.zimohu and 1 or 2
		roomVo.isRed = data.hongzhong and 1 or 2
		roomVo.isBihu = data.bihu and 1 or 2
		roomVo.isFishNum = data.yu
		roomVo.isFeng = data.feng and 1 or 2
		roomVo.isPlayNum = #data.roles
		roomVo.modeType = data.modeType and 1 or 2
		-- 比赛场房间数据
		roomVo.vsRoomNum = data.vsRoomNum
		roomVo.vsType = data.vsType
		roomVo.vscount = data.vsCount
		roomVo.lun = data.vsLun
		-- 新添加
		roomVo.baseNum = data.baseNum
		roomVo.qualified = data.qualified
		roomVo.moneyType = data.moneyType
		global.roomVo = roomVo
		print("============BIHU==============", roomVo.isBihu, roomVo.moneyType)
		for i = 1, #data.roles do
			local joinRoomUserVo = JoinRoomUserVo:New()
			joinRoomUserVo.index = data.roles[i].roleIndex
			joinRoomUserVo.roleId = data.roles[i].roleId
			joinRoomUserVo.name = data.roles[i].name
			joinRoomUserVo.ip = data.roles[i].ip
			joinRoomUserVo.headImg = data.roles[i].headImg
			joinRoomUserVo.jifen = data.roles[i].jifen
			joinRoomUserVo.diamond = data.roles[i].diamond
			joinRoomUserVo.gender = data.roles[i].gender
			joinRoomUserVo.isOnline = data.roles[i].isOnline
			-- 比赛场人物数据
			joinRoomUserVo.curPaiMing = data.roles[i].rank
			joinRoomUserVo.isTrusteeship = data.roles[i].isTrusteeship
			-- 新添加
			joinRoomUserVo.goldcoin = data.roles[i].goldcoin
			-- 金币数量
			joinRoomUserVo.wing = data.roles[i].wing
			-- 元宝数量
			print('GameRoom.Reload(data)======================', data.roles[i].goldcoin, data.roles[i].wing)

			local placeMsg = data.roles[i].locationInfo;
			local strArray
			strArray = string_split(placeMsg, "/")
			global.gpsMsgInfo[tostring(data.roles[i].roleId)] = { strArray[1], tonumber(strArray[2]), tonumber(strArray[3]) }

			global.joinRoomUserVos[i] = joinRoomUserVo

			-- 如果当前玩家是托管状态，显示托管
			if getRoleIndexById(global.userVo.roleId) == i and data.roles[i].isTrusteeship == true then
				local co = coroutine.start( function()
					while not OB_GameMainCtrl.isCreate do
						coroutine.step()
					end
					OB_GameMainPanel.btnTuoGuan:SetActive(false)
					OB_GameMainPanel.imgTuoGuanBG:SetActive(true)
				end )
				table.insert(this.trusteeshipRoleIDS, trusteeshipRoleID)
			end
		end
		if global.roomVo.modeType == 1 then
			text5 = 'AA模式'
		else
			text5 = '老板模式'
		end

		if data.moneyType == RoomMode.goldMode then
			text5 = ''
		elseif data.moneyType == RoomMode.wingMode then
			text5 = ''
		end

		if global.roomVo.isFishNum == 0 then
			text4 = '不下鱼'
		else
			text4 = global.roomVo.isFishNum .. "条鱼"
		end
		if global.roomVo.isSelf == 1 then
			text3 = "自摸胡"
		else
			text3 = '点炮胡'
		end

		if global.roomVo.isBihu == 1 then
			text3 = "点炮必胡"
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
		global.roomVo.playMethod = text1 .. "  " .. text2 .. "  " .. text3 .. "  " .. text4 .. "  " .. text5
		-- global.roomVo.playMethod = text1.."  "..text2.."  "..text3.."\n".."\t\t      "..text4.."  "..text5
		-- global.roomVo.playMethod = text1.."  "..text2.."  "..text3.."\n"..text4.."     "..text5.." 带跟庄".."\n".."漏胡        荒庄加倍"
		if data.vsRoomNum ~= 0 then
			global.roomVo.playMethod = text1 .. "  " .. text2 .. "  " .. text3 .. "\n" .. "\t\t      " .. text4 .. "  鱼吃鱼"
		end
	end

	local co = coroutine.start( function()
		-- 等待资源加载完成
		while this.resCount < this.needResCount do
			coroutine.step()
		end
		while this.loadObjCount < this.needLoadObjCount do
			coroutine.step()
		end
		this.curJushu = data.alreadyJuShu
		if this.curJushu > 1 then
			this.isOnes = false
		end
		MahjongRoom:InitPlayers()
		-- self.players = {}
		this.OnInitRes()
		this.initInfo.bankerIndex = data.zhuang
		-- 庄的索引
		this.initInfo.startDrawIndex = data.zhuaIndex
		-- 在谁那开始抓牌索引
		this.initInfo.diceMin = data.shaiziMin
		-- 骰子最小数（从第几个开始抓牌）
		this.initInfo.diceMax = data.shaiziMax
		-- 骰子最大点数

		this.moPaiLeftPos = Vector3.New(28.836, -8, -1.13)
		-- 0   90  0
		this.moPaiRightPos = Vector3.New(37.843, -8, 3.742)
		-- 180 90  180
		this.moPaiOppsPos = Vector3.New(30.78, -8, 4.5),
		-- 0   180 0

		OB_GameMainCtrl:Open("OB_GameMain")
		while not OB_GameMainCtrl.isCreate do
			coroutine.step()
		end
		RoomInitStatic.Enter(true)
		gameRoom.gameObjShaizi:SetActive(false)
		OB_GameMainPanel.imgGameStart:SetActive(false)

		local pos = gameRoom.gameObjCardContainer.transform.position
		pos.y = 1
		gameRoom.gameObjCardContainer.transform.position = pos

		OB_GameMainCtrl.ShowCount()
		this.DClose:SetActive(true)
		OB_GameMainCtrl:ZhuangJiaShow(this.initInfo.bankerIndex)
		OB_GameMainCtrl:HeadIcon(this.initInfo.bankerIndex)
		-- 直接到最终牌的状态
		OB_GameMainCtrl.GameStart()
		RoomDealStatic.CalcCardStartEnd()
		RoomDealStatic.Exit()
		this.lockHand = true
		this.changeStatic(RoomStatic.RunStatic)

		local count = 0
		local card, info
		local faFinish
		local lastCard
		for j = 1, #data.roles do
			local role = data.roles[j]
			local spInfo = ReLoad_pb.MahjongRoleSpInfo()
			spInfo:ParseFromString(role.spInfoRes)

			local num = spInfo.chessCount
			local len = 0
			local location
			local pglen = 0
			local pgstart = 1

			for i = 1, #spInfo.roleChess do
				info = ChessInfoVo:New()
				local v = spInfo.roleChess[i]
				info.id = v.id
				-- 牌的唯一id
				info.color = v.color
				-- 牌的花色
				info.num = v.num
				-- 牌的数值
				info.used = v.used

				if v.used > 0 then
					location = getOtherPlayerLocation(role.roleIndex)
					if v.used < 5 then
						if location == "D" then
							pgCards = this.myPengGangCards
						elseif location == "R" then
							pgCards = this.rightPengGangCards
							len = len + 1
						elseif location == "L" then
							pgCards = this.leftPengGangCards
							len = len + 1
						elseif location == "U" then
							pgCards = this.oppsPengGangCards
							len = len + 1
						end
						table.insert(pgCards, v)
						pglen = pglen + 1
						local signOperateChess = SignOperateChess.New()
						signOperateChess.roleId = role.roleId
						signOperateChess.roleIndex = role.roleIndex
						signOperateChess.signType = v.used
						signOperateChess.chessInfo = pgCards
						global.signOperateChess = signOperateChess
						if v.used == 1 and pglen == 3 then
							RoomRunStatic.SignOperateCardShow(location, signOperateChess.signType, pgstart)
							pgstart = pgstart + pglen
							pglen = 0
						elseif v.used > 1 and pglen == 4 then
							RoomRunStatic.SignOperateCardShow(location, signOperateChess.signType, pgstart)
							pgstart = pgstart + pglen
							pglen = 0
						end
					end
				else
					if global.userVo.roleId == role.roleId then
						table.insert(this.myCards, info)
						len = len + 1
					end
				end
			end

			if global.userVo.roleId ~= role.roleId then
				len = num - len
			else
				faFinish = spInfo.faFinish
			end
			RoomDealStatic.UserGetChard(role.roleIndex, len)

			count = count + len

			-- 打出来的牌
			for i = 1, #spInfo.outChess do
				info = spInfo.outChess[i]
				local playChess = {
					roleIndex = role.roleIndex,
					roleId = role.roleId,
					chessInfo = info,
				}
				if info.id == data.curOutChess.id then
					lastCard = playChess
				else
					RoomRunStatic.OnCardPlay(playChess, true)
				end
			end
		end

		if lastCard then
			RoomRunStatic.OnCardPlay(lastCard, true)
		else
			OB_GameMainPanel.imgPlayCardDirection:SetActive(false)
		end

		-- 公共牌
		for i = 1, data.lastChess do
			card = this.publicCards[gameRoom.lastCardIndex]
			card.hasMo = true
			card.gameObject:SetActive(false)
			if gameRoom.lastCardIndex % 2 == 0 then
				gameRoom.lastCardIndex = gameRoom.lastCardIndex + 3
				if gameRoom.lastCardIndex >= gameRoom.CARD_TOTOAL then
					gameRoom.lastCardIndex = gameRoom.lastCardIndex - gameRoom.CARD_TOTOAL
				end
			else
				gameRoom.lastCardIndex = gameRoom.lastCardIndex - 1
			end
			gameRoom.cardTotal = gameRoom.cardTotal - 1
		end
		for i = count + 1, data.beforeChess do
			card = this.publicCards[this.curCardIndex]
			card.hasMo = true
			card.gameObject:SetActive(false)
			gameRoom.curCardIndex = gameRoom.curCardIndex - 1
			if gameRoom.curCardIndex < 0 then
				gameRoom.curCardIndex = gameRoom.CARD_TOTOAL - 1
			end
			gameRoom.cardTotal = gameRoom.cardTotal - 1
		end

		OB_GameMainCtrl.SurplusCardNum(gameRoom.cardTotal)

		local myIndex = getRoleIndexById(global.userVo.roleId)
		if myIndex == data.curIndex then
			this.canPlayCard = true
		end
		local location = getOtherPlayerLocation(data.curIndex)
		this.DClose:SetActive(true)
		OB_GameMainCtrl:HeadIcon(data.curIndex)
		this.lockHand = false
		if global.roomVo.moneyType == RoomMode.roomCardMode then
			Room:SetGps(data.roles)
		end
		if not faFinish then
			-- Game.SendProtocal(Protocal.DealOver)
		end
		-- this.hasReload = true
	end )
	table.insert(Network.crts, co)
end

-- 选牌变色的列表
function GameRoom.SetColorCard(obj)
	table.insert(this.colorCardList, obj)
end

-- 点牌变色
function GameRoom.GetColor(objName)
	print("====colorCardList", #this.colorCardList)
	if this.colorCardList == nil then
		return
	end
	local color = nil
	local cardName = "color_" .. string.sub(objName, 1, 4) .. "(Clone)"

	for a, value in pairs(this.colorCardList) do
		if cardName == value.name then
			value:GetComponent("MeshRenderer").material.color = Color.New(0.73, 0.84, 0.43, 1)
			-- 草绿
			-- Color.New(0.7,0.7,0.4,0.5)--淡黄
			table.insert(this.changeCard, value)
		end
	end
end

-- 还原牌的颜色
function GameRoom.SetColor(objName)
	if this.colorCardList == nil then
		return
	end
	for a, value in pairs(this.changeCard) do
		value:GetComponent("MeshRenderer").material.color = this.cardColor
	end
	this.changeCard = { }
end

-- 删除碰杠牌颜色
function GameRoom.DeleteColor(obj)
	for i = #this.colorCardList, 1, -1 do
		if this.colorCardList[i] == obj then
			table.remove(this.colorCardList, i)
			break
		end
	end
end

-- 处理积分显示
function GameRoom.ScoreShow(signType, index, roleId)
	-- print("============ScoreShow")
	-- local jifen = ''
	-- --暗杠一人2分
	-- if signType == SingType.SING_ANGANG then
	-- 	jifen = '2'
	-- 	OB_GameMainPanel.SetScore(roleIndex,jifen)
	-- elseif signType == SingType.SING_MINGGANG then  --明杠打牌的那个人给3分
	-- 	jifen = '3'
	-- 	OB_GameMainPanel.SetScore(roleIndex,jifen,roleId)
	-- elseif signType == SingType.SING_GUOLUGANG then --一人1分
	-- 	jifen = '1'
	-- 	OB_GameMainPanel.SetScore(roleIndex,jifen)
	-- end
end

--[[UI牌的动画（类型,物体,目标位置，旋转角度）
function GameRoom.CardAnim( objType,obj, target, angle)
	local gameObject = obj
	local sequence = DG.Tweening.DOTween.Sequence()	--动画序列
	local rotateMod = DG.Tweening.RotateMode.Fast		--旋转模型
	if objType == 'UI' then
    sequence:Append(gameObject.transform:DOLocalMoveY(gameObject.transform.position.y, gameObject.transform.position.y+3, false))
    	    :Insert( 0.5, gameObject.transform:DOLocalRotate(Vector3.New(0,0,20) ,0.5,rotateMod)) --第一个参数为开始旋转的时间
    	    Append(gameObject.transform:DOLocalMoveX(gameObject.transform.position.x, gameObject.transform.position.x-3, false))
    		:Insert( 1, gameObject.transform:DOLocalRotate(Vector3.New(0,0,0),2,rotateMod))
    		Append(gameObject.transform:DOLocalMoveY(gameObject.transform.position.y, gameObject.transform.position.y-3, false))
    else
    sequence:Append(gameObject.transform:DOLocalMove(target , 1, false))
    	    :Insert( 1, gameObject.transform:DOLocalRotate(angle ,2,rotateMod)) --第一个参数为开始旋转的时间
    		:Insert( 1, gameObject.transform:DOLocalRotate(angle ,2,rotateMod))
end--]]

-- 打牌动作
function GameRoom.HandAnim(location, targetObj, targetPos)
	-- 	local hand = nil
	-- 	local pos  = nil
	-- 	local handPos = nil
	-- 	local parent = nil
	-- 	local sortPos1 = nil
	-- 	local sortPos2 = nil
	-- 	local objMoCard = nil
	-- 	local objDaCard = nil
	-- 	local rotate = nil
	-- 	if not this.lockHand then
	-- 		if location == 'D' then
	-- 			hand = gameRoom.gameObjHand[1]
	-- 			pos  = gameRoom.HandAnList.D
	-- 			handPos = Vector3.New(targetPos.x+0.78,-6.6,targetPos.z-5.42)
	-- 			parent = gameRoom.myContainer
	-- 			rotate = Quaternion.Euler(Vector3.New(90,0,0))
	-- 			--(32.67,-8.25,-0.47)
	-- 		elseif location == 'R' then
	-- 			hand = gameRoom.gameObjHand[2]
	-- 			pos  = gameRoom.HandAnList.R
	-- 			handPos = Vector3.New(targetPos.x+5.42,-6.6,targetPos.z+0.79)
	-- 			parent = gameRoom.RContainer
	-- 			sortPos1 = Vector3.New(42.36,-5.12,2.93) --z-2临时位置/后期改为摸牌位置
	-- 			sortPos2 = Vector3.New(42.36,-5.12,0.93)
	-- 			rotate = Quaternion.Euler(Vector3.New(90,0,90))
	-- 			--(34.65,-8.25,0.09)
	-- 		elseif location == 'U' then
	-- 			hand = gameRoom.gameObjHand[3]
	-- 			pos  = gameRoom.HandAnList.U
	-- 			handPos = Vector3.New(targetPos.x-0.81,-6.6,targetPos.z+5.27)
	-- 			parent = gameRoom.UContainer
	-- 			sortPos1 = Vector3.New(31.02,-5.12,9.21) --x+2临时位置/后期改为摸牌位置
	-- 			sortPos2 = Vector3.New(33.02,-5.12,9.21)
	-- 			rotate = Quaternion.Euler(Vector3.New(90,0,180))
	-- 			--(34.06,-8.25,2.05)
	-- 		elseif location == 'L' then
	-- 			hand = gameRoom.gameObjHand[4]
	-- 			pos  = gameRoom.HandAnList.L
	-- 			handPos = Vector3.New(targetPos.x-5.39,-6.6,targetPos.z-0.78)
	-- 			parent = gameRoom.LContainer
	-- 			sortPos1 = Vector3.New(24.33,-5.12,-2.33) --z+2临时位置/后期改为摸牌位置
	-- 			sortPos2 = Vector3.New(24.33,-5.12,-0.33)
	-- 			rotate = Quaternion.Euler(Vector3.New(90,90,0))
	-- 			--(32.09,-8.25,1.48)
	-- 		end
	-- 		local cardParent = hand.transform:FindChild('Bone001/Bone002/Bone019/Bone020/card')
	-- 		animator = hand.transform:GetComponent('Animator')
	-- 		animator.speed = 1
	-- 		animator:SetBool("isDa",true)
	-- 		if location ~= "D" then
	-- 			print("---------objM--------------",location,gameRoom.objMoCard.name)
	-- 			objMoCard = gameRoom.objMoCard
	-- 			objDaCard = gameRoom.objDaCard
	-- 			objDaCard:SetActive(false)
	-- 		end
	-- 			targetObj.transform.parent = cardParent
	-- 			targetObj.transform.localPosition = Vector3.zero
	-- 			local sequence = DG.Tweening.DOTween.Sequence()
	-- 			sequence:Append(hand.transform:DOMove(handPos, 0.6, false))
	-- 					:OnComplete(function()
	-- 						targetObj.transform.position = targetPos
	-- 						targetObj.transform.parent = parent.transform
	-- 						targetObj.transform.rotation = rotate
	-- 						if location ~= "D" then
	-- 							print("---------objD--------------",location,gameRoom.objDaCard.name)
	-- 						end
	-- 						GameRoom.HandBack(hand,pos,targetPos,sortPos1,sortPos2,objDaCard,objMoCard,"da")
	-- 						end)
	-- 	end
end
-- --复位
-- function GameRoom.HandBack(hand,pos,targetPos,sortPos1,sortPos2,objDaCard,objMoCard,mark)
-- 	if mark ~= nil and mark == "da" then
-- 		local animator = hand.transform:GetComponent('Animator')
-- 		animator:SetBool("isDa",false)
-- 		local sequence = DG.Tweening.DOTween.Sequence()
-- 		sequence:Append(hand.transform:DOLocalMove(pos[1], 0.6, false))
-- 			:OnComplete(function()					
-- 							GameRoom.HandBaiCard(hand,pos,targetPos,sortPos1,sortPos2,objDaCard,objMoCard)
-- 						end)
-- 		OB_GameMainPanel.CardDirection(targetPos)
-- 	else
-- 		local sequence = DG.Tweening.DOTween.Sequence()
-- 		sequence:Append(hand.transform:DOLocalMove(pos[1], 0.6, false))
-- 	end
-- end

-- --摆牌动作
-- function GameRoom.HandBaiCard( hand,pos,targetPos,sortPos1,sortPos2,objDaCard,objMoCard)
-- 	local sequence = DG.Tweening.DOTween.Sequence()
-- 	local animator = hand.transform:GetComponent('Animator')
-- 	animator.speed = 1.2
-- 	animator:SetBool("isBai", true)

-- 	sequence:Append(hand.transform:DOLocalMove(sortPos1, 0.5, false))
-- 			:Append(hand.transform:DOLocalMove(sortPos2, 0.5, false),objMoCard:SetActive(false))
-- 			:OnComplete(function()
-- 				animator:SetBool("isBai", false)
-- 				objDaCard:SetActive(true)
-- 				GameRoom.HandBack(hand,pos)
-- 				end)
-- end

-- --结束推牌
-- function GameRoom.HandPushCard()

-- end

function GameRoom.PlayBackInit(data)
	coroutine.start( function()
		this.loadObjCount = 0
		local roomVo = RoomVo:New()
		roomVo.id = data.roomNum
		roomVo.isSelf = data.zimohu and 1 or 2
		roomVo.isFeng = data.feng and 1 or 2
		roomVo.isRed = data.hongzhong and 1 or 2
		roomVo.isFishNum = data.yu
		roomVo.total = data.jushu
		roomVo.isPlayNum = #data.roleInfos
		for i = 1, #data.roleInfos do
			local joinRoomUserVo = JoinRoomUserVo:New()
			joinRoomUserVo.roleId = data.roleInfos[i].roleId
			joinRoomUserVo.index = data.roleInfos[i].roleIndex
			joinRoomUserVo.name = data.roleInfos[i].name
			joinRoomUserVo.jifen = data.roleInfos[i].jifen
			global.joinRoomUserVos[i] = joinRoomUserVo
		end
		roomVo.modeType = data.modeType
		global.roomVo = roomVo

		if global.roomVo.modeType == 1 then
			text5 = 'AA模式'
		else
			text5 = '老板模式'
		end

		if global.roomVo.isFishNum == 0 then
			text4 = '不下鱼'
		elseif global.roomVo.isFishNum == data.yu then
			text4 = data.yu .. '条鱼'
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
		-- global.roomVo.playMethod = text1.."  "..text2.."  "..text3.."\n"..text4.."     "..text5.." 带跟庄".."\n".."漏胡        荒庄加倍"
		-- global.roomVo.playMethod = text1.."  "..text2.."  "..text3.."\n".."\t\t      "..text4.."  "..text5
		global.roomVo.playMethod = text1 .. "  " .. text2 .. "  " .. text3 .. "  " .. text4 .. "  " .. text5

		-- 等待资源加载完成
		print("===================resCount=====================", this.resCount)
		while this.resCount < this.needResCount do
			coroutine.step()
		end
		this.curJushu = data.alreadyJuShu
		if this.curJushu > 1 then
			this.isOnes = false
		end
		this.OnInitRes()
		while this.loadObjCount < this.needLoadObjCount do
			coroutine.step()
		end
		this.initInfo.bankerIndex = data.zhuang
		-- 庄的索引
		this.initInfo.startDrawIndex = data.zhuaIndex
		-- 在谁那开始抓牌索引
		this.initInfo.diceMin = data.shaiziMin
		-- 骰子最小数（从第几个开始抓牌）
		this.initInfo.diceMax = data.shaiziMax
		-- 骰子最大点数

		this.moPaiLeftPos = Vector3.New(28.836, -8, -1.13)
		-- 0   90  0
		this.moPaiRightPos = Vector3.New(37.843, -8, 3.742)
		-- 180 90  180
		this.moPaiOppsPos = Vector3.New(30.78, -8, 4.5),
		-- 0   180 0

		OB_GameMainCtrl:Open("OB_GameMain")
		while not OB_GameMainCtrl.isCreate do
			coroutine.step()
		end
		-- 这里回放也不显示桌子动画以及骰子动画
		RoomInitStatic.Enter(true)
		gameRoom.gameObjShaizi:SetActive(false)
		OB_GameMainPanel.imgGameStart:SetActive(false)

		local pos = gameRoom.gameObjCardContainer.transform.position
		pos.y = 1
		gameRoom.gameObjCardContainer.transform.position = pos

		OB_GameMainCtrl.ShowCount()
		this.DClose:SetActive(true)
		OB_GameMainCtrl:ZhuangJiaShow(this.initInfo.bankerIndex)
		OB_GameMainCtrl:HeadIcon(this.initInfo.bankerIndex)
		-- 直接到最终牌的状态
		OB_GameMainCtrl.GameStart()
		RoomDealStatic.CalcCardStartEnd()
		RoomDealStatic.Exit()

		this.changeStatic(RoomStatic.RunStatic)

		local count = 0
		local card, info
		local faFinish
		for j = 1, #data.roleInfos do
			local role = data.roleInfos[j]
			-- local num = #role.chessInfos
			local len = 0
			local location

			for i = 1, #role.chessInfos do
				info = ChessInfoVo:New()
				local v = role.chessInfos[i]
				info.id = v.id
				-- 牌的唯一id
				info.color = v.color
				-- 牌的花色
				info.num = v.num
				-- 牌的数值
				info.used = v.used
				location = getOtherPlayerLocation(role.roleIndex)
				if location == "D" then
					table.insert(this.myCards, info)
					len = len + 1
				elseif location == "R" then
					table.insert(this.rightCards, info)
					len = len + 1
				elseif location == "L" then
					table.insert(this.leftCards, info)
					len = len + 1
				elseif location == "U" then
					table.insert(this.upCards, info)
					len = len + 1
				end
			end

			RoomDealStatic.UserGetChard(role.roleIndex, len)
			count = count + len
		end
		GradeDetailCtrl.isPlayBackDealStatic = false
		OB_GameMainCtrl.SurplusCardNum(gameRoom.cardTotal)
		-- 回放初始化完成之后执行摸牌打牌碰杠操作
		GradeDetailCtrl:InvokeRepeat("PlayBackOperate", 0.5, 300000000)
	end )
end

function GameRoom.PlayBack(buzhouId, playBackType, data)
	if playBackType == 2 then
		-- 摸牌
		this.OnCardGetHuiFang(data)
	elseif playBackType == 3 then
		-- 弹出标签
		-- RoomRunStatic.OnCardPushSignHuiFang(data)
	elseif playBackType == 4 then
		-- 标签操作
		RoomRunStatic.OnCardPushSignOperateHuiFang(data, buzhouId)
	elseif playBackType == 5 then
		-- 打牌
		RoomRunStatic.OnCardPlayHuiFang(buzhouId, data)
	end
end

function GameRoom.OnCardGetHuiFang(data)
	this.lockHand = false
	gameRoom.cardTotal = gameRoom.cardTotal - 1
	local moChess = MoChess.New()

	moChess.roleId = data.roleId
	-- 摸牌人roleId
	moChess.roleIndex = data.roleIndex
	-- 摸牌人Index
	moChess.moOrder = data.moOrder
	-- 摸牌的顺序 1=从前面开始摸 2=从后面开始摸
	moChess.moChessInfo = data.chessInfo
	-- 牌的列表

	global.firstMoChess = moChess

	-- 摸到的牌可以让别人看见并且减少桌面上的牌
	local location = getOtherPlayerLocation(moChess.roleIndex)
	local publicCard
	if moChess.moOrder == 1 then
		publicCard = gameRoom.publicCards[gameRoom.curCardIndex]
		gameRoom.curCardIndex = gameRoom.curCardIndex - 1
		if gameRoom.curCardIndex < 0 then
			gameRoom.curCardIndex = gameRoom.CARD_TOTOAL - 1
		end
	else
		publicCard = gameRoom.publicCards[gameRoom.lastCardIndex]
		if gameRoom.lastCardIndex % 2 == 0 then
			gameRoom.lastCardIndex = gameRoom.lastCardIndex + 3
			if gameRoom.lastCardIndex >= gameRoom.CARD_TOTOAL then
				gameRoom.lastCardIndex = gameRoom.lastCardIndex - gameRoom.CARD_TOTOAL
			end
		else
			gameRoom.lastCardIndex = gameRoom.lastCardIndex - 1
		end
	end

	if location == 'D' then
		publicCard.gameObject:SetActive(false)
		local moChess = global.firstMoChess
		local chessInfo = moChess.moChessInfo
		local strNum = ''
		if chessInfo.num < 10 then
			strNum = '0' .. tostring(chessInfo.num)
		else
			strNum = tostring(chessInfo.num)
		end
		local name = 'color_' .. chessInfo.color .. '_' .. strNum
		local objs = Game.GetUICard(name)
		this.LoadCardHuiFang(objs)
	elseif location == 'L' then
		publicCard.gameObject:SetActive(false)
		local moChess = global.firstMoChess
		local chessInfo = moChess.moChessInfo
		local strNum = ''
		if chessInfo.num < 10 then
			strNum = '0' .. tostring(chessInfo.num)
		else
			strNum = tostring(chessInfo.num)
		end
		local name = 'color_' .. chessInfo.color .. '_' .. strNum
		local objs = Game.GetObjCard(name)
		this.LoadLeftCardHuiFang(objs)
	elseif location == 'R' then
		publicCard.gameObject:SetActive(false)
		local moChess = global.firstMoChess
		local chessInfo = moChess.moChessInfo
		local strNum = ''
		if chessInfo.num < 10 then
			strNum = '0' .. tostring(chessInfo.num)
		else
			strNum = tostring(chessInfo.num)
		end
		local name = 'color_' .. chessInfo.color .. '_' .. strNum
		local objs = Game.GetObjCard(name)
		this.LoadRightCardHuiFang(objs)
	elseif location == 'U' then
		publicCard.gameObject:SetActive(false)
		local moChess = global.firstMoChess
		local chessInfo = moChess.moChessInfo
		local strNum = ''
		if chessInfo.num < 10 then
			strNum = '0' .. tostring(chessInfo.num)
		else
			strNum = tostring(chessInfo.num)
		end
		local name = 'color_' .. chessInfo.color .. '_' .. strNum
		local objs = Game.GetObjCard(name)
		this.LoadUpCardHuiFang(objs)
	end
	-- publicCard.hasMo = true
	if OB_GameMainCtrl.isCreate then
		OB_GameMainCtrl:HeadIcon(moChess.roleIndex)
		OB_GameMainCtrl.CountDown(true)
	end
end

-- 加载UI麻将(用于回放)
function GameRoom.LoadCardHuiFang(objs)
	local moChess = global.firstMoChess
	local chessInfo = moChess.moChessInfo

	local uiGo = newObject(objs)
	local image = uiGo.transform:GetComponent('Image')
	local mahUI = MahjongUiCard.New()

	mahUI.image = image
	uiGo.transform.parent = OB_GameMainPanel.selfUiCardImage.transform

	local pos = RoomRunStatic.lastUiCardPos
	if not pos then
		local i = #gameRoom.myUiCards
		local x = myUiCardInitPos.x + 82 * i
		x = x +(14 - i) * 35
		pos = Vector3.New(x, myUiCardInitPos.y, 0)
	end
	pos.x = pos.x + 100
	mahUI.image.rectTransform.anchoredPosition = pos
	mahUI.image.rectTransform.localScale = Vector3.New(1, 1, 1)

	mahUI.gameObject = uiGo
	mahUI.colorType = chessInfo.color
	mahUI.num = chessInfo.num
	mahUI.id = chessInfo.id
	local strNum = ""
	if mahUI.num < 10 then
		strNum = '0' .. tostring(mahUI.num)
	else
		strNum = tostring(chessInfo.num)
	end
	mahUI.image.name = mahUI.colorType .. '_' .. strNum .. '_' .. mahUI.id

	table.insert(gameRoom.myUiCards, mahUI)
	table.insert(gameRoom.myCards, chessInfo)
end

-- 用于回放
function GameRoom.LoadLeftCardHuiFang(objs)
	local moChess = global.firstMoChess
	local chessInfo = moChess.moChessInfo

	local card = newObject(objs)
	local leftPos = gameRoom.leftModelChardMap[#gameRoom.leftModelChardMap].transform.position
	leftPos.z = leftPos.z - 0.5
	card.transform.position = leftPos;
	-- Vector3.New(10,10,1);
	card.transform.rotation = Quaternion.Euler(Vector3.New(90, 90, 0))
	card.transform.localScale = Vector3.New(1.1, 1.1, 1.1)
	card.name = chessInfo.color .. '_' .. chessInfo.num .. '_' .. chessInfo.id
	table.insert(gameRoom.leftModelChardMap, card)
end

function GameRoom.LoadRightCardHuiFang(objs)
	local moChess = global.firstMoChess
	local chessInfo = moChess.moChessInfo
	local card = newObject(objs);
	local rightPos = gameRoom.rightModelChardMap[#gameRoom.rightModelChardMap].transform.position
	rightPos.z = rightPos.z + 0.5
	card.transform.position = rightPos;
	card.transform.rotation = Quaternion.Euler(Vector3.New(90, 0, 90))
	card.transform.localScale = Vector3.New(1.1, 1.1, 1.1)
	card.name = chessInfo.color .. '_' .. chessInfo.num .. '_' .. chessInfo.id
	table.insert(gameRoom.rightModelChardMap, card)
end

function GameRoom.LoadUpCardHuiFang(objs)
	local moChess = global.firstMoChess
	local chessInfo = moChess.moChessInfo
	local card = newObject(objs);
	local oppsPos = gameRoom.upModelChardMap[#gameRoom.upModelChardMap].transform.position
	oppsPos.x = oppsPos.x - 0.5
	card.transform.position = oppsPos;
	card.transform.rotation = Quaternion.Euler(Vector3.New(90, 0, 180))
	card.transform.localScale = Vector3.New(1.1, 1.1, 1.1)
	card.name = chessInfo.color .. '_' .. chessInfo.num .. '_' .. chessInfo.id
	table.insert(gameRoom.upModelChardMap, card)
end

-- 用于回放回退操作
function GameRoom.PlayBackHouTui(buzhouId, playBackType, data)
	if playBackType == 2 then
		-- 摸牌
		this.OnCardGetHuiFangHuiTui(data)
	elseif playBackType == 3 then
		-- 弹出标签
		-- RoomRunStatic.OnCardPushSignHuiFang(data)
	elseif playBackType == 4 then
		-- 标签操作
		RoomRunStatic.OnCardPushSignOperateHuiFangHuiTui(data, buzhouId)
	elseif playBackType == 5 then
		-- 打牌
		RoomRunStatic.OnCardPlayHuiFangHuiTui(data)
	end
end

-- 用于摸牌回放回退操作
function GameRoom.OnCardGetHuiFangHuiTui(data)
	this.lockHand = false
	gameRoom.cardTotal = gameRoom.cardTotal + 1
	local moChess = MoChess.New()

	moChess.roleId = data.roleId
	-- 摸牌人roleId
	moChess.roleIndex = data.roleIndex
	-- 摸牌人Index
	moChess.moOrder = data.moOrder
	-- 摸牌的顺序 1=从前面开始摸 2=从后面开始摸
	moChess.moChessInfo = data.chessInfo
	-- 牌的列表

	global.firstMoChess = moChess

	-- 摸到的牌减少并且增加桌面上的牌
	local location = getOtherPlayerLocation(moChess.roleIndex)
	local publicCard
	if moChess.moOrder == 1 then
		gameRoom.curCardIndex = gameRoom.curCardIndex + 1
		if gameRoom.curCardIndex >= gameRoom.CARD_TOTOAL - 1 then
			gameRoom.curCardIndex = 0
		end
		publicCard = gameRoom.publicCards[gameRoom.curCardIndex]
	else
		if gameRoom.lastCardIndex % 2 == 0 then
			gameRoom.lastCardIndex = gameRoom.lastCardIndex + 1
			if gameRoom.lastCardIndex < 0 then
				gameRoom.lastCardIndex = gameRoom.lastCardIndex + gameRoom.CARD_TOTOAL
			end
		else
			gameRoom.lastCardIndex = gameRoom.lastCardIndex - 3
		end
		publicCard = gameRoom.publicCards[gameRoom.lastCardIndex]
	end

	local moChess = global.firstMoChess
	local chessInfo = moChess.moChessInfo
	if location == 'D' then
		publicCard.gameObject:SetActive(true)
		local len = table.maxn(gameRoom.myUiCards)
		for i = len, 1, -1 do
			local myUiCardsId = gameRoom.myUiCards[i].id
			if myUiCardsId == chessInfo.id then
				gameRoom.myUiCards[i].gameObject:Destroy()
				table.remove(gameRoom.myUiCards, i)
				table.remove(gameRoom.myCards, i)
				break
			end
		end
		RoomRunStatic.CardSort()
	elseif location == 'L' then
		publicCard.gameObject:SetActive(true)
		local len = table.maxn(gameRoom.leftModelChardMap)
		for i = len, 1, -1 do
			local strAr = string_split(gameRoom.leftModelChardMap[i].name, '_')
			local cardId = tonumber(strAr[3])
			if chessInfo.id == cardId then
				gameRoom.leftModelChardMap[i].gameObject:Destroy()
				table.remove(gameRoom.leftModelChardMap, i)
				break
			end
		end
		RoomRunStatic.CardSortOther(location, false)
	elseif location == 'R' then
		publicCard.gameObject:SetActive(true)
		local len = table.maxn(gameRoom.rightModelChardMap)
		for i = len, 1, -1 do
			local strAr = string_split(gameRoom.rightModelChardMap[i].name, '_')
			local cardId = tonumber(strAr[3])
			if chessInfo.id == cardId then
				gameRoom.rightModelChardMap[i].gameObject:Destroy()
				table.remove(gameRoom.rightModelChardMap, i)
				break
			end
		end
		RoomRunStatic.CardSortOther(location, false)
	elseif location == 'U' then
		publicCard.gameObject:SetActive(true)
		local len = table.maxn(gameRoom.upModelChardMap)
		for i = len, 1, -1 do
			local strAr = string_split(gameRoom.upModelChardMap[i].name, '_')
			local cardId = tonumber(strAr[3])
			if chessInfo.id == cardId then
				gameRoom.upModelChardMap[i].gameObject:Destroy()
				table.remove(gameRoom.upModelChardMap, i)
				break
			end
		end
		RoomRunStatic.CardSortOther(location, false)
	end

	if OB_GameMainCtrl.isCreate then
		OB_GameMainCtrl:HeadIcon(moChess.roleIndex)
		OB_GameMainCtrl.CountDown(true)
	end
end


-- 加载UI麻将(用于回放回退)
function GameRoom.LoadCardHuiFangHuiTui(objs, chessInfo)
	local uiGo = newObject(objs)
	local image = uiGo.transform:GetComponent('Image')
	local mahUI = MahjongUiCard.New()

	mahUI.image = image
	uiGo.transform.parent = OB_GameMainPanel.selfUiCardImage.transform

	local pos = RoomRunStatic.lastUiCardPos
	if not pos then
		local i = #gameRoom.myUiCards
		local x = myUiCardInitPos.x + 82 * i
		x = x +(14 - i) * 35
		pos = Vector3.New(x, myUiCardInitPos.y, 0)
	end
	pos.x = pos.x + 100
	mahUI.image.rectTransform.anchoredPosition = pos
	mahUI.image.rectTransform.localScale = Vector3.New(1, 1, 1)

	mahUI.gameObject = uiGo
	mahUI.colorType = chessInfo.color
	mahUI.num = chessInfo.num
	mahUI.id = chessInfo.id
	local strNum = ""
	if mahUI.num < 10 then
		strNum = '0' .. tostring(mahUI.num)
	else
		strNum = tostring(chessInfo.num)
	end
	mahUI.image.name = mahUI.colorType .. '_' .. strNum .. '_' .. mahUI.id
	table.insert(gameRoom.myUiCards, mahUI)
	table.insert(gameRoom.myCards, chessInfo)
end

-- 用于回放回退
function GameRoom.LoadLeftCardHuiFangHuiTui(objs, chessInfo)
	local card = newObject(objs)
	local leftPos = gameRoom.leftModelChardMap[#gameRoom.leftModelChardMap].transform.position
	leftPos.z = leftPos.z - 0.5
	card.transform.position = leftPos;
	-- Vector3.New(10,10,1);
	card.transform.rotation = Quaternion.Euler(Vector3.New(90, 90, 0))
	card.transform.localScale = Vector3.New(1.1, 1.1, 1.1)
	card.name = chessInfo.color .. '_' .. chessInfo.num .. '_' .. chessInfo.id
	table.insert(gameRoom.leftModelChardMap, card)
end

function GameRoom.LoadRightCardHuiFangHuiTui(objs, chessInfo)
	local card = newObject(objs);
	local rightPos = gameRoom.rightModelChardMap[#gameRoom.rightModelChardMap].transform.position
	rightPos.z = rightPos.z + 0.5
	card.transform.position = rightPos;
	card.transform.rotation = Quaternion.Euler(Vector3.New(90, 0, 90))
	card.transform.localScale = Vector3.New(1.1, 1.1, 1.1)
	card.name = chessInfo.color .. '_' .. chessInfo.num .. '_' .. chessInfo.id
	table.insert(gameRoom.rightModelChardMap, card)
end

function GameRoom.LoadUpCardHuiFangHuiTui(objs, chessInfo)
	local card = newObject(objs);
	local oppsPos = gameRoom.upModelChardMap[#gameRoom.upModelChardMap].transform.position
	oppsPos.x = oppsPos.x - 0.5
	card.transform.position = oppsPos;
	card.transform.rotation = Quaternion.Euler(Vector3.New(90, 0, 180))
	card.transform.localScale = Vector3.New(1.1, 1.1, 1.1)
	card.name = chessInfo.color .. '_' .. chessInfo.num .. '_' .. chessInfo.id
	table.insert(gameRoom.upModelChardMap, card)
end

local rank = 0
local leftRoom = 0
local curLun = 0
local vsCount = 0
local vsType = 0
-- 比赛场排名回调
function GameRoom.VsWaitRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = VsWait_pb.VsWaitRes()
	msg:ParseFromString(data)
	rank = msg.rank
	leftRoom = msg.leftRoom
	curLun = msg.curLun
	vsCount = msg.vsCount
	vsType = msg.vsType
	local co = coroutine.start(GameRoom.ShowMatchRankList)
	table.insert(Network.crts, co)
end

function GameRoom.ShowMatchRankList()
	coroutine.wait(1)
	GameMatchRankListCtrl:Open("GameMatchRankList", function()
		GameMatchRankListCtrl:SetText(GameMatchRankListPanel.txtCurrentRankList, tostring(rank))
		GameMatchRankListCtrl:SetText(GameMatchRankListPanel.txtSurplusInfo, tostring(leftRoom))
		GameMatchRankListPanel.imgMatch16jin8BG:SetActive(true)
		GameMatchRankListPanel.img16jin8WaiGuang:SetActive(true)
		GameMatchRankListPanel.img8jin4WaiGuang:SetActive(true)
		GameMatchRankListPanel.img16jin8NeiGuang:SetActive(true)
		GameMatchRankListPanel.img8jin4NeiGuang:SetActive(true)
		GameMatchRankListPanel.img16jin8JinXingZhong:SetActive(true)
		GameMatchRankListPanel.txtJinXingZhong:SetActive(true)
		GameMatchRankListPanel.img8jin4JingXingZhong:SetActive(true)
		GameMatchRankListPanel.imgMatch8jin4BG.transform.localPosition = Vector3.New(0, -10, 0)
		GameMatchRankListPanel.img8jin4WaiGuang.transform.localPosition = Vector3.New(0, -10, 0)
		GameMatchRankListPanel.imgMatchZongjuesai.transform.localPosition = Vector3.New(412, -10, 0)
		if vsCount == 16 then
			GameMatchRankListPanel.imgMatch16jin8BG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(392, 386)
			GameMatchRankListPanel.imgMatch8jin4BG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(392, 386)
			GameMatchRankListPanel.imgMatchZongjuesai:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(392, 386)
			if curLun == 1 then
				GameMatchRankListPanel.img8jin4WaiGuang:SetActive(false)
				GameMatchRankListPanel.img8jin4NeiGuang:SetActive(false)
				GameMatchRankListPanel.img8jin4JingXingZhong:SetActive(false)
				GameMatchRankListPanel.txtJinXingZhong:SetActive(false)
				GameMatchRankListPanel.imgMatch8jin4BG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(352, 347)
				GameMatchRankListPanel.imgMatchZongjuesai:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(352, 347)
			elseif curLun == 2 then
				GameMatchRankListPanel.img16jin8WaiGuang:SetActive(false)
				GameMatchRankListPanel.img16jin8NeiGuang:SetActive(false)
				GameMatchRankListPanel.img16jin8JinXingZhong:SetActive(false)
				GameMatchRankListPanel.imgMatch16jin8BG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(352, 347)
				GameMatchRankListPanel.imgMatchZongjuesai:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(352, 347)
			end
		elseif vsCount == 8 then
			GameMatchRankListPanel.imgMatch16jin8BG:SetActive(false)
			GameMatchRankListPanel.img16jin8WaiGuang:SetActive(false)
			GameMatchRankListPanel.imgMatch8jin4BG.transform.localPosition = Vector3.New(-300, -10, 0)
			GameMatchRankListPanel.img8jin4WaiGuang.transform.localPosition = Vector3.New(-300, -10, 0)
			GameMatchRankListPanel.imgMatchZongjuesai.transform.localPosition = Vector3.New(300, -10, 0)
		end
	end )
end

local rewardType = 0
local rewardCount = 0
local rewardRank = 0
local endType = 0

-- 比赛场淘汰奖励回调
function GameRoom.VsEndRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = VsEnd_pb.VsEndRes()
	msg:ParseFromString(data)
	rewardType = msg.rewardType
	rewardCount = msg.rewardCount
	rewardRank = msg.rank
	endType = msg.endType
	local co = coroutine.start(GameRoom.ShowMatchSettle)
	table.insert(Network.crts, co)
end

function GameRoom.ShowMatchSettle()
	coroutine.wait(1)
	GameMatchSettleCtrl:Open('GameMatchSettle', function()
		GameMatchSettlePanel.imgJiangLi:SetActive(true)
		GameMatchSettlePanel.imgTaoTai:SetActive(true)
		print('GameRoom.ShowMatchSettle322222222222222222', endType)
		if endType == 1 then
			GameMatchSettlePanel.imgJiangLi:SetActive(false)
			GameMatchSettleCtrl:SetText(GameMatchSettlePanel.txtTaotaiRoleName, global.userVo.name)
			GameMatchSettleCtrl:SetText(GameMatchSettlePanel.txtTaoTaiInfo, '您放弃了比赛， 无房卡奖励！')
		elseif endType == 2 then
			if rewardCount <= 0 then
				GameMatchSettlePanel.imgJiangLi:SetActive(false)
				GameMatchSettleCtrl:SetText(GameMatchSettlePanel.txtTaotaiRoleName, global.userVo.name)
				if rewardType == 1 then
					GameMatchSettleCtrl:SetText(GameMatchSettlePanel.txtTaoTaiInfo, '您当前排名第 ' .. '<color=#FFF82B>' .. tostring(rewardRank) .. '</color>' .. '名， 无房卡奖励！')
				elseif rewardType == 2 then
					GameMatchSettleCtrl:SetText(GameMatchSettlePanel.txtTaoTaiInfo, '您当前排名第 ' .. tostring(rewardRank) .. '名， 无金币奖励！')
				end
			else
				GameMatchSettlePanel.imgTaoTai:SetActive(false)
				GameMatchSettleCtrl:SetText(GameMatchSettlePanel.txtJiangliRoleName, '恭喜[' .. global.userVo.name .. ']')
				if rewardType == 1 then
					GameMatchSettleCtrl:SetText(GameMatchSettlePanel.txtJiangliInfo, '您在本次比赛中荣获第 ' .. '<color=#FFF82B>' .. tostring(rewardRank) .. '</color>' .. ' 名， 奖励               ' .. '<color=#FFF82B>x' .. tostring(rewardCount) .. '</color>')
				elseif rewardType == 2 then
					GameMatchSettleCtrl:SetText(GameMatchSettlePanel.txtJiangliInfo, '您在本次比赛中荣获第 ' .. '<color=#FFF82B>' .. tostring(rewardRank) .. '</color>' .. ' 名， 奖励               ' .. '<color=#FFF82B>x' .. tostring(rewardCount) .. '</color>')
				end
			end
		elseif endType == 3 then
			print('GameRoom.ShowMatchSettle33333333333333333333333')
			GameMatchSettlePanel.imgJiangLi:SetActive(false)
			GameMatchSettleCtrl:SetText(GameMatchSettlePanel.txtTaotaiRoleName, global.userVo.name)
			GameMatchSettleCtrl:SetText(GameMatchSettlePanel.txtTaoTaiInfo, '服务器异常，请联系开发人员！')
		end
	end )
end

-- 比赛场托管回调
function GameRoom.VsTrusteeshipRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = VsTrusteeship_pb.VsTrusteeshipRes()
	msg:ParseFromString(data)
	OB_GameMainCtrl.isCanClick = true
	local trusteeshipRoleID = msg.roleId
	print('GameRoom.VsTrusteeshipRes111', msg.roleId, msg.isTrusteeship, global.userVo.roleId)
	if trusteeshipRoleID == global.userVo.roleId then
		if msg.isTrusteeship then
			local co = coroutine.start( function()
				while not OB_GameMainCtrl.isCreate do
					coroutine.step()
				end
				OB_GameMainPanel.btnTuoGuan:SetActive(false)
				OB_GameMainPanel.imgTuoGuanBG:SetActive(true)
			end )
			table.insert(this.trusteeshipRoleIDS, trusteeshipRoleID)
		else
			local co = coroutine.start( function()
				while not OB_GameMainCtrl.isCreate do
					coroutine.step()
				end
				OB_GameMainPanel.btnTuoGuan:SetActive(true)
				OB_GameMainPanel.imgTuoGuanBG:SetActive(false)
			end )
			if global.roomVo.isFangzhu == 3 or global.roomVo.vsRoomNum ~= 0 then
				for i = #this.trusteeshipRoleIDS, 1, -1 do
					if this.trusteeshipRoleIDS[i] == trusteeshipRoleID then
						table.remove(this.trusteeshipRoleIDS, i)
						break
					end
				end
				for i, v in ipairs(global.joinRoomUserVos) do
					if v.roleId == global.userVo.roleId then
						if v.isTrusteeship then
							v.isTrusteeship = false
						end
					end
				end
			end
		end
	end
end

-- 血战麻将推荐牌组回调
function GameRoom.OnBloodFightReferCardRes(buffer)
	local data = buffer:ReadBuffer()
	local msg = BloodFightReferCard_pb.BloodFightReferCardRes()
	msg:ParseFromString(data)
	
	if v.roleId == global.userVo.roleId then
		local referLen = table.maxn(msg.referChessInfo)
		for n = 1, referLen, 1 do
			local info = ChessInfoVo:New()
			local referChess = msg.referChessInfo[j]
			info.id = referChess.id
			-- 牌的唯一id
			info.color = referChess.color
			-- 牌的花色
			info.num = referChess.num
			-- 牌的数值
			info.used = referChess.used
			-- 牌是否被使用 0=没被用   1=被碰  2=被明杠 3=被暗杠 4=过路杠
			print('----------------------------> referChessid:' .. info.id .. ' referChesscolor:' .. info.color .. ' referChessnum:' .. info.num)
			table.insert(this.referCards, n, info)
		end

		local noReferLen = table.maxn(msg.noReferChessInfo)
		for m = 1, noReferLen, 1 do
			local info = ChessInfoVo:New()
			local noReferChess = msg.noReferChessInfo[n]
			info.id = noReferChess.id
			-- 牌的唯一id
			info.color = noReferChess.color
			-- 牌的花色
			info.num = noReferChess.num
			-- 牌的数值
			info.used = noReferChess.used
			-- 牌是否被使用 0=没被用   1=被碰  2=被明杠 3=被暗杠 4=过路杠
			print('----------------------------> noReferChessid:' .. info.id .. 'noReferChesscolor:' .. info.color .. 'noReferChessnum:' .. info.num)
			table.insert(this.noReferCards, m, info)
		end

		local myUiCardLen = table.maxn(this.myUiCards)
		local referCardsLen = table.maxn(this.referCards)
		local noReferCardsLen = table.maxn(this.noReferCards)
		local pos
		for i = 1, myUiCardLen, 1 do
			for j = 1, referCardsLen, 1 do
				local myUiCardsId = this.myUiCards[i].id
				local referChessInfo = this.referCards[j]
				if myUiCardsId == referChessInfo.id then
					pos = this.myUiCards[i].gameObject.transform.position
					pos.y = pos.y + 0.4
					this.myUiCards[i].gameObject.transform.position = pos
					break
				end
			end
		end

		for i = 1, myUiCardLen, 1 do
			for j = 1, noReferCardsLen, 1 do
				local myUiCardsId = this.myUiCards[i].id
				local noReferChessInfo = this.noReferCards[j]
				if myUiCardsId == noReferChessInfo.id then
					this.GetColor(this.myUiCards[i].gameObject.name)
					break
				end
			end
		end		
	end

	this.canPlayCard = true
end