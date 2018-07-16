DissolutionRoomTipsCtrl = {
	thisRoom = nil
};
setbaseclass(DissolutionRoomTipsCtrl, { BaseCtrl })

local showCode;
local DissolutionRoomFangzhuRoleId;
DissolutionRoomCodeParas = { };

-- 启动事件--
function DissolutionRoomTipsCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)
	self:AddClick(DissolutionRoomTipsPanel.btnConfirm, self.OnConfirmBtnClick);
	self:AddClick(DissolutionRoomTipsPanel.btnCancel, self.OnCancelBtnClick);
	self:InitPanel();
end


-- 初始化面板--
function DissolutionRoomTipsCtrl:InitPanel()
	if Room.gameType == RoomType.Tenharf then
		self.thisRoom = TenharfRoom
	elseif Room.gameType == RoomType.GoldFlower then
		self.thisRoom = GoldFlowerRoom
	elseif Room.gameType == RoomType.CatchPock then
		self.thisRoom = CatchPockRoom
	elseif Room.gameType == RoomType.NiuNiu then
		self.thisRoom = NiuNiuRoom
	elseif Room.gameType == RoomType.WuZiQi then
		self.thisRoom = UI_WuZiQiCtrl
	elseif Room.gameType == RoomType.Landlords then
		self.thisRoom = LandlordsRoom
	end

	if MainSenceCtrl.RoomType == RoomMode.roomCardMode then
		if self.thisRoom ~= nil then
			if self.thisRoom.playersData[1] ~= nil and self.thisRoom.playersData[1].roleId ~= nil and global.userVo.roleId ~= nil then
				if self.thisRoom.playersData[1].roleId == global.userVo.roleId then
					self:SetText(DissolutionRoomTipsPanel.txtDissolution, '解散房间不扣房卡,是否确定解散?');
				else
					self:SetText(DissolutionRoomTipsPanel.txtDissolution, '是否退出房间?');
				end
			else
				self:SetText(DissolutionRoomTipsPanel.txtDissolution, '解散房间不扣房卡,是否确定解散?');
			end
		else
			print("解散房间不扣房卡,是否确定解散?2", global.joinRoomUserVos[1].roleId, global.userVo.roleId)
			if global.joinRoomUserVos[1] ~= nil and global.joinRoomUserVos[1].roleId ~= nil and global.userVo.roleId ~= nil then
				if global.joinRoomUserVos[1].roleId == global.userVo.roleId then
					self:SetText(DissolutionRoomTipsPanel.txtDissolution, '解散房间不扣房卡,是否确定解散?')
				else
					self:SetText(DissolutionRoomTipsPanel.txtDissolution, '是否退出房间?')
				end
			else
				self:SetText(DissolutionRoomTipsPanel.txtDissolution, '解散房间不扣房卡,是否确定解散?')
			end
		end
	else
		self:SetText(DissolutionRoomTipsPanel.txtDissolution, '你真的要离开房间吗?');
	end
end

-- 退出房间确认按钮
function DissolutionRoomTipsCtrl.OnConfirmBtnClick(go)
	local self = DissolutionRoomTipsCtrl
	print("=====DissolutionRoomTipsCtrl.OnConfirmBtnClick====MainSenceCtrl.RoomType==",MainSenceCtrl.RoomType)
	if MainSenceCtrl.RoomType == RoomMode.roomCardMode and Room.gameType ~= RoomType.WuZiQi then
		if self.thisRoom ~= nil then
			if self.thisRoom.playersData[1] ~= nil and self.thisRoom.playersData[1].roleId ~= nil and global.userVo.roleId ~= nil then
				if self.thisRoom.playersData[1].roleId ~= global.userVo.roleId then
					Game.SendProtocal(Protocal.QuitRoom)
				else
					Game.SendProtocal(Protocal.DissolutionRoom)
				end
			else
				Game.SendProtocal(Protocal.DissolutionRoom)
			end
		else
			if global.joinRoomUserVos[1] ~= nil and global.joinRoomUserVos[1].roleId ~= nil and global.userVo.roleId ~= nil then
				if global.joinRoomUserVos[1].roleId ~= global.userVo.roleId then
					Game.SendProtocal(Protocal.QuitRoom)
				else
					Game.SendProtocal(Protocal.DissolutionRoom)
				end
			else
				Game.SendProtocal(Protocal.DissolutionRoom)
			end
		end
	else
		Game.SendProtocal(Protocal.QuitMateRoom)
	end
end

function DissolutionRoomTipsCtrl.OnCancelBtnClick(go)
	local self = DissolutionRoomTipsCtrl;
	self:Close();
end

function DissolutionRoomTipsCtrl.OnDissolutionRoomRes(buffer)
	print('DissolutionRoomTipsCtrl:OnDissolutionRoomRes')
	local self = DissolutionRoomTipsCtrl;
	local data = buffer:ReadBuffer();
	local msg = ShowCode_pb.ShowCodeRes();
	msg:ParseFromString(data);
	showCode = msg.showCode;
	DissolutionRoomFangzhuRoleId = msg.roleId;
	DissolutionRoomCodeParas = msg.codeParas[1];

	if Room.gameType == RoomType.Tenharf then
		self.thisRoom = TenharfRoom
	elseif Room.gameType == RoomType.GoldFlower then
		self.thisRoom = GoldFlowerRoom
	elseif Room.gameType == RoomType.CatchPock then
		self.thisRoom = CatchPockRoom
	elseif Room.gameType == RoomType.NiuNiu then
		self.thisRoom = NiuNiuRoom
	elseif Room.gameType == RoomType.WuZiQi then
		self.thisRoom = UI_WuZiQiCtrl
	elseif RoomType.gameType == RoomType.Landlords then
		self.thisRoom = LandlordsRoom
	end
	if MainSenceCtrl.RoomType == RoomMode.roomCardMode then
		if DissolutionRoomFangzhuRoleId ~= nil then
			if DissolutionRoomFangzhuRoleId == global.userVo.roleId then
				-- self:SetText(DissolutionRoomTipsPanel.txtDissolution, '解散房间不扣房卡,是否确定解散?');
				if self.thisRoom ~= nil then
					self.thisRoom:ClearRoomInfo()
					TH_GameMainCtrl:Close();
				else
					Event.Brocast(MsgDefine.Room_Exit)
					GameMainCtrl:Close();
				end
				self:Close();
				-- 房主解散房间把断线重连状态去除
				Game.isReloadBattle = false
				if Room.gameType ~= RoomType.WuZiQi then
					Network.ClearCtrs()
					Game.LoadScene("main")
				else

				end
			else
				if self.thisRoom ~= nil then
					self.thisRoom:ClearRoomInfo()
				end
				DissolutionSuccessCtrl:Open('DissolutionSuccess')
			end
		end
	else
		-- print("------------ClearRoomInfo-------<<<<<<<<<<<<",#self.thisRoom.playersData)
		if self.thisRoom ~= nil then

			self.thisRoom:ClearRoomInfo()
			TH_GameMainCtrl:Close();
		else
			Event.Brocast(MsgDefine.Room_Exit)
			GameMainCtrl:Close();
		end
		self:Close();
		print("==========房主解散房间把断线重连状态去除==========")
		-- 房主解散房间把断线重连状态去除
		Game.isReloadBattle = false
		Network.ClearCtrs()
		Game.LoadScene("main")
	end
end
