Ll_GameMainCtrl = {
    numberList = {},
    spriteList = {},
}
setbaseclass(Ll_GameMainCtrl, {BaseCtrl})

local dateTime = 0
local netTime = 5
--启动事件--
function Ll_GameMainCtrl:OnCreate(obj)
    BaseCtrl.OnCreate(self, obj)
    self:AddClick(Ll_GameMainPanel.btnWaitQuitRoom,self.OnWaitQuitRoomBtnClick)
    self:AddClick(Ll_GameMainPanel.btnInvitationWeChat,self.OnInvitationWeChatBtnClick)
    self:AddClick(Ll_GameMainPanel.btnGameStart, self.OnGameStartBtnClick)
    self:AddClick(Ll_GameMainPanel.btnSetSystem,self.OnSetSystemBtnClick)
    self:AddClick(Ll_GameMainPanel.btnChat,self.OnChatBtnClick)
    self:AddClick(Ll_GameMainPanel.btnGameMainQuitRoom,self.OnGameMainQuitRoomBtnClick)
    self:AddClick(Ll_GameMainPanel.btnQuitTipsYes,self.OnQuitGameYse)
    self:AddClick(Ll_GameMainPanel.btnQuitTipsNo,self.OnQuitGameNo)
    self:AddClick(Ll_GameMainPanel.btnSettleStartGame,LandlordsRoom.OnSettleStartGameReq)
    self:AddClick(Ll_GameMainPanel.btnSendCode,self.SendDeBugCode)
    self:AddClick(Ll_GameMainPanel.btnGPS,self.OpenGps)
    --新添加
    self:AddClick(Ll_GameMainPanel.btnSettleQuitGame,LandlordsRoom.OnSettleQuitGameReq)
    self:AddClick(Ll_GameMainPanel.btnGouwuche,self.OnbtnGouwucheBtnClick)
    
    if Room.gameType == RoomType.CatchPock then
        self:AddClick(Ll_GameMainPanel.btnBuChu,LandlordsRoom.CatchNoPop)
        self:AddClick(Ll_GameMainPanel.btnTiShi,LandlordsRoom.CatchPopTips)
        self:AddClick(Ll_GameMainPanel.btnChuPai,LandlordsRoom.CatchPopCardReq)
    end

    self:AddClick(Ll_GameMainPanel.btnDirStartingGame,LandlordsRoom.StatingGameCard)
    self:AddClick(Ll_GameMainPanel.btnStartOpenCard,LandlordsRoom.StatingOpenCard)

    self:InitPanel()
end

--初始化面板--
function Ll_GameMainCtrl:InitPanel()
    Ll_GameMainPanel.panel_WaitFriend:SetActive(true)
    Ll_GameMainPanel.OpenCard:SetActive(false)
    Ll_GameMainPanel.StartGameOrOpenCard:SetActive(false)
    Ll_GameMainPanel.imgLlGameMain:SetActive(false)
    Ll_GameMainPanel.panel_SingleSettlement:SetActive(false)
    Ll_GameMainPanel.imgTips:SetActive(false)
    Ll_GameMainPanel.btnGameStart:SetActive(false)
    Ll_GameMainPanel.imgPublicCard:SetActive(false)
    Ll_GameMainPanel.btnGameMainQuitRoom:SetActive(false)
    Ll_GameMainPanel.imgSignalBG:SetActive(false)
    Ll_GameMainPanel.btnChat:SetActive(false)
    Ll_GameMainPanel.btnSetSystem:SetActive(false)
    Ll_GameMainPanel.btnGPS:SetActive(false)
    Ll_GameMainPanel.btnInvitationWeChat:SetActive(true)
    Ll_GameMainPanel.btnGameStart.transform.localPosition         = Vector3.New(0,200,0)
    Ll_GameMainPanel.btnInvitationWeChat.transform.localPosition  = Vector3.New(10,320,0)
    --新添加
    Ll_GameMainPanel.btnSettleQuitGame:SetActive(false)
    if LandlordsRoom.RoomMsg.moneyType == RoomMode.goldMode then
        Ll_GameMainPanel.btnInvitationWeChat:SetActive(false)
        Ll_GameMainPanel.btnSettleQuitGame:SetActive(true)
    elseif LandlordsRoom.RoomMsg.moneyType == RoomMode.wingMode then
        Ll_GameMainPanel.btnInvitationWeChat:SetActive(false)
        Ll_GameMainPanel.btnSettleQuitGame:SetActive(true)
    end
    self.isDown = false
    self.isOver = false
    self.isFrist = false
    self.DownCard = nil
    self.UpCard = nil
    self.PopList = {}
    --数字图片获取
    local grandFa = Ll_GameMainPanel.imgNumber
    for i = 1,grandFa.transform.childCount do
        local img = grandFa.transform:GetChild(i-1) 
        Ll_GameMainCtrl.numberList[img.name] = img:GetComponent("Image").sprite
    end 
    Ll_GameMainCtrl:NumberShow(50)
    self:SetText(LandlordsRoom.txtRoomNum,'房间号: '..tostring(LandlordsRoom.RoomMsg.id))
    if LandlordsRoom.RoomMsg.moneyType == RoomMode.goldMode then
        self:SetText(LandlordsRoom.txtRoomNum,'玩家15秒未操作，将自动进入托管状态')
    elseif LandlordsRoom.RoomMsg.moneyType == RoomMode.wingMode then
        self:SetText(LandlordsRoom.txtRoomNum,'玩家15秒未操作，将自动进入托管状态')
    end
    Ll_GameMainCtrl.ShowCount()
    Game.MusicBG("bgm2")
    --位置调整
    Ll_GameMainPanel.btnChat.transform.localPosition = Vector3.New(580,10,0)
    Ll_GameMainPanel.btnTalk.transform.localPosition = Vector3.New(580,-90,0)
