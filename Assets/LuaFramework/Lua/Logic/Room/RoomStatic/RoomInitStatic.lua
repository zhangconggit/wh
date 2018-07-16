require "Common/define"
require "Common/msgDefine"
require "Common/functions"
require "Logic/Room/Mahjong/MahjongCard"
require "3rd/pblua/ChessInfo_pb"
require "3rd/pblua/InitChesses_pb"

--房间初始化牌状态；
RoomInitStatic = {}
local this = RoomInitStatic

local posBase  = Vector3.New(30.49,-9.242,-2.52)   --我的位置；
local posOppo  = Vector3.New(36.182,-9.242,4.049)    --对面位置
local posLeft  = Vector3.New(29.87,-9.242,3.667) 	 --我左面的位置x-90 z90
local posRight = Vector3.New(36.85,-9.242,-2.09)      --我右面的位置x-90 z90  


local cardPositionList   = {}   --牌的坑位数组；
local cardPositionStatic = {}   --坑位牌的状态列表；
local showChard = false

function RoomInitStatic.New() 
	return this
end


function RoomInitStatic.isEnter(...)
	--local args = {...}
	return true
end

function RoomInitStatic.Enter(isReload)

	gameRoom.gameObjContainer.transform.position     = Vector3.New(0,0,0)
	gameRoom.gameObjCardContainer.transform.position = Vector3.New(0,0,0)
	gameRoom.gameObjTable.transform.position         = Vector3.New(33.34,-8.82,0.85)

	gameRoom.gameObjShaizi.transform.localPosition   = Vector3.New(33.157,-8.7,0.95)

	
	--桌子播放动画；
	if not isReload then
		local animator = gameRoom.gameObjTable.transform:GetComponent('Animator')
		animator.speed = 10
	    animator:SetBool("isPlay", true)
	end

	showChard = true
	
	--设置摆放到桌面牌的最大人数
	local maxNum     = 4
	local mePosIndex = gameRoom.myPosIndex

	
	--计算牌数量；
	local cardTotal = 0
	local row       = 0
	local yu        = 0
	
	--总牌数；无风牌总数108张，有风牌总数136张
	if global.roomVo.isFeng == 1 then
		cardTotal = 108
		if global.roomVo.isRed == 1 then
			cardTotal = cardTotal + 4
		end
	else
		cardTotal = 136
	end
	--血战麻将总共108张牌
	if Room.gameType == RoomType.BattleMahjong then
		cardTotal = 108
	end
	
	gameRoom.cardTotal = cardTotal
	gameRoom.CARD_TOTOAL = cardTotal
	
	if cardTotal == 108 then
		row = 13 --52 落 余下 2 落；
		yu  = 2
	elseif cardTotal == 112 then
		row = 14
	else
		row = cardTotal / 8
	end
	
	--计算坑位；-从庄家开始；	
	local curIndex =  gameRoom.initInfo.bankerIndex
	local n = 0

	for i = 1,maxNum,1 do
        
		local argRow = row	
		
		if yu > 0 then
			argRow = row + 1
			yu  = yu - 1
		end		
		
		gameRoom.posIndex[i] = n
		
		n        = this.PositionCompute(cardTotal,argRow,n,mePosIndex,curIndex)	
		curIndex = GameUtil.GetNext(curIndex,maxNum,false) --逆时针；
	end
	
	--牌位置初始化；
	 gameRoom.cardColor = gameRoom.publicCards[1].gameObject:GetComponent("MeshRenderer").material.color
	for index = 0,cardTotal - 1,1 do
		local card = gameRoom.publicCards[index]
		card.gameObject.name = "Mahjong" .. index
		card.gameObject:SetActive(true)
		card.hasMo = false
		local pos =  cardPositionList[index]	
		
		card:setStatic(cardPositionStatic[index])
		card.transform.position = pos
		card.transform.localScale = Vector3.New(1.1,1.1,1.1)
	end

	if not isReload then
		OB_GameMainCtrl.SurplusCardNum( gameRoom.cardTotal )
		gameRoom.gameObjShaizi:SetActive(true)
	end
	OB_GameMainPanel.imgPlayCardDirection.transform.position = Vector3.New(0,500,0);
end

function RoomInitStatic.Update()
	
	if showChard == true then
		local o   = gameRoom.gameObjCardContainer.transform.position
		local y   = o.y + 1.5 * Time.deltaTime
		local pos = Vector3.New(o.x,y,o.z)
		
		if pos.y > 1 then
			pos.y = 1
			showChard = false
			gameRoom.gameObjCardContainer.transform.position = pos
			--手的动画播放
			local location = getOtherPlayerLocation(gameRoom.initInfo.bankerIndex)
			local co = coroutine.start(this.ShaiziAnim)
			table.insert(Network.crts, co)	
		else
			gameRoom.gameObjCardContainer.transform.position = pos
		end
	end
end


--手的位移
function RoomInitStatic.StartAnim( location )
	print("===========StartAnim")
	-- local hand = nil
	-- local pos  = nil
	-- if location == 'D' then
	-- 	hand = gameRoom.gameObjHand[1]
	-- 	pos  = gameRoom.HandAnList.D
	-- elseif location == 'R' then
	-- 	hand = gameRoom.gameObjHand[2]
	-- 	pos  = gameRoom.HandAnList.R
	-- elseif location == 'U' then
	-- 	hand = gameRoom.gameObjHand[3]
	-- 	pos  = gameRoom.HandAnList.U
	-- elseif location == 'L' then
	-- 	hand = gameRoom.gameObjHand[4]
	-- 	pos  = gameRoom.HandAnList.L
	-- end
	-- this.HandAnimPos(hand,pos)
end

