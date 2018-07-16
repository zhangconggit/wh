--文件：角色信息控制


TH_RoleInfoCtrl = {}
setbaseclass(TH_RoleInfoCtrl, {BaseCtrl})

--启动事件--
function TH_RoleInfoCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self,obj)
	self:AddClick(TH_RoleInfoPanel.btnClose,self.OnQuitBtnClick)
	self:AddClick(TH_RoleInfoPanel.BbtnE1,self.OnFaceBtnClick)
	self:AddClick(TH_RoleInfoPanel.BbtnE2,self.OnFaceBtnClick)
	self:AddClick(TH_RoleInfoPanel.BbtnE3,self.OnFaceBtnClick)
	self:AddClick(TH_RoleInfoPanel.BbtnE4,self.OnFaceBtnClick)
	self:AddClick(TH_RoleInfoPanel.BbtnE5,self.OnFaceBtnClick)
	self:AddClick(TH_RoleInfoPanel.BbtnE6,self.OnFaceBtnClick)
	if Room.gameType == RoomType.NiuNiu then
	self.bigPosList = {Vector3.New(-20,0,0),
					Vector3.New(140,-170,0),
					Vector3.New(140,-70,0),
					Vector3.New(140,70,0),
					Vector3.New(0,70,0),
					Vector3.New(-140,70,0),
					Vector3.New(-140,-70,0),
					Vector3.New(-140,-170,0)}
	self.smallPosList = {Vector3.New(-10,-240,0),
		Vector3.New(240,-90,0),
		Vector3.New(240,45,0),
		Vector3.New(240,190,0),
		Vector3.New(-40,190,0),
		Vector3.New(-240,-190,0),
		Vector3.New(-240,45,0),
		Vector3.New(-240,-90,0)}
	end
end

