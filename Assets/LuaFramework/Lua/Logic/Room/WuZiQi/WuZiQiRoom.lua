WuZiQiRoom = {
    RoomMsg = {},
}

setbaseclass(WuZiQiRoom, {RoomObject})
--缓存
function WuZiQiRoom.SaveGameObj(objs,name)
    local  self = WuZiQiRoom
    if self.loadObjList[name] then return end
    self.loadObjList[name] = objs[0]
    print("====SaveGameObj====:",self.loadObjList[name])
end

--加载
function WuZiQiRoom:LoadGameObj(objs)
    print("====LoadGameObj====",Room.gameType)
    local GuiCamera = find('Canvas/GuiCamera')
	self.imgHead 		= BasePanel:GOChild(obj,"Mask/img")
    --获取数据
    WuZiQiRoom.gameUI = newObject(objs)
    WuZiQiRoom.gameUI.transform:SetParent(GuiCamera.transform)
    WuZiQiRoom.gameUI.transform.localScale = Vector3.one
    WuZiQiRoom.gameUI.transform.localPosition = Vector3.zero
    local table     = find("Canvas/GuiCamera/WZGame(Clone)/Table/WuZiQiTable/imgQiPanBG")
    local CHTable = find("Canvas/GuiCamera/NNGame(Clone)/Table/WuZiQiTable")
    CHTable:SetActive(true)
    self.playerPanel = find("Canvas/GuiCamera/Sence(Clone)/Players")
 
    self.playerPanel:SetActive(false)
    self.txtRoomNum  = BasePanel:GOChild(table,"txtRoomNum")

    UI_WuZiQiCtrl:Open("UI_WuZiQi", function()
        for i = 1, 2 do
            local obj = self.playerPanel.transform:FindChild("WZ_Player"..i).gameObject
            obj:SetActive(false)
        end
        print("====LoadGameObj=111221212121238881WuZiqifRoom")
        self:ResourceCheckOver()
        print("====LoadGameObj====222222222WuZiqifRoom")
        local gamePanel = find("Canvas/GuiCamera/UI_WuZiQiPanel")
        gamePanel.transform:SetParent(self.playerPanel.transform)
        gamePanel.transform:SetSiblingIndex(6)
    end)
    self.btnCheck = 0
end

