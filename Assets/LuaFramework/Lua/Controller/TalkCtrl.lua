
TalkCtrl = {};
setbaseclass(TalkCtrl,{BaseCtrl})

function TalkCtrl:OnCreate(obj)
    BaseCtrl.OnCreate(self,obj);
    self:InitPanel();
end

function TalkCtrl:InitPanel()
end

function TalkCtrl.OnYuYinSend(fileurl)
    local self = TalkCtrl
    if Room.gameType == RoomType.Mahjong then
        if OB_GameMainCtrl.isCreate then
            if OB_GameMainPanel.imgFaceIconBGD.activeSelf == true or OB_GameMainPanel.imgChatD.activeSelf == true  then
                OB_GameMainCtrl.SetIconTips("您说话太快了，休息一下吧！")
            else
                local GameChat = Chat_pb.ChatReq();
                GameChat.chatType = 5;
                GameChat.chatText = fileurl;
                    
                -- 本端的roleid
                local myRoleId = global.userVo.roleId
                -- 获取当前端的索引
                local myIndex = getRoleIndexById(myRoleId)
                GameChat.chatSelfIndex = myIndex

                local msg = GameChat:SerializeToString();
                Game.SendProtocal(Protocal.ChatInfo,msg)
            end
        elseif OB_GameMainPanel.isCreate then
            local GameChat = Chat_pb.ChatReq();
            GameChat.chatType = 5;
            GameChat.chatText = fileurl;
                
            -- 本端的roleid
            local myRoleId = global.userVo.roleId
            -- 获取当前端的索引
            local myIndex = getRoleIndexById(myRoleId)
            GameChat.chatSelfIndex = myIndex

            local msg = GameChat:SerializeToString();
            Game.SendProtocal(Protocal.ChatInfo,msg)
        end
    elseif Room.gameType == RoomType.Tenharf then
        self.sendTalkInfo(TenharfRoom,fileurl)
    elseif Room.gameType == RoomType.GoldFlower then
        self.sendTalkInfo(GoldFlowerRoom,fileurl)
    elseif Room.gameType == RoomType.CatchPock then
        self.sendTalkInfo(CatchPockRoom,fileurl)
    elseif Room.gameType == RoomType.NiuNiu then
        self.sendTalkInfo(NiuNiuRoom,fileurl)
    elseif Room.gameType == RoomType.Landlords then
        self.sendTalkInfo(LandlordsRoom,fileurl)
    end
end

function TalkCtrl.sendTalkInfo(roomType,fileurl)
    if roomType:GetPlayer(roomType.myIndex).imgFaceIcon.activeSelf == true or roomType:GetPlayer(roomType.myIndex).imgChat.activeSelf == true  then
        if roomType == CatchPockRoom then
            CH_OB_GameMainCtrl.SetIconTips("您说话太快了，休息一下吧！")
        else
            TH_OB_GameMainCtrl.SetIconTips("您说话太快了，休息一下吧！")
        end
    else
        local GameChat = Chat_pb.ChatReq()
        GameChat.chatType = 5
        GameChat.chatText = fileurl
        GameChat.chatSelfIndex = roomType.myIndex
        
        local msg = GameChat:SerializeToString()
        Game.SendProtocal(Protocal.ChatInfo,msg)
    end
end

