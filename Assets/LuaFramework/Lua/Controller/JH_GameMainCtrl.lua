JH_GameMainCtrl = {
    numberList = {}
}

setbaseclass(JH_GameMainCtrl, {BaseCtrl})

local dateTime = 0
local netTime = 5
local playerPos = {}
local index = 0
local numberSprite = {}
local fenshu = nil

--启动事件--
function JH_GameMainCtrl:OnCreate(obj)
    self:AddClick(TH_GameMainPanel.btnJHUnDouble, self.OnFenBtnClick)
    self:AddClick(TH_GameMainPanel.btnJH2Bei, self.OnFenBtnClick)
    self:AddClick(TH_GameMainPanel.btnJH3Bei, self.OnFenBtnClick)
    self:AddClick(TH_GameMainPanel.btnJH4Bei,self.OnFenBtnClick)
    self:AddClick(TH_GameMainPanel.btnJH5Bei,self.OnFenBtnClick)

    self:AddClick(TH_GameMainPanel.btnJHQiPai,self.OnQiPaiBtnClick)
    self:AddClick(TH_GameMainPanel.btnJHBiPai,self.OnBiPaiBtnClick)
    self:AddClick(TH_GameMainPanel.btnJHJiaZhu,self.OnJiaZhuBtnClick)
    self:AddClick(TH_GameMainPanel.btnJHGengZhu,self.OnGenZhuBtnClick)

    self:AddClick(TH_GameMainPanel.btnJHSetSystem,self.OnSetSystemBtnClick)
    self:AddClick(TH_GameMainPanel.btnJHChat,self.OnChatBtnClick)
    self:AddClick(TH_GameMainPanel.btnJHGameMainQuitRoom,self.OnGameMainQuitRoomBtnClick)
    self:AddClick(TH_GameMainPanel.btnJHQuitTipsYes,self.OnQuitGameYse)
    self:AddClick(TH_GameMainPanel.btnJHQuitTipsNo,self.OnQuitGameNo)
end

--初始化面板--
function JH_GameMainCtrl:InitPanel()
    TH_GameMainPanel.imgJHPublicCard:SetActive(false)
    GoldFlowerRoom.imgJuShu:SetActive(false)
    TH_GameMainPanel.imgJHBeishu:SetActive(false)
    TH_GameMainPanel.imgJHBeishu:SetActive(false)
    TH_GameMainPanel.imgVsShow:SetActive(false)
    local thWanfa1 = ''
    local thWanfa2 = ''
    local thWanfa3 = ''
    local thWanfa = ''

    -- if GoldFlowerRoom.RoomMsg.isMaster  ==  0 then
    --     thWanfa1 = "随机庄家"
    -- elseif GoldFlowerRoom.RoomMsg.isMaster  ==  1 then
    --     thWanfa1 = "房主当庄"
    -- end
    -- if GoldFlowerRoom.RoomMsg.tenHalfTotal == 2 then
    --     thWanfa2 = "每人2局"
    -- elseif GoldFlowerRoom.RoomMsg.tenHalfTotal == 4 then
    --     thWanfa2 = "每人4局"
    -- elseif GoldFlowerRoom.RoomMsg.tenHalfTotal == 6 then
    --     thWanfa2 = "每人6局"
    -- end

    -- if GoldFlowerRoom.RoomMsg.isWang == 0 then
    --     thWanfa3 = '无王牌'
    --     fenshu = TH_GameMainPanel.imgFenShu2
    -- elseif GoldFlowerRoom.RoomMsg.isWang == 1 then 
    --     thWanfa3 = '王牌半点'
    --     fenshu = TH_GameMainPanel.imgFenShu
    -- end

    -- thWanfa = thWanfa1..'/'..thWanfa2..'/'..thWanfa3
    -- self.tenHalfWanfa = thWanfa
    -- self:SetText(GoldFlowerRoom.txtWanFa,thWanfa)
    -- GoldFlowerRoom.txtRoomNum.transform.localPosition = Vector3.New(0,160,0)
    self:SetText(GoldFlowerRoom.txtRoomNum,'房间号: '..tostring(GoldFlowerRoom.RoomMsg.id))
    --数字图片获取
    -- local grandFa = TH_GameMainPanel.imgNumber
    -- for i = 1,grandFa.transform.childCount do
    --     local img = grandFa.transform:GetChild(i-1) 
    --     JH_GameMainCtrl.numberList[img.name] = img:GetComponent("Image").sprite
    -- end 
    JH_GameMainCtrl:NumberShow(50)
end


--下注
function JH_GameMainCtrl.OnFenBtnClick(go)
    Game.MusicEffect(Game.Effect.bet)
    local fen = 0

    if go.name == "btnUnDouble" then
        fen = 0
    elseif go.name == "btn2Bei" then
        fen = 2
    elseif go.name == "btn3Bei" then
        fen = 3
    elseif go.name == "btn4Bei" then
        fen = 4
    elseif go.name == "btn5Bei" then
        fen = 5
    end
    --TenharfRoom.TenHalfBetReq(fen)
end

--弃牌
function JH_GameMainCtrl.OnQiPaiBtnClick(go)

end

--比牌
function JH_GameMainCtrl.OnBiPaiBtnClick(go)

end

--加注
function JH_GameMainCtrl.OnJiaZhuBtnClick(go)

end

