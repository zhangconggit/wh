DiamondPayCtrl = {};
setbaseclass(DiamondPayCtrl, {BaseCtrl})

local num = 0
local isAdd = true
local isEnd = false

function DiamondPayCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self,obj)

	self:AddClick(DiamondPayPanel.btnClose,self.OnQuitBtnClick)
	self:AddClick(DiamondPayPanel.btnCopy1,self.OnCopyBtn1Click)
	self:AddClick(DiamondPayPanel.btnCopy2,self.OnCopyBtn2Click)
	self:AddClick(DiamondPayPanel.btnCopy3,self.OnCopyBtn3Click)
	self:AddClick(DiamondPayPanel.btnQuit,self.OnQuitBtnClick)
	self:AddClickNoChange(DiamondPayPanel.btnDiamondMaskBG,self.OnQuitBtnClick)
    
    --新添加
    self:AddClick(DiamondPayPanel.btnOpenWeb,self.OnOpenBtnClick) --点击二维码打开网页
    self:AddClick(DiamondPayPanel.buttomImg,self.OnOpenBtnClick)

	--self:InitPanel()
end

function DiamondPayCtrl:InitPanel()
	DiamondPayPanel.imgshow:SetActive(false)
end

function DiamondPayCtrl.OnQuitBtnClick(go)
	--Game.MusicEffect(Game.Effect.buttonBack)
	local self = DiamondPayCtrl
	self:Close()
end

function DiamondPayCtrl.OnCopyBtn1Click(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = DiamondPayCtrl
	Util.CopyText(self:GetText(DiamondPayPanel.text2))
	self:SetText(DiamondPayPanel.txtshow,"电话号复制成功") 
	DiamondPayCtrl:ImageShow()
end

function DiamondPayCtrl.OnCopyBtn2Click(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = DiamondPayCtrl
	Util.CopyText(self:GetText(DiamondPayPanel.text3))
	self:SetText(DiamondPayPanel.txtshow,"微信号复制成功") 
	DiamondPayCtrl:ImageShow()
end

function DiamondPayCtrl.OnCopyBtn3Click(go)
	--Game.MusicEffect(Game.Effect.joinRoom)
	local self = DiamondPayCtrl
	Util.CopyText(self:GetText(DiamondPayPanel.text4))
	self:SetText(DiamondPayPanel.txtshow,"QQ群号复制成功") 
	DiamondPayCtrl:ImageShow()
end

function DiamondPayCtrl:ImageShow()
	DiamondPayPanel.imgshow:SetActive(true)
	local co = coroutine.start(function()
        coroutine.wait(3)
        DiamondPayPanel.imgshow:SetActive(false)
    end)
    table.insert(Network.crts, co)	
end

--二维码点击按钮
function DiamondPayCtrl.OnOpenBtnClick()
	weChatFunction.openURL('http://weixin.hzjiuyou.com/static/page/gameQRCodeParant.html')
end
