require "Common/define"
require "Common/msgDefine"
require "Common/functions"
require "Logic/Room/Mahjong/MahjongCard"

require "3rd/pbc/protobuf"
require "3rd/pblua/ChessInfo_pb"
require "3rd/pblua/PlayChess_pb" 
require "3rd/pblua/PushSign_pb" 
require "3rd/pblua/PushSignOperate_pb" 
 
--房间打牌状态；
RoomRunStatic = {

}
local this      = RoomRunStatic

--打牌位置
local	selfPlayPos  	  = Vector3.New(32.26,-8.25,-0.47)  --90 0 0
local	selfTwoLinePlayPos = Vector3.New(32.26,-8.25,-1.01)  --90 0 0 			第二行
local	selfThreeLinePlayPos = Vector3.New(32.26,-8.25,-1.55)  --90 0 0 		第三行
local	selfFourLinePlayPos = Vector3.New(32.26,-8.25,-2.09)  --90 0 0         第四行

local	leftPlayPos  	  = Vector3.New(32.09,-8.25,1.89 ) --90 90 0
local	leftTwoLinePlayPos = Vector3.New(31.55,-8.25,1.89)  --90 90 0 			第二行
local	leftThreeLinePlayPos = Vector3.New(31.01,-8.25,1.89)  --90 90 0		 	第三行
local	leftFourLinePlayPos = Vector3.New(30.47,-8.25,1.89)  --90 90 0         第四行

local	rightPlayPos  	  = Vector3.New(34.65,-8.25,-0.32) --90 0 90
local	rightTwoLinePlayPos = Vector3.New(35.19,-8.25,-0.32)  --90 0 90				
local	rightThreeLinePlayPos = Vector3.New(35.73,-8.25,-0.32)  --90 0 90 			
local	rightFourLinePlayPos = Vector3.New(36.27,-8.25,-0.32)  --90 0 90         	

local	oppsPlayPos  	  = Vector3.New(34.47 ,-8.25,2.05 ) --90 0 180
local	oppsTwoLinePlayPos = Vector3.New(34.47 ,-8.25,2.59)  --90 0 180 			
local	oppsThreeLinePlayPos = Vector3.New(34.47 ,-8.25,3.13)  --90 0 180 			
local	oppsFourLinePlayPos = Vector3.New(34.47 ,-8.25,3.67) --90 0 180         第四行

local PlayCardIndex = {
	DIndex 	 = 1,		--自己打下去牌的初始索引
	RIndex   = 1,
	LIndex   = 1,
	UIndex   = 1
}

local myUiCardInitPos = Vector2.New(-50,-610)	--自己牌的初始位置

local myPengGangCoun = 0			--自己初始碰杠的次数

local leftPengCoun = 0			
local leftAnGangCount = 0		
local leftMingGangCount = 0		

local rightPengCoun = 0			
local rightAnGangCount = 0		
local rightMingGangCount = 0		

local oppsPengCoun = 0			
local oppsAnGangCount = 0		
local oppsMingGangCount = 0		
local rightRemoveCount = 0
local leftRemoveCount = 0
local upRemoveCount = 0
local lastCardColor = 0
local lastCardNum   = 0
local lastHuCardTabel = {}
local rightPosArray = {}
local leftPosArray = {}
local upPosArray = {}
--碰杠牌模型表（用于回放回退操作）
local modelMaps = {}
local myAddCount = 0
local rightAddCount = 0
local leftAddCount = 0
local upAddCount = 0
local allRemoveCount = 0
local allPengGangModelMap = {}
local CardJianJu = 0.41
local pgCount = 0
local playCardBuZhouTable = {}

function RoomRunStatic.New() 
	return this
end

function RoomRunStatic.isEnter(...)
	return true
end

function RoomRunStatic.Enter()
	 --加载牌的ImageUI
	--resMgr:LoadPrefab('MahjongCard', {'color_image'}, this.LoadImageUIProfab)
	-- Event.AddListener(Protocal.Card_Play,this.OnCardPlay)
	-- Event.AddListener(Protocal.Card_PushSign,this.OnCardPushSign)
	-- Event.AddListener(Protocal.Card_PushSignOperate,this.OnCardPushSignOperate)
	--这里重新开始一把要重新设置这些值
	myUiCardInitPos = Vector2.New(-50,-610)
	this.myMoCardInitIndex = 14   --摸牌人的初始索引
	this.leftMoCardInitIndex = 14 --左边摸牌人的初始索引
	this.rightMoCardInitIndex = 14--右边摸牌人的初始索引
	this.upMpCardInitIndex = 14   --对面摸排人的初始索引
	this.moUiMyPos = Vector3.New(1130,-610,0)
	--打牌位置
--打牌位置
	selfPlayPos  	  = Vector3.New(32.26,-8.25,-0.47)  --90 0 0
	selfTwoLinePlayPos = Vector3.New(32.26,-8.25,-1.01)  --90 0 0 			第二行
	selfThreeLinePlayPos = Vector3.New(32.26,-8.25,-1.55)  --90 0 0 		第三行
	selfFourLinePlayPos = Vector3.New(32.26,-8.25,-2.09)  --90 0 0         第四行

	leftPlayPos  	  = Vector3.New(32.09,-8.25,1.89 ) --90 90 0
	leftTwoLinePlayPos = Vector3.New(31.55,-8.25,1.89)  --90 90 0 			第二行
	leftThreeLinePlayPos = Vector3.New(31.01,-8.25,1.89)  --90 90 0		 	第三行
	leftFourLinePlayPos = Vector3.New(30.47,-8.25,1.89)  --90 90 0         第四行

	rightPlayPos  	  = Vector3.New(34.65,-8.25,-0.32) --90 0 90
	rightTwoLinePlayPos = Vector3.New(35.19,-8.25,-0.32)  --90 0 90				
	rightThreeLinePlayPos = Vector3.New(35.73,-8.25,-0.32)  --90 0 90 			
	rightFourLinePlayPos = Vector3.New(36.27,-8.25,-0.32)  --90 0 90         	

	oppsPlayPos  	  = Vector3.New(34.47 ,-8.25,2.05 ) --90 0 180
	oppsTwoLinePlayPos = Vector3.New(34.47 ,-8.25,2.59)  --90 0 180 			
	oppsThreeLinePlayPos = Vector3.New(34.47 ,-8.25,3.13)  --90 0 180 			
	oppsFourLinePlayPos = Vector3.New(34.47 ,-8.25,3.67) --90 0 180         第四行

	this.pengGangPos = {
		D = Vector3.New(37.93,-8.25,-3.3),  --90 0 0  x37.6
		-- R = Vector3.New(38.39,-8.25,4.44),  --90 0 90	 z-0.33
		R = Vector3.New(38.39,-8.25,3.4),  --90 0 90	 z-0.33
		L = Vector3.New(28.29,-8.25,-1.13),  --90 90 0 z+0.33
		U = Vector3.New(29.36,-8.25,4.6),  --90 0 180 x+0.33
	}

	this.pengGangSigns = {
		D = {},
		R = {},
		L = {},
		U = {},
	}
	 
	myPengGangCoun = 0			--自己初始碰杠的次数

	leftPengCoun = 0			
	leftAnGangCount = 0		
	leftMingGangCount = 0		

	rightPengCoun = 0			
	rightAnGangCount = 0		
	rightMingGangCount = 0		

	oppsPengCoun = 0			
	oppsAnGangCount = 0		
	oppsMingGangCount = 0
	rightRemoveCount = 0
	leftRemoveCount = 0
	upRemoveCount = 0
	lastCardColor = 0
	lastCardNum   = 0
	lastHuCardTabel = {}

	PlayCardIndex = {
	DIndex 	 = 1,		--自己打下去牌的初始索引
	RIndex   = 1,
	LIndex   = 1,
	UIndex   = 1
	}

	rightPosArray = {}
	leftPosArray = {}
	upPosArray = {}
	modelMaps = {}
	myAddCount = 0
	rightAddCount = 0
	leftAddCount = 0
	upAddCount = 0
	allRemoveCount = 0
	allPengGangModelMap = {}
	CardJianJu = 0.41

	this.isSign = false
	this.isDrag = false
	this.selectCard = nil
	pgCount = 0
	playCardBuZhouTable = {}
	this.IsBiHu = false
end

function RoomRunStatic.Update()
	--暂时添加摸牌处理
	if gameRoom.curMoCardStatic == 1 then
		RoomRunStatic.LoadImageUIProfab()
		gameRoom.curMoCardStatic = 0
	end
end

function RoomRunStatic.Exit()
	-- Event.RemoveListener(Protocal.Card_Play,this.OnCardPlay)
	-- Event.RemoveListener(Protocal.Card_PushSign,this.OnCardPushSign) 
	-- Event.RemoveListener(Protocal.Card_PushSignOperate,this.OnCardPushSignOperate)  
end

--读取摸牌图片预制体
function RoomRunStatic.LoadImageUIProfab()
	
	local moChess  = global.firstMoChess  
	local chessInfo =	moChess.moChessInfo

	local strNum    = ''
	
	if chessInfo.num < 10 then
			strNum = '0' .. tostring(chessInfo.num)
		else
			strNum = tostring(chessInfo.num)
	end

	local name = 'color_'..  chessInfo.color  .. '_' ..strNum
	local objs = Game.GetUICard(name)
	this.LoadCard(objs)
	--resMgr:LoadPrefab('uimahjongprefabs', { 'color_'..  chessInfo.color  .. '_' ..strNum}, this.LoadCard)
end

--加载UI麻将
function RoomRunStatic.LoadCard(objs)
	-- logWarn('moCardIndex----------->'..index)
	local moChess  =  global.firstMoChess
	local chessInfo = moChess.moChessInfo
	local uiGo    = newObject(objs)
	local image = uiGo.transform:GetComponent('Image')
	local mahUI = MahjongUiCard.New()
	
	mahUI.image = image
	local parent = OB_GameMainPanel.selfUiCardImage.transform
	uiGo.transform:SetParent(parent)
	
	local pos = this.lastUiCardPos
	if not pos then
		local i = #gameRoom.myUiCards
		local x = myUiCardInitPos.x + 82 * i
		x = x + (14 - i) * 35
		pos = Vector3.New(x,myUiCardInitPos.y,0)
	end
	pos.x = pos.x + 100
	mahUI.image.rectTransform.localScale       = Vector3.New(1,1,1)
	--mahUI.image.rectTransform.anchoredPosition = Vector3.New(pos.x,pos.y+100,pos.z)
	mahUI.image.rectTransform.anchoredPosition = Vector3.New(pos.x,pos.y,pos.z)
	-- gameRoom.isGettingCard = true
	-- local sequence = DG.Tweening.DOTween.Sequence()	--动画序列
	-- local rotateMod = DG.Tweening.RotateMode.Fast		--旋转模型
	-- --摸牌动画速度从0.5调整到0.05
	-- sequence:Append(mahUI.image.rectTransform:DOLocalRotate(Vector3.New(0,0,20) ,0,rotateMod))
 --    		:Append(mahUI.image.rectTransform:DOLocalMove(pos,0.05, false))
 --    		:Insert( 0.01, mahUI.image.rectTransform:DOLocalRotate(Vector3.New(0,0,0),0.05,rotateMod))
 --    		:OnComplete(function()
 --    			gameRoom.canPlayCard = true
 --    			gameRoom.isGettingCard = false
 --    			end)
	

	-- mahUI.index = index
	
	local gameObj = Util.addComponent(mahUI.image.gameObject,'Button')
	Util.addComponent(gameObj, "UIDrag")
	mahUI.gameObject = gameObj
	mahUI.colorType  = chessInfo.color
	mahUI.num        = chessInfo.num
	mahUI.id         = chessInfo.id
	local strNum = ""
	if mahUI.num < 10 then
			strNum = '0' .. tostring(mahUI.num)
		else
			strNum = tostring(chessInfo.num)
	end
	mahUI.image.name = mahUI.colorType..'_'..strNum..'_'..mahUI.id
	
	--存储拍照之后UI牌
	table.insert(gameRoom.myUiCards,mahUI)
	table.insert(gameRoom.myCards, chessInfo)
	--this.Photograph(image)

	--为每张摸到的牌添加点击事件监听
	local luaBehavi = gameRoom.canvas.transform:GetComponent('LuaBehaviour')
	luaBehavi:RemoveClick(mahUI.gameObject)
	luaBehavi:AddClick(mahUI.gameObject, this.OnPlayCardClick)

	--确定摸到的牌存到手里列表内在执行听牌提示操作
	OB_GameMainPanel.imgTingPaiTipsBGImage:SetActive(false)
	Game.MusicEffect(Game.Effect.mopai)
end

--拍照处理
-- function RoomRunStatic.Photograph(image)
-- 	local renderTexture = UnityEngine.RenderTexture.New(145,145,1)
-- 	gameRoom.cardCamera.targetTexture = renderTexture
-- 	gameRoom.cardCamera:Render()

-- 	local texture2D = UnityEngine.Texture2D.New(renderTexture.width, renderTexture.height)
-- 	local rect      = UnityEngine.Rect.New(0,0,renderTexture.width,renderTexture.height)
	
-- 	UnityEngine.RenderTexture.active = renderTexture
-- 	local nRect = UnityEngine.Rect.New(0,0,145,145)
-- 	texture2D:ReadPixels(nRect, 0, 0)
-- 	texture2D:Apply()
-- 	UnityEngine.RenderTexture.active = nil
		
-- 	local sRect  = UnityEngine.Rect.New(0,0,145,145)
-- 	local sprite = UnityEngine.Sprite.Create(texture2D,sRect,Vector2.New(-1,0))
-- 	image.sprite = sprite
-- end

function RoomRunStatic.OnDragStart()
	this.isDrag = true
end

function RoomRunStatic.OnDragCard(go,isPlay)
	this.isDrag = false
	print('RoomRunStatic.OnDragCard1111111111111111111111111',gameRoom.canPlayCard)
	if not gameRoom.canPlayCard then
		return false
	end
	if isPlay then
		local uiCardID, cardInfo
		local len = table.maxn(gameRoom.myUiCards)
		for i = 1, len do
			if gameRoom.myUiCards[i].gameObject == go then
				uiCardID = gameRoom.myUiCards[i].id
				cardInfo = gameRoom.myCards[i]
				break
			end
		end
		this.selectCard = nil
		GameRoom.SetColor(go.name)
		this.SendCardPlay(uiCardID, cardInfo)
		return true
	end
	return false
end

-- 点击牌操作
function RoomRunStatic.OnPlayCardClick(go)
	print('RoomRunStatic.OnPlayCardClick11111111',this.isDrag,this.isSign,gameRoom.canPlayCard)
	if this.isDrag then return end
	if this.isSign then return end
	local len = table.maxn(gameRoom.myUiCards)
	if this.selectCard == go then
		local pos = this.selectCard.transform.position
		pos.y = pos.y - 0.4
		this.selectCard.transform.position = pos
		GameRoom.SetColor(go.name)
		this.selectCard = nil
		print('RoomRunStatic.OnPlayCardClick222222222222222222222222',gameRoom.canPlayCard)
		if not gameRoom.canPlayCard then return end
		local uiCardID, cardInfo
		for i = 1, len do
			--if gameRoom.myUiCards[i].gameObject ~= nil then  
				if gameRoom.myUiCards[i].gameObject == go then
					uiCardID = gameRoom.myUiCards[i].id
					cardInfo = gameRoom.myCards[i]
					break
				end
			--end
		end
		this.SendCardPlay(uiCardID, cardInfo)
	else
		local pos
		if this.selectCard then
			pos = this.selectCard.transform.position
			pos.y = pos.y - 0.4
			this.selectCard.transform.position = pos
			GameRoom.SetColor(go.name)
		end
		pos = go.transform.position
		pos.y = pos.y + 0.4
		go.transform.position = pos
		this.selectCard = go
		Game.MusicEffect(Game.Effect.xuanpai)
		GameRoom.GetColor(go.name)
		this.TingCardTishiUIShow(go.name)
	end
