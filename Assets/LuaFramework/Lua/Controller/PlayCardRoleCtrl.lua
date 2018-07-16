PlayCardRoleCtrl = {
	roleInfo = { }
}
setbaseclass(PlayCardRoleCtrl, { BaseCtrl })

-- 启动事件--
function PlayCardRoleCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)

	self.RoleInfoPos = {
		['D'] = Vector3.New(-263,- 44),
		['R'] = Vector3.New(268,37),
		['L'] = Vector3.New(-250,9),
		['U'] = Vector3.New(7,137),
	}

	self:AddClickNoChange(PlayCardRolePanel.btnMask, self.OnQuitBtnClick)
	self:AddClick(PlayCardRolePanel.btnE1, self.OnFaceClick)
	self:AddClick(PlayCardRolePanel.btnE2, self.OnFaceClick)
	self:AddClick(PlayCardRolePanel.btnE3, self.OnFaceClick)
	self:AddClick(PlayCardRolePanel.btnE4, self.OnFaceClick)
	self:AddClick(PlayCardRolePanel.btnE5, self.OnFaceClick)
	self:AddClick(PlayCardRolePanel.btnE6, self.OnFaceClick)
end



-- 初始化面板--
function PlayCardRoleCtrl:InitPanel(info)
	print("------麻将人物信息-------PlayCardRoleCtrl:", info.typeInfo)
	-- 苹果审核版本
	if IS_APP_STORE_CHECK then
		PlayCardRolePanel.roleIP:SetActive(false)
	end
	PlayCardRoleCtrl.roleInfo = info

	local roleIndex = getRoleIndexById(info.roleId)
	local location = getOtherPlayerLocation(roleIndex)

	PlayCardRolePanel.Big.transform.localPosition = self.RoleInfoPos[location]
	PlayCardRolePanel.Small.transform.localPosition = self.RoleInfoPos[location]

	local image = PlayCardRolePanel.roleHead
	local Simage = PlayCardRolePanel.SroleHead
	self:SetText(PlayCardRolePanel.roleName, info.name)
	self:SetText(PlayCardRolePanel.roleID, info.roleId)
	self:SetText(PlayCardRolePanel.roleIP, info.roleIp)

	self:SetText(PlayCardRolePanel.SroleName, info.name)
	self:SetText(PlayCardRolePanel.SroleID, info.roleId)
	self:SetText(PlayCardRolePanel.SroleIP, info.roleIp)

	PlayCardRolePanel.roleMan:SetActive(false)
	PlayCardRolePanel.roleWoman:SetActive(false)

	PlayCardRolePanel.SroleMan:SetActive(false)
	PlayCardRolePanel.SroleWoman:SetActive(false)

	if info.sex == 1 then
		PlayCardRolePanel.roleMan:SetActive(true)
		PlayCardRolePanel.SroleMan:SetActive(true)
	else
		PlayCardRolePanel.roleWoman:SetActive(true)
		PlayCardRolePanel.SroleWoman:SetActive(true)
	end
	local sprite = info.image:GetComponent("Image").sprite
	weChatFunction.GetSprite(image, sprite)
	weChatFunction.GetSprite(Simage, sprite)

	local distance = ''
	local roleIndex = getRoleIndexById(info.roleId)
	local location = getOtherPlayerLocation(roleIndex)
	if IS_APP_STORE_CHECK or global.roomVo.isFangzhu == 3 or global.roomVo.vsRoomNum ~= 0 then
		distance = '  ';
	else
		if table_size(global.gpsMsgInfo) > 0 then
			for selfKey, v in pairs(global.gpsMsgInfo) do
				if selfKey == info.roleId then
					if global.gpsMsgInfo[selfKey][1] == '0' then
						distance = "未开启GPS定位"
					else
						for otherKey, v in pairs(global.gpsMsgInfo) do
							if otherKey ~= info.roleId then
								if global.gpsMsgInfo[otherKey][1] == '0' then
									local name = getOtherRoleInfo(otherKey).name
									distance = distance .. GetShortName(name) .. "定位未开启" .. "   "
								elseif global.gpsMsgInfo[otherKey][1] == '1' then
									local name = getOtherRoleInfo(otherKey).name
									local length = GetDistance(global.gpsMsgInfo[selfKey][2], global.gpsMsgInfo[selfKey][3], global.gpsMsgInfo[otherKey][2], global.gpsMsgInfo[otherKey][3])
									if length <= 0.02 then
										distance = distance .. "与" .. GetShortName(name) .. "相距:<color=#b41818>" .. "过近" .. "</color>" .. "   "
									else
										distance = distance .. "与" .. GetShortName(name) .. "相距:<color=#362918>" .. length .. "km</color>" .. "   "
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
	end
	self:SetText(PlayCardRolePanel.txtInfoMine, distance)
	distance = ''

	if info.typeInfo == "Small" then
		PlayCardRolePanel.Small:SetActive(true)
		PlayCardRolePanel.Big:SetActive(false)
	elseif info.typeInfo == "Big" then
		PlayCardRolePanel.Small:SetActive(false)
		PlayCardRolePanel.Big:SetActive(true)
	end
	-- PlayCardRolePanel.txtInfoMine:SetActive(false)
