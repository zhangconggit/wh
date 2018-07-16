GPSInfoCtrl = {
}

setbaseclass(GPSInfoCtrl, {BaseCtrl})

--启动事件--
function GPSInfoCtrl:OnCreate(obj)
    BaseCtrl.OnCreate(self, obj)
    self:AddClick(GPSInfoPanel.btnClose,self.CloseGPS)
    self:AddClick(GPSInfoPanel.btnDisslution,self.Disslution)
    self:AddClick(GPSInfoPanel.btnContinue,self.Continue)
end

--初始化面板--
function GPSInfoCtrl:InitPanel(info,room)
	print("GPSInfoCtrl",#info,#room.players)
	self.info = info
	self.room = room
	local playersNum = #room.players
	if playersNum == 0 then return end
	if GPSInfoPanel["G"..playersNum].activeSelf == true then return end
	local headList = {GPSInfoPanel.imgHead1,GPSInfoPanel.imgHead2,GPSInfoPanel.imgHead3,
					 GPSInfoPanel.imgHead4,GPSInfoPanel.imgHead5}
	local length = 0
	local message = ""
	local GnLine = "G"..#info.."line"
	local GnText = "G"..#info.."txt"
	if playersNum == 2 then
		GPSInfoPanel.imgHead1.transform.localPosition = Vector3.New(-250,-30,0)
		GPSInfoPanel.imgHead2.transform.localPosition = Vector3.New(250,-30,0)
		GPSInfoPanel.imgHead3:SetActive(false)
		GPSInfoPanel.imgHead4:SetActive(false)
		GPSInfoPanel.imgHead5:SetActive(false)
		GPSInfoPanel.G2:SetActive(true)
	elseif playersNum == 3 then
		GPSInfoPanel.imgHead1.transform.localPosition = Vector3.New(0,-110,0)
		GPSInfoPanel.imgHead2.transform.localPosition = Vector3.New(240,120,0)
		GPSInfoPanel.imgHead3.transform.localPosition = Vector3.New(-240,120,0)
		GPSInfoPanel.imgHead4:SetActive(false)
		GPSInfoPanel.imgHead5:SetActive(false)
		GPSInfoPanel.G3:SetActive(true)
	elseif playersNum == 4 then
		GPSInfoPanel.imgHead1.transform.localPosition = Vector3.New(0,65,0)
		GPSInfoPanel.imgHead2.transform.localPosition = Vector3.New(0,-120,0)
		GPSInfoPanel.imgHead3.transform.localPosition = Vector3.New(250,180,0)
		GPSInfoPanel.imgHead4.transform.localPosition = Vector3.New(-250,180,0)
		GPSInfoPanel.imgHead5:SetActive(false)
		GPSInfoPanel.G4:SetActive(true)
	elseif playersNum == 5 then
		GPSInfoPanel.imgHead1.transform.localPosition = Vector3.New(0,110,0)
		GPSInfoPanel.imgHead2.transform.localPosition = Vector3.New(235,-140,0)
		GPSInfoPanel.imgHead3.transform.localPosition = Vector3.New(235,170,0)
		GPSInfoPanel.imgHead4.transform.localPosition = Vector3.New(-235,170,0)
		GPSInfoPanel.imgHead5.transform.localPosition = Vector3.New(-235,-140,0)
		GPSInfoPanel.G5:SetActive(true)
	end
	local txtNear = ""
	local txtSame = ""
	local txtClose = ""
	--获取详细信息
	for i,v in ipairs(info) do
		if v.open then
			if info[i].coords[1] ~= nil then
				print("------------length1-----",info[i].coords[1],info[i].coords[2],i)
				for j,k in ipairs(info) do
					if i < j and i ~= #info then
						if k.open  and info[j].coords[1] ~= nil then
							length = GetDistance(info[i].coords[1],info[i].coords[2],info[j].coords[1],info[j].coords[2])
							print("--------<color=#b41818>----length---</color>--",length)
							if length <= 1 then
								if length <= 0.03 then
									GPSInfoPanel[GnLine..i..j].transform:FindChild("Image"):GetComponent("Image").sprite = GPSInfoPanel.imgRed:GetComponent("Image").sprite
									message = "<color=#ffffff>过近</color>"
									txtNear = "检测到有人距离过近，是否解散房间？"
								else
									length = length*1000
									message = "<color=#fffc16>"..length.."米</color>"
								end
							else
								message = "<color=#fffc16>"..length.."公里</color>"
							end
							print("------------length-----",message)
							if info[i].ip == info[j].ip then
								GPSInfoPanel[GnLine..i..j].transform:FindChild("Image"):GetComponent("Image").sprite = GPSInfoPanel.imgRed:GetComponent("Image").sprite
								message = "<color=#b41818>相同IP</color>"
								local name1 = info[i].name
								local name2 = info[j].name
								txtSame = "检测到 "..name1.." 与 "..name2.." IP相同，是否解散房间？"
							end
							GPSInfoPanel["txtOpen"..i]:SetActive(not info[i].open)
							GPSInfoPanel["txtOpen"..j]:SetActive(not info[j].open)
						else
							GPSInfoPanel["txtOpen"..i]:SetActive(not info[i].open)
							GPSInfoPanel["txtOpen"..j]:SetActive(not info[j].open)
							GPSInfoPanel[GnText..i..j]:SetActive(false)
							GPSInfoPanel[GnLine..i..j]:SetActive(false)
							txtClose = "检测到有人未开启GPS，是否解散房间？"
						end
						self:SetText(GPSInfoPanel[GnText..i..j],message)
					else
						-- print("-------------ij----",i,j)
						-- GPSInfoPanel["txtOpen"..i]:SetActive(not info[i].open)
						-- GPSInfoPanel["txtOpen"..j]:SetActive(not info[j].open)
						-- GPSInfoPanel[GnText..i..j]:SetActive(false)
						-- GPSInfoPanel[GnLine..i..j]:SetActive(false)
						-- self:SetText(GPSInfoPanel.txtTips,"检测到有人未开启GPS，是否解散房间？")
					end
				end
			else
				for j,k in ipairs(info) do
					if i < j and i ~= #info then
						GPSInfoPanel["txtOpen"..i]:SetActive(not info[i].open)
						GPSInfoPanel["txtOpen"..j]:SetActive(not info[j].open)
						GPSInfoPanel[GnText..i..j]:SetActive(false)
						GPSInfoPanel[GnLine..i..j]:SetActive(false)
						txtClose = "检测到有人未开启GPS，是否解散房间？"
					end
				end
			end
		else
			for j,k in ipairs(info) do
				if i < j and i ~= #info then
					GPSInfoPanel["txtOpen"..i]:SetActive(not info[i].open)
					GPSInfoPanel["txtOpen"..j]:SetActive(not info[j].open)
					GPSInfoPanel[GnText..i..j]:SetActive(false)
					GPSInfoPanel[GnLine..i..j]:SetActive(false)
				txtClose = "检测到有人未开启GPS，是否解散房间？"
				end
			end
			print("1111111111111111111111")
		end
	end

	--设置文字
	if txtNear == "" then
		if txtSame == "" then
			self:SetText(GPSInfoPanel.txtTips,txtClose)
		else
			self:SetText(GPSInfoPanel.txtTips,txtSame)
		end
	else
		self:SetText(GPSInfoPanel.txtTips,txtNear)
	end
	-- if Room.gameType ~= RoomType.Mahjong then
		for j,k in ipairs(info) do
			for i,v in ipairs(room.players) do
				if k.id == v.id then
					print("---------setHeadSprite----------",i,headList[j]:GetComponent("Image").sprite)
					headList[j]:GetComponent("Image").sprite = v.imgHead:GetComponent("Image").sprite
				end
			end
		end
	-- else
	-- 	for i,v in ipairs(room.players) do
	-- 		print("---------setHeadSprite----------",i,headList[i]:GetComponent("Image").sprite)
	-- 		headList[i]:GetComponent("Image").sprite = v.imgHead:GetComponent("Image").sprite
	-- 	end
	-- end
	curTime = 0
	curChange = true
	self:InvokeRepeat("ColorChange",0.1,200)

	if Room.Normal then
		GPSInfoPanel.btnDisslution:SetActive(false)
		GPSInfoPanel.btnContinue:SetActive(false)
	end
end

function GPSInfoCtrl.CloseGPS(go)
	local self = GPSInfoCtrl
	--Game.MusicEffect(Game.Effect.joinRoom)
	self:Close(false)
end

function GPSInfoCtrl.Disslution(go)
	local self = GPSInfoCtrl
	--Game.MusicEffect(Game.Effect.buttonBack)
	if Room.gameType ~= RoomType.Mahjong then
  		TH_GameMainPanel.imgQuitTips:SetActive(true)
    	self:SetText(TH_GameMainPanel.txtQuitTips,"是否确认解散房间")
	else
		OB_GameMainPanel.imgQuitTips:SetActive(true)
		if gameRoom.isOnes then
			self:SetText(OB_GameMainPanel.txtQuitTips,"解散房间不扣房卡，是否确定解散？")
		else
			self:SetText(OB_GameMainPanel.txtQuitTips,"是否确认解散房间")
		end
	end
	self:Close(false)
end

function GPSInfoCtrl.Continue(go)
	local self = GPSInfoCtrl
	--Game.MusicEffect(Game.Effect.joinRoom)
	GPSInfoPanel.btnDisslution:SetActive(false)
	GPSInfoPanel.btnContinue:SetActive(false)
	GPSInfoPanel.txtTips:SetActive(false)
	self:Close(false)
end

local curChange = true
local curTime = 0

function GPSInfoCtrl.ColorChange()
	if curChange then
		curTime = curTime + 0.1
		if curTime > 0.5 then
			curChange = false
		end
	else
		curTime = curTime - 0.1
		if curTime < 0.1 then
			curChange = true
		end
	end
	GPSInfoPanel.txtTips:GetComponent("Text").color = Color.New(curTime,curTime,curTime,1)
end