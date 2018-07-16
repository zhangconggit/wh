LandlordsRoom = {
    RoomMsg = {},
    curPopTips = {},
    clickNum = 0,
    btnCheck = 0,
    OrOpenCard = false,
}

setbaseclass(LandlordsRoom, {RoomObject})

--缓存
function LandlordsRoom.SaveGameObj(objs,name)
    local  self = LandlordsRoom
    if self.loadObjList[name] then return end
    self.loadObjList[name] = objs[0]
    print("====SaveGameObj====:",self.loadObjList[name])
end

--加载
function LandlordsRoom:LoadGameObj(objs)
    print("====LoadGameObj====",Room.gameType)
    local GuiCamera = find('Canvas/GuiCamera')
	self.imgHead 		= BasePanel:GOChild(obj,"Mask/img")
    --获取数据
    LandlordsRoom.gameUI = newObject(objs)
    LandlordsRoom.gameUI.transform:SetParent(GuiCamera.transform)
    LandlordsRoom.gameUI.transform.localScale = Vector3.one
    LandlordsRoom.gameUI.transform.localPosition = Vector3.zero
    local table     = find("Canvas/GuiCamera/LandlordsGame(Clone)/Desk/CHTable/imgTHBG")
    local CHTable = find("Canvas/GuiCamera/LandlordsGame(Clone)/Desk/CHTable")
    CHTable:SetActive(true)
    self.playerPanel = find("Canvas/GuiCamera/LandlordsGame(Clone)/Players")
 
    self.playerPanel:SetActive(false)
    self.allJushu           = LandlordsRoom.RoomMsg.catchTotal
    self.txtWanFa           = BasePanel:GOChild(table,"txtWanFa")
    self.imgJuShu           = BasePanel:GOChild(table,"imgJuShu")
    self.txtJuShu           = BasePanel:GOChild(table,"imgJuShu/txtJuShu")
    self.txtRoomNum         = BasePanel:GOChild(table,"txtRoomNum")
    self.common             = BasePanel:GOChild(self.playerPanel,"Common")
    self.empty              = BasePanel:GOChild(self.playerPanel,"Empty")
    self.cardBg             = BasePanel:GOChild(self.playerPanel,"CardBg")
    print("====LoadGameObj====222222222TenharfRoom")
    Ll_GameMainCtrl:Open("Ll_GameMain", function()
        for i = 1, 3 do
            local obj = self.playerPanel.transform:FindChild("CH_Player"..i).gameObject
            obj:SetActive(false)
        end
        print("====LoadGameObj=111221212121238881TenharfRoom")
        self:ResourceCheckOver()
        local gamePanel = find("Canvas/GuiCamera/Ll_GameMainPanel")
        gamePanel.transform:SetParent(self.playerPanel.transform)
        gamePanel.transform:SetSiblingIndex(6)
    end)
    self.btnCheck = 0
end