local currentMiaoShu = 0;
function TalkCtrl.OpenYuYinTishiWin()
    if not TalkCtrl.isCreate then
        return
    end
    if Room.gameType == RoomType.Mahjong then
        if OB_GameMainCtrl.isCreate then
            if OB_GameMainPanel.imgFaceIconBGD.activeSelf == true or OB_GameMainPanel.imgChatD.activeSelf == true  then
                OB_GameMainCtrl.SetIconTips("您说话太快了，休息一下吧！")
                return
            end
        end
        local panel = find('OB_GameMainPanel')
        if panel == nil then
            global.systemVo.BGSource.volume = 0
        else
            global.systemVo.isTalk = '1'
        end
    elseif Room.gameType == RoomType.Tenharf then
        if TenharfRoom:GetPlayer(TenharfRoom.myIndex).imgFaceIcon.activeSelf == true or TenharfRoom:GetPlayer(TenharfRoom.myIndex).imgChat.activeSelf == true  then
            TH_OB_GameMainCtrl.SetIconTips("您说话太快了，休息一下吧！")
            return
        end
        local panel = find('TH_GameMainPanel')
        if panel == nil then
            global.systemVo.BGSource.volume = 0
        else
            global.systemVo.isTalk = '1'
        end
    elseif Room.gameType == RoomType.GoldFlower then
        if GoldFlowerRoom:GetPlayer(GoldFlowerRoom.myIndex).imgFaceIcon.activeSelf == true or GoldFlowerRoom:GetPlayer(GoldFlowerRoom.myIndex).imgChat.activeSelf == true  then
            TH_OB_GameMainCtrl.SetIconTips("您说话太快了，休息一下吧！")
            return
        end
        local panel = find('TH_GameMainPanel')
        if panel == nil then
            global.systemVo.BGSource.volume = 0
        else
            global.systemVo.isTalk = '1'
        end
    elseif Room.gameType == RoomType.CatchPock then
        if CatchPockRoom:GetPlayer(CatchPockRoom.myIndex).imgFaceIcon.activeSelf == true or CatchPockRoom:GetPlayer(CatchPockRoom.myIndex).imgChat.activeSelf == true  then
            CH_OB_GameMainCtrl.SetIconTips("您说话太快了，休息一下吧！")
            return
        end
        local panel = find('CH_GameMainPanel')
        if panel == nil then
            global.systemVo.BGSource.volume = 0
        else
            global.systemVo.isTalk = '1'
        end
    elseif Room.gameType == RoomType.NiuNiu then
        if NiuNiuRoom:GetPlayer(NiuNiuRoom.myIndex).imgFaceIcon.activeSelf == true or NiuNiuRoom:GetPlayer(NiuNiuRoom.myIndex).imgChat.activeSelf == true  then
            TH_OB_GameMainCtrl.SetIconTips("您说话太快了，休息一下吧！")
            return
        end
        local panel = find('TH_GameMainPanel')
        if panel == nil then
            global.systemVo.BGSource.volume = 0
        else
            global.systemVo.isTalk = '1'
        end
    end
    local self = TalkCtrl
    self:Open('Talk',function()
        TalkPanel.imgTalkIcon:SetActive(true)
        TalkPanel.imgFalseIcon:SetActive(false)
        self:SetText(TalkPanel.txtTalk,"按住说话，松开发送！")
        currentMiaoShu = os.time();
    end)
end

function  TalkCtrl.CloseYuYinTishiWin()
    local self = TalkCtrl
    if os.time() - currentMiaoShu < 2 then
        TalkPanel.imgTalkIcon:SetActive(false)
        TalkPanel.imgFalseIcon:SetActive(true)
        self:SetText(TalkPanel.txtTalk,"录制声音过短")
        coroutine.start(self.TalkWait)
        weChatFunction.yuYinLuZhiDuan(false)
    else
        self:Close()
        weChatFunction.yuYinLuZhiDuan(true)
    end
    if Room.gameType == RoomType.Mahjong then
        local panel = find('OB_GameMainPanel')
        if panel == nil then
            global.systemVo.BGSource.volume = 0.3
        else
            global.systemVo.isTalk = '0'
        end
    elseif Room.gameType == RoomType.Tenharf or Room.gameType == RoomType.GoldFlower then
        local panel = find('TH_GameMainPanel')
        if panel == nil then
            global.systemVo.BGSource.volume = 0.3
        else
            global.systemVo.isTalk = '0'
        end
    elseif Room.gameType == RoomType.CatchPock then
        local panel = find('CH_GameMainPanel')
        if panel == nil then
            global.systemVo.BGSource.volume = 0.3
        else
            global.systemVo.isTalk = '0'
        end
    elseif Room.gameType == RoomType.NiuNiu then
        local panel = find('TH_GameMainPanel')
        if panel == nil then
            global.systemVo.BGSource.volume = 0.3
        else
            global.systemVo.isTalk = '0'
        end
    end
end

--语音
function TalkCtrl.showYuYinVolume(volume)
    TalkPanel.icon1:SetActive(false)
    TalkPanel.icon2:SetActive(false)
    TalkPanel.icon3:SetActive(false)
    TalkPanel.icon4:SetActive(false)
    if volume == 1 then
        TalkPanel.icon1:SetActive(false)
        TalkPanel.icon2:SetActive(false)
        TalkPanel.icon3:SetActive(false)
        TalkPanel.icon4:SetActive(false)
    elseif volume == 2 then
        TalkPanel.icon1:SetActive(true)
        TalkPanel.icon2:SetActive(false)
        TalkPanel.icon3:SetActive(false)
        TalkPanel.icon4:SetActive(false)
    elseif volume == 3 then
        TalkPanel.icon1:SetActive(true)
        TalkPanel.icon2:SetActive(true)
        TalkPanel.icon3:SetActive(false)
        TalkPanel.icon4:SetActive(false)
    elseif volume == 4 then
        TalkPanel.icon1:SetActive(true)
        TalkPanel.icon2:SetActive(true)
        TalkPanel.icon3:SetActive(true)
        TalkPanel.icon4:SetActive(false)
    elseif volume == 5 then
        TalkPanel.icon1:SetActive(true)
        TalkPanel.icon2:SetActive(true)
        TalkPanel.icon3:SetActive(true)
        TalkPanel.icon4:SetActive(true)
    end
end

function TalkCtrl.TalkWait()
    local self = TalkCtrl
    coroutine.wait(1.5)
    self:Close()
end




