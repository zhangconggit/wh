GameMatchDetailPanel = {};
setbaseclass(GameMatchDetailPanel, {BasePanel})

function GameMatchDetailPanel:InitPanel()
	self.jianglineirong = self:Child("imgLeftBG/togGroupLeft/jianglineirong");
	self.saizhixiangqing = self:Child("imgLeftBG/togGroupLeft/saizhixiangqing");
	self.MatchJiangLi = self:Child("MatchJiangLi");
	self.MatchXiangQing = self:Child("MatchXiangQing");
	self.Match8JiangLi = self:Child("Match8JiangLi");
	self.Match8XiangQing = self:Child("Match8XiangQing");
	self.Match4JiangLi = self:Child("Match4JiangLi");
	self.Match4XiangQing = self:Child("Match4XiangQing");
	self.btnQuit = self:Child("btnQuit");
end