end

--显示数字
function Ll_GameMainCtrl:NumberShow(num)
    local fu = "radd"
    local bai = "0"
    local shi = "0"
    local ge  = "0"
    if num >= 0 and num >= 100 then
        local n = tostring(num)
        fu  = "radd"
        bai = "r"..string.sub(n,1,1)
        shi = "r"..string.sub(n,2,2)
        ge  = "r"..string.sub(n,-1)
    elseif num >= 0 and num < 10 then
        local n = tostring(num)
        fu  = "nil"
        bai = "radd"
        shi = "r"..string.sub(n,-1)
        ge  = "nil"
    elseif num >= 0 and num < 100 then
        local n = tostring(num)
        fu  = "nil"
        bai = "radd"
        shi = "r"..string.sub(n,1,1)
        ge  = "r"..string.sub(n,-1)
    elseif num < 0 and num <= -100 then
        local n = tostring(-num)
        fu  = "gsup"
        bai = "g"..string.sub(n,1,1)
        shi = "g"..string.sub(n,2,2)
        ge  = "g"..string.sub(n,-1)
    elseif num < 0 and num > -10 then
        local n = tostring(-num)
        fu  = "nil"
        bai = "gsup"
        shi = "g"..string.sub(n,-1)
        ge  = "nil"
    else
        local n = tostring(-num)
        fu  = "nil"
        bai = "gsup"
        shi = "g"..string.sub(n,1,1)
        ge  = "g"..string.sub(n,-1)
    end
    Ll_GameMainPanel.imgSettlementFenShu1:GetComponent("Image").sprite = Ll_GameMainCtrl.numberList[fu]
    Ll_GameMainPanel.imgSettlementFenShu2:GetComponent("Image").sprite = Ll_GameMainCtrl.numberList[bai]
    Ll_GameMainPanel.imgSettlementFenShu3:GetComponent("Image").sprite = Ll_GameMainCtrl.numberList[shi]
    Ll_GameMainPanel.imgSettlementFenShu4:GetComponent("Image").sprite = Ll_GameMainCtrl.numberList[ge]
end

--发送作弊码--
function Ll_GameMainCtrl:InputSendCode(isShow)
    Ll_GameMainPanel.inputSendCode:SetActive(isShow)
    Ll_GameMainPanel.btnSendCode:SetActive(isShow)
end

--发送作弊码
function Ll_GameMainCtrl.SendDeBugCode()
    self = Ll_GameMainCtrl
    local txtCode = self:GetInputText(Ll_GameMainPanel.inputSendCode)
    local signInfo = StringPara_pb.StringParaReq()
    signInfo.val = txtCode
    local msg = signInfo:SerializeToString()
    Game.SendProtocal(Protocal.StringPara,msg)
end