--跟注
function JH_GameMainCtrl.OnGenZhuBtnClick(go)

end

--持续更新信息显示
function JH_GameMainCtrl.ShowCount()
    self = JH_GameMainCtrl
    self:InvokeRepeat("CardTime",0.1,300000000)
end

function JH_GameMainCtrl.CardTime()
    local self = JH_GameMainCtrl
    --系统时间
    dateTime = dateTime - 0.1
    if dateTime < 0 then
        self:SetText(TH_GameMainPanel.txtJHTime,AppConst.GetDate())
        dateTime = 10
    end
    --网络信号获取间隔
    netTime = netTime - 0.1
    if netTime <0 then
        self:NetWork()
        netTime = 5
    end
    self.FaceIcon()
end

--网络信号
function JH_GameMainCtrl:NetWork()
    local level = network_delay
    if level>0 and level<50 then
        TH_GameMainPanel.imgJHSignal2:SetActive(true)
        TH_GameMainPanel.imgJHSignal3:SetActive(true)
        TH_GameMainPanel.imgJHSignal4:SetActive(true)
        TH_GameMainPanel.imgJHSignal5:SetActive(true)
    elseif level >50 and level<100 then
        TH_GameMainPanel.imgJHSignal2:SetActive(true)
        TH_GameMainPanel.imgJHSignal3:SetActive(true)
        TH_GameMainPanel.imgJHSignal4:SetActive(true)
        TH_GameMainPanel.imgJHSignal5:SetActive(true)
    elseif level >100 and level<150 then
        TH_GameMainPanel.imgJHSignal2:SetActive(true)
        TH_GameMainPanel.imgJHSignal3:SetActive(true)
        TH_GameMainPanel.imgJHSignal4:SetActive(true)
        TH_GameMainPanel.imgJHSignal5:SetActive(false)
    elseif level >150 and level<200 then
        TH_GameMainPanel.imgJHSignal2:SetActive(true)
        TH_GameMainPanel.imgJHSignal3:SetActive(true)
        TH_GameMainPanel.imgJHSignal4:SetActive(false)
        TH_GameMainPanel.imgJHSignal5:SetActive(false)
    else
        TH_GameMainPanel.imgJHSignal2:SetActive(true)
        TH_GameMainPanel.imgJHSignal3:SetActive(false)
        TH_GameMainPanel.imgJHSignal4:SetActive(false)
        TH_GameMainPanel.imgJHSignal5:SetActive(false)
    end
end


--申请解散房间--
function JH_GameMainCtrl.OnGameMainQuitRoomBtnClick(go)
    Game.MusicEffect(Game.Effect.buttonBack)
    local self = JH_GameMainCtrl
    TH_GameMainPanel.imgJHQuitTips:SetActive(true)
    self:SetText(TH_GameMainPanel.txtJHQuitTips,"是否确认解散房间")
end

function JH_GameMainCtrl:OnQuitGameYse()
    Game.MusicEffect(Game.Effect.joinRoom)
    -- if global.roomVo.id == nil then
    --     MessageTipsCtrl:ShowInfo("房间号为空")
    --     return
    -- end
    Game.SendProtocal(Protocal.ApplyDisRoom)
    TH_GameMainPanel.imgJHQuitTips:SetActive(false)
end

function JH_GameMainCtrl:OnQuitGameNo()
    Game.MusicEffect(Game.Effect.buttonBack)
    TH_GameMainPanel.imgJHQuitTips:SetActive(false)
end


--聊天窗下--
function JH_GameMainCtrl.ChatWindow(chatSelfIndex,chatText)
    local self = JH_GameMainCtrl
    self.chatIndex = chatSelfIndex
    local go = TenharfRoom:GetPlayer(chatSelfIndex)
    local txt = go.txtChat:GetComponent("Text")
    local img = go.imgChat:GetComponent("Image")
    txt.text = chatText
    local co = coroutine.start(function ()
        go.imgChat:SetActive(true)
        coroutine.wait(0)
        img.rectTransform.sizeDelta = Vector2.New(txt.rectTransform.sizeDelta.x + 30,img.rectTransform.sizeDelta.y) 
        coroutine.wait(4)
        go.imgChat:SetActive(false)
        global.systemVo.BGSource.volume = 0.3
    end)
    table.insert(Network.crts, co)
end

--表情窗下--
function JH_GameMainCtrl.FaceIconBGD(chatSelfIndexs,isShow,go)
    local self = JH_GameMainCtrl
    TenharfRoom:GetPlayer(chatSelfIndexs).imgFaceIcon:SetActive(isShow)
    local co = coroutine.start(function()
        coroutine.wait(4)
        go:Destroy()
        TenharfRoom:GetPlayer(chatSelfIndexs).imgFaceIcon:SetActive(false)
    end)
    table.insert(Network.crts, co)
end

local R = 0
local G = 1
local K = false
local amount = 1
local kuangHead = nil
local ismyIndex = nil
function JH_GameMainCtrl:ChangeKuang(img,index)
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
function JH_GameMainCtrl.UpDateFunc()
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
                if ismyIndex == TenharfRoom.myIndex then
                    AppConst.Vibrate()
                    print("!!!!!!!!!!MY~~~Vibrate!!!!!!!!!!")
                end
            end
        end
    end
    kuangHead.color = Color.New(R,G,0,1)
    kuangHead.fillAmount = amount
end
