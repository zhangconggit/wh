require "Common/define"
require "Common/msgDefine"
require "Common/functions"
require "Util/GameUtil"
require "Logic/Room/Mahjong/MahjongUiCard"
require "Logic/Room/RoomStatic/RoomRunStatic"
require "Model/Vo/ClientCheckInfoVo"


--房间发牌 状态；
RoomDealStatic = {}
local this = RoomDealStatic

local enterTime    	  = 0
local lastTime     	  = 0
local cy           	  = 0 --第几轮；
local curCardIndex 	  = 0 
local curUserIndex 	  = 0--当前抓拍人索引；

--local myUiCards       = {}
--local myModelChardMap = {}

local myCardCount     = 0	 --手牌个数
local myUiCardBasePos = nil --抓牌的基础位置
local uiCardProfab    = nil


local  leftPos  	   = Vector3.New(29.15,-8,-1.13)  --0   90  0
local rightPos  	   = Vector3.New(37.6,-8,3.742)   --180 90  180
local  oppsPos  	   = Vector3.New(30.78 ,-8,4.5) --0   180 0

local  otherUserCardList = {}
local  curMyCardIndex    = 1
local  curLeftCardIndex  = 1
local  curRightCardIndex = 1
local  curUpCardIndex    = 1

function RoomDealStatic.New() 
	return this
end

function RoomDealStatic.isEnter(...)
	return true
end

--进入发牌状态
function RoomDealStatic.Enter()
	log('--进入发牌状态')

	OB_GameMainCtrl.GameStart()
	-- 计算牌的起点和终点位置
	this.CalcCardStartEnd()

	enterTime         = Time.time
	--这里重新开始需要重置这些值
	cy                = 0
	lastTime          = 0
	curMyCardIndex    = 1
	curLeftCardIndex  = 1
	curRightCardIndex = 1
	curUpCardIndex    = 1
	leftPos  	  = Vector3.New(29.15,-8,3.852 )  --0   90  0
	rightPos  	  = Vector3.New(37.6,-8,-1.314)  --180 90  180
	oppsPos  	  = Vector3.New(35.76 ,-8,4.5 )  --0   180 0
	myCardCount     = 0
	uiCardProfab    = nil
	
	--设置其他玩家的牌列表-----------------------------------------------------------------
	local len = table.maxn(global.joinRoomUserVos)
	print("==========global.joinRoomUserVo",len)
	for i = 1,len,1  do 
		local roomUserVo                    = global.joinRoomUserVos[i]
		otherUserCardList[roomUserVo.index] = {}
		
	end
	---------------------------------------------------------------------------------------	
	this.totalDeal = 0
	
	curUserIndex    = gameRoom.initInfo.bankerIndex --第一个抓拍的为庄家，之后逆时针，下家；
	myUiCardBasePos = Vector2.New(-50,-610)
	OB_GameMainCtrl:ZhuangJiaShow(gameRoom.initInfo.bankerIndex)
	OB_GameMainCtrl:HeadIcon(gameRoom.initInfo.bankerIndex)
	this.isEnterEnd = true
	OB_GameMainPanel.btnQuit:SetActive(false)
	OB_GameMainPanel.btnTuoGuan:SetActive(false)
	 --加载牌的ImageUI
	-- resMgr:LoadPrefab('MahjongCard', {'color_image'}, this.LoadImageUIProfab)
end

function RoomDealStatic.CalcCardStartEnd()
	local realStartIndex = gameRoom.initInfo.startDrawIndex + 1
	if realStartIndex > 4 then
		realStartIndex = 1
	end
	local cardIndex   = gameRoom.posIndex[realStartIndex]
	local cardStart   = cardIndex - gameRoom.initInfo.diceMin * 2 - 1
	print("========diceMin", gameRoom.initInfo.diceMin)
	if cardStart < 0 then
		cardStart = gameRoom.CARD_TOTOAL + cardStart
	end
	local cardEnd = cardIndex - (gameRoom.initInfo.diceMin - 1) * 2 - 1
	if cardEnd < 0 then
		cardEnd = gameRoom.CARD_TOTOAL + cardEnd
	end
	gameRoom.lastCardIndex = cardEnd
	
	curCardIndex      = cardStart
	gameRoom.curCardIndex = curCardIndex

	myUiCardBasePos = Vector2.New(-50,-610)

	leftPos  	  = Vector3.New(29.15,-8,3.852 )  --0   90  0
	rightPos  	  = Vector3.New(37.6,-8,-1.314)  --180 90  180
	oppsPos  	  = Vector3.New(35.76 ,-8,4.5 )  --0   180 0

	curMyCardIndex    = 1
	curLeftCardIndex  = 1
	curRightCardIndex = 1
	curUpCardIndex    = 1
