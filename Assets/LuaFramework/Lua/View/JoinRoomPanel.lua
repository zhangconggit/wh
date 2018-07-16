--local transform;
--local gameObject;

JoinRoomPanel = {};
setbaseclass(JoinRoomPanel, {BasePanel})
--local this = JoinRoomPanel;

--启动事件--
--[[function JoinRoomPanel.Awake(obj)
	gameObject = obj;
	transform = obj.transform;

	this.InitPanel();
	logWarn("Awake lua--->>"..gameObject.name);
end--]]

--初始化面板--
function JoinRoomPanel:InitPanel()

logWarn("-----------------------------------------JoinRoomPanel");

    self.btnQuit = self:Child("btnQuit");
	self.txt1 = self:Child("imgShowNumber/txt1");
	self.txt2 = self:Child("imgShowNumber/txt2");
	self.txt3 = self:Child("imgShowNumber/txt3");
	self.txt4 = self:Child("imgShowNumber/txt4");
	self.txt5 = self:Child("imgShowNumber/txt5");
	self.txt6 = self:Child("imgShowNumber/txt6");
	self.btnNum0 = self:Child("btnNum0");
	self.btnNum1 = self:Child("btnNum1");
	self.btnNum2 = self:Child("btnNum2");
	self.btnNum3 = self:Child("btnNum3");
	self.btnNum4 = self:Child("btnNum4");
	self.btnNum5 = self:Child("btnNum5");
	self.btnNum6 = self:Child("btnNum6");
	self.btnNum7 = self:Child("btnNum7");
	self.btnNum8 = self:Child("btnNum8");
	self.btnNum9 = self:Child("btnNum9");
	self.btnBackSpace = self:Child("btnBackSpace");
	self.btnClear = self:Child("btnClear");
	self.btnJoinRoomMaskBG = self:Child("imgJoinRoomMaskBG");

	--[[this.btnQuit = transform:FindChild("btnQuit").gameObject;
	this.txt1 = transform:FindChild("imgShowNumber/txt1");
	this.txt2 = transform:FindChild("imgShowNumber/txt2");
	this.txt3 = transform:FindChild("imgShowNumber/txt3");
	this.txt4 = transform:FindChild("imgShowNumber/txt4");
	this.txt5 = transform:FindChild("imgShowNumber/txt5");
	this.txt6 = transform:FindChild("imgShowNumber/txt6");
	this.btnNum0 = transform:FindChild("btnNum0").gameObject;
	this.btnNum1 = transform:FindChild("btnNum1").gameObject;
	this.btnNum2 = transform:FindChild("btnNum2").gameObject;
	this.btnNum3 = transform:FindChild("btnNum3").gameObject;
	this.btnNum4 = transform:FindChild("btnNum4").gameObject;
	this.btnNum5 = transform:FindChild("btnNum5").gameObject;
	this.btnNum6 = transform:FindChild("btnNum6").gameObject;
	this.btnNum7 = transform:FindChild("btnNum7").gameObject;
	this.btnNum8 = transform:FindChild("btnNum8").gameObject;
	this.btnNum9 = transform:FindChild("btnNum9").gameObject;
	this.btnBackSpace = transform:FindChild("btnBackSpace").gameObject;
	this.btnClear = transform:FindChild("btnClear").gameObject;--]]
end

--单击事件--
--[[function JoinRoomPanel.OnDestroy()
	logWarn("OnDestroy---->>>");
end--]]