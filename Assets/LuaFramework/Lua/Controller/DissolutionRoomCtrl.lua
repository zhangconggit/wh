--文件：申请解散房间界面控制

DissolutionRoomCtrl = {}
setbaseclass(DissolutionRoomCtrl, {BaseCtrl})



local txtPlayer = nil
local time

function DissolutionRoomCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	self.roomPlayMsg = {}
	self:AddClick(DissolutionRoomPanel.btnApplyConfrim,self.OnApplyConfirmBtnClick)
	self:AddClick(DissolutionRoomPanel.btnApplyCancel,self.OnApplyCancelBtnClick)
	self:InitPanel()
end

--初始化信息
function DissolutionRoomCtrl:InitPanel(objs)
    local self = DissolutionRoomCtrl
	if global.userVo.name == global.applyDisRoomVo.name then
		self:SetText(DissolutionRoomPanel.txtDissolutionRoom,"您已申请解散房间，请等待其他玩家确认：")
		DissolutionRoomPanel.btnApplyConfrim:SetActive(false)
		DissolutionRoomPanel.btnApplyCancel:SetActive(false)
	else
		self:SetText(DissolutionRoomPanel.txtDissolutionRoom, "<color=#3a7400>" .. global.applyDisRoomVo.name .. "</color>  申请解散房间，是否同意：")
		DissolutionRoomPanel.btnApplyConfrim:SetActive(true)
		DissolutionRoomPanel.btnApplyCancel:SetActive(true)
	end
    time = global.applyDisRoomVo.time / 1000
    print("=====DissolutionRoomCtrl==global",global.applyDisRoomVo.time)
	self:SetText(DissolutionRoomPanel.timeTxt,time)
	self:InvokeRepeat("SetWaitTime",1,time)
    if Room.gameType == RoomType.Mahjong then
        if #global.joinRoomUserVos == 4 then
        	txtPlayer = {
        	DissolutionRoomPanel.txtPlayerOne,DissolutionRoomPanel.txtPlayerTwo,DissolutionRoomPanel.txtPlayerThree
        	}
        else
        	txtPlayer = {
        	DissolutionRoomPanel.txtPlayerOne,DissolutionRoomPanel.txtPlayerTwo
        	}
        end
    elseif Room.gameType == RoomType.Tenharf then
        self.InitPanelApplyCard(TenharfRoom)
    elseif Room.gameType == RoomType.GoldFlower then
        self.InitPanelApplyCard(GoldFlowerRoom)
    elseif Room.gameType == RoomType.CatchPock then
        self.InitPanelApplyCard(CatchPockRoom)
    elseif Room.gameType == RoomType.NiuNiu then
        self.InitPanelApplyCard(NiuNiuRoom)
    elseif Room.gameType == RoomType.WuZiQi then   
        self.InitPanelApplyCard(UI_WuZiQiCtrl)
    elseif Room.gameType == RoomType.Landlords then
        self.InitPanelApplyCard(LandlordsRoom)
    end

	for k,v in ipairs(global.applyDisRoomVo.otherInfo) do
		local name    = v.name;
		self.roomPlayMsg[tostring(v.roleId)] = self:GetShortName(name) .. "：待同意"
	end

	self:SetPanelMsg()

	local c = ClientCheckInfoVo:New()
	c.isGameOver = 0
	global.clientCheckInfoVo = c
end

function DissolutionRoomCtrl.InitPanelApplyCard(roomType)
    if roomType.playerCount >= 5 then
        txtPlayer = {
        DissolutionRoomPanel.txtPlayerOne,DissolutionRoomPanel.txtPlayerTwo,DissolutionRoomPanel.txtPlayerThree,DissolutionRoomPanel.txtPlayerFour
        }
    elseif roomType.playerCount == 4 then
        txtPlayer = {
        DissolutionRoomPanel.txtPlayerOne,DissolutionRoomPanel.txtPlayerTwo,DissolutionRoomPanel.txtPlayerThree
        }
    elseif roomType.playerCount == 3  then
        txtPlayer = {
        DissolutionRoomPanel.txtPlayerOne,DissolutionRoomPanel.txtPlayerTwo
        }
    elseif roomType.playerCount == 2  then
        txtPlayer = {
        DissolutionRoomPanel.txtPlayerOne
        }
    end
