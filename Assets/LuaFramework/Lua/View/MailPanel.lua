MailPanel = {};
setbaseclass(MailPanel, {BasePanel})

function MailPanel:InitPanel()
    --返回按钮
    self.btnBack   = self:Child("btnBack");  --返回按钮
    self.btnGetAll = self:Child("btnGetAll");--一键获取
    self.grid = self:Child("parentOfMail/Viewport/grid");

end