--初始化
function LandlordsRoom:InitPlayers()
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
        local obj = self.playerPanel.transform:FindChild("CH_Player"..i).gameObject
        obj:SetActive(false)
    end
        --初始化玩家信息
    for i = 1, self.playerCount do
        print("------------------CH_Player---",playerCount,i)
        local obj = self.playerPanel.transform:FindChild("CH_Player"..self:GetRoomIndexByIndex(i)).gameObject
        local playerObj = LandlordsPlayer:New(self.playersData[i],obj)
        table.insert(self.players, playerObj)
        if self.myIndex ~= playerObj.index then
            Ll_GameMainCtrl:RemoveClick(playerObj.imgHead)
            Ll_GameMainCtrl:AddClick(playerObj.imgHead,Ll_GameMainCtrl.OnClickHead)
        else
            if not self.isAdd then
                Ll_GameMainCtrl:AddClick(playerObj.imgHead,Ll_GameMainCtrl.OnClickHead)
                self.isAdd = true
            end
        end     
        playerObj.obj:SetActive(true)   
    end
    print("--------------------------",#self.players)
    for i,v in ipairs(self.players) do
        v.obj:SetActive(true)
        Ll_GameMainCtrl:SetText(v.txtName,v.name)
        Ll_GameMainCtrl:SetText(v.txtScore,v.jifen)
        v.imgOK:SetActive(false)
        v.imgZhuang:SetActive(false)
        v.imgChat:SetActive(false)
        v.imgFaceIcon:SetActive(false)
        v.imgDeng:SetActive(false)
        v.imgAnim:SetActive(false)
        v.imgCur:SetActive(false)
        v.imgCard:SetActive(false)
        v:PopType(0,0)
        --新添加
        v.imgYuanbao:SetActive(false)
        v.imgJinbi:SetActive(false) 
        if self.RoomMsg.moneyType == RoomMode.goldMode then
            v.imgJinbi:SetActive(true) 
            Ll_GameMainCtrl:SetText(v.txtScore,v.goldcoin)
        elseif self.RoomMsg.moneyType == RoomMode.wingMode then
            v.imgYuanbao:SetActive(true)
            Ll_GameMainCtrl:SetText(v.txtScore,v.wing)
        end
    end
    Ll_GameMainPanel.btnGameStart:SetActive(true)
    --新添加
    if self.RoomMsg.moneyType == RoomMode.goldMode then
        Ll_GameMainPanel.btnGameStart:SetActive(false)  
    elseif self.RoomMsg.moneyType == RoomMode.wingMode then
        Ll_GameMainPanel.btnGameStart:SetActive(false) 
    end
    self.playerPanel:SetActive(true)
    self.btnObjList = {
    btnBuChu    = {btn = Ll_GameMainPanel.btnBuChu:GetComponent("Button"),
                    img = Ll_GameMainPanel.btnBuChu:GetComponent("Image"),
                    txt = BasePanel:GOChild(Ll_GameMainPanel.btnBuChu,"Text"):GetComponent("Text"),
                    spr = nil,color = nil
                },
    btnChuPai   = {btn = Ll_GameMainPanel.btnChuPai:GetComponent("Button"),
                    img = Ll_GameMainPanel.btnChuPai:GetComponent("Image"),
                    txt = BasePanel:GOChild(Ll_GameMainPanel.btnChuPai,"Text"):GetComponent("Text"),
                    spr = nil,color = nil
                },
    btnTiShi   = {btn = Ll_GameMainPanel.btnTiShi:GetComponent("Button"),
                txt = BasePanel:GOChild(Ll_GameMainPanel.btnTiShi,"Text")
            },
            }
    self.spr_gray = Ll_GameMainPanel.btn_gray:GetComponent("Image").sprite
    self.txt_gray = Color.New(0,0,0,0.7)

    --准备状态
    if self.RoomMsg.readyIndex ~= nil then
        for i,v in ipairs(self.RoomMsg.readyIndex) do
            local curCache = self:GetPlayerById(v)
            print("-------",curCache)
            curCache.imgOK:SetActive(true)
            if curCache.index == self.myIndex then
                Ll_GameMainPanel.btnGameStart:SetActive(false)
            end
        end
    end
    local quitPanel = Ll_GameMainPanel.imgQuitTips
    local singlePanel = Ll_GameMainPanel.panel_SingleSettlement
    singlePanel.transform:SetParent(self.playerPanel.transform)
    singlePanel.transform:SetAsLastSibling()
    quitPanel.transform:SetParent(self.playerPanel.transform)
    quitPanel.transform:SetAsLastSibling()
    BlockLayerCtrl:CloseSpec()
    self.initPlayerEnd = true
end

--接收数据
function LandlordsRoom:Reload(data)
    self.notVoice = true
    self.hasLoaded = false
    self.initPlayerEnd = false
    local roomVo = RoomCatchVo:New()
    roomVo.id                  = data.roomNum
    roomVo.catchTotal         = data.catchTotal
    --添加
    roomVo.baseNum   = data.baseNum
    roomVo.qualified = data.qualified
    roomVo.moneyType = data.moneyType
    
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
        --新添加
        joinRoomUserVo.goldcoin =  v.goldcoin    --金币数量
        joinRoomUserVo.wing = v.wing         --元宝数量
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
        Ll_GameMainPanel.panel_WaitFriend:SetActive(false)
        Ll_GameMainPanel.imgCHGameMain:SetActive(true)
        Ll_GameMainPanel.btnGameMainQuitRoom:SetActive(true)
        --新添加
        if self.RoomMsg.moneyType == RoomMode.goldMode then
            Ll_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
        elseif self.RoomMsg.moneyType == RoomMode.wingMode then
            Ll_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
        end
        Ll_GameMainPanel.btnSetSystem:SetActive(true)
        Ll_GameMainPanel.btnChat:SetActive(true)
        Ll_GameMainPanel.imgSignalBG:SetActive(true)
        Ll_GameMainPanel.btnGPS:SetActive(true)

        self:InitPlayers()
        self.curJushu   = data.alreadyJuShu
        self.allJushu   = data.catchTotal
        self.alreadyJuShu = data.alreadyJuShu
        self:SetCurJushu(self.curJushu)

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
        if self.RoomMsg.moneyType == RoomMode.roomCardMode then
            Room:SetGps(data.roles)
        end
        print("ReLoad---------------------",curIndex,self.myIndex)
    end)
    table.insert(Network.crts, co)
