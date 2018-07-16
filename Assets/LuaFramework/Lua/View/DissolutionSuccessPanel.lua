
DissolutionSuccessPanel = {}

setbaseclass(DissolutionSuccessPanel, {BasePanel})

function DissolutionSuccessPanel:InitPanel()
    logWarn("-----------------------------------------DissolutionSuccessPanel")
    self.btnConfirm = self:Child("btnConfirm");
    self.txtDissolutionSuccess = self:Child("txtDissolutionSuccess");
end