end


--发送打牌消息
function RoomRunStatic.SendCardPlay(uiCardID, cardInfo)
	--gameRoom.canPlayCard = false
	local playCard = PlayChess_pb.PlayChessReq()
	playCard.chessId = uiCardID
	local msg = playCard:SerializeToString()
    Game.SendProtocal(Protocal.Card_Play, msg)

    -- 客户端自己先表现，加强体验
    -- local playChess = {}
    -- playChess.roleId = global.userVo.roleId
    -- playChess.roleIndex = getRoleIndexById(playChess.roleId)
    -- playChess.chessInfo = cardInfo
    -- this.OnCardPlay(playChess, 2)
end

--收到服务器打牌消息
function RoomRunStatic.OnCardPlay(buffer, isReload)
	gameRoom.canPlayCard = false
	if AppConst.getPlayerPrefs('isNXFYOn') == '' then
		global.systemVo.isNXFYOn = '1'
	else
		global.systemVo.isNXFYOn  = AppConst.getPlayerPrefs('isNXFYOn')
	end

	local playChess, info
	if not isReload then
		local data   = buffer:ReadBuffer()
		local msg    = PlayChess_pb.PlayChessRes()	
		msg:ParseFromString(data)
	
		playChess = {}
		
		playChess.roleId      = msg.roleId       --打牌人roleId
	    playChess.roleIndex   = msg.roleIndex    --打牌人Index
		
		info = PlayChess:New()
		info.id    = msg.chessInfo.id   	-- 牌的唯一id
		info.color = msg.chessInfo.color   -- 牌的花色
		info.num   = msg.chessInfo.num     --牌的数值
		info.used  = msg.chessInfo.used 	-- 牌是否被使用 0=没被用   1=被碰  2=被明杠 3=被暗杠 4=过路杠
		playChess.chessInfo   = info
		logWarn('----------------------------> id:' .. info.id .. ' color:'..  info.color  .. ' num:' ..info.num)
		playCardPlayerId = msg.roleId
	else
		playChess = buffer
		info = playChess.chessInfo
	end
	local location = getOtherPlayerLocation( playChess.roleIndex )
	-- if global.roomVo.isFangzhu == 3 or global.roomVo.vsRoomNum ~= 0 then
	-- 	local isTrusteeships = false
	-- 	for i,v in ipairs(global.joinRoomUserVos) do
	-- 		if v.roleId == global.userVo.roleId then
	-- 			for i = 1,#gameRoom.trusteeshipRoleIDS,1  do
	-- 				if gameRoom.trusteeshipRoleIDS[i] == global.userVo.roleId then
	-- 					isTrusteeships = true
	-- 				end
	-- 			end
	-- 			if v.isTrusteeship or isTrusteeships == true then
	-- 			else
	-- 				if not isReload and location == 'D' then return end
	-- 			end
	-- 		end
	-- 	end
	-- else
	-- 	if not isReload and location == 'D' then return end
	-- end

	if location == 'D' then
		table.insert(gameRoom.myPlayCards,PlayCardIndex.DIndex,info)
		this.isTingCardBtnClickOper(true,info.color..'_'..info.num)
		--听牌之后不停牌立刻关掉听牌提示按钮
		local playCardColorAndNum = info.color..'-'..info.num
		local len = table.maxn(gameRoom.canPlayCardTingCardTable)
		OB_GameMainPanel.btnTingPai:SetActive(false)
		for i = 1,len,1  do 
			if playCardColorAndNum == gameRoom.canPlayCardTingCardTable[i].dropChess then
				if this.isTingPaiOpenBtn == true then
					OB_GameMainPanel.btnTingPai:SetActive(true)
					this.isTingPaiOpenBtn = false
				end
			end
		end
		this.ClearTingCardSignObject()
	elseif location == 'R' then
		table.insert(gameRoom.RPlayCards,PlayCardIndex.RIndex,info)
	elseif location == 'L' then
		table.insert(gameRoom.LPlayCards,PlayCardIndex.LIndex,info)
	elseif location == 'U' then
		table.insert(gameRoom.UPlayCards,PlayCardIndex.UIndex,info)
	else
		logWarn('--------------------------->位置信息错误')
	end
	log('======playChess.roleIndex:'..playChess.roleIndex)
	log("PlayChess---------".."color_"..info.color.."_"..info.num)
	local strNum    = ''
	if info.num < 10 then
		strNum = '0' .. tostring(info.num)
	else
		strNum = tostring(info.num)
	end
	local chess =tostring("color_"..info.color.."_"..strNum)
	global.playChess = playChess
	this.PlayCardShow(location, isReload)
	Game.MusicEffect(Game.Effect.dapai)
	Game.ChangeLanguage(chess)
end
local chessInfo = nil

--删除手里的牌数据以及UI图片并且生成打下去牌的模型列表
function RoomRunStatic.PlayCardShow(location, isReload)
	local objMoCard = nil
	local objDaCard = nil
	local playChessID = global.playChess.chessInfo.id
	if location == 'D' then
		if not isReload or isReload == 2 then
			local len = table.maxn(gameRoom.myUiCards)
			for i = len,1,-1  do 
				local myUiCardsId = gameRoom.myUiCards[i].id
				if myUiCardsId == playChessID then
					gameRoom.myUiCards[i].gameObject:Destroy()
					table.remove (gameRoom.myUiCards,i)
					table.remove (gameRoom.myCards, i)
					break	
				end
			end
		end

		--加载自己打下去的牌
		chessInfo = gameRoom.myPlayCards[PlayCardIndex.DIndex]
		this.OutModel(chessInfo,PlayCardIndex.DIndex,'D')
		PlayCardIndex.DIndex = PlayCardIndex.DIndex +1
		if not isReload or isReload == 2 then
			this.CardSort()	
		end
		--加载右边打下去的牌
	elseif location == 'R' then
		if not isReload then
			local len = table.maxn(gameRoom.rightModelChardMap)
			for i = len,1,-1 do
				objMoCard = gameRoom.rightModelChardMap[i].gameObject
				objMoCard:SetActive(false)
				table.remove (gameRoom.rightModelChardMap,i)
				break
			end
			-- local t1 = math.ceil(len/2)
			-- for i = t1,1,-1 do
			-- 	objDaCard = gameRoom.rightModelChardMap[i].gameObject
			-- 	break
			-- end
		end
		chessInfo = gameRoom.RPlayCards[PlayCardIndex.RIndex]
		this.OutModel(chessInfo,PlayCardIndex.RIndex,'R')
		PlayCardIndex.RIndex = PlayCardIndex.RIndex +1
		--加载左边打下去的牌
	elseif location == 'L' then
		if not isReload then
			local len = table.maxn(gameRoom.leftModelChardMap)
			for i = len,1,-1 do
				objMoCard = gameRoom.leftModelChardMap[i].gameObject
				objMoCard:SetActive(false)
				table.remove (gameRoom.leftModelChardMap,i)
				break
			end
			-- local t1 = math.ceil(len/2)
			-- for i = t1,1,-1 do
			-- 	objDaCard = gameRoom.leftModelChardMap[i].gameObject
			-- 	break
			-- end
		end

		chessInfo = gameRoom.LPlayCards[PlayCardIndex.LIndex]
		this.OutModel(chessInfo,PlayCardIndex.LIndex,'L')
		PlayCardIndex.LIndex = PlayCardIndex.LIndex +1
		--加载对面打下去的牌
	elseif location == 'U' then
		if not isReload then
			local len = table.maxn(gameRoom.upModelChardMap)
			for i = len,1,-1 do
				objMoCard = gameRoom.upModelChardMap[i].gameObject
				objMoCard:SetActive(false)
				table.remove (gameRoom.upModelChardMap,i)
				break
			end
			-- local t1 = math.ceil(len/2)
			-- for i = t1,1,-1 do
			-- 	objDaCard = gameRoom.upModelChardMap[i].gameObject
			-- 	break
			-- end
		end
		chessInfo = gameRoom.UPlayCards[PlayCardIndex.UIndex]
		this.OutModel(chessInfo,PlayCardIndex.UIndex,'U')
		PlayCardIndex.UIndex = PlayCardIndex.UIndex +1
	else
		logWarn('-------------------------------->加载错误')
	end
	gameRoom.objMoCard = objMoCard
	gameRoom.objDaCard = objDaCard
end

--加载打下去的牌
function RoomRunStatic.OutModel( chessInfo,CardIndex,location )
	local strNum    = ''
	if chessInfo.num < 10 then
		strNum = '0' .. tostring(chessInfo.num)
	else
		strNum = tostring(chessInfo.num)
	end
	local chess = tostring('color_'..  chessInfo.color  .. '_' ..strNum)
	local name = 'color_'..  chessInfo.color  .. '_' ..strNum
	local objs = Game.GetObjCard(name)
	this.LoadPlayCard(objs,CardIndex,location,chess)
	-- resMgr:LoadPrefab('MahjongCard', { 'Color_'..  chessInfo.color  .. '_' ..strNum}, function(objs, index)
	-- 	this.LoadPlayCard(objs, index, location,chess)
	-- end,CardIndex)
end

--手里牌进行排序
function RoomRunStatic.CardSort()
	local len = table.maxn(gameRoom.myUiCards)
	if len ~= #gameRoom.myCards then return end
	this.selectCard = nil
	table.sort(gameRoom.myUiCards,function(a,b) return a.image.name<b.image.name end )
	table.sort(gameRoom.myCards, function(a,b)
		local an = a.color * 100 + a.num
		local bn = b.color * 100 + b.num
		an = an .. "_" .. a.id
		bn = bn .. "_" .. b.id
		return an < bn
	end)
	for i = 1,len,1  do
		-- 复盘时该出牌时最后一个留一定的间隙
		local cell = 0
		if len % 3 == 2 and i == len then
			cell = 17
		end
		local x = myUiCardInitPos.x + 82 * i
		x = x + (14 - len) * 35
		local pos = Vector3.New(x + cell,myUiCardInitPos.y,0)
		gameRoom.myUiCards[i].image.rectTransform.anchoredPosition = pos
		if i == len then
			this.lastUiCardPos = pos
		end
	end
end

--其他人牌排序（目前用于回放）
function RoomRunStatic.CardSortOther(location,isFirst)
	if location == "R" then
		local ar = gameRoom.rightModelChardMap
		local len = #ar
		if isFirst then
			for i = 1, len do
				local pos = ar[i].transform.position
				table.insert(rightPosArray,pos)
			end
		end
		table.sort(gameRoom.rightModelChardMap,function(a,b) return a.name<b.name end )
		for j = 1,len do
			ar[j].transform.position = rightPosArray[j]
		end
	elseif location == "L" then
		local ar = gameRoom.leftModelChardMap
		local len = #ar
		if isFirst then
			for i = 1, len do
				local pos = ar[i].transform.position
				table.insert(leftPosArray,pos)
			end
		end

		table.sort(gameRoom.leftModelChardMap,function(a,b) return a.name<b.name end )
		for j = 1,len do
			ar[j].transform.position = leftPosArray[j]
		end
	elseif location == "U" then
		local ar = gameRoom.upModelChardMap
		local len = #ar
		if isFirst then
			for i = 1, len do
				local pos = ar[i].transform.position
				table.insert(upPosArray,pos)
			end
		end
		table.sort(gameRoom.upModelChardMap,function(a,b) return a.name<b.name end )
		for j = 1,len do
			ar[j].transform.position = upPosArray[j]
		end
	end
end

--创建打下去的牌模型
function RoomRunStatic.LoadPlayCard(objs,index,location,chess)
	local card = nil
	--当前人的位置
	if location == 'D' then
		card = SetPlayCardPos(objs,index,gameRoom.myPlayCards,gameRoom.myContainer)
		if index <= 7 then
			selfPlayPos  = Vector3.New(selfPlayPos.x + CardJianJu,selfPlayPos.y,selfPlayPos.z)				
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,0,0))
			card.transform.position = selfPlayPos
			this.cardPos = selfPlayPos	
		elseif index <= 14 then
			selfTwoLinePlayPos  = Vector3.New(selfTwoLinePlayPos.x + CardJianJu,selfTwoLinePlayPos.y,selfTwoLinePlayPos.z)				 
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,0,0))
			this.cardPos = selfTwoLinePlayPos
			card.transform.position = selfTwoLinePlayPos
		elseif index <= 21 then
			selfThreeLinePlayPos  = Vector3.New(selfThreeLinePlayPos.x + CardJianJu,selfThreeLinePlayPos.y,selfThreeLinePlayPos.z)				 
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,0,0))
			this.cardPos = selfThreeLinePlayPos
			card.transform.position = selfThreeLinePlayPos
		elseif index <= 28 then
			selfFourLinePlayPos  = Vector3.New(selfFourLinePlayPos.x + CardJianJu,selfFourLinePlayPos.y,selfFourLinePlayPos.z)				
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,0,0))
			this.cardPos = selfFourLinePlayPos
			card.transform.position = selfFourLinePlayPos
		end
		table.insert(gameRoom.PlayModelCardDMap,index,card)
		GameRoom.SetColorCard(card.gameObject)
	elseif location == 'L' then 
		card = SetPlayCardPos(objs,index,gameRoom.LPlayCards,gameRoom.LContainer)
		if index <= 7 then
			leftPlayPos  = Vector3.New(leftPlayPos.x,leftPlayPos.y,leftPlayPos.z-CardJianJu)				
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,90,0))
			this.cardPos = leftPlayPos
			card.transform.position = leftPlayPos
		elseif index <= 14 then
			leftTwoLinePlayPos  = Vector3.New(leftTwoLinePlayPos.x,leftTwoLinePlayPos.y,leftTwoLinePlayPos.z-CardJianJu)				
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,90,0))
			this.cardPos = leftTwoLinePlayPos
			card.transform.position = leftTwoLinePlayPos
		elseif index <= 21 then
			leftThreeLinePlayPos  = Vector3.New(leftThreeLinePlayPos.x ,leftThreeLinePlayPos.y,leftThreeLinePlayPos.z-CardJianJu)				 
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,90,0))
			this.cardPos = leftThreeLinePlayPos
			card.transform.position = leftThreeLinePlayPos
		elseif index <= 28 then
			leftFourLinePlayPos  = Vector3.New(leftFourLinePlayPos.x,leftFourLinePlayPos.y,leftFourLinePlayPos.z-CardJianJu)	
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,90,0))
			this.cardPos = leftFourLinePlayPos
			card.transform.position = leftFourLinePlayPos
		end
		table.insert(gameRoom.PlayModelCardLMap,index,card)
		GameRoom.SetColorCard(card.gameObject)
	elseif location == 'R' then
		card = SetPlayCardPos(objs,index,gameRoom.RPlayCards,gameRoom.RContainer)
		if index <= 7 then
			rightPlayPos  = Vector3.New(rightPlayPos.x ,rightPlayPos.y,rightPlayPos.z+CardJianJu)				
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,0,90))
			this.cardPos = rightPlayPos
			card.transform.position = rightPlayPos	
		elseif index <= 14 then
			rightTwoLinePlayPos  = Vector3.New(rightTwoLinePlayPos.x,rightTwoLinePlayPos.y,rightTwoLinePlayPos.z+ CardJianJu)				
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,0,90))
			this.cardPos = rightTwoLinePlayPos
			card.transform.position = rightTwoLinePlayPos
		elseif index <= 21 then
			rightThreeLinePlayPos  = Vector3.New(rightThreeLinePlayPos.x,rightThreeLinePlayPos.y,rightThreeLinePlayPos.z+ CardJianJu)				
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,0,90))
			this.cardPos = rightThreeLinePlayPos
			card.transform.position = rightThreeLinePlayPos		
		elseif index <= 28 then
			rightFourLinePlayPos  = Vector3.New(rightFourLinePlayPos.x,rightFourLinePlayPos.y,rightFourLinePlayPos.z+CardJianJu)				
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,0,90))
			this.cardPos = rightFourLinePlayPos
			card.transform.position = rightFourLinePlayPos		
		end
		table.insert(gameRoom.PlayModelCardRMap,index,card)
		GameRoom.SetColorCard(card.gameObject)
	elseif location == 'U' then
	 	card = SetPlayCardPos(objs,index,gameRoom.UPlayCards,gameRoom.UContainer)
		if index <= 7 then
			oppsPlayPos  = Vector3.New(oppsPlayPos.x-CardJianJu ,oppsPlayPos.y,oppsPlayPos.z)				
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,0,180))
			this.cardPos = oppsPlayPos
			card.transform.position = oppsPlayPos		
		elseif index <= 14 then
			oppsTwoLinePlayPos  = Vector3.New(oppsTwoLinePlayPos.x-CardJianJu,oppsTwoLinePlayPos.y,oppsTwoLinePlayPos.z)				
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,0,180))
			this.cardPos = oppsTwoLinePlayPos
			card.transform.position = oppsTwoLinePlayPos		
		elseif index <= 21 then
			oppsThreeLinePlayPos  = Vector3.New(oppsThreeLinePlayPos.x-CardJianJu,oppsThreeLinePlayPos.y,oppsThreeLinePlayPos.z)				 
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,0,180))
			this.cardPos = oppsThreeLinePlayPos
			card.transform.position = oppsThreeLinePlayPos			
		elseif index <= 28 then
			oppsFourLinePlayPos  = Vector3.New(oppsFourLinePlayPos.x-CardJianJu,oppsFourLinePlayPos.y,oppsFourLinePlayPos.z)				
			card.transform.rotation  = Quaternion.Euler(Vector3.New(90,0,180))
			this.cardPos = oppsFourLinePlayPos
			card.transform.position = oppsFourLinePlayPos		
		end
		table.insert(gameRoom.PlayModelCardUMap,index,card)
		GameRoom.SetColorCard(card.gameObject)

	end
	OB_GameMainCtrl.CardDirection(card.transform.position)
	--GameRoom.HandAnim(location,card,this.cardPos)
