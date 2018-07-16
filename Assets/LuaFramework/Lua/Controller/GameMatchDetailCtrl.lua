GameMatchDetailCtrl = {};
setbaseclass(GameMatchDetailCtrl,{BaseCtrl});

--启动事件--
function GameMatchDetailCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj);
	self:AddClick(GameMatchDetailPanel.btnQuit, self.OnQuitBtnClick);
	self:AddOnValueChanged(GameMatchDetailPanel.jianglineirong , self.OnJianglineirongClick)
	self:AddOnValueChanged(GameMatchDetailPanel.saizhixiangqing , self.OnSaizhixiangqingClick)
    self:InitPanel()
end

--初始化面板--
function GameMatchDetailCtrl:InitPanel(objs)
    GameMatchDetailPanel.MatchJiangLi :SetActive(true) 
    GameMatchDetailPanel.MatchXiangQing:SetActive(true)
    GameMatchDetailPanel.Match8JiangLi :SetActive(true) 
    GameMatchDetailPanel.Match8XiangQing:SetActive(true)
    GameMatchDetailPanel.Match4JiangLi :SetActive(true) 
    GameMatchDetailPanel.Match4XiangQing:SetActive(true)
    if GameRoomCardMatchCtrl.currentXiangQingBtn == 16 then
        GameMatchDetailPanel.MatchXiangQing:SetActive(false)
        GameMatchDetailPanel.Match8JiangLi :SetActive(false) 
        GameMatchDetailPanel.Match8XiangQing:SetActive(false)
        GameMatchDetailPanel.Match4JiangLi :SetActive(false) 
        GameMatchDetailPanel.Match4XiangQing:SetActive(false)
    elseif GameRoomCardMatchCtrl.currentXiangQingBtn == 8 then
        GameMatchDetailPanel.MatchJiangLi :SetActive(false) 
        GameMatchDetailPanel.MatchXiangQing:SetActive(false)
        GameMatchDetailPanel.Match8XiangQing:SetActive(false)
        GameMatchDetailPanel.Match4JiangLi :SetActive(false) 
        GameMatchDetailPanel.Match4XiangQing:SetActive(false)
    elseif GameRoomCardMatchCtrl.currentXiangQingBtn == 4 then
        GameMatchDetailPanel.MatchJiangLi :SetActive(false) 
        GameMatchDetailPanel.MatchXiangQing:SetActive(false)
        GameMatchDetailPanel.Match8JiangLi :SetActive(false) 
        GameMatchDetailPanel.Match8XiangQing:SetActive(false)
        GameMatchDetailPanel.Match4XiangQing:SetActive(false)
    end
end

function GameMatchDetailCtrl.OnJianglineirongClick(go,bool)
     if bool then
     	Game.MusicEffect(Game.Effect.joinRoom)
        if GameRoomCardMatchCtrl.currentXiangQingBtn == 16 then
            GameMatchDetailPanel.MatchJiangLi :SetActive(true)
        elseif GameRoomCardMatchCtrl.currentXiangQingBtn == 8 then
            GameMatchDetailPanel.Match8JiangLi :SetActive(true)
        elseif GameRoomCardMatchCtrl.currentXiangQingBtn == 4 then
            GameMatchDetailPanel.Match4JiangLi :SetActive(true) 
        end
     else
        if GameRoomCardMatchCtrl.currentXiangQingBtn == 16 then
            GameMatchDetailPanel.MatchJiangLi :SetActive(false)
        elseif GameRoomCardMatchCtrl.currentXiangQingBtn == 8 then
            GameMatchDetailPanel.Match8JiangLi :SetActive(false)
        elseif GameRoomCardMatchCtrl.currentXiangQingBtn == 4 then
            GameMatchDetailPanel.Match4JiangLi :SetActive(false) 
        end

     end    
end

function GameMatchDetailCtrl.OnSaizhixiangqingClick(go,bool)
     if bool  then
     	Game.MusicEffect(Game.Effect.joinRoom)
        if GameRoomCardMatchCtrl.currentXiangQingBtn == 16 then
            GameMatchDetailPanel.MatchXiangQing:SetActive(true)
        elseif GameRoomCardMatchCtrl.currentXiangQingBtn == 8 then
            GameMatchDetailPanel.Match8XiangQing:SetActive(true)
        elseif GameRoomCardMatchCtrl.currentXiangQingBtn == 4 then
            GameMatchDetailPanel.Match4XiangQing:SetActive(true) 
        end
     else
        if GameRoomCardMatchCtrl.currentXiangQingBtn == 16 then
            GameMatchDetailPanel.MatchXiangQing:SetActive(false)
        elseif GameRoomCardMatchCtrl.currentXiangQingBtn == 8 then
            GameMatchDetailPanel.Match8XiangQing:SetActive(false)
        elseif GameRoomCardMatchCtrl.currentXiangQingBtn == 4 then
            GameMatchDetailPanel.Match4XiangQing:SetActive(false) 
        end
     end 
end

function GameMatchDetailCtrl.OnQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = GameMatchDetailCtrl;
	self:Close(true);

end