end


function PlayCardRoleCtrl.OnQuitBtnClick(go)
	local self = PlayCardRoleCtrl
	PlayCardRoleCtrl.roleInfo = { }
	self:Close(true)
end


-- 点击表情
function PlayCardRoleCtrl.OnFaceClick(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local myIndex = getRoleIndexById(global.userVo.roleId)
	local targetIndex = getRoleIndexById(PlayCardRoleCtrl.roleInfo.roleId)
	print("------------", PlayCardRoleCtrl.roleInfo.roleId)
	if myIndex == targetIndex then
		local self = PlayCardRoleCtrl
		PlayCardRoleCtrl.roleInfo = { }
		self:Close(true)
		GameMainCtrl.SetIconTips("不能对自己发送！")
		return
	end
	local faceName = go.name
	local chatInfo = tostring(myIndex .. targetIndex .. go.name)
	local faceType = 6
	self = PlayCardRoleCtrl
	local obj = PlayCardRoleCtrl.AnimationPos(targetIndex, 'imgAnim')
	if obj.activeSelf == true then
		GameMainCtrl.SetIconTips("您说话太快了，休息一下吧！")
		PlayCardRoleCtrl.OnQuitBtnClick(go)
	else
		PlayCardRoleCtrl:SendFaceAnimation(faceType, chatInfo)
	end
end

-- 发送表情
function PlayCardRoleCtrl:SendFaceAnimation(chatType, chatInfo)
	local GameChat = Chat_pb.ChatReq()
	GameChat.chatType = chatType
	GameChat.chatText = chatInfo
	print('PlayCardRoleCtrl:SendFaceAnimation===', chatType, chatInfo)
	local msg = GameChat:SerializeToString()
	Game.SendProtocal(Protocal.ChatInfo, msg)
	self:Close()
end

-- 接收表情
function PlayCardRoleCtrl.OnChatInfoRes(buffer)
	if not GameMainCtrl.isCreate then
		return
	end
	local data = buffer:ReadBuffer()
	local msg = Chat_pb.ChatReq()
	msg:ParseFromString(data)
	local chatType = msg.chatType
	if chatType ~= 6 then return end
	local chatText = msg.chatText
	local myIndex = string.sub(chatText, 1, 1)
	local targetIndex = string.sub(chatText, 2, 2)
	local faceName = string.sub(chatText, 3, #chatText)
	PlayCardRoleCtrl.AnimationShow(myIndex, targetIndex, faceName)
end

-- 显示表情
function PlayCardRoleCtrl.AnimationShow(myIndex, targetIndex, faceName)
	print("======myIndex=======targetIndex============", myIndex, targetIndex, faceName)
	local myPos = PlayCardRoleCtrl.AnimationPos(myIndex, 'imgHead')
	local tarPos = PlayCardRoleCtrl.AnimationPos(targetIndex, 'imgHead')
	local curSprite = PlayCardRoleCtrl.SpriteReturn(faceName)
	local obj = nil
	obj = PlayCardRoleCtrl.AnimationPos(targetIndex, 'imgAnim')
	obj.transform.position = myPos.transform.position
	obj.transform.localRotation = Vector3.New(0, 0, 180)
	obj:SetActive(true)
	obj.transform:GetComponent("Image").sprite = curSprite
	PlayCardRoleCtrl.AnimationCtrl(obj, myPos, tarPos, faceName)
end

-- 解析图片
function PlayCardRoleCtrl.SpriteReturn(faceName)
	local sprite = nil
	local panel = nil
    panel = GameMainPanel
	sprite = BasePanel:GOChild(panel.imgAnimList,faceName):GetComponent('Image').sprite
	return sprite
end
-- 获取坐标
function PlayCardRoleCtrl.AnimationPos(index, typeName)
	location = getOtherPlayerLocation(index)
	local pos = nil

	if location == 'D' then
		if typeName == "imgHead" then
			pos = GameMainPanel.imgHeadD
		elseif typeName == "imgAnim" then
			pos = GameMainPanel.imgAnimD
		end
	elseif location == 'R' then
		if typeName == "imgHead" then
			pos = GameMainPanel.imgHeadR
		elseif typeName == "imgAnim" then
			pos = GameMainPanel.imgAnimR
		end
	elseif location == 'L' then
		if typeName == "imgHead" then
			pos = GameMainPanel.imgHeadL
		elseif typeName == "imgAnim" then
			pos = GameMainPanel.imgAnimL
		end
	elseif location == 'U' then
		if typeName == "imgHead" then
			pos = GameMainPanel.imgHeadU
		elseif typeName == "imgAnim" then
			pos = GameMainPanel.imgAnimU
		end
	end
	return pos
end

-- 动画飞行控制
function PlayCardRoleCtrl.AnimationCtrl(obj, myPos, tarPos, faceName)
	print("========obj", obj.name)
	local gameObject = obj
	local sequence = DG.Tweening.DOTween.Sequence()
	-- 动画序列
	local rotateMod = DG.Tweening.RotateMode.Fast
	-- 旋转模型
	if faceName == "imgE1" then
		--Game.MusicEffect(Game.Effect.feizaofly)
	elseif faceName == "imgE3" then
		--Game.MusicEffect(Game.Effect.kissfly)
	else
		--Game.MusicEffect(Game.Effect.eggfly)
	end
	sequence:Append(gameObject.transform:DOMove(Vector2.New(tarPos.transform.position.x, tarPos.transform.position.y), 1, false))
	:Insert(0.3, gameObject.transform:DORotate(Vector3.zero, 0.7, rotateMod))
	-- 第一个参数为开始旋转的时间
	:OnComplete( function()
		PlayCardRoleCtrl.Back(gameObject, tarPos, faceName)
	end )
end	

-- 返回原点隐藏
function PlayCardRoleCtrl.Back(gameObject, tarPos, faceName)
	gameObject:SetActive(false)
	resMgr:LoadPrefab('faceanimation', { faceName }, function(objs)
		if faceName == "imgE2" then
			--Game.MusicEffect(Game.Effect.cheers)
		elseif faceName == "imgE3" then
			--Game.MusicEffect(Game.Effect.kissdes)
		elseif faceName == "imgE4" then
			--Game.MusicEffect(Game.Effect.xihongshi)
		elseif faceName == "imgE1" then
			--Game.MusicEffect(Game.Effect.feizaofly)
		else
			--Game.MusicEffect(Game.Effect.eggdes)
		end
		PlayCardRoleCtrl.SetPos(objs, tarPos)
	end )
end

function PlayCardRoleCtrl.SetPos(objs, tarPos)
	local go = newObject(objs[0])
	go.transform.parent = tarPos.transform
	go.transform.localScale = Vector3.one
	go.transform.localPosition = Vector3.zero
	local sequence = DG.Tweening.DOTween.Sequence()
	-- 动画序列
	sequence:Append(go.transform:DOMove(tarPos.transform.position, 1.2, false))
	:OnComplete( function()
		go:Destroy()
	end )
end