end
 
--发牌中
function RoomDealStatic.Update()
	if not this.isEnterEnd then
		return
	end
	if Game.isReloadBattle then
		return
	end
	if cy >= 4 then 
		--牌发完以后，进入打牌状态；
		-- Game.SendProtocal(Protocal.DealOver)
		-- gameRoom.hasReload = true
		-- gameRoom.changeStatic(RoomStatic.RunStatic)
		-- RoomRunStatic.CardSort()
		-- this.isEnterEnd = false
		return
	end
	
	local curTime = Time.time
	
	--延迟1秒再发牌；策划要求发牌速度调快到0.02，原来是0.05
	if curTime - enterTime <0.02 then
		return
	end
	
	if curTime - lastTime> 0.1 then
		lastTime = curTime
		
		--第N轮抓X张牌
		local cardNum = 4
		if cy == 3  then
			cardNum = 1
		end
 		
		this.UserGetChard(curUserIndex,cardNum)
		this.totalDeal = this.totalDeal + cardNum
		-- 发完所有牌
		if this.totalDeal == 13 * #global.joinRoomUserVos then
			this.isEnterEnd = false
			gameRoom.changeStatic(RoomStatic.RunStatic)
			gameRoom.hasReload = true
		end
		--curUserIndex = GameUtil.GetNext(curUserIndex,4,cardNum) --临时将人数设置为4
		--发到手里的牌全部用真实数据
		curUserIndex = GameUtil.GetNext(curUserIndex,table.maxn(global.joinRoomUserVos),cardNum)
		
		--当前抓牌人为庄，轮数+1
		if curUserIndex == gameRoom.initInfo.bankerIndex then
			print("====RoomDealStatic===Update=:",curUserIndex)
			cy = cy + 1
		end
	end
end

--发牌结束
function RoomDealStatic.Exit()
	print("===========RoomDealStatic.Exit========")
	local location = getOtherPlayerLocation(curUserIndex)
	OB_GameMainCtrl.CountDown(true)
	coroutine.start(RoomDealStatic.WaitQuit)

end

function RoomDealStatic.WaitQuit()
	coroutine.wait(3)
	if OB_GameMainCtrl.isCreate then
		if global.roomVo.moneyType == RoomMode.roomCardMode then
			OB_GameMainPanel.btnQuit:SetActive(true)
		end
		if global.roomVo.isFangzhu == 3 or  global.roomVo.vsRoomNum ~= 0 then
			OB_GameMainPanel.btnQuit:SetActive(false)
			OB_GameMainPanel.btnTuoGuan:SetActive(true)
		end
		if GradeDetailCtrl.isPlayBackHideTuichuBtn then
			OB_GameMainPanel.btnQuit:SetActive(false)
			GradeDetailCtrl.isPlayBackHideTuichuBtn = false
		end
	end
end