end


function DissolutionRoomCtrl:SetPanelMsg()
	for i, v in ipairs(global.applyDisRoomVo.otherInfo) do
		self:SetText(txtPlayer[i],self.roomPlayMsg[tostring(v.roleId)])
	end
end

function DissolutionRoomCtrl:SetWaitTime()
	time=time-1
	self:SetText(DissolutionRoomPanel.timeTxt,time)
end

function DissolutionRoomCtrl.OnApplyConfirmBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local dissolutionOperate = ApplyDisRoomOperate_pb.ApplyDisRoomOperateReq()	
	dissolutionOperate.type  = 1
    local msg = dissolutionOperate:SerializeToString()
    Game.SendProtocal(Protocal.ApplyDisRoomOperation, msg)
    DissolutionRoomPanel.btnApplyConfrim:SetActive(false)
    DissolutionRoomPanel.btnApplyCancel:SetActive(false)
end


function DissolutionRoomCtrl.OnApplyCancelBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local dissolutionOperate = ApplyDisRoomOperate_pb.ApplyDisRoomOperateReq()
	dissolutionOperate.type     = 2
    local msg = dissolutionOperate:SerializeToString()
    Game.SendProtocal(Protocal.ApplyDisRoomOperation, msg)
end

--申请解散房间操作回调
function DissolutionRoomCtrl.OnDissolutionRoomRes(buffer)
	print("=====OnDissolutionRoomRes==10021")
	local self = DissolutionRoomCtrl
	local operate 
	local data   = buffer:ReadBuffer()
	local msg    = ApplyDisRoomOperate_pb.ApplyDisRoomOperateRes()	
	msg:ParseFromString(data)
	--currentTime = global.applyDisRoomVo.time
	local infoType = msg.type
	local msgs = ""
	log('Get player operate info----type='..tostring(infoType))
	
	if infoType == 1 then
		  operate = ApplyDisRoomOperate_pb.Agree()
		  operate:ParseFromString(msg.data)
		local roleId = tostring(operate.roleId)
		log('Agreen---'..roleId)
		if Room.gameType == RoomType.Mahjong then
			self.roomPlayMsg[roleId] = self:GetShortName(getOtherRoleInfo(roleId).name) .. "：同意"
		elseif Room.gameType == RoomType.Tenharf then
			self.roomPlayMsg[roleId] = self:GetShortName(TenharfRoom:GetPlayerById(roleId).name) .. "：同意"
        elseif Room.gameType == RoomType.GoldFlower then
            self.roomPlayMsg[roleId] = self:GetShortName(GoldFlowerRoom:GetPlayerById(roleId).name) .. "：同意"
        elseif Room.gameType == RoomType.CatchPock then
            self.roomPlayMsg[roleId] = self:GetShortName(CatchPockRoom:GetPlayerById(roleId).name) .. "：同意"
		elseif Room.gameType == RoomType.NiuNiu then
            self.roomPlayMsg[roleId] = self:GetShortName(NiuNiuRoom:GetPlayerById(roleId).name) .. "：同意"
        elseif Room.gameType == RoomType.Landlords then
            self.roomPlayMsg[roleId] = self:GetShortName(LandlordsRoom:GetPlayerById(roleId).name) .. "：同意"
        end
		if self.isCreate then
			self:SetPanelMsg()
		end

	elseif infoType == 2 then
		operate = ApplyDisRoomOperate_pb.DisAgree()
		operate:ParseFromString(msg.data)
		local name = operate.name
		self:Close(true)
        msgs = name  .. "  拒绝解散房间！"
        MessageTipsCtrl:ShowInfo(msgs)
	elseif infoType == 3 then
		local operate = ApplyDisRoomOperate_pb.AllAgree()
		  operate:ParseFromString(msg.data)
        if Room.gameType == RoomType.Mahjong then
        	if SingleSettlementCtrl.isClose == false then
                if SingleSettlementPanel.btnStart ~= nil then
            		SingleSettlementPanel.btnStart:SetActive(false)
            		SingleSettlementPanel.btnTotalScore:SetActive(true)
                end
        	end
            self.gameOver = true
            if #global.joinRoomUserVos == 4 then
                msgs = "经玩家"..operate.names[1].."--"..operate.names[2].."--"..operate.names[3].."同意，房间已解散！"
            else
                msgs = "经玩家"..operate.names[1].."--"..operate.names[2].."同意，房间已解散！"
            end
        elseif Room.gameType == RoomType.Tenharf then
            msgs = self.DissolutionRoomAppleCard(TenharfRoom,operate)
        elseif Room.gameType == RoomType.GoldFlower then
            msgs = self.DissolutionRoomAppleCard(GoldFlowerRoom,operate)
        elseif Room.gameType == RoomType.CatchPock then
            msgs = self.DissolutionRoomAppleCard(CatchPockRoom,operate)
        elseif Room.gameType == RoomType.NiuNiu then
            msgs = self.DissolutionRoomAppleCard(NiuNiuRoom,operate)
        elseif Room.gameType == RoomType.Landlords then
            msgs = self.DissolutionRoomAppleCard(LandlordsRoom,operate)
        end
        MessageTipsCtrl:ShowInfo(msgs)
        self:Close(true)
	elseif infoType == 4 then
		local operate = ApplyDisRoomOperate_pb.TimeEnd()
		  operate:ParseFromString(msg.data)
        if Room.gameType == RoomType.Mahjong then
        	if SingleSettlementCtrl.isClose == false then
                if SingleSettlementPanel.btnStart ~= nil then
            		SingleSettlementPanel.btnStart:SetActive(false)
            		SingleSettlementPanel.btnTotalScore:SetActive(true)
                end
        	end
        end
		self.gameOver = true
		local code  = operate.code
		local roomNum = operate.roomNum
		local ms = operate.ms
		self:Close(true)
	end	
