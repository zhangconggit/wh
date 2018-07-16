--聊天表情窗口
GameChatPanel = {}

setbaseclass(GameChatPanel, {BasePanel})

function GameChatPanel:InitPanel()
    logWarn("-----------------------------------------GameChatPanel")
    self.imgMaskBG = self:Child("imgMaskBG");
    self.btnFaceIcon = self:Child("btnFaceIcon");
    self.btnFaceIconDown = self:Child("btnFaceIconDown");
    self.btnChat = self:Child("btnChat");
    self.btnChatDown = self:Child("btnChatDown");
    self.btnMusic = self:Child("btnMusic");
    self.btnMusicDown = self:Child("btnMusicDown");
    --普通话聊天内容
    self.imgPTChat = self:Child("imgPTChat");
    self.btnPChat1 = self:Child("imgPTChat/btnPChat1");
    self.btnPChat2 = self:Child("imgPTChat/btnPChat2");
    self.btnPChat2Text = self:Child("imgPTChat/btnPChat2/Text");
    self.btnPChat3 = self:Child("imgPTChat/btnPChat3");
    self.btnPChat4 = self:Child("imgPTChat/btnPChat4");
    self.btnPChat5 = self:Child("imgPTChat/btnPChat5");
    self.btnPChat6 = self:Child("imgPTChat/btnPChat6");
    self.btnPChat7 = self:Child("imgPTChat/btnPChat7");
    self.btnPChat7Text = self:Child("imgPTChat/btnPChat7/Text");
    --聊天表情
    self.imgFaceIcon = self:Child("imgFaceIcon");
    self.imgE1 = self:Child("imgFaceIcon/imgE1");
    self.imgE2 = self:Child("imgFaceIcon/imgE2");
    self.imgE3 = self:Child("imgFaceIcon/imgE3");
    self.imgE4 = self:Child("imgFaceIcon/imgE4");
    self.imgE5 = self:Child("imgFaceIcon/imgE5");
    self.imgE6 = self:Child("imgFaceIcon/imgE6");
    self.imgE7 = self:Child("imgFaceIcon/imgE7");
    self.imgE8 = self:Child("imgFaceIcon/imgE8");
    self.imgE9 = self:Child("imgFaceIcon/imgE9");
    self.imgE10 = self:Child("imgFaceIcon/imgE10");
    self.imgE11 = self:Child("imgFaceIcon/imgE11");
    self.imgE12 = self:Child("imgFaceIcon/imgE12");
    self.imgE13 = self:Child("imgFaceIcon/imgE13");
    self.imgE14 = self:Child("imgFaceIcon/imgE14");
    self.imgE15 = self:Child("imgFaceIcon/imgE15");
    self.imgE16 = self:Child("imgFaceIcon/imgE16");
    self.imgE17 = self:Child("imgFaceIcon/imgE17");
    self.imgE18 = self:Child("imgFaceIcon/imgE18");
    self.imgE19 = self:Child("imgFaceIcon/imgE19");
    self.imgE20 = self:Child("imgFaceIcon/imgE20");
    self.imgE21 = self:Child("imgFaceIcon/imgE21");
    self.imgE22 = self:Child("imgFaceIcon/imgE22");
    self.imgE23 = self:Child("imgFaceIcon/imgE23");
    self.imgE24 = self:Child("imgFaceIcon/imgE24");
    --聊天音乐
    self.scrbMusic = self:Child("scrbMusic");
    self.btnRow1 = self:Child("scrbMusic/Grid/btnRow1");
	self.btnRow2 = self:Child("scrbMusic/Grid/btnRow2");
	self.btnRow3 = self:Child("scrbMusic/Grid/btnRow3");
	self.btnRow4 = self:Child("scrbMusic/Grid/btnRow4");
	self.btnRow5 = self:Child("scrbMusic/Grid/btnRow5");
	self.btnRow6 = self:Child("scrbMusic/Grid/btnRow6");
	self.btnRow7 = self:Child("scrbMusic/Grid/btnRow7");
	self.btnRow8 = self:Child("scrbMusic/Grid/btnRow8");
	self.btnRow9 = self:Child("scrbMusic/Grid/btnRow9");
    self.btnRow9Text = self:Child("scrbMusic/Grid/btnRow9/Text");
	self.btnRow10 = self:Child("scrbMusic/Grid/btnRow10");
	self.btnRow11 = self:Child("scrbMusic/Grid/btnRow11");
	self.btnRow12 = self:Child("scrbMusic/Grid/btnRow12");
	self.btnRow13 = self:Child("scrbMusic/Grid/btnRow13");
	self.btnRow14 = self:Child("scrbMusic/Grid/btnRow14");
	--方言聊天内容
	self.scrbFYChat = self:Child("scrbFYChat");
    self.btnChat1 = self:Child("scrbFYChat/Grid/btnChat1");
    self.btnChat2 = self:Child("scrbFYChat/Grid/btnChat2");
    self.btnChat3 = self:Child("scrbFYChat/Grid/btnChat3");
    self.btnChat4 = self:Child("scrbFYChat/Grid/btnChat4");
    self.btnChat5 = self:Child("scrbFYChat/Grid/btnChat5");
    self.btnChat6 = self:Child("scrbFYChat/Grid/btnChat6");
    self.btnChat7 = self:Child("scrbFYChat/Grid/btnChat7");
    self.btnChat8 = self:Child("scrbFYChat/Grid/btnChat8");
    self.btnChat9 = self:Child("scrbFYChat/Grid/btnChat9");
    self.btnChat10 = self:Child("scrbFYChat/Grid/btnChat10");
    self.btnChat11 = self:Child("scrbFYChat/Grid/btnChat11");
    self.btnChat12 = self:Child("scrbFYChat/Grid/btnChat12");
    self.btnChat13 = self:Child("scrbFYChat/Grid/btnChat13");
    self.btnChat14 = self:Child("scrbFYChat/Grid/btnChat14");
    self.btnChat15 = self:Child("scrbFYChat/Grid/btnChat15");
    self.inputChatText = self:Child("inputChatText");
    self.btnSendChat = self:Child("btnSendChat");
end