--初始化
function WuZiQiRoom:InitPlayers()
 	print("=============InitPlayers===",#self.players,self.playerCount,self.myIndex,self.playersData,global.systemVo.EffectSource.volume)
  	self.curJushu = 0
	self:SetCurJushu(self.curJushu)
    --清理手牌和玩家
    if self.players ~= nil then
        for _, v in ipairs(self.players) do
            if v.obj ~= nil then
                v:Destroy()
            end
        end
        self.players = {}
    end
    for i = 1, 3 do
        local obj = self.playerPanel.transform:FindChild("WZ_Player"..i).gameObject
        obj:SetActive(false)
    end
    --初始化玩家信息
    for i = 1, self.playerCount do
        print("------------------WZ_Player---",self:GetRoomIndexByIndex(i))
        local obj = self.playerPanel.transform:FindChild("WZ_Player"..self:GetRoomIndexByIndex(i)).gameObject
        local playerObj = CatchPockPlayer:New(self.playersData[i],obj)
        table.insert(self.players, playerObj)
        if self.myIndex ~= playerObj.index then
            UI_WuZiQiCtrl:RemoveClick(playerObj.imgHead)
            UI_WuZiQiCtrl:AddClick(playerObj.imgHead,UI_WuZiQiCtrl.OnClickHead)
        else
            if not self.isAdd then
                UI_WuZiQiCtrl:AddClick(playerObj.imgHead,UI_WuZiQiCtrl.OnClickHead)
                self.isAdd = true
            end
        end     
        playerObj.obj:SetActive(true)   
    end
    print("--------------------------",#self.players)
    for i,v in ipairs(self.players) do
        v.obj:SetActive(true)
        UI_WuZiQiCtrl:SetText(v.txtName,v.name)
        UI_WuZiQiCtrl:SetText(v.txtScore,v.jifen)
        v.imgOK:SetActive(false)
        v.imgZhuang:SetActive(false)
        v.imgChat:SetActive(false)
        v.imgFaceIcon:SetActive(false)
        v.imgDeng:SetActive(false)
        v.imgAnim:SetActive(false)
        v.imgCur:SetActive(false)
        v.imgCard:SetActive(false)
        v:PopType(0,0)
    end
    self.playerPanel:SetActive(true)
    BlockLayerCtrl:CloseSpec()
    self.initPlayerEnd = true
end

function CatchPockRoom:Reload(data)
    --接收数据
    self.notVoice = true
    self.hasLoaded = false
    self.initPlayerEnd = false
    local roomVo = RoomCatchVo:New()
    roomVo.id                  = data.roomNum
    roomVo.catchTotal         = data.catchTotal
    self.RoomMsg = roomVo
    self.playersData = {}
    self.players = {}
    self.btnCheck = 0
    local curEnd = data.curEnd
    self:ClearRoomInfo()
    for i,v in ipairs(data.roles) do
        local joinRoomUserVo     = JoinRoomUserVo:New()
        joinRoomUserVo.index     = v.roleIndex;
        joinRoomUserVo.roleId    = v.roleId;
        joinRoomUserVo.name      = v.name;
        joinRoomUserVo.ip        = v.ip;
        joinRoomUserVo.headImg   = v.headImg;
        joinRoomUserVo.jifen     = v.jifen;
        joinRoomUserVo.gender    = v.gender;
        joinRoomUserVo.diamond   = v.diamond;
        joinRoomUserVo.isOnline  = v.isOnline;
        print("11111111111111111111111111",v.isOnline,v.jifen)
        local placeMsg    = v.locationInfo;
        local strArray 
        strArray = string_split(placeMsg,"/")
        global.gpsMsgInfo[tostring(v.roleId)] = {strArray[1],tonumber(strArray[2]),tonumber(strArray[3])}
        self.playersData[v.roleIndex] = joinRoomUserVo
        if v.roleId == global.userVo.roleId then
            self.myIndex = v.roleIndex
        end
    end
    self.playerCount = #self.playersData

    -- 重连设置
    local co = coroutine.start(function()
        while not self.isPrefabLoaded do
            coroutine.step()
        end
        -- 设置房间信息
        print("====Reload==SetRoom==",data.roomNum,data.alreadyJuShu,data.curIndex)
        CH_GameMainPanel.panel_WaitFriend:SetActive(false)
        CH_GameMainPanel.imgCHGameMain:SetActive(true)
        CH_GameMainPanel.btnGameMainQuitRoom:SetActive(true)
        CH_GameMainPanel.btnSetSystem:SetActive(true)
        CH_GameMainPanel.btnChat:SetActive(true)
        CH_GameMainPanel.imgSignalBG:SetActive(true)
        CH_GameMainPanel.btnGPS:SetActive(true)

        self:InitPlayers()
        self.curJushu   = data.alreadyJuShu
        self.allJushu   = data.catchTotal
        self.alreadyJuShu = data.alreadyJuShu

        local curIndex   = data.curIndex
        local curEnd     = data.curEnd
        local firstIndex = data.firstIndex
        local lastIndex = curIndex

        --把自己的头像放在左边
        for i,v in ipairs(self.players) do
            if self.myIndex == v.index then
                v.obj.transform.localPosition = Vector3.New(-550,-45,0)
            end
        end
        --设置玩家信息
        if not curEnd then
            for i, role in ipairs(data.roles) do
                local curCache = self:GetPlayer(i)
                local spInfo = ReLoad_pb.CatchPockRoleSpInfo()
                spInfo:ParseFromString(role.spInfoRes)
                curCache.cardsCount = spInfo.leftCount
                print("player----cardtype-----------",i,#spInfo.popCards,spInfo.buttonTips,#spInfo.tips)
                --最后出的牌
                if i ~= curIndex then
                    self:ClearLastCards(i,spInfo.popCards)
                    self:CardType(i,spInfo.popCardType,spInfo.popCards)
                end
                --给自己生成手牌
                if i == self.myIndex then
                    for j,k in ipairs(spInfo.handCards) do
                        curCache:GetOneCard(i,k,2,false)
                    end
                    print("!!!!!!!!!!!!!!!!!!!!!!!!!!---------------------self",curCache.cardsCount)
                end

                --提示
                if curIndex == self.myIndex and curIndex == i then
                    self.TipFunc(curIndex,spInfo.buttonTips,spInfo.tips)
                end
                curCache.imgCard:SetActive(true)
            end
        end
        lastIndex = lastIndex - 1
        if lastIndex <= 0 then
            lastIndex = 3
        end
        self:GoNextPlayer(lastIndex)
        self.notVoice = false
        self.hasLoaded = true
        Room:SetGps(data.roles)
        print("ReLoad---------------------",curIndex,self.myIndex)
    end)
    table.insert(Network.crts, co)
end