--某人抓num张牌；
function RoomDealStatic.UserGetChard(uIndex,num)
	print("=================UserGetChard==========",num)
	gameRoom.cardTotal = gameRoom.cardTotal - num
	OB_GameMainCtrl.SurplusCardNum( gameRoom.cardTotal)
	local myPosIndex = gameRoom.myPosIndex
	local location = getOtherPlayerLocation(uIndex)
	if location == "D" then
		Game.MusicEffect("fapai")
	end
	for i = 1,num,1  do
			local card = gameRoom.publicCards[curCardIndex]
			if location == 'D' then
					--card:setStatic(1)
					--加载自己的牌；
					local chessInfo = gameRoom.myCards[curMyCardIndex]
					local strNum    = ''
		
					if chessInfo.num < 10 then
						strNum = '0' .. tostring(chessInfo.num)
					else
						strNum = tostring(chessInfo.num)
					end
					local name = 'color_'..  chessInfo.color  .. '_' ..strNum
					local objs = Game.GetUICard(name)
					this.LoadCard(objs,curMyCardIndex)
					-- resMgr:LoadPrefab('uimahjongprefabs', { 'color_'..  chessInfo.color  .. '_' ..strNum}, this.LoadCard,curMyCardIndex)
					--计算位置
					card.gameObject:SetActive(false)
					curMyCardIndex = curMyCardIndex + 1
			elseif location == 'L' then

				if GradeDetailCtrl.isPlayBackDealStatic == true then
					local leftChessInfo = gameRoom.leftCards[curLeftCardIndex];
					local strNum    = '';
					if leftChessInfo.num < 10 then
						strNum = '0' .. tostring(leftChessInfo.num);
					else
						strNum = tostring(leftChessInfo.num);
					end
					local name = 'color_'..  leftChessInfo.color  .. '_' ..strNum
					local objs = Game.GetObjCard(name)
					this.LoadLeftCard(objs,curLeftCardIndex)
					card.gameObject:SetActive(false)
					curLeftCardIndex = curLeftCardIndex + 1;
				else
					leftPos  = Vector3.New(leftPos.x,leftPos.y,leftPos.z - 0.38);				
					card.transform.position  = leftPos;   --Vector3.New(10,10,1);
					card:setStatic(2);				
					table.insert(gameRoom.leftModelChardMap,card);
					curLeftCardIndex = curLeftCardIndex + 1;
				end
			elseif location == 'R' then
				if GradeDetailCtrl.isPlayBackDealStatic == true then
					local rightChessInfo = gameRoom.rightCards[curRightCardIndex];
					local strNum    = '';
					if rightChessInfo.num < 10 then
						strNum = '0' .. tostring(rightChessInfo.num);
					else
						strNum = tostring(rightChessInfo.num);
					end
					local name = 'color_'..  rightChessInfo.color  .. '_' ..strNum
					local objs = Game.GetObjCard(name)
					this.LoadRightCard(objs,curRightCardIndex)
					card.gameObject:SetActive(false)
					curRightCardIndex = curRightCardIndex + 1;
				else
					rightPos = Vector3.New(rightPos.x,rightPos.y,rightPos.z + 0.38);
					card.transform.position  = rightPos;
					card:setStatic(3);
					table.insert(gameRoom.rightModelChardMap,card);
					curRightCardIndex = curRightCardIndex + 1;
				end
			elseif location == 'U' then
				if GradeDetailCtrl.isPlayBackDealStatic == true then
					local upChessInfo = gameRoom.upCards[curUpCardIndex];
					local strNum    = '';
					if upChessInfo.num < 10 then
						strNum = '0' .. tostring(upChessInfo.num);
					else
						strNum = tostring(upChessInfo.num);
					end
					local name = 'color_'..  upChessInfo.color  .. '_' ..strNum
					local objs = Game.GetObjCard(name)
					this.LoadUpCard(objs,curUpCardIndex)
					card.gameObject:SetActive(false)
					curUpCardIndex = curUpCardIndex + 1;
				else
					oppsPos  = Vector3.New(oppsPos.x - 0.37,oppsPos.y,oppsPos.z);
					card.transform.position =  oppsPos;
					card:setStatic(4);
					table.insert(gameRoom.upModelChardMap,card);
					curUpCardIndex = curUpCardIndex + 1;
				end
			end

			card.hasMo = true
			
			curCardIndex = curCardIndex - 1
			--循环摸牌；
			if curCardIndex < 0 then
				curCardIndex = gameRoom.CARD_TOTOAL - 1 
			end
			gameRoom.curCardIndex = curCardIndex
	end
end