--微信邀请
function Ll_GameMainCtrl.OnInvitationWeChatBtnClick(go)
    local self = Ll_GameMainCtrl
    Game.MusicEffect(Game.Effect.joinRoom)
    local currentPalyNum = LandlordsRoom.playerCount
    local playNum = 3 - currentPalyNum
    local playNumText = ""
    if playNum == 1 then
        playNumText = "2缺1"
    elseif playNum == 2 then
        playNumText = "1缺2"
    end
    local shareContent = "房号:"..tostring(LandlordsRoom.RoomMsg.id)..",局数:"..tostring(LandlordsRoom.RoomMsg.catchTotal).."局"..",速度来啊!【跑得快】"
    local imageUrl = 'http://download.hzjiuyou.com/shareicon/zhuamaz.png'
    local title = "跑得快-"..tostring(LandlordsRoom.RoomMsg.id).."，"..tostring(playNumText)
    local downUrl = 'http://download.hzjiuyou.com/dl/hzdownload.htm'
    weChatFunction.weChatInviteFriendBtnClick(shareContent,imageUrl,title,downUrl)
    print("-----------------------OnInvitationWeChatBtnClick--",shareContent)
end

--开始游戏
function Ll_GameMainCtrl.OnGameStartBtnClick(go)
    print("=================PlanStart=====================")
    Game.MusicEffect(Game.Effect.joinRoom)
    if  Room.gameType == RoomType.Landlords then
        local msg = ""
        Game.SendProtocal(Protocal.DouDiZhuPlayRead, msg)
    end
    Ll_GameMainPanel.btnGameStart:SetActive(false)
    Ll_GameMainPanel.btnGPS:SetActive(false)
    --------------------------------------------------------
    -- local card = CHCard.cardList
    -- LandlordsRoom:DealCard(card.roleIndex,card.cardInfo,card.firstIndex)

end

--聊天
function Ll_GameMainCtrl.OnChatBtnClick(go)
    Game.MusicEffect(Game.Effect.joinRoom)
    GameChatCtrl:Open('GameChat')
end


function Ll_GameMainCtrl:ClickIcon(id,iconObj )
    local roleInfo = {}
    local room = nil
    if  Room.gameType == RoomType.Landlords then
        room = LandlordsRoom
    end
    for i,v in ipairs(room.playersData) do
        print("ClickIcon",v.name,v.roleId,v.ip,iconObj.name)
        if id == v.roleId then
            roleInfo = {name = v.name,roleId = v.roleId, roleIp = v.ip,
            image = iconObj,sex = v.sex,index = v.index}
            break
        end
    end

    TH_RoleInfoCtrl:Open("TH_RoleInfo",function()
        if  Ll_GameMainPanel.panel_WaitFriend.activeSelf then
            TH_RoleInfoCtrl:InitPanel(roleInfo,false,room)
        else
            TH_RoleInfoCtrl:InitPanel(roleInfo,true,room)
        end
    end)
end

--点击头像
function Ll_GameMainCtrl.OnClickHead( go )
    Ll_GameMainCtrl:ClickIcon(go.name,go)
end

--持续更新信息显示
function Ll_GameMainCtrl.ShowCount()
    self = Ll_GameMainCtrl
    self:InvokeRepeat("CardTime",0.1,30000000000)
end
local clockTime = 10
local clockStart= false  
--闹钟倒计时
function Ll_GameMainCtrl:CountDown(sitIndex)
    Ll_GameMainPanel.imgClock:SetActive(true)
    if sitIndex == 1 then
        Ll_GameMainPanel.imgClock.transform.localPosition = Vector3.New(0,60,0)
    elseif sitIndex == 2 then
        Ll_GameMainPanel.imgClock.transform.localPosition = Vector3.New(300,150,0)
    elseif sitIndex == 3 then
        Ll_GameMainPanel.imgClock.transform.localPosition = Vector3.New(-300,150,0)
    end
    clockTime = 10
    clockStart = true
end

function Ll_GameMainCtrl.CardTime()
    local self = Ll_GameMainCtrl
    --系统时间
    dateTime = dateTime - 0.1
    if dateTime < 0 then
        if Ll_GameMainPanel.txtTime ~= nil then
            self:SetText(Ll_GameMainPanel.txtTime,AppConst.GetDate())
        end
        dateTime = 10
    end
    --网络信号获取间隔
    netTime = netTime - 0.1
    if netTime <0 then
        self:NetWork()
        netTime = 5
    end
    self.FaceIcon()

    --闹钟倒计时
    if clockStart then
        clockTime = clockTime - 0.1
        t1,t2 = math.modf(clockTime)
        local txt = Ll_GameMainPanel.txtClock.transform:GetComponent('Text')
        if t1 < 10 then
            txt.text = '0'..t1
        else
            txt.text = t1
        end
        if clockTime <= 0 then
            txt.text = '00'
            clockStart = false
            Game.MusicEffect("naozhong")
        end
        --self:SetText(Ll_GameMainPanel.txtClock,tostring(clockTime))
    end 
