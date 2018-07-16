--local transform;
--local gameObject;

NoticeTipsPanel = {};
setbaseclass(NoticeTipsPanel,{BasePanel});
--local this = NoticeTipsPanel;

--启动事件--
-- function NoticeTipsPanel.Awake(obj)
-- 	gameObject = obj;
-- 	transform = obj.transform;

-- 	this.InitPanel();
-- 	logWarn("Awake lua--->>"..gameObject.name);
-- end

--初始化面板--
function NoticeTipsPanel:InitPanel()
	self.imgTitle = self:Child("imgTitle");
	self.BgImage = self:Child("BgImage");
	self.txtNotice = self:Child("BgImage/view/txtnotice");
end

--单击事件--
-- function NoticeTipsPanel.OnDestroy()
-- 	logWarn("OnDestroy---->>>");
-- end