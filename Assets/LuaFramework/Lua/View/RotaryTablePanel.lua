RotaryTablePanel = {};
setbaseclass(RotaryTablePanel, {BasePanel})

function RotaryTablePanel:InitPanel(obj)
    --抽奖按钮
    self.btnStart = self:Child("btnStart");
    --返回按钮
    self.btnBack  = self:Child("btnBack");
    --指针
    self.imgPointer = self:Child("imgPointer");	

    --抽奖一次
    --抽奖十次
end