end

function SetPlayCardPos(objs,index,chessInfo,container)

	local go = newObject(objs)
	go.transform.parent   = container.transform
	go.transform.localScale = Vector3.New(1.2,1.2,1.2)
	local chessInfo = chessInfo[index]

	local card = MahjongCard:New()
	card.static = -1
	card.gameObject = go
	card.transform  = go.transform
	card.index      = index
	card.colorType  = chessInfo.color
	card.num        = chessInfo.num
	card.id         = chessInfo.id
	return card
end

--收到服务器标签消息
function RoomRunStatic.OnCardPushSign(buffer)

	local data   = buffer:ReadBuffer()
	local msg    = PushSign_pb.PushSignRes()	
	msg:ParseFromString(data)
	
	local chessCardSigns = msg.signs
	local roleId = msg.roleId

	local co = coroutine.start(function()
		-- while gameRoom.isGettingCard do
		-- 	coroutine.step()
		-- end
		-- 临时标记是否该自己打牌
		if gameRoom.canPlayCard and roleId == global.userVo.roleId then
			this.canPlayCard = true
		end
		gameRoom.canPlayCard = false
		if this.selectCard then
			pos = this.selectCard.transform.position
			pos.y = pos.y - 0.4
			this.selectCard.transform.position = pos
			GameRoom.SetColor(this.selectCard.name)
			this.selectCard = nil
		end
		this.isSign = true

		this.cardSignsUIShow(chessCardSigns)
	end)
	table.insert(Network.crts, co)
end

--处理碰杠胡过界面显示
function RoomRunStatic.cardSignsUIShow(signs)
	if signs ~= nil then
		OB_GameMainPanel.imgPengGangHuBG:SetActive(true)
		OB_GameMainPanel.btnNil:SetActive(false)
		OB_GameMainPanel.btnPeng:SetActive(false)
		OB_GameMainPanel.btnGang:SetActive(false)
		OB_GameMainPanel.btnHu:SetActive(false)
		gameRoom.curSignType = {}
		local len = table.maxn(signs)
		for i = 1,len, 1 do
			local signType = signs[i]
			print('=====RoomRunStatic.OnCardPushSign==',signType)
			if signType == SingType.SING_PENG then
				OB_GameMainPanel.btnPeng:SetActive(true)
			end
			
			if signType == SingType.SING_ANGANG or  signType == SingType.SING_MINGGANG  or signType == SingType.SING_GUOLUGANG then
				OB_GameMainPanel.btnGang:SetActive(true)
			end
			if signType == SingType.SING_HU or signType == SingType.SING_ZIMO then
				--1
				if global.roomVo.isBihu == 1 then
					RoomRunStatic.IsBiHu = true
				end
				OB_GameMainPanel.btnHu:SetActive(true)
				print('=====DIANBIHU==',RoomRunStatic.IsBiHu,global.roomVo.isBihu)
			end
			table.insert(gameRoom.curSignType,i,signType)
		end

		if OB_GameMainPanel.btnPeng.activeSelf == true and OB_GameMainPanel.btnGang.activeSelf == false and OB_GameMainPanel.btnHu.activeSelf == false then 
			OB_GameMainPanel.btnNil:SetActive(true)
		end
		if OB_GameMainPanel.btnGang.activeSelf == true and OB_GameMainPanel.btnHu.activeSelf == false and OB_GameMainPanel.btnPeng.activeSelf == false then
			OB_GameMainPanel.btnNil:SetActive(true)
		end
		if OB_GameMainPanel.btnHu.activeSelf == true and OB_GameMainPanel.btnPeng.activeSelf == false and OB_GameMainPanel.btnGang.activeSelf == false then
			OB_GameMainPanel.btnNil:SetActive(true)
		end
	end
end


--桌面特效显示
function RoomRunStatic.EffectShow(location,singType )
	if not Game.isReloadBattle or gameRoom.hasReload then
		if singType == SingType.SING_PENG then
			OB_GameMainCtrl.ShowTableEffect(location,'effect_peng')
			if OB_GameMainPanel.imgLouHu.activeSelf then
				if location == "D" then
					local co = coroutine.start(OB_GameMainCtrl.LouhuShow)
					table.insert(Network.crts, co)
				end
			end
		end
		if singType == SingType.SING_ANGANG then
			OB_GameMainCtrl.ShowTableEffect(location,'effect_gang')
			OB_GameMainCtrl.ShowTableEffect(location,'effect_xiayu')
		elseif singType == SingType.SING_MINGGANG then
			OB_GameMainCtrl.ShowTableEffect(location,'effect_gang')
			OB_GameMainCtrl.ShowTableEffect(location,'effect_guafeng')
		elseif singType == SingType.SING_GUOLUGANG then
			OB_GameMainCtrl.ShowTableEffect(location,'effect_gang')
			OB_GameMainCtrl.ShowTableEffect(location,'effect_guafeng')
		elseif singType == SingType.SING_HU then
			OB_GameMainCtrl.ShowTableEffect(location,'effect_hu')
			OB_GameMainCtrl.ShowTableEffect(location,"effect_huguang")
		elseif singType == SingType.SING_ZIMO then
			OB_GameMainCtrl.ShowTableEffect(location,'effect_zimo')
			OB_GameMainCtrl.ShowTableEffect(location,"effect_huguang")			
		end
	end
end
--收到服务器标签操作消息
function RoomRunStatic.OnCardPushSignOperate(buffer)
	print('--OnCardPushSignOperate1111111111')
	this.isSign = false
	local data   = buffer:ReadBuffer()
	local msg    = BloodFightPushSignOperate_pb.BloodFightPushSignOperateRes()	
	msg:ParseFromString(data)
	local signOperateChess = SignOperateChess.New()
	signOperateChess.roleId      = msg.roleId     
    signOperateChess.roleIndex   = msg.roleIndex    
	signOperateChess.signType 	 = msg.signType	
	local len = table.maxn(msg.chessInfo)
	local location = getOtherPlayerLocation(signOperateChess.roleIndex)
	if msg.signType == SingType.SING_HU then
		this.delPlayCardHuShow(location,msg.chessInfo)
	end


	RoomRunStatic.EffectShow(location,signOperateChess.signType)

	if signOperateChess.signType == SingType.SING_PENG then
		OB_GameMainCtrl:HeadIcon(signOperateChess.roleIndex)
		OB_GameMainCtrl.CountDown(true)
	end

	--清除之前碰杠的数据
	if next(gameRoom.myPengGangCards) ~= nil then
		local len = table.maxn(gameRoom.myPengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.myPengGangCards,i)
		end
	end
	
	if next(gameRoom.leftPengGangCards) ~= nil then
		local len = table.maxn(gameRoom.leftPengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.leftPengGangCards,i)
		end
	end
	
	if next(gameRoom.rightPengGangCards) ~= nil then
		local len = table.maxn(gameRoom.rightPengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.rightPengGangCards,i)
		end
	end
	
	if next(gameRoom.oppsPengGangCards) ~= nil then
		local len = table.maxn(gameRoom.oppsPengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.oppsPengGangCards,i)
		end
	end

	if next(gameRoom.PengGangCards) ~= nil then
		local len = table.maxn(gameRoom.PengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.PengGangCards,i)
		end
	end

	for i = 1,len,1 do
		  local info = SignOperateChess:New() 
		  local v = msg.chessInfo[i]
	      info.id	 =  v.id -- 牌的唯一id
		  info.color =	v.color-- 牌的花色
		  info.num   =	v.num --牌的数值
		  info.used  =	v.used -- 牌是否被使用 0=没被用   1=被碰  2=被明杠 3=被暗杠 4=过路杠
		  
		if location == 'D' then
			table.insert(gameRoom.myPengGangCards,i,info)
		elseif location == 'R' then
			table.insert(gameRoom.rightPengGangCards,i,info)
		elseif location == 'L' then
			table.insert(gameRoom.leftPengGangCards,i,info)
		elseif location == 'U' then
			table.insert(gameRoom.oppsPengGangCards,i,info)
		end
		table.insert(gameRoom.PengGangCards,i,info)
	end 
	if global.signOperateChess.signType ~= SingType.SING_GUOLUGANG then
		if location == 'D' then
			signOperateChess.chessInfo   = gameRoom.myPengGangCards    --牌的列表
		elseif location == 'R' then
			signOperateChess.chessInfo   = gameRoom.rightPengGangCards    --牌的列表
		elseif location == 'L' then
			signOperateChess.chessInfo   = gameRoom.leftPengGangCards    --牌的列表
		elseif location == 'U' then
			signOperateChess.chessInfo   = gameRoom.oppsPengGangCards    --牌的列表
		end
	end
	global.signOperateChess = signOperateChess

	--如果标签为胡或者自摸的话不更新表现层,直接返回
	if global.signOperateChess.signType == SingType.SING_HU or global.signOperateChess.signType == SingType.SING_ZIMO  then
		gameRoom.canPlayCard = false
	elseif signOperateChess.signType == SingType.SING_PENG and signOperateChess.roleId == global.userVo.roleId then
		gameRoom.canPlayCard = true
	elseif this.canPlayCard then
		gameRoom.canPlayCard = true
	end
	this.canPlayCard = false
	if  global.signOperateChess.signType == SingType.SING_GUO then
		--这里隐藏碰杠面板是用于托管
		OB_GameMainPanel.imgPengGangHuBG:SetActive(false)
		return
	end
	OB_GameMainPanel.imgPlayCardDirection.transform.position = Vector3.New(0,500,0)
	if global.signOperateChess.signType ~= SingType.SING_ANGANG and global.signOperateChess.signType ~= SingType.SING_GUOLUGANG then
		this.delPlayCardPengGangShow()
	end
	this.SignOperateCardShow(location, signOperateChess.signType)
end

