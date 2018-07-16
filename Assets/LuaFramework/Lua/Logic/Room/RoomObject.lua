RoomObject = {
	curChildRoom	= nil, --当前房间子类	
	players         = {}, --玩家人数
	playerCount		= 0,
	playersData		= {}, --玩家数据
	watchData		= {}, --观战玩家数据
	watchPlayers	= {}, --观战玩家人数
	loadObjList		= {}, --缓存列表
	operateIndex	= 0 , --当前操作人的索引
	curJushu		= 1,  --当前局数
	totalJushu		= 1,  --总局数
	isSettlement	= false,
}

setbaseclass(RoomObject, {Invoker})

-- 加载资源
function RoomObject:LoadResources(roomType)
	BlockLayerCtrl:OpenSpec()
	local abName = ""
	local assName = ""
	self.curChildRoom = nil
	self.roomType = roomType
	if roomType ~= RoomType.NiuNiu then
		if roomType == RoomType.Tenharf then
			self.resCount     = 0
			self.needResCount = 2
	    	self.isAdd        = false
	    	abName 			  = "th_gamemain"
	    	assName			  = "Game"
	    	self.curChildRoom = TenharfRoom
		elseif roomType == RoomType.GoldFlower then
			self.resCount     = 0
			self.needResCount = 2
	    	self.isAdd        = false
	    	abName 			  = "th_gamemain"
	    	assName			  = "Game"
	    	self.curChildRoom = GoldFlowerRoom
	   	elseif roomType == RoomType.CatchPock then
	    	self.resCount     = 0
			self.needResCount = 2
	    	self.isAdd        = false
	    	abName 			  = "ch_gamemain"
	    	assName			  = "Sence"
	    	self.curChildRoom = CatchPockRoom
	    elseif roomType == RoomType.Landlords then
	    	self.resCount     = 0
			self.needResCount = 2
	    	self.isAdd        = false
	    	abName 			  = "ll_gamemain"
	    	assName			  = "LandlordsGame"
	    	self.curChildRoom = LandlordsRoom
		end
		print(assName,self.loadObjList[assName])
		if not self.loadObjList[assName] then
	        resMgr:LoadPrefab(abName,{assName}, function (objs)
	            self.curChildRoom.SaveGameObj(objs,assName)
	            self.curChildRoom:LoadGameObj(self:GetObj(assName,self.loadObjList))
	            print('RoomObject:LoadResources111111111133333333333333333333')
	        end)
	        print('RoomObject:LoadResources111111111100000000000')
	    else
	        self.curChildRoom:LoadGameObj(self:GetObj(assName,self.loadObjList))
	        print('RoomObject:LoadResources11111111112222222222222222')
	    end
	else
    	self.resCount     = 0
		self.needResCount = 2
    	self.isAdd        = false
    	self.curChildRoom = NiuNiuRoom
    	if not self.loadObjList["NNGame"] then
    		resMgr:LoadPrefab("ui_niuniu",{"NNGame"}, function (objs)
	            self.curChildRoom.SaveGameObj(objs,"NNGame")
	            self.curChildRoom:LoadGameObj(self:GetObj("NNGame",self.loadObjList))
	        end)
	    else
	    	self.curChildRoom:LoadGameObj(self:GetObj("NNGame",self.loadObjList))
	    end
	end
	CardObject.Load("uipokerprefab")
end

--资源检查
function RoomObject:ResourceCheckOver()
	print('RoomObject:ResourceCheckOver111',self.resCount,self.needResCount)
	self.resCount = self.resCount + 1
	print('RoomObject:ResourceCheckOver222',self.resCount,self.needResCount)
	if self.resCount == self.needResCount then
		print('RoomObject:ResourceCheckOver3333',self.resCount,self.needResCount)
		self:LoadPrefabs()
	end
end

function RoomObject:LoadPrefabs()
	-- 自己的索引
	self.initPlayerEnd = false
	self.myIndex = self.myIndex or 1
	self.curChildRoom:InitPlayers()
	-- 扑克牌没有发牌过程所以初始化和加载完成在一起
	self.isPrefabLoaded = true
	--BlockLayerCtrl:CloseSpec()
end

-- 开始发牌前的初始化
function RoomObject:Init()
	-- 牌总数
	self.totalCardCount = 52
	-- 剩余排数
	self.leftCardCount = 52
	-- 当前局数
	self.curRound = 0
	-- 总局数
	self.totalRound = 8
end

function RoomObject:GetRoomIndexByIndex(index)
	if index == nil then return end
	local di = index - self.myIndex
	di = 1 + di
	if di < 1 then
		if self.roomType == 4 then
			di = di + 3
		elseif self.roomType == 5 then
			di = di + 6
		elseif self.roomType == 8 then
			di = di + 3
		else
			di = di + 5
		end
	end
	return di
end

--索引找玩家
function RoomObject:GetPlayer(index)
	for _, player in ipairs(self.players) do
		if player.index == index then
			return player
		end
	end
end

--ID找玩家
function RoomObject:GetPlayerById(roleId)
	for _, player in ipairs(self.players) do
		if player.id == tostring(roleId) then
			return player
		end
	end
end

--退出房间清理
function RoomObject:QuitRoom()
	self.players         = {} --玩家人数
	self.playerCount	 = 0
	self.playersData	 = {} --玩家数据
	self.loadObjList	 = {} --缓存列表
	self.operateIndex	 = 0 --当前操作人的索引
	self.curJushu		 = 1  --当前局数
	self.totalJushu		 = 1  --总局数
end

function RoomObject:Destroy()
	for _, player in ipairs(self.players) do
		player:Destroy()
	end
	self.players = nil
end


function RoomObject:DoColor(obj)
	local self = MainSenceCtrl
	local img = obj.transform:GetComponent("Image")
	local color = img.color
	local co = coroutine.start(function()
		coroutine.wait(0.4)
		img.color = Color.red
		coroutine.wait(0.4)
		img.color = Color.yellow
		coroutine.wait(0.4)
		img.color = Color.blue
		coroutine.wait(0.4)
		img.color = Color.green
		coroutine.wait(0.4)
		img.color = Color.cyan
		coroutine.wait(0.4)
		img.color = Color.magenta
		coroutine.wait(0.4)
		img.color = color
	end)
	table.insert(Network.crts, co)
end

function RoomObject:DoScale(obj)
	local ease = DG.Tweening.Ease
	local img = obj.transform:GetComponent("Image")
	img.rectTransform:DOScale(Vector3.New(1,1,1),0.5):SetEase(ease.OutBounce)
end

function RoomObject:DoMove(obj,position)
	sequence:Append(gameObject.transform:DOMove(Vector2.New(tarPos.transform.position.x,tarPos.transform.position.y),1,false))
			:Insert( 0.3, gameObject.transform:DORotate(Vector3.zero ,0.7,rotateMod)) --第一个参数为开始旋转的时间
			:OnComplete(function ()	
			self:Back(gameObject,tarPos,faceName)
		end)
end

function RoomObject:GetObj(name,list)
    for k,v in pairs(list) do
        if name == k then
            return v
        end
    end
end

--随机生成器--
function RoomObject:Random(m,n)
    math.randomseed(tostring(os.time()):reverse():sub(1, 6))
    return math.random(m,n)
end