end

--语音及音效--
--系统设置音乐按钮只控制背景音乐，所有别的声音都用音效按钮控制
function Ll_GameMainCtrl.FaceIcon()
    if global.systemVo.isMusicEffectOn == '0' then
        global.systemVo.EffectSource.volume = 0
        global.systemVo.CardSource.volume = 0
        global.systemVo.TalkSource.volume = 0
    else
        global.systemVo.EffectSource.volume = 1
        global.systemVo.CardSource.volume = 1
        global.systemVo.TalkSource.volume = 1
    end 
    if global.systemVo.isMusicOn == '0' then
        global.systemVo.BGSource.volume = 0
        -- global.systemVo.CardSource.volume = 0
        -- global.systemVo.TalkSource.volume = 0
    else
        if global.systemVo.isTalk == "0" then
            global.systemVo.BGSource.volume = 0.1
        else    
            global.systemVo.BGSource.volume = 0
        end
        -- global.systemVo.CardSource.volume = 1
        -- global.systemVo.TalkSource.volume = 1
    end
end

--网络信号
function Ll_GameMainCtrl:NetWork()
    local level = network_delay
    if level>0 and level<50 then
        Ll_GameMainPanel.imgSignal2:SetActive(true)
        Ll_GameMainPanel.imgSignal3:SetActive(true)
        Ll_GameMainPanel.imgSignal4:SetActive(true)
        Ll_GameMainPanel.imgSignal5:SetActive(true)
    elseif level >50 and level<100 then
        Ll_GameMainPanel.imgSignal2:SetActive(true)
        Ll_GameMainPanel.imgSignal3:SetActive(true)
        Ll_GameMainPanel.imgSignal4:SetActive(true)
        Ll_GameMainPanel.imgSignal5:SetActive(true)
    elseif level >100 and level<150 then
        Ll_GameMainPanel.imgSignal2:SetActive(true)
        Ll_GameMainPanel.imgSignal3:SetActive(true)
        Ll_GameMainPanel.imgSignal4:SetActive(true)
        Ll_GameMainPanel.imgSignal5:SetActive(false)
    elseif level >150 and level<200 then
        Ll_GameMainPanel.imgSignal2:SetActive(true)
        Ll_GameMainPanel.imgSignal3:SetActive(true)
        Ll_GameMainPanel.imgSignal4:SetActive(false)
        Ll_GameMainPanel.imgSignal5:SetActive(false)
    else
        Ll_GameMainPanel.imgSignal2:SetActive(true)
        Ll_GameMainPanel.imgSignal3:SetActive(false)
        Ll_GameMainPanel.imgSignal4:SetActive(false)
        Ll_GameMainPanel.imgSignal5:SetActive(false)
    end
end

function Ll_GameMainCtrl.OnSetSystemBtnClick(go)
    Game.MusicEffect(Game.Effect.joinRoom)
    local touxiang = nil
    if Room.gameType == RoomType.Tenharf then
        touxiang = LandlordsRoom:GetPlayer(LandlordsRoom.myIndex)
    elseif Room.gameType == RoomType.GoldFlower then
        touxiang = GoldFlowerRoom:GetPlayer(GoldFlowerRoom.myIndex)
    elseif Room.gameType == RoomType.CatchPock then
        touxiang = LandlordsRoom:GetPlayer(LandlordsRoom.myIndex)
         print("touxiang4")
    end
    print("touxiang",touxiang.obj.name,BasePanel:GOChild(touxiang.obj,"Mask/"..global.userVo.roleId))
    SetSystemCtrl:GetInfo(global.userVo.name,global.userVo.roleId,global.userVo.roleIp,
         BasePanel:GOChild(touxiang.obj,"Mask/"..global.userVo.roleId))
    SetSystemCtrl:Open('SetSystem')
end