--手按骰子动画
function RoomInitStatic.HandAnimPos(hand,pos)
	-- print("HandAnimPos--------",hand.name,tostring(pos))
	-- animator = hand.transform:GetComponent('Animator')
	-- animator.speed = 2
	-- animator:SetBool("isAn",false)
	-- animator:SetBool("isAn",true)
	-- local sequence = DG.Tweening.DOTween.Sequence()
 -- 	sequence:Append(hand.transform:DOLocalMove(pos[2], 0.5, false))
	-- 		:Append(hand.transform:DOLocalMove(pos[1], 0.5, false))
	-- 		:OnComplete(function() 
	-- 			animator:SetBool("isAn",false)
	-- 			 end)
end

--骰子动画及点数
function RoomInitStatic.ShaiziAnim( )
	-- print("================ShaiziAnim")
	-- local animator = gameRoom.gameObjShaizi.transform:GetComponent('Animator')
 --    local max = gameRoom.gameObjShaizi.transform:Find('ShaiZi2/Bone024')
 --   	local min = gameRoom.gameObjShaizi.transform:Find('ShaiZi1/Bone025')
 --   	local eulerA = Quaternion.identity	
 --   	local eulerB = Quaternion.identity
 --   	--骰子转动速度从1.5调整到0.5
	-- if animator ~= nil then
	-- 	animator.speed = 0.5
	--     animator:SetBool("isPlay", true)
	--     Game.MusicEffect(Game.Effect.shaizi)
	--     coroutine.wait(1.4)	
	--     animator.enabled = false
	--     for i=1,#gameRoom.ShaiziPos do
	--     	if gameRoom.initInfo.diceMin == i then
	--     		print("================ShaiziPos===",i)
	--     		eulerA.eulerAngles = gameRoom.ShaiziPos[i]
	--    --  		local sequence = DG.Tweening.DOTween.Sequence()	--动画序列
	-- 			-- local rotateMod = DG.Tweening.RotateMode.Fast		--旋转模型
	-- 			-- sequence:Append(min.transform:DOLocalRotate(gameRoom.ShaiziPos[i] ,0.1,rotateMod))
	--     		min.transform.localRotation = eulerA
	--     	end
	--     	if gameRoom.initInfo.diceMax == i then
	--     		print("================ShaiziPos===",i)
	-- 			eulerB.eulerAngles = gameRoom.ShaiziPos[i]
	--    --  		local sequence = DG.Tweening.DOTween.Sequence()	--动画序列
	-- 			-- local rotateMod = DG.Tweening.RotateMode.Fast		--旋转模型
	-- 			-- sequence:Append(max.transform:DOLocalRotate(gameRoom.ShaiziPos[i] ,0.1,rotateMod))
	-- 			max.transform.localRotation = eulerB
	--     	end
	--     end
	    local co = coroutine.start(function()
	    	while not OB_GameMainCtrl.isCreate do
	    		coroutine.step()
	    	end
	--     	--动画播完后开始发牌
	 	    gameRoom.changeStatic(RoomStatic.DealStatic)
	-- 	    if animator ~= nil then 
	-- 	    	animator.enabled = true
	-- 	   		animator:SetBool("isPlay", false)
	-- 		end
	   		OB_GameMainCtrl.ShowCount()
	    	gameRoom.gameObjShaizi:SetActive(false)
	    	gameRoom.DClose:SetActive(true)
	    end)
	    table.insert(Network.crts, co)
	-- end
end

function RoomInitStatic.Exit()
 
end

--计算坑位；
function RoomInitStatic.PositionCompute(cardTotal,row,n,mePosIndex,targetIndex)
	
	 --计算牌的坑位；逆时针；
	-- local rela          = GameUtil.getPosRelation(mePosIndex,targetIndex,false)
	local rela = getOtherPlayerLocation(targetIndex, true)
	local bankerBasePos = this.getBasePos(targetIndex, true)
	
	local cardStatic = 0
	
	if rela == "L" or rela == "R" then
		cardStatic = 1
	else
		cardStatic = 0
	end

	for i = 0,row - 1,1 do
		
		local pos = Vector3.New(0,0,0)	
			pos.x = bankerBasePos.x
			pos.y = bankerBasePos.y
			pos.z = bankerBasePos.z
		
		if rela     == "L" then
			pos.z = bankerBasePos.z - 0.37 * i
		elseif rela == "R" then
			pos.z = bankerBasePos.z + 0.37 * i
		elseif rela == "U" then
			pos.x = bankerBasePos.x - 0.37 * i
		elseif rela == "D" then
			pos.x = bankerBasePos.x + 0.37 * i 
		end
		
		local pos2 = Vector3.New(pos.x,pos.y + 0.25,pos.z)

		table.insert(cardPositionList,n,pos)
		table.insert(cardPositionStatic,n,cardStatic)
		n = n + 1
		table.insert(cardPositionList,n,pos2)
		table.insert(cardPositionStatic,n,cardStatic)
		n = n + 1
	end
	
	return n
end

--根据我的位置索引，获取某位置索引的，基础位置点；
function RoomInitStatic.getBasePos(targetIndex, isDeal)	
	
	-- local rela = GameUtil.getPosRelation(myIndex,targetIndex)
	-- if rela == RelativePosition.Origin then
	-- 	return posBase
	-- end
	
	-- if rela == RelativePosition.Left then
	-- 	return posLeft
	-- end

	-- if rela == RelativePosition.Right then
	-- 	return posRight
	-- end 
	
	-- if rela == RelativePosition.Opposite then 
	-- 	return posOppo
	-- end
	local poss = {
		D = posBase,
		R = posRight,
		U = posOppo,
		L = posLeft,
	}

	local location = getOtherPlayerLocation(targetIndex, isDeal)
	return poss[location]
end