--初始化面板--
function TH_RoleInfoCtrl:InitPanel(info,isBig,room)
	print("TH_RoleInfoCtrl",#info)
	self.info = info
	self.room = room
	if isBig == true then
		local index = room:GetRoomIndexByIndex(info.index)
		if Room.gameType == RoomType.CatchPock then
			if index == 1 then
				TH_RoleInfoPanel.objBig.transform.localPosition = Vector3.New(-170,-170,0)
			elseif index == 2 then
				TH_RoleInfoPanel.objBig.transform.localPosition = Vector3.New(140,150,0)
			elseif index == 3 then
				TH_RoleInfoPanel.objBig.transform.localPosition = Vector3.New(-140,150,0)
			end
		elseif Room.gameType == RoomType.NiuNiu then
			TH_RoleInfoPanel.objBig.transform.localPosition = self.bigPosList[index]
		else
			if index == 1 then
				TH_RoleInfoPanel.objBig.transform.localPosition = Vector3.New(120,-100,0)
			elseif index == 2 then
				TH_RoleInfoPanel.objBig.transform.localPosition = Vector3.New(160,-30,0)
			elseif index == 3 then
				TH_RoleInfoPanel.objBig.transform.localPosition = Vector3.New(140,150,0)
			elseif index == 4 then
				TH_RoleInfoPanel.objBig.transform.localPosition = Vector3.New(-140,150,0)
			elseif index == 5 then
				TH_RoleInfoPanel.objBig.transform.localPosition = Vector3.New(-160,-30,0)
			end
		end

		TH_RoleInfoPanel.objSmall:SetActive(false)
		TH_RoleInfoPanel.objBig:SetActive(true)
		local image	= TH_RoleInfoPanel.BimgHead
		if info.sex == 1 then
			TH_RoleInfoPanel.BimgWoman:SetActive(true)
			TH_RoleInfoPanel.BimgMan:SetActive(false)
		else
			TH_RoleInfoPanel.BimgWoman:SetActive(false)
			TH_RoleInfoPanel.BimgMan:SetActive(true)
		end
		self:SetText(TH_RoleInfoPanel.BtxtName,info.name)
		self:SetText(TH_RoleInfoPanel.BtxtID, info.roleId)
		self:SetText(TH_RoleInfoPanel.BtxtIP, info.roleIp)
		TH_RoleInfoPanel.BimgHead:GetComponent("Image").sprite = info.image:GetComponent("Image").sprite

		local distance = ''
		if IS_APP_STORE_CHECK then
			distance = '  ';
		else
			if table_size(global.gpsMsgInfo) > 0 then
				for selfKey,v in pairs(global.gpsMsgInfo) do
					if selfKey == info.roleId then
						if global.gpsMsgInfo[selfKey][1] == '0' then
							distance = "未开启GPS定位"
						else
							for otherKey,v in pairs(global.gpsMsgInfo) do
								if otherKey ~= info.roleId then
									if global.gpsMsgInfo[otherKey][1] == '0' then
										local name = room:GetPlayerById(otherKey).name
										distance = distance .. GetShortName(name) .. "定位未开启" .. "   "
									elseif global.gpsMsgInfo[otherKey][1] == '1' then
										local name = room:GetPlayerById(otherKey).name
										local length = GetDistance(global.gpsMsgInfo[selfKey][2],global.gpsMsgInfo[selfKey][3],global.gpsMsgInfo[otherKey][2],global.gpsMsgInfo[otherKey][3])
										if length <= 0.02 then
										distance = distance .. "与" .. GetShortName(name) .. "相距:<color=#b41818>" .. "过近" .. "</color>" .. "   "
										else
											distance = distance .. "与" .. GetShortName(name) .. "相距:<color=#fffc16>" .. length .. "km</color>" .. "   "
										end
									end
								end
							end
						end
					end
				end
			else
				distance = '正在获取位置信息。。。'
			end
		self:SetText(TH_RoleInfoPanel.BtxtInfoMine,distance)
		distance = ''
		end
	else
		local index = room:GetRoomIndexByIndex(info.index)
		if Room.gameType == RoomType.CatchPock then
			if index == 1 then
				TH_RoleInfoPanel.objSmall.transform.localPosition = Vector3.New(270,-244,0)
			elseif index == 2 then
				TH_RoleInfoPanel.objSmall.transform.localPosition = Vector3.New(255,160,0)
			elseif index == 3 then
				TH_RoleInfoPanel.objSmall.transform.localPosition = Vector3.New(-255,160,0)
			end
		elseif Room.gameType == RoomType.NiuNiu then

			print("pos-------->>",index,self.smallPosList[index])
			TH_RoleInfoPanel.objSmall.transform.localPosition = self.smallPosList[index]
		else
			if index == 1 then
				TH_RoleInfoPanel.objSmall.transform.localPosition = Vector3.New(16,-146,0)
			elseif index == 2 then
				TH_RoleInfoPanel.objSmall.transform.localPosition = Vector3.New(270,-30,0)
			elseif index == 3 then
				TH_RoleInfoPanel.objSmall.transform.localPosition = Vector3.New(255,160,0)
			elseif index == 4 then
				TH_RoleInfoPanel.objSmall.transform.localPosition = Vector3.New(-255,160,0)
			elseif index == 5 then
				TH_RoleInfoPanel.objSmall.transform.localPosition = Vector3.New(-270,-14,0)
			end
		end

		TH_RoleInfoPanel.objBig:SetActive(false)
		TH_RoleInfoPanel.objSmall:SetActive(true)
		local image	= TH_RoleInfoPanel.SimgHead
		if info.sex == 1 then
			TH_RoleInfoPanel.SimgWoman:SetActive(true)
			TH_RoleInfoPanel.SimgMan:SetActive(false)
		else
			TH_RoleInfoPanel.SimgWoman:SetActive(false)			
			TH_RoleInfoPanel.SimgMan:SetActive(true)
		end
		self:SetText(TH_RoleInfoPanel.StxtName,info.name)
		self:SetText(TH_RoleInfoPanel.StxtID, info.roleId)
		self:SetText(TH_RoleInfoPanel.StxtIP, info.roleIp)
		TH_RoleInfoPanel.SimgHead:GetComponent("Image").sprite = info.image:GetComponent("Image").sprite
		print("==============",info.roleIp,info.image:GetComponent("Image").sprite.name)
	end
end

function TH_RoleInfoCtrl.OnQuitBtnClick(go)
	local self = TH_RoleInfoCtrl
	self:Close()
end

--获取坐标
function TH_RoleInfoCtrl:AnimationPos(index,typeName)
	local pos = nil
	local room = nil
	if  Room.gameType == RoomType.Tenharf then
        room = TenharfRoom
    elseif Room.gameType == RoomType.GoldFlower then
        room = GoldFlowerRoom
    elseif Room.gameType == RoomType.CatchPock then
    	room = CatchPockRoom
    elseif Room.gameType == RoomType.NiuNiu then
    	room = NiuNiuRoom
    end
	print("AnimationPos",index,typeName)
	if typeName == "imgHead" then
		pos = room:GetPlayer(index).obj
	elseif typeName == "imgAnim" then
		pos = room:GetPlayer(index).imgAnim
	end
	return pos
end

--点击表情
function TH_RoleInfoCtrl.OnFaceBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = nil
	local room = nil
	if  Room.gameType == RoomType.Tenharf then
        room = TenharfRoom
    elseif Room.gameType == RoomType.GoldFlower then
        room = GoldFlowerRoom
    elseif Room.gameType == RoomType.CatchPock then
    	room = CatchPockRoom
    elseif Room.gameType == RoomType.NiuNiu then
    	room = NiuNiuRoom
    end
	if TH_GameMainCtrl.isCreate then
		panel = TH_GameMainCtrl
	elseif CH_GameMainCtrl.isCreate then
		panel = CH_GameMainCtrl
	end
	self = TH_RoleInfoCtrl
	local myIndex = room.myIndex
	local targetIndex = self.info.index
	if myIndex == targetIndex then
		self.info = {}
		self:Close()
		panel.SetIconTips("不能对自己发送！")
		return
	end

	local faceName = go.name
	local chatInfo = tostring(myIndex..targetIndex..go.name)
	local faceType = 6
	local obj = self:AnimationPos(targetIndex,'imgAnim')
	print("===OnFaceBtnClick:",myIndex,targetIndex,go.name,obj.name)
	if obj.activeSelf == true then 
		panel.SetIconTips("您说话太快了，休息一下吧！")
		self:Close()
	else
		self:SendFaceAnimation(faceType,chatInfo)
	end
end 

--发送表情
function TH_RoleInfoCtrl:SendFaceAnimation(chatType,chatInfo)
	local GameChat = Chat_pb.ChatReq()
	GameChat.chatType = chatType
	GameChat.chatText = chatInfo
	local msg = GameChat:SerializeToString()
	Game.SendProtocal(Protocal.ChatInfo,msg)
	self:Close()
end

function TH_RoleInfoCtrl.AnimationShow(myIndex,targetIndex,faceName)
	local self = TH_RoleInfoCtrl
	print("AnimationShow",myIndex,targetIndex,faceName)
	local myPos = self:AnimationPos(tonumber(myIndex),'imgHead')
	local tarPos = self:AnimationPos(tonumber(targetIndex),'imgHead')
	local curSprite =  self:SpriteReturn(faceName)
	local obj = nil
		obj = self:AnimationPos(tonumber(targetIndex),'imgAnim')
		obj.transform.position = myPos.transform.position
		obj.transform.localRotation = Vector3.New(0,0,180)
		obj:SetActive(true)
		obj.transform:GetComponent("Image").sprite = curSprite
	self:AnimationCtrl(obj,myPos,tarPos,faceName)
end

--解析图片
function TH_RoleInfoCtrl:SpriteReturn(faceName)
	local panel = nil
	local sprite = nil
	if TH_GameMainCtrl.isCreate then
		panel = TH_GameMainPanel
	else
		panel = CH_GameMainPanel
	end
	sprite = BasePanel:GOChild(panel.imgAnimList,faceName):GetComponent('Image').sprite
	return sprite
end

--动画飞行控制
function TH_RoleInfoCtrl:AnimationCtrl(obj,myPos,tarPos,faceName)
	print("========obj",obj.name,faceName)
	local gameObject = obj
	local sequence = DG.Tweening.DOTween.Sequence()	--动画序列
	local rotateMod = DG.Tweening.RotateMode.Fast		--旋转模型
	if faceName == "imgE1" then
		Game.MusicEffect(Game.Effect.feizaofly)
	elseif faceName == "imgE3" then
		Game.MusicEffect(Game.Effect.kissfly)
	else
		Game.MusicEffect(Game.Effect.eggfly)
	end
	sequence:Append(gameObject.transform:DOMove(Vector2.New(tarPos.transform.position.x,tarPos.transform.position.y),1,false))
			:Insert( 0.3, gameObject.transform:DORotate(Vector3.zero ,0.7,rotateMod)) --第一个参数为开始旋转的时间
			:OnComplete(function ()	
			self:Back(gameObject,tarPos,faceName)
		end)
end	

--返回原点隐藏
function TH_RoleInfoCtrl:Back( gameObject,tarPos,faceName)
		gameObject:SetActive(false)
		resMgr:LoadPrefab('faceanimation',{faceName},function(objs)
				if faceName == "imgE2" then
				Game.MusicEffect(Game.Effect.cheers)
			elseif faceName == "imgE3" then
				Game.MusicEffect(Game.Effect.kissdes)
			elseif faceName == "imgE4" then
				Game.MusicEffect(Game.Effect.xihongshi)
			elseif faceName == "imgE1" then	
				Game.MusicEffect(Game.Effect.feizaofly)
			else
				Game.MusicEffect(Game.Effect.eggdes)
			end
		self:SetPos(objs,tarPos)
		end)
end

function TH_RoleInfoCtrl:SetPos(objs,tarPos)
	local go = newObject(objs[0])
	go.transform.parent = tarPos.transform
	go.transform.localScale = Vector3.one
	go.transform.localPosition = Vector3.zero
	local sequence = DG.Tweening.DOTween.Sequence()	--动画序列
	sequence:Append(go.transform:DOMove(tarPos.transform.position,1.2,false))
			:OnComplete(function ()
				go:Destroy()
			end)
end