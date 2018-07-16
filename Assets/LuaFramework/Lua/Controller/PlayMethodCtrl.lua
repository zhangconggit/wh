
PlayMethodCtrl = {};
setbaseclass(PlayMethodCtrl,{BaseCtrl});


local panel;
local luaBehavi;

--启动事件--
function PlayMethodCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj);
	self:AddClick(PlayMethodPanel.btnClose, self.OnQuitBtnClick);
	self:AddOnValueChanged(PlayMethodPanel.togMahjong , self.OntogMahjongClick)
	self:AddOnValueChanged(PlayMethodPanel.togTenHalf , self.OntogTenHalfClick)
	self:AddOnValueChanged(PlayMethodPanel.togjinhua , self.OntogjinhuaClick)
	self:AddOnValueChanged(PlayMethodPanel.togMaZi , self.OntogMaZiClick)
	self:AddOnValueChanged(PlayMethodPanel.togNiu , self.OntogNiuClick)   
    self:AddOnValueChanged(PlayMethodPanel.togXue , self.OntogXueClick)
    self:AddOnValueChanged(PlayMethodPanel.togRed , self.OntogRedClick)
    self:AddOnValueChanged(PlayMethodPanel.togDou , self.OntogDouClick)
    self:AddOnValueChanged(PlayMethodPanel.togWu , self.OntogWuClick)
    self:InitPanel()
end

--初始化面板--
function PlayMethodCtrl:InitPanel(objs)
        --申请苹果审核
    if IS_APP_STORE_CHECK then
        PlayMethodPanel.togTenHalf:SetActive(false)
        PlayMethodPanel.togjinhua:SetActive(false)
        PlayMethodPanel.togMaZi:SetActive(false)
        PlayMethodPanel.togNiu:SetActive(false)
        PlayMethodPanel.togXue:SetActive(false)
        PlayMethodPanel.togRed:SetActive(false)
        PlayMethodPanel.togDou:SetActive(false)
        PlayMethodPanel.togWu:SetActive(false)
    end
end

function PlayMethodCtrl.OntogMahjongClick(go,bool)
     if bool then
     	Game.MusicEffect(Game.Effect.joinRoom)
        PlayMethodPanel.MahjongPlayMethod :SetActive(true) 
        PlayMethodPanel.imgMask:SetActive(false)
     else
        PlayMethodPanel.MahjongPlayMethod :SetActive(false)
     end    
end

function PlayMethodCtrl.OntogTenHalfClick(go,bool)
     if bool  then
     	Game.MusicEffect(Game.Effect.joinRoom)
        PlayMethodPanel.TenHalfPlayMethod:SetActive(true)
        PlayMethodPanel.imgMask:SetActive(false) 
     else
        PlayMethodPanel.TenHalfPlayMethod:SetActive(false)
     end 
end

function PlayMethodCtrl.OntogjinhuaClick(go,bool)
    --未完成功能全都不显示
    if IS_COMPLETE_FUNCTION then
        Game.MusicEffect(Game.Effect.joinRoom)
        PlayMethodPanel.imgMask:SetActive(true)
        return  
    end
    if bool then
     	Game.MusicEffect(Game.Effect.joinRoom)
        PlayMethodPanel.JinHuaPlayMethod :SetActive(true) 
        PlayMethodPanel.imgMask:SetActive(false)
    else
        PlayMethodPanel.JinHuaPlayMethod :SetActive(false) 
    end   
end

function PlayMethodCtrl.OntogMaZiClick(go,bool)
     if bool  then
     	Game.MusicEffect(Game.Effect.joinRoom)
        PlayMethodPanel.MaZiPlayMethod:SetActive(true)
        PlayMethodPanel.imgMask:SetActive(false) 
     else
        PlayMethodPanel.MaZiPlayMethod:SetActive(false)
     end   
end

function PlayMethodCtrl.OntogNiuClick(go,bool)
     if bool  then
	   Game.MusicEffect(Game.Effect.joinRoom)
        PlayMethodPanel.NiuPlayMethod:SetActive(true)
        PlayMethodPanel.imgMask:SetActive(false) 
     else
        PlayMethodPanel.NiuPlayMethod:SetActive(false) 
     end 
end

function PlayMethodCtrl.OntogXueClick(go,bool)
     if bool  then
        Game.MusicEffect(Game.Effect.joinRoom)
        PlayMethodPanel.XuePlayMethod:SetActive(true)
        PlayMethodPanel.imgMask:SetActive(false) 
     else
        PlayMethodPanel.XuePlayMethod:SetActive(false) 
     end 
end

function PlayMethodCtrl.OntogRedClick(go,bool)
     if bool  then
        Game.MusicEffect(Game.Effect.joinRoom)
        PlayMethodPanel.RedPlayMethod:SetActive(true)
        PlayMethodPanel.imgMask:SetActive(false) 
     else
        PlayMethodPanel.RedPlayMethod:SetActive(false) 
     end 
end

function PlayMethodCtrl.OntogDouClick(go,bool)
     if bool  then
        Game.MusicEffect(Game.Effect.joinRoom)
        PlayMethodPanel.DouPlayMethod:SetActive(true)
        PlayMethodPanel.imgMask:SetActive(false) 
     else
        PlayMethodPanel.DouPlayMethod:SetActive(false) 
     end 
end

function PlayMethodCtrl.OntogWuClick(go,bool)
     if bool  then
        Game.MusicEffect(Game.Effect.joinRoom)
        PlayMethodPanel.WuPlayMethod:SetActive(true)
        PlayMethodPanel.imgMask:SetActive(false) 
     else
        PlayMethodPanel.WuPlayMethod:SetActive(false) 
     end 
end

function PlayMethodCtrl.OnQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = PlayMethodCtrl;
	self:Close();

end