end

function DissolutionRoomCtrl.DissolutionRoomAppleCard(roomType,operate)
    local self = DissolutionRoomCtrl
    self.gameOver = true
    if roomType.playerCount == 5 then
         msgs = "经玩家"..operate.names[1].."--"..operate.names[2].."--"..operate.names[3].."--"..operate.names[4].."同意，房间已解散！"
    elseif roomType.playerCount == 4 then
        msgs = "经玩家"..operate.names[1].."--"..operate.names[2].."--"..operate.names[3].."同意，房间已解散！"
    elseif roomType.playerCount == 3  then
        msgs = "经玩家"..operate.names[1].."--"..operate.names[2].."同意，房间已解散！"
    elseif roomType.playerCount == 2  then
        msgs = "经玩家"..operate.names[1].."同意，房间已解散！"
    end
    return msgs
end

--@brief 切割字符串，并用“...”替换尾部
 --@param sName:要切割的字符串
 --@return nMaxCount，字符串上限,中文字为2的倍数
 --@param nShowCount：显示英文字个数，中文字为2的倍数,可为空
 --@note         函数实现：截取字符串一部分，剩余用“...”替换
function DissolutionRoomCtrl:GetShortName(sName)
	local nMaxCount = 20
	local nShowCount = 20
     if sName == nil or nMaxCount == nil then
         return
     end
     local sStr = sName
     local tCode = {}
     local tName = {}
     local nLenInByte = #sStr
     local nWidth = 0
     if nShowCount == nil then
        nShowCount = nMaxCount - 3
     end
     for i=1,nLenInByte do
         local curByte = string.byte(sStr, i)
         local byteCount = 0
         if curByte>0 and curByte<=127 then
             byteCount = 1
         elseif curByte>=192 and curByte<223 then
             byteCount = 2
         elseif curByte>=224 and curByte<239 then
             byteCount = 3
         elseif curByte>=240 and curByte<=247 then
             byteCount = 4
         end
         local char = nil
         if byteCount > 0 then
             char = string.sub(sStr, i, i+byteCount-1)
             i = i + byteCount -1
         end
         if byteCount == 1 then
             nWidth = nWidth + 1
             table.insert(tName,char)
             table.insert(tCode,1)
             
        elseif byteCount > 1 then
             nWidth = nWidth + 2
             table.insert(tName,char)
             table.insert(tCode,2)
         end
     end
     
    if nWidth > nMaxCount then
         local _sN = ""
         local _len = 0
         for i=1,#tName do
             _sN = _sN .. tName[i]
             _len = _len + tCode[i]
             if _len >= nShowCount then
                 break
             end
         end
         sName = _sN .. ".."
     end
     return sName
 end