--加载UI上的牌
function RoomDealStatic.LoadCard(objs,index)	
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
	if index == len then
		if Game.isReloadBattle then
			gameRoom.hasReload = true
		end
		if len % 3 == 2 then
			cell = 17
		end
	end

	local x = myUiCardBasePos.x + 82 * index
	x = x + (14 - len) * 35
	local pos = Vector3.New(x + cell,myUiCardBasePos.y,0)
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
	--this.Photograph(image)

	--为每张初始化的牌添加点击事件监听
	local luaBehavi = gameRoom.canvas.transform:GetComponent('LuaBehaviour')
	luaBehavi:RemoveClick(gameRoom.myUiCards[index].gameObject)
	luaBehavi:AddClick(gameRoom.myUiCards[index].gameObject, RoomRunStatic.OnPlayCardClick)

	if index == 13 then
		RoomRunStatic.CardSort()
	end
end

--用于回放
function RoomDealStatic.LoadLeftCard(objs,index)
	local chessInfo = gameRoom.leftCards[index];
	local card    = newObject(objs);
	leftPos  = Vector3.New(leftPos.x,leftPos.y,leftPos.z - 0.38);				
	card.transform.position  = leftPos;   --Vector3.New(10,10,1);
	card.transform.rotation = Quaternion.Euler(Vector3.New(90,90,0))
	card.transform.localScale = Vector3.New(1.1,1.1,1.1)
	card.name = chessInfo.color..'_'..chessInfo.num..'_'..chessInfo.id
	table.insert(gameRoom.leftModelChardMap,card);
	if index == 13 then
		RoomRunStatic.CardSortOther("L",true)
	end
end

function RoomDealStatic.LoadRightCard(objs,index)
	local chessInfo = gameRoom.rightCards[index];
	local card    = newObject(objs);
	rightPos = Vector3.New(rightPos.x,rightPos.y,rightPos.z + 0.38);
	card.transform.position  = rightPos;
	card.transform.rotation = Quaternion.Euler(Vector3.New(90,0,90))
	card.transform.localScale = Vector3.New(1.1,1.1,1.1)
	card.name = chessInfo.color..'_'..chessInfo.num..'_'..chessInfo.id
	table.insert(gameRoom.rightModelChardMap,card);
	if index == 13 then
		RoomRunStatic.CardSortOther("R",true)
	end
end

function RoomDealStatic.LoadUpCard(objs,index)
	local chessInfo = gameRoom.upCards[index];
	local card    = newObject(objs);
	oppsPos  = Vector3.New(oppsPos.x - 0.37,oppsPos.y,oppsPos.z);
	card.transform.position =  oppsPos;
	card.transform.rotation = Quaternion.Euler(Vector3.New(90,0,180))
	card.transform.localScale = Vector3.New(1.1,1.1,1.1)
	card.name = chessInfo.color..'_'..chessInfo.num..'_'..chessInfo.id
	table.insert(gameRoom.upModelChardMap,card);
	if index == 13 then
		RoomRunStatic.CardSortOther("U",true)
	end
end

--拍照方法
-- function RoomDealStatic.Photograph(image)
-- 	local renderTexture = UnityEngine.RenderTexture.New(128,128,1)
-- 	gameRoom.cardCamera.targetTexture = renderTexture
-- 	gameRoom.cardCamera:Render()

-- 	local texture2D = UnityEngine.Texture2D.New(renderTexture.width, renderTexture.height)
-- 	local rect      = UnityEngine.Rect.New(0,0,renderTexture.width,renderTexture.height)
	
-- 	UnityEngine.RenderTexture.active = renderTexture
-- 	local nRect = UnityEngine.Rect.New(0,0,128,128)
-- 	texture2D:ReadPixels(nRect, 0, 0)
-- 	texture2D:Apply()
-- 	UnityEngine.RenderTexture.active = nil
		
-- 	local sRect  = UnityEngine.Rect.New(0,0,128,128)
-- 	local sprite = UnityEngine.Sprite.Create(texture2D,sRect,Vector2.New(-1,0))
-- 	image.sprite = sprite
-- end

-- function RoomDealStatic.LoadImageUIProfab(objs)
-- 	uiCardProfab = newObject(objs[0])
-- end