--胡的牌加到模型列表里
function RoomRunStatic.delPlayCardHuShow(location,chessInfo)
	local publicCard = newObject(gameRoom.objHuCard)
	if location == 'D' then

	elseif location == 'R' then
		local pos = gameRoom.rightModelChardMap[#gameRoom.rightModelChardMap].transform.position
		pos.z = pos.z + 0.5
		publicCard.transform.position  = pos
		publicCard.transform.rotation = Quaternion.Euler(Vector3.New(0,-90,0))
		table.insert(gameRoom.rightModelChardMap,publicCard)			
	elseif location == 'L' then
		local pos = gameRoom.leftModelChardMap[#gameRoom.leftModelChardMap].transform.position
		pos.z = pos.z - 0.5
		publicCard.transform.position  = pos  			
		publicCard.transform.rotation = Quaternion.Euler(Vector3.New(0,90,0))
		table.insert(gameRoom.leftModelChardMap,publicCard)			
	elseif location == 'U' then
		local pos = gameRoom.upModelChardMap[#gameRoom.upModelChardMap].transform.position
		pos.x = pos.x - 0.5
		publicCard.transform.position =  pos
		publicCard.transform.rotation = Quaternion.Euler(Vector3.New(0,180,0))
		table.insert(gameRoom.upModelChardMap,publicCard)	
	end
end

--删除打下去被碰或者杠的牌
function RoomRunStatic.delPlayCardPengGangShow()
	local location = getOtherPlayerLocation(global.playChess.roleIndex)
	if location == 'D' then
		local myPlayCardsLen = table.maxn(gameRoom.myPlayCards)
		local pengGangCardsLen = table.maxn(gameRoom.PengGangCards)
		print('自己打牌被碰',myPlayCardsLen,pengGangCardsLen)
		for i = myPlayCardsLen,1,-1 do
			for j = pengGangCardsLen,1,-1 do
				local myPlayCardsId = gameRoom.myPlayCards[i].id
				local pengGangCardsId = gameRoom.PengGangCards[j].id
				if myPlayCardsId == pengGangCardsId then
					gameRoom.DeleteColor(gameRoom.PlayModelCardDMap[i].gameObject)
					gameRoom.PlayModelCardDMap[i].gameObject:Destroy()
					table.remove (gameRoom.PlayModelCardDMap,i)
					table.remove (gameRoom.myPlayCards,i)
					PlayCardIndex.DIndex = PlayCardIndex.DIndex -1
					break
				end
			end
		end
		print('自己打牌索引'..PlayCardIndex.DIndex)
		if PlayCardIndex.DIndex <= 7 then
			selfPlayPos  = Vector3.New(selfPlayPos.x - CardJianJu,selfPlayPos.y,selfPlayPos.z)				
		elseif PlayCardIndex.DIndex <= 14 then
			selfTwoLinePlayPos  = Vector3.New(selfTwoLinePlayPos.x - CardJianJu,selfTwoLinePlayPos.y,selfTwoLinePlayPos.z)				 
		elseif PlayCardIndex.DIndex <= 21 then
			selfThreeLinePlayPos  = Vector3.New(selfThreeLinePlayPos.x - CardJianJu,selfThreeLinePlayPos.y,selfThreeLinePlayPos.z)				 
		elseif PlayCardIndex.DIndex <= 28 then
			selfFourLinePlayPos  = Vector3.New(selfFourLinePlayPos.x - CardJianJu,selfFourLinePlayPos.y,selfFourLinePlayPos.z)				
		end
		
	elseif location == 'R' then
		local rPlayCardsLen = table.maxn(gameRoom.RPlayCards)
		local pengGangCardsLen = table.maxn(gameRoom.PengGangCards)
		print('右边打牌被碰',rPlayCardsLen,pengGangCardsLen)
		for i = rPlayCardsLen,1,-1 do
			for j = pengGangCardsLen,1,-1 do
				local rPlayCardsId = gameRoom.RPlayCards[i].id
				local PengGangCardsId = gameRoom.PengGangCards[j].id
				if rPlayCardsId == PengGangCardsId then
					gameRoom.DeleteColor(gameRoom.PlayModelCardRMap[i].gameObject)
					gameRoom.PlayModelCardRMap[i].gameObject:Destroy()
					table.remove (gameRoom.PlayModelCardRMap,i)
					table.remove (gameRoom.RPlayCards,i)
					PlayCardIndex.RIndex = PlayCardIndex.RIndex -1
					break
				end
			end
		end
		print('右边打牌索引'..PlayCardIndex.RIndex)
		if PlayCardIndex.RIndex <= 7 then
			rightPlayPos  = Vector3.New(rightPlayPos.x ,rightPlayPos.y,rightPlayPos.z-CardJianJu)				
		elseif PlayCardIndex.RIndex <= 14 then
			rightTwoLinePlayPos  = Vector3.New(rightTwoLinePlayPos.x,rightTwoLinePlayPos.y,rightTwoLinePlayPos.z- CardJianJu)				
		elseif PlayCardIndex.RIndex <= 21 then
			rightThreeLinePlayPos  = Vector3.New(rightThreeLinePlayPos.x,rightThreeLinePlayPos.y,rightThreeLinePlayPos.z- CardJianJu)				
		elseif PlayCardIndex.RIndex <= 28 then
			rightFourLinePlayPos  = Vector3.New(rightFourLinePlayPos.x,rightFourLinePlayPos.y,rightFourLinePlayPos.z-CardJianJu)				
		end
	elseif location == 'L' then
		local lPlayCardsLen = table.maxn(gameRoom.LPlayCards)
		local PengGangCardsLen = table.maxn(gameRoom.PengGangCards)
		print('左边打牌被碰',lPlayCardsLen,PengGangCardsLen)
		for i = lPlayCardsLen,1,-1 do
			for j = PengGangCardsLen,1,-1 do
				local lPlayCardsId = gameRoom.LPlayCards[i].id
				local PengGangCardsId = gameRoom.PengGangCards[j].id
				if lPlayCardsId == PengGangCardsId then
					gameRoom.DeleteColor(gameRoom.PlayModelCardLMap[i].gameObject)
					gameRoom.PlayModelCardLMap[i].gameObject:Destroy()
					table.remove (gameRoom.PlayModelCardLMap,i)
					table.remove (gameRoom.LPlayCards,i)
					PlayCardIndex.LIndex = PlayCardIndex.LIndex -1
					break
				end
			end
		end
		print('左边打牌索引'..PlayCardIndex.LIndex)
		if PlayCardIndex.LIndex <= 7 then
			leftPlayPos  = Vector3.New(leftPlayPos.x,leftPlayPos.y,leftPlayPos.z+CardJianJu)				
		elseif PlayCardIndex.LIndex <= 14 then
			leftTwoLinePlayPos  = Vector3.New(leftTwoLinePlayPos.x,leftTwoLinePlayPos.y,leftTwoLinePlayPos.z+CardJianJu)				
		elseif PlayCardIndex.LIndex <= 21 then
			leftThreeLinePlayPos  = Vector3.New(leftThreeLinePlayPos.x ,leftThreeLinePlayPos.y,leftThreeLinePlayPos.z+CardJianJu)				 
		elseif PlayCardIndex.LIndex <= 28 then
			leftFourLinePlayPos  = Vector3.New(leftFourLinePlayPos.x,leftFourLinePlayPos.y,leftFourLinePlayPos.z+CardJianJu)	
		end
	elseif location == 'U' then
		local uPlayCardsLen = table.maxn(gameRoom.UPlayCards)
		local PengGangCardsLen = table.maxn(gameRoom.PengGangCards)
		print('对面打牌被碰',uPlayCardsLen,PengGangCardsLen)
		for i = uPlayCardsLen,1,-1 do
			for j = PengGangCardsLen,1,-1 do
				local uPlayCardsId = gameRoom.UPlayCards[i].id
				local PengGangCardsId = gameRoom.PengGangCards[j].id
				if uPlayCardsId == PengGangCardsId then
					gameRoom.DeleteColor(gameRoom.PlayModelCardUMap[i].gameObject)
					gameRoom.PlayModelCardUMap[i].gameObject:Destroy()
					table.remove (gameRoom.PlayModelCardUMap,i)
					table.remove (gameRoom.UPlayCards,i)
					PlayCardIndex.UIndex = PlayCardIndex.UIndex -1
					break
				end
			end
		end
		print('对面打牌索引'..PlayCardIndex.UIndex)
		if PlayCardIndex.UIndex <= 7 then
			oppsPlayPos  = Vector3.New(oppsPlayPos.x+CardJianJu ,oppsPlayPos.y,oppsPlayPos.z)				
		elseif PlayCardIndex.UIndex <= 14 then
			oppsTwoLinePlayPos  = Vector3.New(oppsTwoLinePlayPos.x+CardJianJu,oppsTwoLinePlayPos.y,oppsTwoLinePlayPos.z)				
		elseif PlayCardIndex.UIndex <= 21 then
			oppsThreeLinePlayPos  = Vector3.New(oppsThreeLinePlayPos.x+CardJianJu,oppsThreeLinePlayPos.y,oppsThreeLinePlayPos.z)				 
		elseif PlayCardIndex.UIndex <= 28 then
			oppsFourLinePlayPos  = Vector3.New(oppsFourLinePlayPos.x+CardJianJu,oppsFourLinePlayPos.y,oppsFourLinePlayPos.z)				
		end
	end
end

--标签操作牌显示
function RoomRunStatic.SignOperateCardShow(location, signType, start)
	print("-----------------SignOperateCardShow ", location)
	local posD = Vector3.New(0,-80,-4)
	local posU = Vector3.New(0,210,-4)
	local posR = Vector3.New(250,80,-4)
	local posL = Vector3.New(-250,80,-4)
	--如果是自己
	if location == 'D' then
		local myUiCardLen = table.maxn(gameRoom.myUiCards)
		local myPengGangCardLen = table.maxn(gameRoom.myPengGangCards)

		for i = myUiCardLen,1,-1 do
			for j = myPengGangCardLen,1,-1 do
				local myUiCardsId = gameRoom.myUiCards[i].id
				local myPengGangCardId = gameRoom.myPengGangCards[j].id
				if myUiCardsId == myPengGangCardId then
					gameRoom.myUiCards[i].gameObject:Destroy()
					table.remove (gameRoom.myUiCards,i)
					table.remove (gameRoom.myCards,i)
					break
				end
			end
		end
		this.CardSort()
		this.CheckPengGangCard(myPengGangCardLen,gameRoom.myPengGangCards,location, signType, start)
	elseif location == 'R' then
		local len = table.maxn(gameRoom.rightModelChardMap)
		for i = len,1,-1 do
			gameRoom.rightModelChardMap[i].gameObject:SetActive(false)
			table.remove (gameRoom.rightModelChardMap,i)
			rightRemoveCount = rightRemoveCount + 1
			if signType == SingType.SING_PENG then
				if rightRemoveCount == 2 then
					break
				end
			elseif signType == SingType.SING_ANGANG then
				if rightRemoveCount == 4 then
					break
				end
			elseif signType == SingType.SING_MINGGANG then
				if rightRemoveCount == 3 then
					break
				end
			elseif signType == SingType.SING_GUOLUGANG then
				if rightRemoveCount == 1 then
					break
				end
			end
		end
		gameRoom.moPaiRightPos = gameRoom.moPaiRightPos - Vector3(0, 0, 0.38 * rightRemoveCount)
		rightRemoveCount = 0
		-- this.CardSortOther(location)
		local rightPengGangCardLen = table.maxn(gameRoom.rightPengGangCards)
		this.CheckPengGangCard(rightPengGangCardLen,gameRoom.rightPengGangCards,location, signType, start)
	elseif location == 'L' then
		local len = table.maxn(gameRoom.leftModelChardMap)
		for i = len,1,-1 do
			gameRoom.leftModelChardMap[i].gameObject:SetActive(false)
			table.remove (gameRoom.leftModelChardMap,i)
			leftRemoveCount = leftRemoveCount + 1
			if signType == SingType.SING_PENG then
				if leftRemoveCount == 2 then
					break
				end
			elseif signType == SingType.SING_ANGANG then
				if leftRemoveCount == 4 then
					break
				end
			elseif signType == SingType.SING_MINGGANG then
				if leftRemoveCount == 3 then
					break
				end
			elseif signType == SingType.SING_GUOLUGANG then
				if leftRemoveCount == 1 then
					break
				end
			end
		end
		leftRemoveCount = 0
		-- this.CardSortOther(location)
		local leftPengGangCardLen = table.maxn(gameRoom.leftPengGangCards)
		this.CheckPengGangCard(leftPengGangCardLen,gameRoom.leftPengGangCards,location, signType, start)
	elseif location == 'U' then
		local len = table.maxn(gameRoom.upModelChardMap)
		for i = len,1,-1 do
			gameRoom.upModelChardMap[i].gameObject:SetActive(false)
			table.remove (gameRoom.upModelChardMap,i)
			upRemoveCount = upRemoveCount + 1
			if signType == SingType.SING_PENG then
				if upRemoveCount == 2 then
					break
				end
			elseif signType == SingType.SING_ANGANG then
				if upRemoveCount == 4 then
					break
				end
			elseif signType == SingType.SING_MINGGANG then
				if upRemoveCount == 3 then
					break
				end
			elseif signType == SingType.SING_GUOLUGANG then
				if upRemoveCount == 1 then
					break
				end
			end
		end
		upRemoveCount = 0
		-- this.CardSortOther(location)
		local oppsPengGangCardLen = table.maxn(gameRoom.oppsPengGangCards)
		this.CheckPengGangCard(oppsPengGangCardLen,gameRoom.oppsPengGangCards,location, signType, start)
	end
end

--加载碰杠
function RoomRunStatic.CheckPengGangCard( CardLen,CardList, location, signType, start)
	print("------------CheckPengGangCard",CardLen,CardList[start], location, signType, start)
	if not start then start = 1 end
	local chessInfo = CardList[start]
	local strNum    = ''

	if chessInfo.num < 10 then
		strNum = '0' .. tostring(chessInfo.num)
	else
		strNum = tostring(chessInfo.num)
	end

	local isGuolu = false
	if CardLen == 1 then
		isGuolu = true
	end
	local chess = tostring('color_'..  chessInfo.color  .. '_' ..strNum)
	modelMaps = {
		D = gameRoom.myPengGangModelChardMap,
		L = gameRoom.leftPengGangModelChardMap,
		R = gameRoom.rightPengGangModelChardMap,
		U = gameRoom.oppsPengGangModelChardMap
	}
	local objs = Game.GetObjCard(chess)
	-- this.LoadPengGang(objs,CardLen,CardList,location,signType,start,chess,isGuolu,chessInfo,modelMaps)
	this.LoadPengGang(objs,CardLen,CardList,location,signType,start,chess,isGuolu,chessInfo)
end

-- function RoomRunStatic.LoadPengGang(objs,CardLen,CardList,location,signType,start,chess,isGuolu,chessInfo,modelMaps)
function RoomRunStatic.LoadPengGang(objs,CardLen,CardList,location,signType,start,chess,isGuolu,chessInfo)
	local count = 0
	local effectPos = nil
	for i = start, CardLen do
		local card = SetPlayCardPos(objs,i,CardList,gameRoom.pengGangGameObjContainer)
		table.insert(allPengGangModelMap,card)
		pgCount = #this.pengGangSigns[location]
		if isGuolu then
			for j, v in ipairs(this.pengGangSigns[location]) do
				if v[2] == chess then
					pgCount = j - 1
					break
				end
			end
		end
		local stPos = this.pengGangPos[location]
		effectPos =card.transform.position
		chessInfo = CardList[i]
		GameRoom.SetColorCard(card.gameObject)
		card.transform.position, card.transform.eulerAngles = this.CalcPengGangPos(location, count, pgCount, stPos, signType, isGuolu)
		table.insert(modelMaps[location], card)
		count = count + 1
	end
	-- 过路杠是贴在杠牌上面，不用重新添加
	if not isGuolu then
		table.insert(this.pengGangSigns[location], {signType, chess})
	end
	this.CardSort()
end

function RoomRunStatic.CalcPengGangPos(location, count, pgCounts, stPos, signType, isGuolu)
	local width = 0.4
	local height = 0.25
	local offset = (3 * width + 0.1) * pgCounts
	local pos, rot
	local effectName = "effect_pengyan"
	if location == "D" then
		rot = Vector3(90, 0, 0)
		if count == 3 or isGuolu then
			pos = stPos - Vector3(offset, 0, 0) - Vector3(width, -height, 0)
		else
			pos = stPos - Vector3(offset, 0, 0) - Vector3(width * count, 0, 0)
			if signType == SingType.SING_ANGANG then
				rot = Vector3(-90, 0, 0)
			end
		end
		OB_GameMainCtrl.SmokeEffect(location,effectName,pos)
	elseif location == "R" then
		rot = Vector3(90, -90, 0)
		if count == 3 or isGuolu then
			pos = stPos - Vector3(0, 0, offset) - Vector3(0, -height, width)
		else
			pos = stPos - Vector3(0, 0, offset) - Vector3(0, 0, width * count)
			if signType == SingType.SING_ANGANG then
				rot = Vector3(-90, -90, 0)
			end
		end
		OB_GameMainCtrl.SmokeEffect(location,effectName,pos)
	elseif location == "L" then
		rot = Vector3(90, 90, 0)
		if count == 3 or isGuolu then
			pos = stPos + Vector3(0, 0, offset) + Vector3(0, height, width)
		else
			pos = stPos + Vector3(0, 0, offset) + Vector3(0, 0, width * count)
			if signType == SingType.SING_ANGANG then
				rot = Vector3(-90, 90, 0)
			end
		end
		OB_GameMainCtrl.SmokeEffect(location,effectName,pos)		
	elseif location == "U" then
		rot = Vector3(90, 180, 0)
		if count == 3 or isGuolu then
			pos = stPos + Vector3(offset, 0, 0) + Vector3(width, height, 0)
		else
			pos = stPos + Vector3(offset, 0, 0) + Vector3(width * count, 0, 0)
			if signType == SingType.SING_ANGANG then
				rot = Vector3(-90, 180, 0)
			end
		end
		OB_GameMainCtrl.SmokeEffect(location,effectName,pos)
	end
	return pos, rot
end

function RoomRunStatic.OnCardTingOperate(buffer)
	log('--收到服务器听牌提示消息')
	local data   = buffer:ReadBuffer()
	local msg    = TingChess_pb.TingChessRes()	
	msg:ParseFromString(data)
	gameRoom.huCardTingCardTable = {}
	gameRoom.canPlayCardTingCardTable = {}
	local len = table.maxn(msg.tingAllInfo)
	if len == 0 then
		return
	end

	for i = 1,len,1 do
	  local info = {}
	  local v = msg.tingAllInfo[i]
      info.dropChess	 =  v.dropChess -- 可以打掉的牌
      log('dropChess'..info.dropChess)
      local tingCardLen = table.maxn(v.tingChessInfo)
	  for j = 1,tingCardLen,1 do
	  	local tingCardInfo = {}
	  	local dorpCard = info.dropChess
	  	tingCardInfo.dropChess = dorpCard
  		tingCardInfo.huChess = v.tingChessInfo[j].huChess
  		log('huChess'..tingCardInfo.huChess)
  		tingCardInfo.fan     = v.tingChessInfo[j].fan
  		tingCardInfo.leftCount = v.tingChessInfo[j].leftCount
  		table.insert(gameRoom.huCardTingCardTable,j,tingCardInfo)
  		log('tingCardInfo.dropChess'..tingCardInfo.dropChess)
	  end
	  table.insert(gameRoom.canPlayCardTingCardTable,i,info)
	end
	this.ShowTingCardTiShi()
	--是否显示听牌按钮
	this.isTingPaiOpenBtn = true
end

--显示听牌提示左上角标记
function RoomRunStatic.ShowTingCardTiShi()
	local myUiCardsLen = table.maxn(gameRoom.myUiCards)
	log('myUiCardsLen'..myUiCardsLen)
	local canPlayCardTingCardLen = table.maxn(gameRoom.canPlayCardTingCardTable)
	log('myUiCardsLen'..canPlayCardTingCardLen)
	local canPlayCardCountIndex = 1
	for i = 1,myUiCardsLen,1 do
		for j = 1,canPlayCardTingCardLen,1 do
			local cardColor = 0
			local cardNum = 0
			local strAr = string_split(gameRoom.canPlayCardTingCardTable[j].dropChess,'-')
			cardColor = tonumber(strAr[1])
			cardNum = tonumber(strAr[2])
			if gameRoom.myUiCards[i].colorType == cardColor and gameRoom.myUiCards[i].num == cardNum then
				local myUiCardsGameObject = gameRoom.myUiCards[i].gameObject
				local tingCard = gameRoom.tingCardSign
				this.LoadTingCard(tingCard,canPlayCardCountIndex,myUiCardsGameObject)
				canPlayCardCountIndex = canPlayCardCountIndex + 1
			end
		end
	end
end

--加载听的牌左上角的标记
function RoomRunStatic.LoadTingCard(objs,index,myUiCardsGameObject)	
	local uiGo    = newObject(objs)
	local image = uiGo.transform:GetComponent('Image')
	local mahUI = MahjongUiCard.New()
	mahUI.image = image
	local parent = myUiCardsGameObject.transform
	uiGo.transform:SetParent(parent)
	mahUI.image.rectTransform.anchoredPosition = Vector3.New(0,90,0)
	mahUI.image.rectTransform.localScale       = Vector3.one
	mahUI.image.rectTransform.localRotation    = Vector3.zero
	mahUI.index = index
	table.insert(gameRoom.TingCardSignObject,index,uiGo)
end

--打牌后清理左上角标记以及内框对象和胡牌对象
function  RoomRunStatic.ClearTingCardSignObject()
	if next(gameRoom.canPlayCardTingCardTable) ~= nil then
		local len = table.maxn(gameRoom.canPlayCardTingCardTable)
		for i = len,1,-1  do 
			table.remove (gameRoom.canPlayCardTingCardTable,i)
		end
	end
	if next(gameRoom.TingCardSignObject) ~= nil then
		local len = table.maxn(gameRoom.TingCardSignObject)
		for i = len,1,-1  do 
			if gameRoom.TingCardSignObject[i].gameObject then
				gameRoom.TingCardSignObject[i].gameObject:Destroy()
			end
			table.remove (gameRoom.TingCardSignObject,i)
		end
	end
	OB_GameMainPanel.imgTingPaiTipsBGImage:SetActive(false)
end

--点击牌之后听牌提示胡牌信息显示
function RoomRunStatic.TingCardTishiUIShow(name)
	OB_GameMainPanel.imgTingPaiTipsBGImage:SetActive(false)
	if next(gameRoom.TingCardNeiKuangObject) ~= nil then
		local len = table.maxn(gameRoom.TingCardNeiKuangObject)
		for i = len,1,-1  do 
			if gameRoom.TingCardNeiKuangObject[i].gameObject then
				gameRoom.TingCardNeiKuangObject[i].gameObject:Destroy()
			end
			table.remove (gameRoom.TingCardNeiKuangObject,i)
		end
	end

	local canPlayCardTingCardLen = table.maxn(gameRoom.canPlayCardTingCardTable)
	for j = 1,canPlayCardTingCardLen,1 do
		local cardColor = 0
		local cardNum = 0
		local gameObjectColor = 0
		local gameObjectNum = 0
		local strAr = string_split(gameRoom.canPlayCardTingCardTable[j].dropChess,'-')
		cardColor = tonumber(strAr[1])
		cardNum = tonumber(strAr[2])
		local strName = string_split(name,'_')
		gameObjectColor =  tonumber(strName[1])
		gameObjectNum =  tonumber(strName[2])
		
		if cardColor ==  gameObjectColor and cardNum == gameObjectNum then
			--最后这个标记用来调整位置
			resMgr:LoadPrefab('uimahjongprefabs', {'tingPaiNeiKuangImage'}, function(objs)
				this.LoadHuTingCard(objs, gameRoom.huCardTingCardTable,cardColor,cardNum,2)
			end)
			break
		end
	end
	-- end
end

--存储打下去牌的信息以及可以胡的列表
function RoomRunStatic.isTingCardBtnClickOper(isTingCardBtnClick,name)
	local canPlayCardTingCardLen = table.maxn(gameRoom.canPlayCardTingCardTable)
	for j = 1,canPlayCardTingCardLen,1 do
		local cardColor = 0
		local cardNum = 0
		local gameObjectColor = 0
		local gameObjectNum = 0
		local strAr = string_split(gameRoom.canPlayCardTingCardTable[j].dropChess,'-')
		cardColor = tonumber(strAr[1])
		cardNum = tonumber(strAr[2])
		local strName = string_split(name,'_')
		gameObjectColor =  tonumber(strName[1])
		gameObjectNum =  tonumber(strName[2])
		
		if cardColor ==  gameObjectColor and cardNum == gameObjectNum then
			if isTingCardBtnClick == true then
				lastCardColor = cardColor
				lastCardNum = cardNum
				lastHuCardTabel = gameRoom.huCardTingCardTable
				print('lastCardColor',lastCardColor,'lastCardNum',lastCardNum,'lastHuCardTabel',lastHuCardTabel)
				isTingCardBtnClick = false
			end
			break
		end
	end
end

--加载点击听牌可以胡的牌
function RoomRunStatic.LoadHuTingCard(objs,huCardTingCardTable,cardColor,strNum,posSing)
	if next(gameRoom.TingCardCanHuObject) ~= nil then
		local len = table.maxn(gameRoom.TingCardCanHuObject)
		print('RoomRunStatic.TingCardTishiUIShow1',len)
		for i = len,1,-1  do 
			print('RoomRunStatic.TingCardTishiUIShow2',gameRoom.TingCardCanHuObject[i].gameObject)
			if gameRoom.TingCardCanHuObject[i].gameObject then
				gameRoom.TingCardCanHuObject[i].gameObject:Destroy()
			end
			table.remove (gameRoom.TingCardCanHuObject,i)
		end
	end

	local huCardTingCardTableLen = table.maxn(huCardTingCardTable)
	local huCardCountIndex = 1
	local canPlayCarddropChess = cardColor..'-'..strNum
	for n = 1,huCardTingCardTableLen,1 do
		if canPlayCarddropChess == huCardTingCardTable[n].dropChess then
			OB_GameMainPanel.imgTingPaiTipsBGImage:SetActive(true)
			if huCardCountIndex > 10 then
				break
			end
			local strHuCard = string_split(huCardTingCardTable[n].huChess,'-')
			local huCardColor = tonumber(strHuCard[1])
			local huCardNum = tonumber(strHuCard[2])
			local fanCount = huCardTingCardTable[n].fan
			local leftCount = huCardTingCardTable[n].leftCount
			--加载点击听牌可以胡的牌
			local uiGo    = newObject(objs[0])
			local parent = OB_GameMainPanel.GridTingPai.transform
			uiGo.transform:SetParent(parent)
			uiGo.transform.localScale = Vector3.one
			uiGo.transform.localPosition = Vector3.zero
				--获取组件--
			local tingpaiBeiShuText 			= BasePanel:GOChild(uiGo,"tingpaiBeiShuText")
			local tingpaiZhangShuText 			= BasePanel:GOChild(uiGo,"tingpaiZhangShuText")
			--赋值信息--
			local cardNum    = ''
			if huCardNum < 10 then
				cardNum = '0' .. tostring(huCardNum)
			else
				cardNum = tostring(huCardNum)
			end
			tingpaiBeiShuText.transform:GetComponent('Text').text = '<color=#753d0c>'..fanCount..'</color>'..'倍'
			tingpaiZhangShuText.transform:GetComponent('Text').text = '<color=#753d0c>'..leftCount..'</color>'..'张'
			table.insert(gameRoom.TingCardNeiKuangObject,huCardCountIndex,uiGo)
			local name = 'color_'..  huCardColor  .. '_' ..cardNum
			local objs = Game.GetUICard(name)
			this.LoadHuTingCardImage(objs, huCardCountIndex,leftCount)
			huCardCountIndex = huCardCountIndex + 1
		end
	end



	if posSing == 1 then
		if huCardCountIndex == 2 then
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(275, 173)
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.anchoredPosition = Vector3.New(395,-50,0)
		elseif huCardCountIndex == 3 then
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(415, 173)
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.anchoredPosition = Vector3.New(340,-50,0)
		elseif huCardCountIndex == 4 then
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(550, 173)
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.anchoredPosition = Vector3.New(285,-50,0)
		elseif huCardCountIndex == 5 then
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(690, 173)
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.anchoredPosition = Vector3.New(230,-50,0)
		elseif huCardCountIndex == 6 then
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(830, 173)
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.anchoredPosition = Vector3.New(120,-50,0)
		elseif huCardCountIndex == 10 or huCardCountIndex == 7 or huCardCountIndex == 8 or huCardCountIndex == 9 or huCardCountIndex == 11 then
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(830, 265)
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.anchoredPosition = Vector3.New(120,-50,0)
		end
	else
		if huCardCountIndex == 2 then
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(275, 173)
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.anchoredPosition = Vector3.New(0,-180,0)
		elseif huCardCountIndex == 3 then
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(415, 173)
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.anchoredPosition = Vector3.New(0,-180,0)
		elseif huCardCountIndex == 4 then
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(550, 173)
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.anchoredPosition = Vector3.New(0,-180,0)
		elseif huCardCountIndex == 5 then
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(690, 173)
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.anchoredPosition = Vector3.New(0,-180,0)
		elseif huCardCountIndex == 6 then
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(830, 173)
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.anchoredPosition = Vector3.New(0,-180,0)
		elseif huCardCountIndex == 10 or huCardCountIndex == 7 or huCardCountIndex == 8 or huCardCountIndex == 9 or huCardCountIndex == 11  then
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.sizeDelta = Vector2.New(830, 265)
			OB_GameMainPanel.imgTingPaiTipsBG:GetComponent("Image").rectTransform.anchoredPosition = Vector3.New(0,-120,0)
		end
		
	end
end

--加载听牌的胡牌信息
function RoomRunStatic.LoadHuTingCardImage(objs,index,leftCount)
	local uiGo    = newObject(objs)
	local parent = OB_GameMainPanel.GridTingPaiCard.transform
	uiGo.transform:SetParent(parent)
	uiGo.transform.localScale = Vector3.one
	uiGo.transform.localPosition = Vector3.zero
	if leftCount == 0 then
		uiGo.transform:GetComponent("Image").color = Color.New(0.58,0.58,0.58,1)
	else
		uiGo.transform:GetComponent("Image").color = Color.New(1,1,1,1)
	end
	table.insert(gameRoom.TingCardCanHuObject,index,uiGo)
end

--点击听牌提示按钮显示之前的胡牌信息
function RoomRunStatic.tingCardBtnClick()
	OB_GameMainPanel.imgTingPaiTipsBGImage:SetActive(false)
	if next(gameRoom.TingCardNeiKuangObject) ~= nil then
		local len = table.maxn(gameRoom.TingCardNeiKuangObject)
		for i = len,1,-1  do 
			if gameRoom.TingCardNeiKuangObject[i].gameObject then
				gameRoom.TingCardNeiKuangObject[i].gameObject:Destroy()
			end
			table.remove (gameRoom.TingCardNeiKuangObject,i)
		end
	end
	resMgr:LoadPrefab('uimahjongprefabs', {'tingPaiNeiKuangImage'}, function(objs)
		this.LoadHuTingCard(objs, lastHuCardTabel,lastCardColor,lastCardNum,1)
	end)
end

--GM命令回调
function RoomRunStatic.OnInitGMRes(buffer)
	log('RoomRunStatic.OnInitGMRes')
	if next(gameRoom.myCards) ~= nil then
		local len = table.maxn(gameRoom.myCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.myCards,i)
		end
	end

	--清理UI牌数据以及对象
	if next(gameRoom.myUiCards) ~= nil then
		local len = table.maxn(gameRoom.myUiCards)
		for i = len,1,-1  do
			if gameRoom.myUiCards[i].gameObject then
				gameRoom.myUiCards[i].gameObject:Destroy()
			end
			table.remove (gameRoom.myUiCards,i)
		end
	end

	local data   = buffer:ReadBuffer()
	local msg    = InitChesses_pb.InitChessesRes()	
	msg:ParseFromString(data)
	
	gameRoom.initInfo.bankerIndex     = msg.zhuang    --庄的索引
	gameRoom.initInfo.startDrawIndex  = msg.zhuaIndex --在谁那开始抓牌索引
	gameRoom.initInfo.diceMin         = msg.shaiziMin --骰子最小数（从第几个开始抓牌）
	gameRoom.initInfo.diceMax         = msg.shaiziMax --骰子最大点数；	
	local len = table.maxn(msg.chessInfo)
	for i = 1,len,1 do
		  local info = ChessInfoVo:New() 
		  local v = msg.chessInfo[i]
	      info.id	 =  v.id -- 牌的唯一id
		  info.color =	v.color-- 牌的花色
		  info.num   =	v.num --牌的数值
		  info.used  =	v.used -- 牌是否被使用 0=没被用   1=被碰  2=被明杠 3=被暗杠 4=过路杠
		  logWarn('----------------------------> id:' .. info.id .. ' color:'..  info.color  .. ' num:' ..info.num)
		  table.insert(gameRoom.myCards,i,info)
	end
	this.InitGMCardShow()
end

function RoomRunStatic.InitGMCardShow()
	local myCardsLen = table.maxn(gameRoom.myCards)
	for i = 1,myCardsLen,1 do
		local chessInfo = gameRoom.myCards[i]
		local strNum    = ''
		if chessInfo.num < 10 then
			strNum = '0' .. tostring(chessInfo.num)
		else
			strNum = tostring(chessInfo.num)
		end
		local name = 'color_'..  chessInfo.color  .. '_' ..strNum
		local objs = Game.GetUICard(name)
		this.LoadCardGM(objs,i)
		--resMgr:LoadPrefab('uimahjongprefabs', { 'color_'..  chessInfo.color  .. '_' ..strNum}, this.LoadCardGM,i)
	end
end

--加载UI上的牌
function RoomRunStatic.LoadCardGM(objs,index)	
	 local chessInfo = gameRoom.myCards[index]
	--拍照到UI
	local uiGo    = newObject(objs)
	local image = uiGo.transform:GetComponent('Image')
	local mahUI = MahjongUiCard.New()
		
	mahUI.image = image
	local parent = OB_GameMainPanel.selfUiCardImage.transform
	uiGo.transform:SetParent(parent)
	local len = #gameRoom.myCards
	-- 复盘时该出牌时最后一个留一定的间隙
	local cell = 0
	if len % 3 == 2 and index == len then
		cell = 17
	end
	local x = myUiCardInitPos.x + 82 * index
	x = x + (14 - len) * 35
	local pos = Vector3.New(x + cell,myUiCardInitPos.y,0)
	mahUI.image.rectTransform.anchoredPosition = pos
	mahUI.image.rectTransform.localScale       = Vector3.New(1,1,1)
	mahUI.index = index
	
	local gameObj = Util.addComponent(mahUI.image.gameObject,'Button')
	Util.addComponent(gameObj, "UIDrag")
	mahUI.gameObject = gameObj
	mahUI.colorType = chessInfo.color
	mahUI.num        = chessInfo.num
	mahUI.id         = chessInfo.id
	local strNum = ""
	if mahUI.num < 10 then
			strNum = '0' .. tostring(mahUI.num)
		else
			strNum = tostring(chessInfo.num)
	end
	mahUI.image.name = mahUI.colorType..'_'..strNum..'_'..mahUI.id
	table.insert(gameRoom.myUiCards,index,mahUI)
	
	--为每张初始化的牌添加点击事件监听
	local luaBehavi = gameRoom.canvas.transform:GetComponent('LuaBehaviour')
	luaBehavi:RemoveClick(gameRoom.myUiCards[index].gameObject)
	luaBehavi:AddClick(gameRoom.myUiCards[index].gameObject, RoomRunStatic.OnPlayCardClick)
end

--用于回放的打牌消息
function RoomRunStatic.OnCardPlayHuiFang(buzhouId,data)
	local playChess, info
	playChess = {}
	
	playChess.roleId      = data.roleId       --打牌人roleId
    playChess.roleIndex   = data.roleIndex    --打牌人Index
    --这里存步骤ID用来做碰杠回退被碰杠牌玩家索引
    playChess.buzhouId   = buzhouId           --打牌时步骤
    table.insert(playCardBuZhouTable,playChess)
	
	info = PlayChess:New()
	info.id    = data.chessInfo.id   	-- 牌的唯一id
	info.color = data.chessInfo.color   -- 牌的花色
	info.num   = data.chessInfo.num     --牌的数值
	info.used  = data.chessInfo.used 	-- 牌是否被使用 0=没被用   1=被碰  2=被明杠 3=被暗杠 4=过路杠
	playChess.chessInfo   = info
	logWarn('----------------------------> id:' .. info.id .. ' color:'..  info.color  .. ' num:' ..info.num)

	local location = getOtherPlayerLocation( playChess.roleIndex )
	if location == 'D' then
		table.insert(gameRoom.myPlayCards,PlayCardIndex.DIndex,info)
	elseif location == 'R' then
		table.insert(gameRoom.RPlayCards,PlayCardIndex.RIndex,info)
	elseif location == 'L' then
		table.insert(gameRoom.LPlayCards,PlayCardIndex.LIndex,info)
	elseif location == 'U' then
		table.insert(gameRoom.UPlayCards,PlayCardIndex.UIndex,info)
	else
		logWarn('--------------------------->位置信息错误')
	end
	local strNum    = ''
	if info.num < 10 then
		strNum = '0' .. tostring(info.num)
	else
		strNum = tostring(info.num)
	end
	local chess =tostring("color_"..info.color.."_"..strNum)
	global.playChess = playChess
	this.PlayCardShowHuiFang(location, false,data.chessInfo.id)
	--Game.ChangeLanguage(chess)
end

--删除手里的牌数据以及UI图片并且生成打下去牌的模型列表(用于回放)
function RoomRunStatic.PlayCardShowHuiFang(location, isReload,id)
	local objMoCard = nil
	local objDaCard = nil
	local playChessID = id	
	if location == 'D' then
		if not isReload then
			local len = table.maxn(gameRoom.myUiCards)
			for i = len,1,-1  do 
				local myUiCardsId = gameRoom.myUiCards[i].id
				if myUiCardsId == playChessID then
					gameRoom.myUiCards[i].gameObject:Destroy()
					table.remove (gameRoom.myUiCards,i)
					table.remove (gameRoom.myCards, i)
					break	
				end
			end
		end

		--加载自己打下去的牌
		chessInfo = gameRoom.myPlayCards[PlayCardIndex.DIndex]
		this.OutModel(chessInfo,PlayCardIndex.DIndex,'D')
		PlayCardIndex.DIndex = PlayCardIndex.DIndex +1
		if not isReload then
			this.CardSort()	
		end
		--加载右边打下去的牌
	elseif location == 'R' then
		if not isReload then
			local len = table.maxn(gameRoom.rightModelChardMap)
			for i = len,1,-1 do
				local strAr = string_split(gameRoom.rightModelChardMap[i].name,'_')
				local cardId = tonumber(strAr[3])
				if playChessID == cardId then
					objMoCard = gameRoom.rightModelChardMap[i]
					objMoCard:SetActive(false)
					table.remove (gameRoom.rightModelChardMap,i)
					break
				end
			end
		end
		chessInfo = gameRoom.RPlayCards[PlayCardIndex.RIndex]
		this.OutModel(chessInfo,PlayCardIndex.RIndex,'R')
		PlayCardIndex.RIndex = PlayCardIndex.RIndex +1
		this.CardSortOther(location,false)
		--加载左边打下去的牌
	elseif location == 'L' then
		if not isReload then
			local len = table.maxn(gameRoom.leftModelChardMap)
			for i = len,1,-1 do
				local strAr = string_split(gameRoom.leftModelChardMap[i].name,'_')
				local cardId = tonumber(strAr[3])
				if playChessID == cardId then
					objMoCard = gameRoom.leftModelChardMap[i]
					objMoCard:SetActive(false)
					table.remove (gameRoom.leftModelChardMap,i)
					break
				end
			end
		end

		chessInfo = gameRoom.LPlayCards[PlayCardIndex.LIndex]
		this.OutModel(chessInfo,PlayCardIndex.LIndex,'L')
		PlayCardIndex.LIndex = PlayCardIndex.LIndex +1
		this.CardSortOther(location,false)
		--加载对面打下去的牌
	elseif location == 'U' then
		if not isReload then
			local len = table.maxn(gameRoom.upModelChardMap)
			for i = len,1,-1 do
				local strAr = string_split(gameRoom.upModelChardMap[i].name,'_')
				local cardId = tonumber(strAr[3])
				if playChessID == cardId then
					objMoCard = gameRoom.upModelChardMap[i]
					objMoCard:SetActive(false)
					table.remove (gameRoom.upModelChardMap,i)
					break
				end
			end
		end
		chessInfo = gameRoom.UPlayCards[PlayCardIndex.UIndex]
		this.OutModel(chessInfo,PlayCardIndex.UIndex,'U')
		PlayCardIndex.UIndex = PlayCardIndex.UIndex +1
		this.CardSortOther(location,false)
	else
		logWarn('-------------------------------->加载错误')
	end
	gameRoom.objMoCard = objMoCard
	gameRoom.objDaCard = objDaCard
end

--用于回放的标签消息
function RoomRunStatic.OnCardPushSignHuiFang(data)
	local chessCardSigns = data.signs
	local roleId = data.roleId

	-- 临时标记是否该自己打牌
	if gameRoom.canPlayCard then
		this.canPlayCard = true
	end
	gameRoom.canPlayCard = false
	if this.selectCard then
		pos = this.selectCard.transform.position
		pos.y = pos.y - 0.4
		this.selectCard.transform.position = pos
		GameRoom.SetColor(this.selectCard.name)
		this.selectCard = nil
	end
	this.isSign = true

	this.cardSignsUIShow(chessCardSigns)
end

--用于回放标签操作消息
function RoomRunStatic.OnCardPushSignOperateHuiFang(data,buzhouId)
	this.isSign = false
	local signOperateChess = SignOperateChess.New()
	signOperateChess.roleId      = data.roleId     
    signOperateChess.roleIndex   = data.roleIndex    
	signOperateChess.signType 	 = data.signType	
	local len = table.maxn(data.chessInfo)		
	local location = getOtherPlayerLocation(signOperateChess.roleIndex)
	if location == 'D' then
		OB_GameMainPanel.imgPengGangHuBG:SetActive(false)
	end
	if gameRoom.lastIndex == nil then
		gameRoom.lastIndex = signOperateChess.roleIndex
		gameRoom.lastType = signOperateChess.signType
	else 
		gameRoom.lastIndex = signOperateChess.roleIndex
		gameRoom.lastType = signOperateChess.signType
		print("-------lastIndex------------lastType---",gameRoom.lastIndex,gameRoom.lastType)
	end
	RoomRunStatic.EffectShow(location,signOperateChess.signType)
	if data.signType == SingType.SING_HU then
		OB_GameMainCtrl.ShowTableEffect(location,'effect_hu')
		OB_GameMainCtrl.ShowTableEffect(location,'effect_huguang')
	end
	if data.signType == SingType.SING_ZIMO then
		OB_GameMainCtrl.ShowTableEffect(location,'effect_zimo')
		OB_GameMainCtrl.ShowTableEffect(location,'effect_huguang')
	end

	if signOperateChess.signType == SingType.SING_PENG then
		OB_GameMainCtrl:HeadIcon(signOperateChess.roleIndex)
		OB_GameMainCtrl.CountDown(true)
	end

	--清除之前碰杠的数据
	if next(gameRoom.myPengGangCards) ~= nil then
		local len = table.maxn(gameRoom.myPengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.myPengGangCards,i)
		end
	end
	
	if next(gameRoom.leftPengGangCards) ~= nil then
		local len = table.maxn(gameRoom.leftPengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.leftPengGangCards,i)
		end
	end
	
	if next(gameRoom.rightPengGangCards) ~= nil then
		local len = table.maxn(gameRoom.rightPengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.rightPengGangCards,i)
		end
	end
	
	if next(gameRoom.oppsPengGangCards) ~= nil then
		local len = table.maxn(gameRoom.oppsPengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.oppsPengGangCards,i)
		end
	end

	if next(gameRoom.PengGangCards) ~= nil then
		local len = table.maxn(gameRoom.PengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.PengGangCards,i)
		end
	end

	for i = 1,len,1 do
		  local info = SignOperateChess:New() 
		  local v = data.chessInfo[i]
	      info.id	 =  v.id -- 牌的唯一id
		  info.color =	v.color-- 牌的花色
		  info.num   =	v.num --牌的数值
		  info.used  =	v.used -- 牌是否被使用 0=没被用   1=被碰  2=被明杠 3=被暗杠 4=过路杠
		  print('RoomRunStatic.OnCardPushSignOperateHuiFang1',info.id)
		  
		if location == 'D' then
			table.insert(gameRoom.myPengGangCards,i,info)
		elseif location == 'R' then
			table.insert(gameRoom.rightPengGangCards,i,info)
		elseif location == 'L' then
			table.insert(gameRoom.leftPengGangCards,i,info)
		elseif location == 'U' then
			table.insert(gameRoom.oppsPengGangCards,i,info)
		end
		table.insert(gameRoom.PengGangCards,i,info)
	end 

	if global.signOperateChess.signType ~= SingType.SING_GUOLUGANG then
		if location == 'D' then
			signOperateChess.chessInfo   = gameRoom.myPengGangCards    --牌的列表
		elseif location == 'R' then
			signOperateChess.chessInfo   = gameRoom.rightPengGangCards    --牌的列表
		elseif location == 'L' then
			signOperateChess.chessInfo   = gameRoom.leftPengGangCards    --牌的列表
		elseif location == 'U' then
			signOperateChess.chessInfo   = gameRoom.oppsPengGangCards    --牌的列表
		end
	end
	global.signOperateChess = signOperateChess

	--如果标签为胡或者自摸的话不更新表现层,直接返回
	if global.signOperateChess.signType == SingType.SING_HU or global.signOperateChess.signType == SingType.SING_ZIMO  then
		gameRoom.isWin = gameRoom.isWin+1
		return
	elseif signOperateChess.signType == SingType.SING_PENG and signOperateChess.roleId == global.userVo.roleId then
		gameRoom.canPlayCard = true
	elseif this.canPlayCard then
		gameRoom.canPlayCard = true
	end
	this.canPlayCard = false
	if  global.signOperateChess.signType == SingType.SING_GUO then
		return
	end
	OB_GameMainPanel.imgPlayCardDirection.transform.position = Vector3.New(0,500,0)
	if global.signOperateChess.signType ~= SingType.SING_ANGANG and global.signOperateChess.signType ~= SingType.SING_GUOLUGANG then
		this.delPlayCardPengGangShowHuiFang(buzhouId)
	end
	this.SignOperateCardShowHuiFang(location, signOperateChess.signType)
end

--标签操作牌显示(用于回放)
function RoomRunStatic.SignOperateCardShowHuiFang(location, signType, start)
	print("-----------------SignOperateCardShow ", location)
	local posD = Vector3.New(0,-80,-4)
	local posU = Vector3.New(0,210,-4)
	local posR = Vector3.New(250,80,-4)
	local posL = Vector3.New(-250,80,-4)
	--如果是自己
	if location == 'D' then
		local myUiCardLen = table.maxn(gameRoom.myUiCards)
		local myPengGangCardLen = table.maxn(gameRoom.myPengGangCards)

		for i = myUiCardLen,1,-1 do
			for j = myPengGangCardLen,1,-1 do
				local myUiCardsId = gameRoom.myUiCards[i].id
				local myPengGangCardId = gameRoom.myPengGangCards[j].id
				if myUiCardsId == myPengGangCardId then
					gameRoom.myUiCards[i].gameObject:Destroy()
					table.remove (gameRoom.myUiCards,i)
					table.remove (gameRoom.myCards,i)
					break
				end
			end
		end
		this.CardSort()
		this.CheckPengGangCard(myPengGangCardLen,gameRoom.myPengGangCards,location, signType, start)
	elseif location == 'R' then
		local rightModelCardlen = table.maxn(gameRoom.rightModelChardMap)
		local rightPengGangCardLen = table.maxn(gameRoom.rightPengGangCards)
		for i = rightModelCardlen,1,-1 do
			for j = rightPengGangCardLen,1,-1 do
				local strAr = string_split(gameRoom.rightModelChardMap[i].name,'_')
				local cardId = tonumber(strAr[3])
				if gameRoom.rightPengGangCards[j].id == cardId then
					gameRoom.rightModelChardMap[i].gameObject:SetActive(false)
					table.remove (gameRoom.rightModelChardMap,i)
					break
				end
			end
		end
		this.CardSortOther(location,false)
		this.CheckPengGangCard(rightPengGangCardLen,gameRoom.rightPengGangCards,location, signType, start)
	elseif location == 'L' then
		local leftModelCardlen = table.maxn(gameRoom.leftModelChardMap)
		local leftPengGangCardLen = table.maxn(gameRoom.leftPengGangCards)
		for i = leftModelCardlen,1,-1 do
			for j = leftPengGangCardLen,1,-1 do
				local strAr = string_split(gameRoom.leftModelChardMap[i].name,'_')
				local cardId = tonumber(strAr[3])
				if gameRoom.leftPengGangCards[j].id == cardId then
					gameRoom.leftModelChardMap[i].gameObject:SetActive(false)
					table.remove (gameRoom.leftModelChardMap,i)
					break
				end
			end
		end
		this.CardSortOther(location,false)
		this.CheckPengGangCard(leftPengGangCardLen,gameRoom.leftPengGangCards,location, signType, start)
	elseif location == 'U' then
		local upModelCardlen = table.maxn(gameRoom.upModelChardMap)
		local oppsPengGangCardLen = table.maxn(gameRoom.oppsPengGangCards)
		for i = upModelCardlen,1,-1 do
			for j = oppsPengGangCardLen,1,-1 do
				local strAr = string_split(gameRoom.upModelChardMap[i].name,'_')
				local cardId = tonumber(strAr[3])
				if gameRoom.oppsPengGangCards[j].id == cardId then
					gameRoom.upModelChardMap[i].gameObject:SetActive(false)
					table.remove (gameRoom.upModelChardMap,i)
					break
				end
			end
		end
		this.CardSortOther(location,false)
		this.CheckPengGangCard(oppsPengGangCardLen,gameRoom.oppsPengGangCards,location, signType, start)
	end
end

--其他人牌排序（目前用于打牌摸牌回放回退）
function RoomRunStatic.CardSortOtherHuiFangHuiTui(location)
	local PosArrayHuiFangHuiTui = {}
	if location == "R" then
		local ar = gameRoom.rightModelChardMap
		local len = #ar
		for i = 1, len do
			local pos = ar[i].transform.position
			table.insert(PosArrayHuiFangHuiTui,pos)
		end

		table.sort(gameRoom.rightModelChardMap,function(a,b) return a.name<b.name end )
		for j = 1,len do
			ar[j].transform.position = PosArrayHuiFangHuiTui[j]
		end
	elseif location == "L" then
		local ar = gameRoom.leftModelChardMap
		local len = #ar
		for i = 1, len do
			local pos = ar[i].transform.position
			table.insert(PosArrayHuiFangHuiTui,pos)
		end

		table.sort(gameRoom.leftModelChardMap,function(a,b) return a.name<b.name end )
		for j = 1,len do
			ar[j].transform.position = PosArrayHuiFangHuiTui[j]
		end
	elseif location == "U" then
		local ar = gameRoom.upModelChardMap
		local len = #ar
		for i = 1, len do
			local pos = ar[i].transform.position
			table.insert(PosArrayHuiFangHuiTui,pos)
		end
		table.sort(gameRoom.upModelChardMap,function(a,b) return a.name<b.name end )
		for j = 1,len do
			ar[j].transform.position = PosArrayHuiFangHuiTui[j]
		end
	end
end

--用于回放的打牌回退消息
function RoomRunStatic.OnCardPlayHuiFangHuiTui(data)
	local playChess, info
	playChess = {}
	
	playChess.roleId      = data.roleId       --打牌人roleId
    playChess.roleIndex   = data.roleIndex    --打牌人Index
	
	info = PlayChess:New()
	info.id    = data.chessInfo.id   	-- 牌的唯一id
	info.color = data.chessInfo.color   -- 牌的花色
	info.num   = data.chessInfo.num     --牌的数值
	info.used  = data.chessInfo.used 	-- 牌是否被使用 0=没被用   1=被碰  2=被明杠 3=被暗杠 4=过路杠
	playChess.chessInfo   = info
	logWarn('----------------------------> id:' .. info.id .. ' color:'..  info.color  .. ' num:' ..info.num)

	local strNum    = ''
	if playChess.chessInfo.num < 10 then
		strNum = '0' .. tostring(playChess.chessInfo.num)
	else
		strNum = tostring(playChess.chessInfo.num)
	end
	local name = 'color_'..  playChess.chessInfo.color  .. '_' ..strNum

	local location = getOtherPlayerLocation( playChess.roleIndex )
	if location == 'D' then
		local len = table.maxn(gameRoom.myPlayCards)
		for i = len,1,-1  do 
			local myPlayCardsId = gameRoom.myPlayCards[i].id
			if myPlayCardsId == playChess.chessInfo.id then
				gameRoom.PlayModelCardDMap[i].gameObject:Destroy()
				table.remove (gameRoom.PlayModelCardDMap,i)
				table.remove (gameRoom.myPlayCards,i)
				PlayCardIndex.DIndex = PlayCardIndex.DIndex -1
				break
			end
		end
		if PlayCardIndex.DIndex <= 7 then
			selfPlayPos  = Vector3.New(selfPlayPos.x - CardJianJu,selfPlayPos.y,selfPlayPos.z)				
		elseif PlayCardIndex.DIndex <= 14 then
			selfTwoLinePlayPos  = Vector3.New(selfTwoLinePlayPos.x - CardJianJu,selfTwoLinePlayPos.y,selfTwoLinePlayPos.z)				 
		elseif PlayCardIndex.DIndex <= 21 then
			selfThreeLinePlayPos  = Vector3.New(selfThreeLinePlayPos.x - CardJianJu,selfThreeLinePlayPos.y,selfThreeLinePlayPos.z)				 
		elseif PlayCardIndex.DIndex <= 28 then
			selfFourLinePlayPos  = Vector3.New(selfFourLinePlayPos.x - CardJianJu,selfFourLinePlayPos.y,selfFourLinePlayPos.z)				
		end
		
		local objs = Game.GetUICard(name)
		GameRoom.LoadCardHuiFangHuiTui(objs,playChess.chessInfo)
		this.CardSort()
	elseif location == 'R' then
		local len = table.maxn(gameRoom.RPlayCards)
		for i = len,1,-1  do 
			local rPlayCardsId = gameRoom.RPlayCards[i].id
			if rPlayCardsId == playChess.chessInfo.id then
				gameRoom.PlayModelCardRMap[i].gameObject:Destroy()
				table.remove (gameRoom.PlayModelCardRMap,i)
				table.remove (gameRoom.RPlayCards,i)
				PlayCardIndex.RIndex = PlayCardIndex.RIndex -1
				break
			end
		end
		if PlayCardIndex.RIndex <= 7 then
			rightPlayPos  = Vector3.New(rightPlayPos.x ,rightPlayPos.y,rightPlayPos.z-CardJianJu)				
		elseif PlayCardIndex.RIndex <= 14 then
			rightTwoLinePlayPos  = Vector3.New(rightTwoLinePlayPos.x,rightTwoLinePlayPos.y,rightTwoLinePlayPos.z- CardJianJu)				
		elseif PlayCardIndex.RIndex <= 21 then
			rightThreeLinePlayPos  = Vector3.New(rightThreeLinePlayPos.x,rightThreeLinePlayPos.y,rightThreeLinePlayPos.z- CardJianJu)				
		elseif PlayCardIndex.RIndex <= 28 then
			rightFourLinePlayPos  = Vector3.New(rightFourLinePlayPos.x,rightFourLinePlayPos.y,rightFourLinePlayPos.z-CardJianJu)				
		end
		
		local objs = Game.GetObjCard(name)
		GameRoom.LoadRightCardHuiFangHuiTui(objs,playChess.chessInfo)
		this.CardSortOtherHuiFangHuiTui(location)
	elseif location == 'L' then
		local len = table.maxn(gameRoom.LPlayCards)
		for i = len,1,-1  do 
			local lPlayCardsId = gameRoom.LPlayCards[i].id
			if lPlayCardsId == playChess.chessInfo.id then
				gameRoom.PlayModelCardLMap[i].gameObject:Destroy()
				table.remove (gameRoom.PlayModelCardLMap,i)
				table.remove (gameRoom.LPlayCards,i)
				PlayCardIndex.LIndex = PlayCardIndex.LIndex -1
				break
			end
		end
		if PlayCardIndex.LIndex <= 7 then
			leftPlayPos  = Vector3.New(leftPlayPos.x,leftPlayPos.y,leftPlayPos.z+CardJianJu)				
		elseif PlayCardIndex.LIndex <= 14 then
			leftTwoLinePlayPos  = Vector3.New(leftTwoLinePlayPos.x,leftTwoLinePlayPos.y,leftTwoLinePlayPos.z+CardJianJu)				
		elseif PlayCardIndex.LIndex <= 21 then
			leftThreeLinePlayPos  = Vector3.New(leftThreeLinePlayPos.x ,leftThreeLinePlayPos.y,leftThreeLinePlayPos.z+CardJianJu)				 
		elseif PlayCardIndex.LIndex <= 28 then
			leftFourLinePlayPos  = Vector3.New(leftFourLinePlayPos.x,leftFourLinePlayPos.y,leftFourLinePlayPos.z+CardJianJu)	
		end
		
		local objs = Game.GetObjCard(name)
		GameRoom.LoadLeftCardHuiFangHuiTui(objs,playChess.chessInfo)
		this.CardSortOtherHuiFangHuiTui(location)
	elseif location == 'U' then
		local len = table.maxn(gameRoom.UPlayCards)
		for i = len,1,-1  do 
			local uPlayCardsId = gameRoom.UPlayCards[i].id
			if uPlayCardsId == playChess.chessInfo.id then
				gameRoom.PlayModelCardUMap[i].gameObject:Destroy()
				table.remove (gameRoom.PlayModelCardUMap,i)
				table.remove (gameRoom.UPlayCards,i)
				PlayCardIndex.UIndex = PlayCardIndex.UIndex -1
				break
			end
		end
		if PlayCardIndex.UIndex <= 7 then
			oppsPlayPos  = Vector3.New(oppsPlayPos.x+CardJianJu ,oppsPlayPos.y,oppsPlayPos.z)				
		elseif PlayCardIndex.UIndex <= 14 then
			oppsTwoLinePlayPos  = Vector3.New(oppsTwoLinePlayPos.x+CardJianJu,oppsTwoLinePlayPos.y,oppsTwoLinePlayPos.z)				
		elseif PlayCardIndex.UIndex <= 21 then
			oppsThreeLinePlayPos  = Vector3.New(oppsThreeLinePlayPos.x+CardJianJu,oppsThreeLinePlayPos.y,oppsThreeLinePlayPos.z)				 
		elseif PlayCardIndex.UIndex <= 28 then
			oppsFourLinePlayPos  = Vector3.New(oppsFourLinePlayPos.x+CardJianJu,oppsFourLinePlayPos.y,oppsFourLinePlayPos.z)				
		end
		
		local objs = Game.GetObjCard(name)
		GameRoom.LoadUpCardHuiFangHuiTui(objs,playChess.chessInfo)
		this.CardSortOtherHuiFangHuiTui(location)
	else
		logWarn('--------------------------->位置信息错误')
	end
	
	OB_GameMainPanel.imgPlayCardDirection.transform.position = Vector3.New(0,500,0)
	if OB_GameMainCtrl.isCreate then
		OB_GameMainCtrl:HeadIcon(global.firstMoChess.roleIndex)
		OB_GameMainCtrl.CountDown(true)
	end
end

--用于回放标签操作回退消息
function RoomRunStatic.OnCardPushSignOperateHuiFangHuiTui(data,buzhouId)
	this.isSign = false
	global.signOperateChess = {}
	local signOperateChess = SignOperateChess.New()
	signOperateChess.roleId      = data.roleId     
    signOperateChess.roleIndex   = data.roleIndex    
	signOperateChess.signType 	 = data.signType	
	local len = table.maxn(data.chessInfo)		
	local location = getOtherPlayerLocation(signOperateChess.roleIndex)
	if gameRoom.lastIndex == nil then
		gameRoom.lastIndex = signOperateChess.roleIndex
		gameRoom.lastType = signOperateChess.signType
	else 
		gameRoom.lastIndex = signOperateChess.roleIndex
		gameRoom.lastType = signOperateChess.signType
		print("-------lastIndex------------lastType---",gameRoom.lastIndex,gameRoom.lastType)
	end
	--RoomRunStatic.EffectShow(location,signOperateChess.signType)

	if signOperateChess.signType == SingType.SING_PENG then
		OB_GameMainCtrl:HeadIcon(signOperateChess.roleIndex)
		OB_GameMainCtrl.CountDown(true)
	end

	--清除之前碰杠的数据
	if next(gameRoom.myPengGangCards) ~= nil then
		local len = table.maxn(gameRoom.myPengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.myPengGangCards,i)
		end
	end
	
	if next(gameRoom.leftPengGangCards) ~= nil then
		local len = table.maxn(gameRoom.leftPengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.leftPengGangCards,i)
		end
	end
	
	if next(gameRoom.rightPengGangCards) ~= nil then
		local len = table.maxn(gameRoom.rightPengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.rightPengGangCards,i)
		end
	end
	
	if next(gameRoom.oppsPengGangCards) ~= nil then
		local len = table.maxn(gameRoom.oppsPengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.oppsPengGangCards,i)
		end
	end

	if next(gameRoom.PengGangCards) ~= nil then
		local len = table.maxn(gameRoom.PengGangCards)
		for i = len,1,-1  do 
			table.remove (gameRoom.PengGangCards,i)
		end
	end

	for i = 1,len,1 do
		  local info = SignOperateChess:New() 
		  local v = data.chessInfo[i]
	      info.id	 =  v.id -- 牌的唯一id
		  info.color =	v.color-- 牌的花色
		  info.num   =	v.num --牌的数值
		  info.used  =	v.used -- 牌是否被使用 0=没被用   1=被碰  2=被明杠 3=被暗杠 4=过路杠
		  
		if location == 'D' then
			table.insert(gameRoom.myPengGangCards,i,info)
		elseif location == 'R' then
			table.insert(gameRoom.rightPengGangCards,i,info)
		elseif location == 'L' then
			table.insert(gameRoom.leftPengGangCards,i,info)
		elseif location == 'U' then
			table.insert(gameRoom.oppsPengGangCards,i,info)
		end
		table.insert(gameRoom.PengGangCards,i,info)
	end 

	if global.signOperateChess.signType ~= SingType.SING_GUOLUGANG then
		if location == 'D' then
			signOperateChess.chessInfo   = gameRoom.myPengGangCards    --牌的列表
		elseif location == 'R' then
			signOperateChess.chessInfo   = gameRoom.rightPengGangCards    --牌的列表
		elseif location == 'L' then
			signOperateChess.chessInfo   = gameRoom.leftPengGangCards    --牌的列表
		elseif location == 'U' then
			signOperateChess.chessInfo   = gameRoom.oppsPengGangCards    --牌的列表
		end
	end
	global.signOperateChess = signOperateChess

	--如果标签为胡或者自摸的话不更新表现层,直接返回
	if global.signOperateChess.signType == SingType.SING_HU or global.signOperateChess.signType == SingType.SING_ZIMO  then
		gameRoom.isWin = gameRoom.isWin-1
		return
	elseif signOperateChess.signType == SingType.SING_PENG and signOperateChess.roleId == global.userVo.roleId then
		gameRoom.canPlayCard = true
	elseif this.canPlayCard then
		gameRoom.canPlayCard = true
	end
	this.canPlayCard = false
	if  global.signOperateChess.signType == SingType.SING_GUO then
		return
	end
	OB_GameMainPanel.imgPlayCardDirection.transform.position = Vector3.New(0,500,0)
	if global.signOperateChess.signType ~= SingType.SING_ANGANG and global.signOperateChess.signType ~= SingType.SING_GUOLUGANG then
		this.addPlayCardPengGangShowHuiFang(buzhouId)
	end
	this.SignOperateCardShowHuiFangHuiTui(location, signOperateChess.signType)
end

--添加打下去被碰或者杠的牌（用于回放回退操作）
function RoomRunStatic.addPlayCardPengGangShowHuiFang(buzhouId)
	local playChessRoleIndex
	for i = #playCardBuZhouTable,1,-1 do
		if playCardBuZhouTable[i].buzhouId < buzhouId then
			playChessRoleIndex = playCardBuZhouTable[i].roleIndex
			break
		end
	end
	local location = getOtherPlayerLocation(playChessRoleIndex)
	print('RoomRunStatic.addPlayCardPengGangShowHuiFang1111',location,global.playChess.roleIndex,playChessRoleIndex)
	if location == 'D' then
		local pengGangCardsLen = table.maxn(gameRoom.PengGangCards)
		for j = pengGangCardsLen,1,-1 do
			table.insert (gameRoom.myPlayCards,PlayCardIndex.DIndex,gameRoom.PengGangCards[j])
			this.OutModel(gameRoom.PengGangCards[j],PlayCardIndex.DIndex,location)
			PlayCardIndex.DIndex = PlayCardIndex.DIndex + 1
			break
		end
		print('自己打牌被碰',#gameRoom.myPlayCards,pengGangCardsLen)
	elseif location == 'R' then
		local pengGangCardsLen = table.maxn(gameRoom.PengGangCards)
		for j = pengGangCardsLen,1,-1 do
			table.insert (gameRoom.RPlayCards,PlayCardIndex.RIndex,gameRoom.PengGangCards[j])
			this.OutModel(gameRoom.PengGangCards[j],PlayCardIndex.RIndex,location)
			PlayCardIndex.RIndex = PlayCardIndex.RIndex + 1
			break
		end
		print('右边打牌被碰',#gameRoom.RPlayCards,pengGangCardsLen)
	elseif location == 'L' then
		local PengGangCardsLen = table.maxn(gameRoom.PengGangCards)
		for j = PengGangCardsLen,1,-1 do
			table.insert (gameRoom.LPlayCards,PlayCardIndex.LIndex,gameRoom.PengGangCards[j])
			this.OutModel(gameRoom.PengGangCards[j],PlayCardIndex.LIndex,location)
			PlayCardIndex.LIndex = PlayCardIndex.LIndex + 1
			break
		end
		print('左边打牌被碰',#gameRoom.LPlayCards,PengGangCardsLen)
	elseif location == 'U' then
		local PengGangCardsLen = table.maxn(gameRoom.PengGangCards)
		for j = PengGangCardsLen,1,-1 do
			table.insert (gameRoom.UPlayCards,PlayCardIndex.UIndex,gameRoom.PengGangCards[j])
			this.OutModel(gameRoom.PengGangCards[j],PlayCardIndex.UIndex,location)
			PlayCardIndex.UIndex = PlayCardIndex.UIndex + 1
			break
		end
		print('对面打牌被碰',#gameRoom.UPlayCards,PengGangCardsLen)
	end
end

--标签操作牌显示(用于回放回退操作)
function RoomRunStatic.SignOperateCardShowHuiFangHuiTui(location, signType, start)
	print("-----------------SignOperateCardShowHuiFangHuiTui ", location)
	local posD = Vector3.New(0,-80,-4)
	local posU = Vector3.New(0,210,-4)
	local posR = Vector3.New(250,80,-4)
	local posL = Vector3.New(-250,80,-4)
	--如果是自己
	if location == 'D' then
		local myPengGangCardLen = table.maxn(gameRoom.myPengGangCards)
		for i = 1,myPengGangCardLen,1 do
			myAddCount = myAddCount + 1
			local strNum    = ''
			if gameRoom.myPengGangCards[myAddCount].num < 10 then
				strNum = '0' .. tostring(gameRoom.myPengGangCards[myAddCount].num)
			else
				strNum = tostring(gameRoom.myPengGangCards[myAddCount].num)
			end
			local name = 'color_'..  gameRoom.myPengGangCards[myAddCount].color  .. '_' ..strNum
			local objs = Game.GetUICard(name)
			GameRoom.LoadCardHuiFangHuiTui(objs,gameRoom.myPengGangCards[myAddCount])
			if signType == SingType.SING_PENG then
				if myAddCount == 2 then
					break
				end
			elseif signType == SingType.SING_ANGANG then
				if myAddCount == 4 then
					break
				end
			elseif signType == SingType.SING_MINGGANG then
				if myAddCount == 3 then
					break
				end
			elseif signType == SingType.SING_GUOLUGANG then
				if myAddCount == 1 then
					break
				end
			end
		end
		myAddCount = 0
		this.CardSort()
	elseif location == 'R' then
		local rightPengGangCardLen = table.maxn(gameRoom.rightPengGangCards)
		for i = 1,rightPengGangCardLen,1 do
			rightAddCount = rightAddCount + 1
			local strNum    = ''
			if gameRoom.rightPengGangCards[rightAddCount].num < 10 then
				strNum = '0' .. tostring(gameRoom.rightPengGangCards[rightAddCount].num)
			else
				strNum = tostring(gameRoom.rightPengGangCards[rightAddCount].num)
			end
			local name = 'color_'..  gameRoom.rightPengGangCards[rightAddCount].color  .. '_' ..strNum
			local objs = Game.GetObjCard(name)
			GameRoom.LoadRightCardHuiFangHuiTui(objs,gameRoom.rightPengGangCards[rightAddCount])
			if signType == SingType.SING_PENG then
				if rightAddCount == 2 then
					break
				end
			elseif signType == SingType.SING_ANGANG then
				if rightAddCount == 4 then
					break
				end
			elseif signType == SingType.SING_MINGGANG then
				if rightAddCount == 3 then
					break
				end
			elseif signType == SingType.SING_GUOLUGANG then
				if rightAddCount == 1 then
					break
				end
			end
		end
		rightAddCount = 0
		this.CardSortOther(location,false)
	elseif location == 'L' then
		local leftPengGangCardLen = table.maxn(gameRoom.leftPengGangCards)
		for i = 1,leftPengGangCardLen,1 do
			leftAddCount = leftAddCount + 1
			local strNum    = ''
			if gameRoom.leftPengGangCards[leftAddCount].num < 10 then
				strNum = '0' .. tostring(gameRoom.leftPengGangCards[leftAddCount].num)
			else
				strNum = tostring(gameRoom.leftPengGangCards[leftAddCount].num)
			end
			local name = 'color_'..  gameRoom.leftPengGangCards[leftAddCount].color  .. '_' ..strNum
			local objs = Game.GetObjCard(name)
			GameRoom.LoadLeftCardHuiFangHuiTui(objs,gameRoom.leftPengGangCards[leftAddCount])
			if signType == SingType.SING_PENG then
				if leftAddCount == 2 then
					break
				end
			elseif signType == SingType.SING_ANGANG then
				if leftAddCount == 4 then
					break
				end
			elseif signType == SingType.SING_MINGGANG then
				if leftAddCount == 3 then
					break
				end
			elseif signType == SingType.SING_GUOLUGANG then
				if leftAddCount == 1 then
					break
				end
			end
		end
		leftAddCount = 0
		this.CardSortOther(location,false)
	elseif location == 'U' then
		local oppsPengGangCardLen = table.maxn(gameRoom.oppsPengGangCards)
		for i = 1,oppsPengGangCardLen,1 do
			upAddCount = upAddCount + 1
			local strNum    = ''
			if gameRoom.oppsPengGangCards[upAddCount].num < 10 then
				strNum = '0' .. tostring(gameRoom.oppsPengGangCards[upAddCount].num)
			else
				strNum = tostring(gameRoom.oppsPengGangCards[upAddCount].num)
			end
			local name = 'color_'..  gameRoom.oppsPengGangCards[upAddCount].color  .. '_' ..strNum
			local objs = Game.GetObjCard(name)
			GameRoom.LoadUpCardHuiFangHuiTui(objs,gameRoom.oppsPengGangCards[upAddCount])
			if signType == SingType.SING_PENG then
				if upAddCount == 2 then
					break
				end
			elseif signType == SingType.SING_ANGANG then
				if upAddCount == 4 then
					break
				end
			elseif signType == SingType.SING_MINGGANG then
				if upAddCount == 3 then
					break
				end
			elseif signType == SingType.SING_GUOLUGANG then
				if upAddCount == 1 then
					break
				end
			end
		end
		upAddCount = 0
		this.CardSortOther(location,false)
	end
	for i = #allPengGangModelMap,1,-1 do
		allRemoveCount = allRemoveCount + 1
		allPengGangModelMap[i].gameObject:Destroy()
		table.remove(allPengGangModelMap,i)
		if signType == SingType.SING_PENG then
			if allRemoveCount == 3 then
				break
			end
		elseif signType == SingType.SING_ANGANG then
			if allRemoveCount == 4 then
				break
			end
		elseif signType == SingType.SING_MINGGANG then
			if allRemoveCount == 4 then
				break
			end
		elseif signType == SingType.SING_GUOLUGANG then
			if allRemoveCount == 1 then
				break
			end
		end
	end
	allRemoveCount = 0

	--碰杠回退需要清除碰杠标签列表，以保证位置正确
	local PengGangCardsLen = table.maxn(gameRoom.PengGangCards)
	for j, v in ipairs(this.pengGangSigns[location]) do
		if signType == SingType.SING_GUOLUGANG then
			pgCount = j + 1
			break
		end

		for i = PengGangCardsLen,1,-1 do
			local pengGangCardscolor = gameRoom.PengGangCards[i].color
			local pengGangCardsNum = gameRoom.PengGangCards[i].num
			local strNum    = ''
			if pengGangCardsNum < 10 then
				strNum = '0' .. tostring(pengGangCardsNum)
			else
				strNum = tostring(pengGangCardsNum)
			end
			local pengGangCardsName = tostring('color_'..  pengGangCardscolor  .. '_' ..strNum)
			if v[2] == pengGangCardsName then
				table.remove (this.pengGangSigns[location],j)
				break
			end
		end
	end
end


--删除打下去被碰或者杠的牌(用于回放)
function RoomRunStatic.delPlayCardPengGangShowHuiFang(buzhouId)
	local playChessRoleIndex
	for i = #playCardBuZhouTable,1,-1 do
		if playCardBuZhouTable[i].buzhouId < buzhouId then
			playChessRoleIndex = playCardBuZhouTable[i].roleIndex
			break
		end
	end
	local location = getOtherPlayerLocation(playChessRoleIndex)
	print('RoomRunStatic.delPlayCardPengGangShowHuiFang1111',location,global.playChess.roleIndex,playChessRoleIndex)
	if location == 'D' then
		local myPlayCardsLen = table.maxn(gameRoom.myPlayCards)
		local pengGangCardsLen = table.maxn(gameRoom.PengGangCards)
		print('自己打牌被碰',myPlayCardsLen,pengGangCardsLen)
		for i = myPlayCardsLen,1,-1 do
			for j = pengGangCardsLen,1,-1 do
				local myPlayCardsId = gameRoom.myPlayCards[i].id
				local pengGangCardsId = gameRoom.PengGangCards[j].id
				if myPlayCardsId == pengGangCardsId then
					gameRoom.DeleteColor(gameRoom.PlayModelCardDMap[i].gameObject)
					gameRoom.PlayModelCardDMap[i].gameObject:Destroy()
					table.remove (gameRoom.PlayModelCardDMap,i)
					table.remove (gameRoom.myPlayCards,i)
					PlayCardIndex.DIndex = PlayCardIndex.DIndex -1
					break
				end
			end
		end
		print('自己打牌索引'..PlayCardIndex.DIndex)
		if PlayCardIndex.DIndex <= 7 then
			selfPlayPos  = Vector3.New(selfPlayPos.x - CardJianJu,selfPlayPos.y,selfPlayPos.z)				
		elseif PlayCardIndex.DIndex <= 14 then
			selfTwoLinePlayPos  = Vector3.New(selfTwoLinePlayPos.x - CardJianJu,selfTwoLinePlayPos.y,selfTwoLinePlayPos.z)				 
		elseif PlayCardIndex.DIndex <= 21 then
			selfThreeLinePlayPos  = Vector3.New(selfThreeLinePlayPos.x - CardJianJu,selfThreeLinePlayPos.y,selfThreeLinePlayPos.z)				 
		elseif PlayCardIndex.DIndex <= 28 then
			selfFourLinePlayPos  = Vector3.New(selfFourLinePlayPos.x - CardJianJu,selfFourLinePlayPos.y,selfFourLinePlayPos.z)				
		end
		
	elseif location == 'R' then
		local rPlayCardsLen = table.maxn(gameRoom.RPlayCards)
		local pengGangCardsLen = table.maxn(gameRoom.PengGangCards)
		print('右边打牌被碰',rPlayCardsLen,pengGangCardsLen)
		for i = rPlayCardsLen,1,-1 do
			for j = pengGangCardsLen,1,-1 do
				local rPlayCardsId = gameRoom.RPlayCards[i].id
				local PengGangCardsId = gameRoom.PengGangCards[j].id
				if rPlayCardsId == PengGangCardsId then
					gameRoom.DeleteColor(gameRoom.PlayModelCardRMap[i].gameObject)
					gameRoom.PlayModelCardRMap[i].gameObject:Destroy()
					table.remove (gameRoom.PlayModelCardRMap,i)
					table.remove (gameRoom.RPlayCards,i)
					PlayCardIndex.RIndex = PlayCardIndex.RIndex -1
					break
				end
			end
		end
		print('右边打牌索引'..PlayCardIndex.RIndex)
		if PlayCardIndex.RIndex <= 7 then
			rightPlayPos  = Vector3.New(rightPlayPos.x ,rightPlayPos.y,rightPlayPos.z-CardJianJu)				
		elseif PlayCardIndex.RIndex <= 14 then
			rightTwoLinePlayPos  = Vector3.New(rightTwoLinePlayPos.x,rightTwoLinePlayPos.y,rightTwoLinePlayPos.z- CardJianJu)				
		elseif PlayCardIndex.RIndex <= 21 then
			rightThreeLinePlayPos  = Vector3.New(rightThreeLinePlayPos.x,rightThreeLinePlayPos.y,rightThreeLinePlayPos.z- CardJianJu)				
		elseif PlayCardIndex.RIndex <= 28 then
			rightFourLinePlayPos  = Vector3.New(rightFourLinePlayPos.x,rightFourLinePlayPos.y,rightFourLinePlayPos.z-CardJianJu)				
		end
	elseif location == 'L' then
		local lPlayCardsLen = table.maxn(gameRoom.LPlayCards)
		local PengGangCardsLen = table.maxn(gameRoom.PengGangCards)
		print('左边打牌被碰',lPlayCardsLen,PengGangCardsLen)
		for i = lPlayCardsLen,1,-1 do
			for j = PengGangCardsLen,1,-1 do
				local lPlayCardsId = gameRoom.LPlayCards[i].id
				local PengGangCardsId = gameRoom.PengGangCards[j].id
				if lPlayCardsId == PengGangCardsId then
					gameRoom.DeleteColor(gameRoom.PlayModelCardLMap[i].gameObject)
					gameRoom.PlayModelCardLMap[i].gameObject:Destroy()
					table.remove (gameRoom.PlayModelCardLMap,i)
					table.remove (gameRoom.LPlayCards,i)
					PlayCardIndex.LIndex = PlayCardIndex.LIndex -1
					break
				end
			end
		end
		print('左边打牌索引'..PlayCardIndex.LIndex)
		if PlayCardIndex.LIndex <= 7 then
			leftPlayPos  = Vector3.New(leftPlayPos.x,leftPlayPos.y,leftPlayPos.z+CardJianJu)				
		elseif PlayCardIndex.LIndex <= 14 then
			leftTwoLinePlayPos  = Vector3.New(leftTwoLinePlayPos.x,leftTwoLinePlayPos.y,leftTwoLinePlayPos.z+CardJianJu)				
		elseif PlayCardIndex.LIndex <= 21 then
			leftThreeLinePlayPos  = Vector3.New(leftThreeLinePlayPos.x ,leftThreeLinePlayPos.y,leftThreeLinePlayPos.z+CardJianJu)				 
		elseif PlayCardIndex.LIndex <= 28 then
			leftFourLinePlayPos  = Vector3.New(leftFourLinePlayPos.x,leftFourLinePlayPos.y,leftFourLinePlayPos.z+CardJianJu)	
		end
	elseif location == 'U' then
		local uPlayCardsLen = table.maxn(gameRoom.UPlayCards)
		local PengGangCardsLen = table.maxn(gameRoom.PengGangCards)
		print('对面打牌被碰',uPlayCardsLen,PengGangCardsLen)
		for i = uPlayCardsLen,1,-1 do
			for j = PengGangCardsLen,1,-1 do
				local uPlayCardsId = gameRoom.UPlayCards[i].id
				local PengGangCardsId = gameRoom.PengGangCards[j].id
				if uPlayCardsId == PengGangCardsId then
					gameRoom.DeleteColor(gameRoom.PlayModelCardUMap[i].gameObject)
					gameRoom.PlayModelCardUMap[i].gameObject:Destroy()
					table.remove (gameRoom.PlayModelCardUMap,i)
					table.remove (gameRoom.UPlayCards,i)
					PlayCardIndex.UIndex = PlayCardIndex.UIndex -1
					break
				end
			end
		end
		print('对面打牌索引'..PlayCardIndex.UIndex)
		if PlayCardIndex.UIndex <= 7 then
			oppsPlayPos  = Vector3.New(oppsPlayPos.x+CardJianJu ,oppsPlayPos.y,oppsPlayPos.z)				
		elseif PlayCardIndex.UIndex <= 14 then
			oppsTwoLinePlayPos  = Vector3.New(oppsTwoLinePlayPos.x+CardJianJu,oppsTwoLinePlayPos.y,oppsTwoLinePlayPos.z)				
		elseif PlayCardIndex.UIndex <= 21 then
			oppsThreeLinePlayPos  = Vector3.New(oppsThreeLinePlayPos.x+CardJianJu,oppsThreeLinePlayPos.y,oppsThreeLinePlayPos.z)				 
		elseif PlayCardIndex.UIndex <= 28 then
			oppsFourLinePlayPos  = Vector3.New(oppsFourLinePlayPos.x+CardJianJu,oppsFourLinePlayPos.y,oppsFourLinePlayPos.z)				
		end
	end
end