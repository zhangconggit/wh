TalkPanel = {};
setbaseclass(TalkPanel, {BasePanel})

function TalkPanel:InitPanel()
    self.imgTalkIcon = self:Child("imgTalkIcon")
    self.imgFalseIcon = self:Child("imgFalseIcon")
    self.txtTalk = self:Child("txtTalk")
    self.icon1 = self:Child("imgTalkIcon/icon1")
    self.icon2 = self:Child("imgTalkIcon/icon2")
    self.icon3 = self:Child("imgTalkIcon/icon3")
    self.icon4 = self:Child("imgTalkIcon/icon4")
end