--发送退出房间消息
function Ll_GameMainCtrl.OnWaitQuitRoomBtnClick(go)
    Game.MusicEffect(Game.Effect.buttonBack)
    DissolutionRoomTipsCtrl:Open('DissolutionRoomTips')
end

--申请解散房间--
function Ll_GameMainCtrl.OnGameMainQuitRoomBtnClick(go)
    Game.MusicEffect(Game.Effect.buttonBack)
    local self = Ll_GameMainCtrl
    Ll_GameMainPanel.imgQuitTips:SetActive(true)
    self:SetText(Ll_GameMainPanel.txtQuitTips,"是否确认解散房间")
end

function Ll_GameMainCtrl:OnQuitGameYse()
    Game.MusicEffect(Game.Effect.joinRoom)
    Game.SendProtocal(Protocal.ApplyDisRoom)
    Ll_GameMainPanel.imgQuitTips:SetActive(false)
end

function Ll_GameMainCtrl:OnQuitGameNo()
    Game.MusicEffect(Game.Effect.buttonBack)
    Ll_GameMainPanel.imgQuitTips:SetActive(false)
end


--聊天窗下--
function Ll_GameMainCtrl.ChatWindow(chatSelfIndex,chatText,roomType)
    local self = Ll_GameMainCtrl
    self.chatIndex = chatSelfIndex
    local go = roomType:GetPlayer(chatSelfIndex)
    local txt = go.txtChat:GetComponent("Text")
    local img = go.imgChat:GetComponent("Image")
    txt.text = chatText
    local co = coroutine.start(function ()
        go.imgChat:SetActive(true)
        coroutine.wait(0)
        img.rectTransform.sizeDelta = Vector2.New(txt.rectTransform.sizeDelta.x + 50,img.rectTransform.sizeDelta.y) 
        coroutine.wait(4)
        go.imgChat:SetActive(false)
        global.systemVo.BGSource.volume = 0.3
    end)
    table.insert(Network.crts, co)
end

--表情窗下--
function Ll_GameMainCtrl.FaceIconBGD(chatSelfIndexs,isShow,go,roomType)
    local self = Ll_GameMainCtrl
    roomType:GetPlayer(chatSelfIndexs).imgFaceIcon:SetActive(isShow)
    local co = coroutine.start(function()
        coroutine.wait(4)
        go:Destroy()
        roomType:GetPlayer(chatSelfIndexs).imgFaceIcon:SetActive(false)
    end)
    table.insert(Network.crts, co)
end

local R = 0
local G = 1
local K = false
local amount = 1
local kuangHead = nil
local ismyIndex = nil
function Ll_GameMainCtrl:ChangeKuang(img,index)
    ismyIndex = index
    self:CancelInvoke("UpDateFunc")
    img.color = Color.green
    kuangHead = img
    K = true
    R = 0
    G = 1
    amount = 1
    self:InvokeRepeat("UpDateFunc",0.01,128)
end

--框颜色渐变
function Ll_GameMainCtrl.UpDateFunc()
    if K then
        amount = amount - 0.008
        if R< 1 then
            R = R + 0.015
        elseif R ~= 1 then
            G = G - 0.015
        end
        if G <= 0.1 then
            amount = 1
            K = false
            if global.systemVo.isShakeOn == '1' then
                if ismyIndex == LandlordsRoom.myIndex then
                    AppConst.Vibrate()
                    print("!!!!!!!!!!MY~~~Vibrate!!!!!!!!!!")
                end
            end
        end
    end
    kuangHead.color = Color.New(R,G,0,1)
    kuangHead.fillAmount = amount
end

--提示框
function Ll_GameMainCtrl.SetIconTips(str,bool)
    self = Ll_GameMainCtrl
    if bool == nil then
        if Ll_GameMainPanel.imgTips.activeSelf == true then return end
        Ll_GameMainCtrl.ChatTips()
        local tipsText =  BasePanel:GOChild(Ll_GameMainPanel.imgTips,"Name")
        local tipsPos = Vector3.New(0,-172.8,3782)
        local sequence = DG.Tweening.DOTween.Sequence()
        sequence:Append(Ll_GameMainPanel.imgTips.transform:DOLocalMoveY(tipsPos.y+50, 2, false))
                :OnComplete(function()
                Ll_GameMainPanel.imgTips.transform.localPosition = tipsPos
                end)
        self:SetText(tipsText,str)
    elseif bool == true then
        local tipsText =  BasePanel:GOChild(Ll_GameMainPanel.imgTips,"Name")
        local tipsPos = Vector3.New(0,-130,3782)
        Ll_GameMainPanel.imgTips.transform.localPosition = tipsPos
        Ll_GameMainPanel.imgTips:SetActive(true)
        self:SetText(tipsText,str)
    else
        Ll_GameMainPanel.imgTips:SetActive(false)
    end
