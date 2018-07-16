MessageTipsPanel = {}

setbaseclass(MessageTipsPanel, {BasePanel})

function MessageTipsPanel:InitPanel()
    logWarn("-----------------------------------------MessageTipsPanel")
    --self.transform:SetParent(GameObject.Find("Canvas").transform)
    self.txtMessageTips = self:Child("txtMessageTips")
    self.btnConfim = self:Child("btnConfim")
end