end

--按钮变灰
function LandlordsRoom:BtnShow(name,bool)
    if bool then
        if self.btnObjList[name].spr == nil then
            self.btnObjList[name].spr = self.btnObjList[name].img.sprite
            self.btnObjList[name].color = self.btnObjList[name].txt.color
        else
            self.btnObjList[name].img.sprite = self.btnObjList[name].spr
            self.btnObjList[name].txt.color = self.btnObjList[name].color
        end
    else
        if self.btnObjList[name].spr == nil then
            self.btnObjList[name].spr = self.btnObjList[name].img.sprite
            self.btnObjList[name].color = self.btnObjList[name].txt.color
        end
        self.btnObjList[name].img.sprite = self.spr_gray
        self.btnObjList[name].txt.color  = self.txt_gray
    end
    self.btnObjList[name].btn.interactable = bool
end

--发牌
function LandlordsRoom:DealCard(roleIndex,cardInfo)
    Ll_GameMainPanel.btnGameMainQuitRoom:SetActive(true)
    --新添加
    if self.RoomMsg.moneyType == RoomMode.goldMode then
        Ll_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
    elseif self.RoomMsg.moneyType == RoomMode.wingMode then
        Ll_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
    end
    Ll_GameMainPanel.imgSignalBG:SetActive(true)
    Ll_GameMainPanel.btnChat:SetActive(true)
    Ll_GameMainPanel.imgCHGameMain:SetActive(true)
    Ll_GameMainPanel.btnSetSystem:SetActive(true)
    Ll_GameMainPanel.imgBtn:SetActive(false)
    Ll_GameMainPanel.imgClock:SetActive(false)
    self.curJushu = self.curJushu + 1
    self:SetCurJushu(self.curJushu)
    self.hasLoaded      = false 
   print("-----------DealCard------",roleIndex,#cardInfo)
    for i,v in ipairs(self.players) do
        v.imgCard:SetActive(true)
        if self.myIndex == v.index then
            v.obj.transform.localPosition = Vector3.New(-550,-45,0)
        end
    end
    --手牌张数，牌间距
    local co = coroutine.start(function()
        local curCache = self:GetPlayer(roleIndex)
        for i,v in ipairs(cardInfo) do
            curCache:GetOneCard(roleIndex,v,2,false)
            coroutine.wait(0.01)
        end
        Game.MusicEffect(Game.Effect.thfapai1)
        Ll_GameMainPanel.imgPublicCard:SetActive(false)
        self.hasLoaded = true
    end)
    table.insert(Network.crts, co)
end

--设置房间局数
function LandlordsRoom:SetCurJushu(curJushu)
    local self = LandlordsRoom
    local totalJushu = self.RoomMsg.catchTotal
    Ll_GameMainCtrl:SetText(self.txtJuShu,curJushu..'/'..tostring(totalJushu))
    --新添加 
    local textlandBasenum = '底注:'..tostring(LandlordsRoom.RoomMsg.baseNum)
    local textlandQualified = tostring(LandlordsRoom.RoomMsg.qualified)..'进'..tostring(LandlordsRoom.RoomMsg.qualified)..'出'
    if self.RoomMsg.moneyType == RoomMode.goldMode then
        Ll_GameMainCtrl:SetText(self.txtJuShu,textlandBasenum.."\n"..textlandQualified)
    elseif self.RoomMsg.moneyType == RoomMode.wingMode then
        Ll_GameMainCtrl:SetText(self.txtJuShu,textlandBasenum.."\n"..textlandQualified)
    end
end

--准备消息返回
function LandlordsRoom.ReadyGameRes(buffer)
    local self = LandlordsRoom
    local data   = buffer:ReadBuffer()
    local msg    = DouDiZhuPlayRead_pb.DouDiZhuPlayReadRes()  
    print("=====ReadyGame=====1",#msg.alreadyIndex)
    msg:ParseFromString(data)
    print("=====ReadyGame=====2",msg.allStart)
    local readyIndex = msg.alreadyIndex
    local allStart   = msg.allStart
    for i,v in ipairs(readyIndex) do
        local curCache = self:GetPlayer(v) 
        curCache.imgOK:SetActive(true)
        if v == self.myIndex then
            Ll_GameMainPanel.imgBtn:SetActive(false)
            Ll_GameMainPanel.btnBuChu:SetActive(true)
            Ll_GameMainPanel.btnChuPai:SetActive(true)
            Ll_GameMainCtrl.SetIconTips("没有牌大过上家",false)
            Ll_GameMainCtrl:SetText(self.btnObjList.btnTiShi.txt,"提  示")
            Ll_GameMainPanel.panel_SingleSettlement:SetActive(false)
            if self.curJushu == 0 then
                Ll_GameMainPanel.btnGameStart:SetActive(false)
            end
        end
    end 
    if allStart then
        self:NextGame()
    end
    if self.curJushu ~= 0 then
        Ll_GameMainPanel.panel_WaitFriend:SetActive(false)
    end
end

--下局清理
function LandlordsRoom:NextGame()
    self.curPopTips = {}
    self.btnCheck = 0
    for i,v in ipairs(self.players) do
        print("-------------------------",v.index,#v.popList)
        v.imgCard:SetActive(false)
        v.warning:SetActive(false)
        v.cardsCount = 16
        v.txtOverNum:SetActive(true)
        Ll_GameMainCtrl:SetText(v.txtOverNum,"")
        v:PopType(0,0)
        for j,k in ipairs(v.popList) do
            k:Destroy()
        end
        v.popList = {}
        if v.index == self.myIndex then
            for j,k in ipairs(v.cards) do
                k:Destroy()
            end
        end
        v.cards = {}
        v.soundOne = false
        v.soundTwo = false
    end
    self:StatingCard()
end

function LandlordsRoom:StatingCard()
    Ll_GameMainPanel.panel_WaitFriend:SetActive(false)
    Ll_GameMainPanel.StartGameOrOpenCard:SetActive(true)
end

function LandlordsRoom.StatingGameCard()
    self = LandlordsRoom
    self.OrOpenCard = false
    self:StartGame()
end

function LandlordsRoom.StatingOpenCard()
    self = LandlordsRoom
    self.OrOpenCard = true
    self:StartGame()
end

function LandlordsRoom:StartGame()
    Game.MusicEffect(Game.Effect.joinRoom)
    if Room.gameType == RoomType.Landlords then
        local  openCardRoom = OpenCard_pb.openCardReq()
        openCardRoom.open = self.OrOpenCard
        if self.OrOpenCard then
            openCardRoom.openMultiple = 5
        else
            openCardRoom.openMultiple = 0
        end
        print("===========Send:StatingGame================="..tostring(self.OrOpenCard))
        local  msg = openCardRoom:SerializeToString()
        Game.SendProtocal(Protocal.OpenCard,msg)
    end
    Ll_GameMainPanel.StartGameOrOpenCard:SetActive(false)
end

--发牌消息返回
function LandlordsRoom.LandlordsDealRes(buffer)
    local self = LandlordsRoom
    local data   = buffer:ReadBuffer()
    local msg    = DouDiZhuPockDeal_pb.DouDiZhuPockDealRes()  
    msg:ParseFromString(data)
    local roleIndex  = msg.roleIndex
    local cardInfo   = msg.cardInfo
    local firstIndex = msg.firstIndex
    local currentMultiple = msg.currentMultiple
    local open = msg.open
    print("=====CatchPockDeal=====",roleIndex,cardInfo)
    self:DealCard(roleIndex,cardInfo)

    for i,v in ipairs(self.players) do
        v.imgOK:SetActive(false)
    end
end

function LandlordsRoom.LandlordsOpenCarRes()
    local self = LandlordsRoom
    local data = buffer:ReadBuffer()
    local msg = OpenCard_pb.openCardRes()
    msg:ParseFromString(data)
    local openUserIndex = msg.openUserIndex        --明牌玩家index
    local currentMultiple = msg.currentMultiple    --当前倍数
    local open = msg.open                          ----cardtype明牌
    local cardInfo  = msg.cardInfo
end

--打牌消息--
function LandlordsRoom.LandlordsCardReq()
    Game.MusicEffect(Game.Effect.joinRoom)
    local self = LandlordsRoom
     print("-----------------!!!!!!!!-------------D1--",self.btnCheck)
    if self.btnCheck == 1 then return end
    self.btnCheck = 1
    local popCardInfo = CatchPopCard_pb.CatchPopCardReq()
    local curCache = self:GetPlayer(self.myIndex)
    local strList = ""
   -- print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",curCache.cards[1].gameObject.transform.localPosition.y)
    for i,v in ipairs(curCache.cards) do
        if v.selectNum == 1 and v.gameObject.transform.localPosition.y == 0 then
            v.selectNum = 0
        end
        if v.selectNum == 1 then
            v:PickUp()
            strList = strList..v.id..","
        end
    end
    print("--------CatchPopCardReq----------",strList)
    if strList == "" then 
        self.btnCheck = 0
        Ll_GameMainCtrl.SetIconTips("您选择的牌不符合规则")
        return
    end
    popCardInfo.handCard = strList
    local msg = popCardInfo:SerializeToString()
    Game.SendProtocal(Protocal.CatchPopCard, msg)
end

--打牌消息返回--
function LandlordsRoom.LandlordsPopCardRes(buffer)
    local self = LandlordsRoom
    local data   = buffer:ReadBuffer()
    local msg    = CatchPopCard_pb.CatchPopCardRes()  
    msg:ParseFromString(data)
    local roleIndex = msg.roleIndex
    local cardInfo  = msg.cardInfo
    local cardType  = msg.cardType
    print("---------CatchPopCardRes----------",roleIndex,#cardInfo,cardType)

    self:ClearLastCards(roleIndex,cardInfo)
    self:CardType(roleIndex,cardType,cardInfo)
    self:GoNextPlayer(roleIndex)
end

--收到返回清理手牌
function LandlordsRoom:ClearLastCards(roleIndex,cardInfo,isEnd)
    local curCache  = self:GetPlayer(roleIndex)
    if roleIndex ~= self.myIndex then
        for j,k in ipairs(cardInfo) do
            print("-------------------------每次出牌      結束時出牌")
            curCache:GetOneCard(roleIndex,k,2,true,isEnd)
        end
    else
        for i,v in ipairs(cardInfo) do
            for j,k in ipairs(curCache.cards) do
                if v.id == k.id then
                    curCache:PopCard(k)
                    table.remove(curCache.cards,j)
                end
            end
        end
    end
end

--判断牌型
function LandlordsRoom:CardType(index,cardType,cardInfo)
    print("===========CardType",index,cardType)
    local curCache  = self:GetPlayer(index)
    local animType = 0
    if self.hasLoaded then
        curCache.cardsCount = curCache.cardsCount - #cardInfo
        local curCount = curCache.cardsCount
        if curCache.cardsCount <= 3 then
            curCache.warning:SetActive(true)
            Ll_GameMainCtrl:SetText(curCache.txtOverNum,curCount)
            if curCount == 1 then
                curCache:PlaySound("one")
            elseif curCount == 2 then
                curCache:PlaySound("two")
            else
                curCache:PlaySound(cardType,cardInfo)
            end
        else
            curCache:PlaySound(cardType,cardInfo)
        end
    end
     --判断牌型
    if cardType == 2 or cardType == 3 then
        cardType = 2
        animType = 2
    elseif cardType == 9 then
        animType = 1
    elseif cardType == 1 then
        animType = 0
    elseif cardType == 10 then
        animType = 1
    elseif cardType == 11 or cardType == 12 or cardType == 13 then
        cardType = 11
        animType = 3
    else
        cardType = 0
    end
    print("===========CardType11",index,cardType,animType)
    curCache:PopType(index,cardType,animType)
end

--提示--
function LandlordsRoom.CatchPopTips()
    local self = LandlordsRoom
    
    if #self.curPopTips == 0 then
        Ll_GameMainCtrl.SetIconTips("暂无提示，请手动出牌")
    end
    self.clickNum = self.clickNum - 1
    local curCache = self:GetPlayer(self.myIndex)
    print("========CatchPopTips======",#self.curPopTips,self.clickNum,#curCache.cards)
    for a,b in ipairs(curCache.cards) do
        b.selectNum = 0
        b:PickDown()
        b.pickUp = false
    end

    if self.clickNum <= #self.curPopTips and self.clickNum > 0 then
        for i,v in ipairs(self.curPopTips[self.clickNum].cardInfo) do
            for j,k in ipairs(curCache.cards) do
                if v.id == k.id then
                    k.selectNum = 1
                    k:PickUp()
                    k.pickUp = true
                end
            end
        end
        Game.MusicEffect(Game.Effect.joinRoom)
    else
        self.clickNum = #self.curPopTips
        if #self.curPopTips == 0 then
            LandlordsRoom.CatchNoPop()
            return
        end
        for i,v in ipairs(self.curPopTips[self.clickNum].cardInfo) do
            for j,k in ipairs(curCache.cards) do
                if v.id == k.id then
                    k.selectNum = 1
                    k:PickUp()
                    k.pickUp = true
                end
            end
        end
        Game.MusicEffect(Game.Effect.joinRoom)
    end
end

--提示消息返回--
function LandlordsRoom.CatchPockTipsRes(buffer)
    local data   = buffer:ReadBuffer()
    local msg    = CatchPockTips_pb.CatchPockTipsRes()
    msg:ParseFromString(data)
    local roleIndex  = msg.roleIndex
    local buttonTips = msg.buttonTips
    local tips       = msg.tips
    LandlordsRoom.TipFunc(roleIndex,buttonTips,tips)
end

function LandlordsRoom.TipFunc(roleIndex,buttonTips,tips)
    local self = LandlordsRoom
    self.btnCheck = 0
    self.clickNum = #tips + 1
    self.curPopTips = {}
    for i,v in ipairs(tips) do
        for m,n in ipairs(v.cardInfo) do
            print(m,n.id,n.num,n.color)
        end
    end
    local atLast = false
    local curCache = self:GetPlayer(self.myIndex)
    print("=====CatchPockTipsRes====",roleIndex,buttonTips,#tips)
    if roleIndex == self.myIndex then
        if buttonTips == 0 then
            if #tips == 0 then
                Ll_GameMainCtrl.SetIconTips("没有牌大过上家",true)
                self.curPopTips = {}
                self:BtnShow("btnChuPai",false)
                print("-----------------!!!!!!!!--------------1--",self.btnCheck)
                -- local co = coroutine.start(function()
                --     coroutine.wait(1)
                --     if self.btnCheck == 0 then

                --         LandlordsRoom.CatchNoPop()
                --     end
                -- end)
                -- table.insert(Network.crts, co)
            else
                self.curPopTips  = tips
            end
            -- return
        elseif buttonTips == 1 then
            print("-----------------!!!!!!!!buttonTips1",#tips,#tips[1].cardInfo,curCache.cardsCount)
            if #tips == 1 and #tips[1].cardInfo == 1 and curCache.cardsCount == 1 then
                atLast = true
            elseif #tips == 1 and #tips[1].cardInfo == curCache.cardsCount then
                atLast = true
            end
            self:BtnShow("btnBuChu",false)
            self.curPopTips  = tips
        else
            print("-----------------!!!!!!!!buttonTips2",#tips,#tips[1].cardInfo,curCache.cardsCount)
            if #tips == 1 and #tips[1].cardInfo == 1 and curCache.cardsCount == 1 then
                atLast = true
            elseif #tips == 1 and #tips[1].cardInfo == curCache.cardsCount then
                atLast = true
            end
            -- self:BtnShow("btnChuPai",true)
            self:BtnShow("btnBuChu",true)
            self.curPopTips  = tips
        end
        if atLast then
            local co = coroutine.start(function ()
                if self.hasLoaded ~= true then
                    coroutine.wait(1)
                end
                for i,v in ipairs(curCache.cards) do
                    v.selectNum = 1
                    v:PickUp()
                end
               self.CatchPopCardReq()
            end)
            table.insert(Network.crts,co)
        end
        Ll_GameMainPanel.imgBtn:SetActive(true)
    end
    print("-----------------------------22222",#self.curPopTips)
end

--不出--
function LandlordsRoom.CatchNoPop()
    local self = LandlordsRoom
    print("-----------------!!!!!!!!!!!-------------2---",self.btnCheck)
    if self.btnCheck == 1 then return end
    self.btnCheck = 1
    Game.MusicEffect(Game.Effect.joinRoom)
    local strList = ""
    local popCardInfo = CatchPopCard_pb.CatchPopCardReq()
    local msg = popCardInfo:SerializeToString()
    Game.SendProtocal(Protocal.CatchPopCard, msg)
    print("--------CatchNoPop----------",strList)
    
    local curCache = self:GetPlayer(self.myIndex)
    Ll_GameMainPanel.imgBtn:SetActive(false)
    Ll_GameMainPanel.btnTiShi:SetActive(true)
    Ll_GameMainPanel.btnChuPai:SetActive(true)
    Ll_GameMainPanel.btnBuChu:SetActive(true)
    Ll_GameMainCtrl.SetIconTips("没有牌大过上家",false)
    for a,b in ipairs(curCache.cards) do
        b.selectNum = 0
        b:PickDown()
    end
    print("-----------------!!!!!!!!!!!-------------3---",self.btnCheck)
end

--单局结算
function LandlordsRoom.CatchSingleSettlementRes(buffer)
    print("==================CatchSingleSettlementRes==================",buffer)
    local self = LandlordsRoom
    local data   = buffer:ReadBuffer()
    local msg    = CatchSingleSettlement_pb.CatchSingleSettlementRes()  
    msg:ParseFromString(data)
    local playerInfo    = msg.settlementInfo
    local endType       = msg.endType 

    Ll_GameMainPanel.imgCHGameMain:SetActive(false)
    print("==================CatchSingleSettlementRes==================",#msg.settlementInfo,msg.endType)
    local co = coroutine.start(function ()
        if endType == 3 or endType == 4 or self.curJushu == self.RoomMsg.catchTotal then
            Ll_GameMainPanel.btnSettleStartGame:SetActive(false)
        else
            coroutine.wait(1.5)
        end

        for i,v in ipairs(msg.settlementInfo) do
            local player = self:GetPlayer(v.roleIndex)
            player.jifen = v.jiFen
            Ll_GameMainCtrl:SetText(player.txtScore,player.jifen)
            print("----------CatchSingleSettlementRes---------",v.roleIndex,v.curJiFen,v.jiFen,#v.leftCardInfo)
            for m,n in ipairs(player.cardTypeList) do
                n.obj:SetActive(false)
            end
            for i,v in ipairs(player.popList) do
                v:Destroy()
            end
            if v.roleIndex == self.myIndex then
                if v.curJiFen > 0 then
                    Game.MusicEffect(Game.Effect.shengli)
                    Ll_GameMainPanel.imgSettlementLost:SetActive(false)
                    Ll_GameMainPanel.imgSettlementWin:SetActive(true)
                    Ll_GameMainPanel.imgSettlementWin.transform.localScale = Vector3.zero
                    self:DoScale(Ll_GameMainPanel.imgSettlementWin)
                else
                    Game.MusicEffect(Game.Effect.shibai)
                    Ll_GameMainPanel.imgSettlementWin:SetActive(false)
                    Ll_GameMainPanel.imgSettlementLost:SetActive(true)
                    Ll_GameMainPanel.imgSettlementLost.transform.localScale = Vector3.zero
                    self:DoScale(Ll_GameMainPanel.imgSettlementLost)
                end
                Ll_GameMainCtrl:NumberShow(v.curJiFen)
                if #player.cards == 0 then
                    for j,k in ipairs(v.leftCardInfo) do
                        player:GetOneCard(v.roleIndex,k,2,false)
                    end
                end
                player.warning:SetActive(false)
                player.imgCard:SetActive(true)
            else
                self:ClearLastCards(v.roleIndex,v.leftCardInfo,true)
                player.imgCard:SetActive(false)
                player.warning:SetActive(false)
                player.txtOverNum:SetActive(false)
            end
        end
        Ll_GameMainPanel.panel_SingleSettlement:SetActive(true)
    end)
    table.insert(Network.crts, co)
end

function LandlordsRoom.OnSettleStartGameReq()
    local msg = ""
    Game.SendProtocal(Protocal.LandlordsRoomReady, msg)
end 

function LandlordsRoom.OnSettleQuitGameReq()
    Game.MusicEffect(Game.Effect.buttonBack)
    Game.SendProtocal(Protocal.QuitMateRoom)
end


--总结算
function LandlordsRoom.CatchTotalSettlementRes(buffer)
    print("------------",buffer)
    local self = LandlordsRoom
    local data   = buffer:ReadBuffer()
    local msg    = CatchTotalSettlement_pb.CatchTotalSettlementRes()
    msg:ParseFromString(data)
    print("==================CatchTotalSettlementRes==================",msg.roomNum,msg.totalJushu)
    msg.totalJushu = self.allJushu
    TH_RoleInfoCtrl:Close()
    MessageTipsCtrl:Close()
    
    if DissolutionRoomCtrl.gameOver then
        Ll_GameMainPanel.panel_SingleSettlement:SetActive(false)
        TH_TotalSettlementCtrl:Open("TH_TotalSettlement",function()
            --生成预制--
            resMgr:LoadPrefab('th_totalsettlement',{'th_totalplayer'},function(objs)
                TH_TotalSettlementCtrl:InitPanel(objs,msg)
            end)
        end)
    else
         Ll_GameMainPanel.panel_SingleSettlement.transform:DOScale(Vector3.zero,0.2):SetDelay(1):OnComplete(
        function ()
                Ll_GameMainPanel.panel_SingleSettlement:SetActive(false)
                TH_TotalSettlementCtrl:Open("TH_TotalSettlement",function()
                --生成预制--
                resMgr:LoadPrefab('th_totalsettlement',{'th_totalplayer'},function(objs)
                    TH_TotalSettlementCtrl:InitPanel(objs,msg)
                end)
            end)
        end)
    end
end

--清理房间数据
function LandlordsRoom:ClearRoomInfo()
    for _, v in ipairs(self.players) do
        if v.obj ~= nil then
            v:Destroy()
        end
    end
    self.players = {}
end

--下一位
function LandlordsRoom:GoNextPlayer(index)
    index = index + 1
    if index > 3 then
        index = 1
    end
    if index == self.myIndex then
        self.btnCheck = 0
        Ll_GameMainPanel.imgBtn:SetActive(true)
    else
        Ll_GameMainPanel.imgBtn:SetActive(false)
    end
    self:BtnShow("btnChuPai",true)
    self:BtnShow("btnBuChu",true)
    --显示框
    self:KuangShow(index)
    --清理上一次出的牌
    local curCache = self:GetPlayer(index)
    print("-------------------------",curCache.index,#curCache.popList)
    for i,v in ipairs(curCache.popList) do
        v:Destroy()
    end
    curCache.popList = {}
    curCache:PopType(0,0)
    Ll_GameMainCtrl:CountDown(curCache.sitIndex)
end

--显示操作框
function LandlordsRoom:KuangShow(index,bool)
    local show = true
    if bool then
        show = false
    end
    for i,v in ipairs(self.players) do
        if v.index == index then
            v.imgCur:SetActive(show)
            local img = v.imgCur:GetComponent("Image")
            Ll_GameMainCtrl:ChangeKuang(img,v.index)
        else
            v.imgCur:SetActive(not show)
        end
    end
end

function LandlordsRoom:ErrorCodeShow(code)
    self.btnCheck = 0
    if code == 1091 then
        Ll_GameMainCtrl.SetIconTips("不符合出牌规则")
    elseif code == 1092 then
        Ll_GameMainCtrl.SetIconTips("红桃3先出哦")
    elseif code == 1093 then
        Ll_GameMainCtrl.SetIconTips("下家报单了,可不要放水哦")
    elseif code == 1094 then
        Ll_GameMainCtrl.SetIconTips("最大不能连到2")
    elseif code == 1107 then
        Ll_GameMainCtrl.SetIconTips("天炸送分啦,还在等什么")
    end
    Ll_GameMainPanel.imgBtn:SetActive(true)
    print("-----------------!!!!!!!!-------------D2--",self.btnCheck)
end

--收到断线重连消息
function LandlordsRoom:OfflinePush(msg)
    if not Ll_GameMainCtrl.isCreate then return end
    local roleId  = msg.roleId --断线（重连）roleId
    local state   = msg.state  --true=上线  false=离线
    print("========OfflinePush======",roleId,state)
    for i,v in ipairs(self.players) do
        if v.id == roleId then
            v.imgOffLine:SetActive(not state)
            break
        end
    end
end