end
--聊天提示
function Ll_GameMainCtrl.ChatTips()
    local self = Ll_GameMainCtrl
    Ll_GameMainPanel.imgTips:SetActive(true)
    coroutine.start(self.ChatWait)
end

function Ll_GameMainCtrl.ChatWait()
    coroutine.wait(1.8)
    Ll_GameMainPanel.imgTips:SetActive(false)
end

--鼠标按下
function Ll_GameMainCtrl.MouseDown()
    local self = Ll_GameMainCtrl
    self.isDown = true
    self.isFrist = true
    self.DownCard = nil
    --print("---------------------------Down",self.isDown)
end

--鼠标抬起
function Ll_GameMainCtrl.MouseUp()
    local self = Ll_GameMainCtrl
    local curCache = LandlordsRoom:GetPlayer(LandlordsRoom.myIndex)
    if self.UpCard == self.DownCard then
        if curCache.cards[self.UpCard].pickUp == false then
            CatchPockPlayer.OnClickCard(curCache.cards[self.UpCard])
        end
    end
    for i,v in ipairs(curCache.cards) do
        if v.gray then
            if v.pickUp == false then
                v.pickUp = true
            else
                v.pickUp = false
            end
            if v.pickUp then
                v:PickUp()
                v.selectNum = 1
            else
                v:PickDown()
                v.selectNum = 0
            end
            v:White()
        end
    end
    self.isDown = false
    self.isOver = false
    --print("---------------------------up",self.UpCard,self.DownCard)
end

--鼠标进入
function Ll_GameMainCtrl.MouseOver(go)
    local self = Ll_GameMainCtrl
    if self.isDown then
        if self.isOver == false then
            --print("---------------------------Enter",go.name)
            self.isOver = true
            local curCache = LandlordsRoom:GetPlayer(LandlordsRoom.myIndex)
            for i,v in ipairs(curCache.cards) do
                if go.name == v.cardName then
                    if self.isFrist then
                        self.DownCard = i
                        self.isFrist = false
                    end
                    self.UpCard = i 
                    if i > self.DownCard then
                        for j,k in ipairs(curCache.cards) do
                            if  j >= self.DownCard and i+1 > j then
                                if self.DownCard ~= i then
                                    k:Gray()
                                end
                                k.gray = true
                            else
                                k:White()
                                k.gray = false
                            end 
                        end
                    else
                        for j,k in ipairs(curCache.cards) do
                            if  j <= self.DownCard and i-1 < j then
                                if self.DownCard ~= i then
                                    k:Gray() 
                                end
                                k.gray = true
                            else
                                k:White()
                                k.gray = false
                            end 
                        end
                    end
                end
            end
        end
    end
end

--鼠标退出
function Ll_GameMainCtrl.MouseExit(go)
    local self = Ll_GameMainCtrl
    if self.isDown then
        if self.isOver then
            --print("---------------------------MouseExit",go.name,self.DownCard)
            self.isOver = false
        end
    end
end

--GPS面板
function Ll_GameMainCtrl.OpenGps(go)
    local room = nil
    if  Room.gameType == RoomType.Tenharf then
        room = TenharfRoom
    elseif Room.gameType == RoomType.GoldFlower then
        room = GoldFlowerRoom
    elseif Room.gameType == RoomType.NiuNiu then   
        room = NiuNiuRoom
    elseif Room.gameType == RoomType.CatchPock then   
        room = LandlordsRoom    
    elseif Room.gameType == RoomType.Mahjong then
        room = MahjongRoom
    elseif Room.gameType == RoomType.Landlords then
        room = LandlordsRoom
    end
     GPSInfoCtrl:Open("GPSInfo",function()
                GPSInfoCtrl:InitPanel(Room.gpsList,room)
            end)
end

function Ll_GameMainCtrl.OnbtnGouwucheBtnClick()
    Game.MusicEffect(Game.Effect.joinRoom) 
    ShopMallCtrl:Open("ShopMall")   
end