--Ω‚…¢∑øº‰
DissolutionRoomTipsPanel = {}

setbaseclass(DissolutionRoomTipsPanel, {BasePanel})

function DissolutionRoomTipsPanel:InitPanel()
    logWarn("-----------------------------------------DissolutionRoomTipsPanel")
    self.btnConfirm = self:Child("btnConfirm");
    self.btnCancel = self:Child("btnCancel");
    self.txtDissolution = self:Child("txtDissolution");
end