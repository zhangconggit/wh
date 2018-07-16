ShopMallCtrl = {};
setbaseclass(ShopMallCtrl,{BaseCtrl});

--启动事件--
function ShopMallCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj);
	obj.transform.localPosition = Vector3.New(0,-50,0);
	self:AddClick(ShopMallPanel.btnGoumai6, self.OnGoumaiBtnClick);
	self:AddClick(ShopMallPanel.btnGoumai30, self.OnGoumaiBtnClick);
	self:AddClick(ShopMallPanel.btnGoumai60, self.OnGoumaiBtnClick);
	self:AddClick(ShopMallPanel.btnGoumai128, self.OnGoumaiBtnClick);
	self:AddClick(ShopMallPanel.btnGoumai328, self.OnGoumaiBtnClick);
	self:AddClick(ShopMallPanel.btnGoumai618,self.OnGoumaiBtnClick);	
	self:AddClick(ShopMallPanel.btnCopy,self.OnCopyBtnClick);
	self:AddClick(ShopMallPanel.btnCancel,self.OnCancelBtnClick);
    
    --新添加功能
	self:AddClick(ShopMallPanel.btnGold,self.OnGoldWingCardBtnClick);          --金币
	self:AddClick(ShopMallPanel.btnWing,self.OnGoldWingCardBtnClick);          --元宝
	self:AddClick(ShopMallPanel.btnRoomCard,self.OnGoldWingCardBtnClick);      --房卡

	self:AddClick(ShopMallPanel.SbtnGold,self.OnGoldWingCardBtnClick);          --游戏内金币
	self:AddClick(ShopMallPanel.SbtnWing,self.OnGoldWingCardBtnClick);          --游戏内元宝
	self:AddClick(ShopMallPanel.SbtnRoomCard,self.OnGoldWingCardBtnClick);      --游戏内房卡

    --商城按钮功能
    self:AddClick(ShopMallPanel.btnFangKa5,self.OnFangKaBtnClick);
    self:AddClick(ShopMallPanel.btnFangKa10,self.OnFangKaBtnClick);
    self:AddClick(ShopMallPanel.btnFangKa20,self.OnFangKaBtnClick);
    self:AddClick(ShopMallPanel.btnFangKa30,self.OnFangKaBtnClick);
    self:AddClick(ShopMallPanel.btnFangKa50,self.OnFangKaBtnClick);
    self:AddClick(ShopMallPanel.btnFangKa100,self.OnFangKaBtnClick);         --房卡购买

    self:AddClick(ShopMallPanel.btnYuanBao10,self.OnYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnYuanBao50,self.OnYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnYuanBao100,self.OnYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnYuanBao300,self.OnYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnYuanBao500,self.OnYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnYuanBao1000,self.OnYuanBaoBtnClick);      --元宝购买

    self:AddClick(ShopMallPanel.btnJinBi10,self.OnJinBiBtnClick);
    self:AddClick(ShopMallPanel.btnJinBi30,self.OnJinBiBtnClick);
    self:AddClick(ShopMallPanel.btnJinBi50,self.OnJinBiBtnClick);
    self:AddClick(ShopMallPanel.btnJinBi100,self.OnJinBiBtnClick);
    self:AddClick(ShopMallPanel.btnJinBi150,self.OnJinBiBtnClick);
    self:AddClick(ShopMallPanel.btnJinBi200,self.OnJinBiBtnClick);            --金币购买

    self:AddClick(ShopMallPanel.SbtnFangKa5,self.OnFangKaBtnClick);
    self:AddClick(ShopMallPanel.SbtnFangKa10,self.OnFangKaBtnClick);
    self:AddClick(ShopMallPanel.SbtnFangKa20,self.OnFangKaBtnClick);
    self:AddClick(ShopMallPanel.SbtnFangKa30,self.OnFangKaBtnClick);
    self:AddClick(ShopMallPanel.SbtnFangKa50,self.OnFangKaBtnClick);
    self:AddClick(ShopMallPanel.SbtnFangKa100,self.OnFangKaBtnClick);         --游戏内房卡购买

    self:AddClick(ShopMallPanel.SbtnYuanBao10,self.OnYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.SbtnYuanBao50,self.OnYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.SbtnYuanBao100,self.OnYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.SbtnYuanBao300,self.OnYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.SbtnYuanBao500,self.OnYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.SbtnYuanBao1000,self.OnYuanBaoBtnClick);      --游戏内元宝购买

    self:AddClick(ShopMallPanel.SbtnJinBi10,self.OnJinBiBtnClick);
    self:AddClick(ShopMallPanel.SbtnJinBi30,self.OnJinBiBtnClick);
    self:AddClick(ShopMallPanel.SbtnJinBi50,self.OnJinBiBtnClick);
    self:AddClick(ShopMallPanel.SbtnJinBi100,self.OnJinBiBtnClick);
    self:AddClick(ShopMallPanel.SbtnJinBi150,self.OnJinBiBtnClick);
    self:AddClick(ShopMallPanel.SbtnJinBi200,self.OnJinBiBtnClick);            --游戏内金币购买

    self:AddClick(ShopMallPanel.btnZhiFuBao,self.OnZhiFuBaoClick);            --支付宝支付
    self:AddClick(ShopMallPanel.btnWeiXin,self.OnWeiXinClick);                --微信支付
    self:AddClick(ShopMallPanel.btnPayPageBack,self.OnPayPageBackBtnClick); 

    self:AddClick(ShopMallPanel.btnSure,self.OnSureChangeCoinBtnClick);   --确认兑换金币按钮
    self:AddClick(ShopMallPanel.btnCancle,self.OnCancleChangeCoinBtnClick); --取消兑换金币按钮

    self:AddClick(ShopMallPanel.btnQuit,self.OnQuitBtnClick); --退出外商城
    self:AddClick(ShopMallPanel.btnClose,self.OnCloseBtnClick); --退出内商城

   	self:AddClick(ShopMallPanel.btnGiveYuanBao10,self.OnGiveYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnGiveYuanBao50,self.OnGiveYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnGiveYuanBao100,self.OnGiveYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnGiveYuanBao300,self.OnGiveYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnGiveYuanBao500,self.OnGiveYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnGiveYuanBao1000,self.OnGiveYuanBaoBtnClick);      --元宝赠送

    self:AddClick(ShopMallPanel.btnDemandYuanBao10,self.OnDemandYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnDemandYuanBao50,self.OnDemandYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnDemandYuanBao100,self.OnDemandYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnDemandYuanBao300,self.OnDemandYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnDemandYuanBao500,self.OnDemandYuanBaoBtnClick);
    self:AddClick(ShopMallPanel.btnDemandYuanBao1000,self.OnDemandYuanBaoBtnClick);     --元宝索要

    self:AddClick(ShopMallPanel.btnGiveSure,self.OnSureGiveBtnClick);   --确认兑换金币按钮
    self:AddClick(ShopMallPanel.btnGiveCancle,self.OnCancleGiveBtnClick); --取消兑换金币按钮
 
	self:InitPanel();
end

--初始化面板--
function ShopMallCtrl:InitPanel(objs)
	ShopMallPanel.MainShopMall:SetActive(false)
	ShopMallPanel.GameShopMall:SetActive(false)
	
    if Game.GetSceneName() == "main" then
       ShopMallPanel.MainShopMall:SetActive(true)
    else
       ShopMallPanel.MainShopMall:SetActive(false)
	   ShopMallPanel.GameShopMall:SetActive(true)
	end

	if global.userVo.modes == 1 then
       mainSceneBtnAddMode = btnJinBiPayMode
       ShopMallPanel.buyJinBi:SetActive(true)       --默认显示金币界面
	   ShopMallPanel.buyFangKa:SetActive(false)
	   ShopMallPanel.buyYuanBao:SetActive(false)
	   ShopMallPanel.imgJinBi:SetActive(true)       --默认显示金币图标
	   ShopMallPanel.imgFangKa:SetActive(false)
	   ShopMallPanel.imgYuanBao:SetActive(false)

	   ShopMallPanel.SbuyJinBi:SetActive(true)       --默认显示金币界面
	   ShopMallPanel.SbuyFangKa:SetActive(false)
	   ShopMallPanel.SbuyYuanBao:SetActive(false)
	   ShopMallPanel.SimgJinBi:SetActive(true)       --默认显示金币图标
	   ShopMallPanel.SimgFangKa:SetActive(false)
	   ShopMallPanel.SimgYuanBao:SetActive(false)
    elseif  global.userVo.modes == 2 then
       mainSceneBtnAddMode = btnYuanBaoPayMode
       ShopMallPanel.buyJinBi:SetActive(false)       --默认显示金币界面
	   ShopMallPanel.buyFangKa:SetActive(false)
	   ShopMallPanel.buyYuanBao:SetActive(true)
	   ShopMallPanel.imgJinBi:SetActive(false)       --默认显示金币图标
	   ShopMallPanel.imgFangKa:SetActive(false)
	   ShopMallPanel.imgYuanBao:SetActive(true)

	   ShopMallPanel.SbuyJinBi:SetActive(false)       --默认显示金币界面
	   ShopMallPanel.SbuyFangKa:SetActive(false)
	   ShopMallPanel.SbuyYuanBao:SetActive(true)
	   ShopMallPanel.SimgJinBi:SetActive(false)       --默认显示金币图标
	   ShopMallPanel.SimgFangKa:SetActive(false)
	   ShopMallPanel.SimgYuanBao:SetActive(true)
    elseif   global.userVo.modes == 0 then
       mainSceneBtnAddMode = btnFangKaPayMode
       ShopMallPanel.buyJinBi:SetActive(false)       --默认显示金币界面
	   ShopMallPanel.buyFangKa:SetActive(true)
	   ShopMallPanel.buyYuanBao:SetActive(false)
	   ShopMallPanel.imgJinBi:SetActive(false)       --默认显示金币图标
	   ShopMallPanel.imgFangKa:SetActive(true)
	   ShopMallPanel.imgYuanBao:SetActive(false)

	   ShopMallPanel.SbuyJinBi:SetActive(false)       --默认显示金币界面
	   ShopMallPanel.SbuyFangKa:SetActive(true)
	   ShopMallPanel.SbuyYuanBao:SetActive(false)
	   ShopMallPanel.SimgJinBi:SetActive(false)       --默认显示金币图标
	   ShopMallPanel.SimgFangKa:SetActive(true)
	   ShopMallPanel.SimgYuanBao:SetActive(false)
	else
       ShopMallPanel.buyJinBi:SetActive(true)       --默认显示金币界面
	   ShopMallPanel.buyFangKa:SetActive(false)
	   ShopMallPanel.buyYuanBao:SetActive(false)
	   ShopMallPanel.imgJinBi:SetActive(true)       --默认显示金币图标
	   ShopMallPanel.imgFangKa:SetActive(false)
	   ShopMallPanel.imgYuanBao:SetActive(false)

	   ShopMallPanel.SbuyJinBi:SetActive(false)       --默认显示金币界面
	   ShopMallPanel.SbuyFangKa:SetActive(false)
	   ShopMallPanel.SbuyYuanBao:SetActive(true)
	   ShopMallPanel.SimgJinBi:SetActive(false)       --默认显示金币图标
	   ShopMallPanel.SimgFangKa:SetActive(false)
	   ShopMallPanel.SimgYuanBao:SetActive(true)
    end

	ShopMallPanel.imgBG3:SetActive(false)
	ShopMallPanel.imgTips:SetActive(false)
	ShopMallPanel.payPage:SetActive(false)           --支付界面默认关闭


	--[[if mainSceneBtnAddMode == btnYuanBaoPayMode then
	   ShopMallPanel.buyJinBi:SetActive(false)       --默认显示金币界面
	   ShopMallPanel.buyFangKa:SetActive(false)
	   ShopMallPanel.buyYuanBao:SetActive(true)
	   ShopMallPanel.imgJinBi:SetActive(false)       --默认显示金币图标
	   ShopMallPanel.imgFangKa:SetActive(false)
	   ShopMallPanel.imgYuanBao:SetActive(true)

	   ShopMallPanel.SbuyJinBi:SetActive(false)       --默认显示金币界面
	   ShopMallPanel.SbuyFangKa:SetActive(false)
	   ShopMallPanel.SbuyYuanBao:SetActive(true)
	   ShopMallPanel.SimgJinBi:SetActive(false)       --默认显示金币图标
	   ShopMallPanel.SimgFangKa:SetActive(false)
	   ShopMallPanel.SimgYuanBao:SetActive(true)
	end
	if mainSceneBtnAddMode == btnFangKaPayMode then
	   ShopMallPanel.buyJinBi:SetActive(false)       --默认显示金币界面
	   ShopMallPanel.buyFangKa:SetActive(true)
	   ShopMallPanel.buyYuanBao:SetActive(false)
	   ShopMallPanel.imgJinBi:SetActive(false)       --默认显示金币图标
	   ShopMallPanel.imgFangKa:SetActive(true)
	   ShopMallPanel.imgYuanBao:SetActive(false)

	   ShopMallPanel.SbuyJinBi:SetActive(false)       --默认显示金币界面
	   ShopMallPanel.SbuyFangKa:SetActive(true)
	   ShopMallPanel.SbuyYuanBao:SetActive(false)
	   ShopMallPanel.SimgJinBi:SetActive(false)       --默认显示金币图标
	   ShopMallPanel.SimgFangKa:SetActive(true)
	   ShopMallPanel.SimgYuanBao:SetActive(false)	   
	end
	if mainSceneBtnAddMode == btnJinBiPayMode then
	   ShopMallPanel.buyJinBi:SetActive(true)       --默认显示金币界面
	   ShopMallPanel.buyFangKa:SetActive(false)
	   ShopMallPanel.buyYuanBao:SetActive(false)
	   ShopMallPanel.imgJinBi:SetActive(true)       --默认显示金币图标
	   ShopMallPanel.imgFangKa:SetActive(false)
	   ShopMallPanel.imgYuanBao:SetActive(false)

	   ShopMallPanel.SbuyJinBi:SetActive(true)       --默认显示金币界面
	   ShopMallPanel.SbuyFangKa:SetActive(false)
	   ShopMallPanel.SbuyYuanBao:SetActive(false)
	   ShopMallPanel.SimgJinBi:SetActive(true)       --默认显示金币图标
	   ShopMallPanel.SimgFangKa:SetActive(false)
	   ShopMallPanel.SimgYuanBao:SetActive(false)
	end--]]
end

function ShopMallCtrl.OnGoumaiBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	if go.name == "btnGoumai6" then
		ShopMallPanel.imgBG3:SetActive(true)
	elseif go.name == "btnGoumai30" then
		ShopMallPanel.imgBG3:SetActive(true)
	elseif go.name == "btnGoumai60" then
		ShopMallPanel.imgBG3:SetActive(true)
	elseif go.name == "btnGoumai128" then
		ShopMallPanel.imgBG3:SetActive(true)
	elseif go.name == "btnGoumai328" then
		ShopMallPanel.imgBG3:SetActive(true)
	elseif go.name == "btnGoumai618" then
		ShopMallPanel.imgBG3:SetActive(true)
	end
end

function ShopMallCtrl.OnCloseBtnClick(go)
	local self = ShopMallCtrl
	self:Close()
end

function ShopMallCtrl.OnQuitBtnClick(go)
	local self = ShopMallCtrl
	Game.MusicEffect(Game.Effect.buttonBack)
	MainSencePanel.btnS:SetActive(true)                --这句不可少
    MainSencePanel.ChooseRoom:SetActive(false)         
	NoticeTipsCtrl:Open('NoticeTips')                  --打开消息提示
	MainSencePanel.fartherOfMainSence:SetActive(true)  --显示一级界面部分内容
	self:Close()
end

function ShopMallCtrl.OnCopyBtnClick(go)
	local self = ShopMallCtrl
	Game.MusicEffect(Game.Effect.joinRoom)
	Util.CopyText('棋牌')
	self.SetIconTips("复制成功！")
end

function ShopMallCtrl.OnCancelBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	ShopMallPanel.imgBG3:SetActive(false)
end

--提示
function ShopMallCtrl.ChatTips()
	local self = ShopMallCtrl
	ShopMallPanel.imgTips:SetActive(true)
	coroutine.start(self.ChatWait)
end
function ShopMallCtrl.ChatWait()
	coroutine.wait(1.8)
	if ShopMallCtrl.isCreate then
		ShopMallPanel.imgTips:SetActive(false)
	end
end

function ShopMallCtrl.SetIconTips(str,bool)
	local self = ShopMallCtrl
	if bool == nil then
		if ShopMallPanel.imgTips.activeSelf == true then return end
		self.ChatTips()
		local tipsText =  BasePanel:GOChild(ShopMallPanel.imgTips,"Name")
		local tipsPos = Vector3.New(0,-172.8,3782)
		local sequence = DG.Tweening.DOTween.Sequence()
		sequence:Append(ShopMallPanel.imgTips.transform:DOLocalMoveY(tipsPos.y+50, 2, false))
				:OnComplete(function()
				ShopMallPanel.imgTips.transform.localPosition = tipsPos
				end)
		self:SetText(tipsText,str)
	elseif bool == true then
		local tipsText =  BasePanel:GOChild(ShopMallPanel.imgTips,"Name")
		local tipsPos = Vector3.New(0,-130,3782)
		ShopMallPanel.imgTips.transform.localPosition = tipsPos
		ShopMallPanel.imgTips:SetActive(true)
		self:SetText(tipsText,str)
	else
		ShopMallPanel.imgTips:SetActive(false)
	end
end

--点击购买类型的标题(金币,房卡,元宝)
function ShopMallCtrl.OnGoldWingCardBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)              --------------暂用音效
	if go.name == "btnGold" or go.name == "SbtnGold" then		
		ShopMallPanel.buyJinBi:SetActive(true)
		ShopMallPanel.buyFangKa:SetActive(false)
		ShopMallPanel.buyYuanBao:SetActive(false)

		ShopMallPanel.imgJinBi:SetActive(true)
		ShopMallPanel.imgFangKa:SetActive(false)
		ShopMallPanel.imgYuanBao:SetActive(false)

		ShopMallPanel.SbuyJinBi:SetActive(true)
		ShopMallPanel.SbuyFangKa:SetActive(false)
		ShopMallPanel.SbuyYuanBao:SetActive(false)

		ShopMallPanel.SimgJinBi:SetActive(true)
		ShopMallPanel.SimgFangKa:SetActive(false)
		ShopMallPanel.SimgYuanBao:SetActive(false)
	end
	if go.name == "btnWing" or go.name == "SbtnWing"  then
		ShopMallPanel.buyJinBi:SetActive(false)
		ShopMallPanel.buyFangKa:SetActive(false)
		ShopMallPanel.buyYuanBao:SetActive(true)

		ShopMallPanel.imgJinBi:SetActive(false)
		ShopMallPanel.imgFangKa:SetActive(false)
		ShopMallPanel.imgYuanBao:SetActive(true)

		ShopMallPanel.SbuyJinBi:SetActive(false)
		ShopMallPanel.SbuyFangKa:SetActive(false)
		ShopMallPanel.SbuyYuanBao:SetActive(true)

		ShopMallPanel.SimgJinBi:SetActive(false)
		ShopMallPanel.SimgFangKa:SetActive(false)
		ShopMallPanel.SimgYuanBao:SetActive(true)
	end
	if go.name == "btnRoomCard" or go.name == "SbtnRoomCard"  then
	    ShopMallPanel.buyJinBi:SetActive(false)
		ShopMallPanel.buyFangKa:SetActive(true)
		ShopMallPanel.buyYuanBao:SetActive(false)

		ShopMallPanel.imgJinBi:SetActive(false)
		ShopMallPanel.imgFangKa:SetActive(true)
		ShopMallPanel.imgYuanBao:SetActive(false)

	    ShopMallPanel.SbuyJinBi:SetActive(false)
		ShopMallPanel.SbuyFangKa:SetActive(true)
		ShopMallPanel.SbuyYuanBao:SetActive(false)

		ShopMallPanel.SimgJinBi:SetActive(false)
		ShopMallPanel.SimgFangKa:SetActive(true)
		ShopMallPanel.SimgYuanBao:SetActive(false)
	end

end

--购买房卡的按钮
function ShopMallCtrl.OnFangKaBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)              --------------暂用音效
	ShopMallPanel.payPage:SetActive(true)
	self.roleId  = global.userVo.roleId
    self.unionID = AppConst.getPlayerPrefs('unionID')
    self.openID  = AppConst.getPlayerPrefs('userID')
    self.diamond  = global.userVo.diamond                  --房卡
	if go.name == "btnFangKa5" then
		self.productId = "1d0321e52f164e9aa52faed153cd37ea"
		print("======================>>>>>>>>>>>>>>>>索要元宝,10") 
	end
	if go.name == "btnFangKa10" or go.name == "SbtnFangKa10" then
		self.productId = "b3a9f94b354f42299c8c5538068b665c"
	end
	if go.name == "btnFangKa20"  or go.name == "SbtnFangKa20" then
		self.productId = "2c428c4c96b44aee9fe5e6b3a589e0a7"
	end
	if go.name == "btnFangKa30"  or go.name == "SbtnFangKa30" then
		self.productId = "ff984158dfc24d12be1308adecc66509"
	end
	if go.name == "btnFangKa50"  or go.name == "SbtnFangKa50" then
		self.productId = "cb030252bcad41228ea1395d46c1898c"
	end
	if go.name == "btnFangKa100"  or go.name == "SbtnFangKa100" then
		self.productId = "2af7ed6b29da48fe801a8cbb646c62f8"
	end
end

--购买元宝的按钮
function ShopMallCtrl.OnYuanBaoBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)              --------------暂用音效
    ShopMallPanel.payPage:SetActive(true)
    self.roleId  = global.userVo.roleId
    self.unionID = AppConst.getPlayerPrefs('unionID')
    self.openID  = AppConst.getPlayerPrefs('userID')
    self.diamond  = global.userVo.wing                      --元宝

	if go.name == "btnYuanBao10" or go.name == "SbtnYuanBao10" then
       self.productId = "9797d53ded0a44058121dde62c9ab0a0"
	end
	if go.name == "btnYuanBao50" or go.name == "SbtnYuanBao50" then
       self.productId = "6f95ee563ddb45c28393b0662e443586"
	end
	if go.name == "btnYuanBao100" or go.name == "SbtnYuanBao100" then
       self.productId = "d084da23fe3f4e7bbca17b973a09aa3f"	  
	end
	if go.name == "btnYuanBao300" or go.name == "SbtnYuanBao300" then
       self.productId = "1c6267fa99d4468f8248c8bc2eb907ad"
	end
	if go.name == "btnYuanBao500" or go.name == "SbtnYuanBao500" then
       self.productId = "6ba6af9bf1da4df48b089ddf6e1c9572"
	end
	if go.name == "btnYuanBao1000" or go.name == "SbtnYuanBao1000" then
       self.productId = "0c67869ba79d4b7cb0e833a02184ecaa"
	end
end

--赠送元宝的按钮
function ShopMallCtrl.OnGiveYuanBaoBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
    ShopMallPanel.GiveYuanbao:SetActive(true)              --赠送元宝输入框确认界面
    print("======================>>>>>>>>>>>>>>>>赠送元宝输入框界面")
end

--元宝赠送确认按钮
function ShopMallCtrl.OnSureGiveBtnClick(go)
	print("======================>>>>>>>>>>>>>>>>赠送元宝输入框确认按钮") 

	--local playerID = ConvertCoin_pb.ConvertCoinReq()
	--playerID.productId = self.productId
	--local msg = playerID:SerializeToString()
	--Game.SendProtocal(Protocal.WuZiQiStay, msg)		--向服务端发送赠送元宝请求
end

--元宝赠送确认按钮回调
--[[function ShopMallCtrl.OnSureGiveBtnClickRes(buffer)
	local self = ShopMallCtrl
	local data   = buffer:ReadBuffer()
	local msg    = IntTypeReturn_pb.IntTypeReturnRes()	
	msg:ParseFromString(data)
	local intVal = msg.intVal
	if intVal == 0 then
	end
	if intVal == 1 then
		ShopMallPanel.GiveYuanbao:SetActive(false)					--赠送确认界面隐藏
		ShopMallPanel.payPage:SetActive(true)						--支付界面弹出
    	self.unionID = AppConst.getPlayerPrefs('unionID')
    	self.openID  = AppConst.getPlayerPrefs('userID')

		if go.name == "btnYuanBao10" then
       		self.productId = "9797d53ded0a44058121dde62c9ab0a0"
		end
		if go.name == "btnYuanBao50" then
       		self.productId = "6f95ee563ddb45c28393b0662e443586"
		end
		if go.name == "btnYuanBao100" then
       		self.productId = "d084da23fe3f4e7bbca17b973a09aa3f"	  
		end
		if go.name == "btnYuanBao300" then
       		self.productId = "1c6267fa99d4468f8248c8bc2eb907ad"
		end
		if go.name == "btnYuanBao500" then
       		self.productId = "6ba6af9bf1da4df48b089ddf6e1c9572"
		end
		if go.name == "btnYuanBao1000" then 
       		self.productId = "0c67869ba79d4b7cb0e833a02184ecaa"
		end
	end
end--]]


--元宝赠送取消按钮
function ShopMallCtrl.OnCancleGiveBtnClick(go)
	print("======================>>>>>>>>>>>>>>>>赠送元宝输入框取消按钮")
	ShopMallPanel.GiveYuanbao:SetActive(false)
end

--索要元宝的按钮
function ShopMallCtrl.OnDemandYuanBaoBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)

	if go.name == "btnYuanBao10" then
       self.productId = "9797d53ded0a44058121dde62c9ab0a0"

       print("======================>>>>>>>>>>>>>>>>索要元宝,10") 
	    local self = ShopMallCtrl;
		if(AppConst.getCurrentPlatform() == 'PC') then
			MessageTipsCtrl:ShowInfo("当前不能赠送！")
        	return
		end
		local shareContent = "10元代购分享"
		local imageUrl = 'http://static.hzjiuyou.com/img/shopPear.png'
		local title = "棋牌"
		local downUrl = 'http://192.168.1.201:8080/xlw/dl/download.html'
		weChatFunction.weChatInviteFriendBtnClick(shareContent,imageUrl,title,downUrl)
	end

	if go.name == "btnYuanBao50" then
       self.productId = "6f95ee563ddb45c28393b0662e443586"

       print("======================>>>>>>>>>>>>>>>>索要元宝,50") 
	   local self = ShopMallCtrl;
		if(AppConst.getCurrentPlatform() == 'PC') then
			MessageTipsCtrl:ShowInfo("当前不能赠送！")
        	return
		end
		local shareContent = "50元代购分享"
		local imageUrl = 'http://static.hzjiuyou.com/img/shopPeach.png'
		local title = "棋牌"
		local downUrl = 'http://192.168.1.201:8080/xlw/dl/download.html'
		weChatFunction.weChatInviteFriendBtnClick(shareContent,imageUrl,title,downUrl)     
	end

	if go.name == "btnYuanBao100" then
       self.productId = "d084da23fe3f4e7bbca17b973a09aa3f"	  

       print("======================>>>>>>>>>>>>>>>>索要元宝,100")  
	   local self = ShopMallCtrl;
		if(AppConst.getCurrentPlatform() == 'PC') then
			MessageTipsCtrl:ShowInfo("当前不能赠送！")
        	return
		end
		local shareContent = "100元代购分享"
		local imageUrl = 'http://static.hzjiuyou.com/img/shopWaterMollen.png'
		local title = "棋牌"
		local downUrl = 'http://192.168.1.201:8080/xlw/dl/download.html'
		weChatFunction.weChatInviteFriendBtnClick(shareContent,imageUrl,title,downUrl)
	end

	if go.name == "btnYuanBao300" then
       self.productId = "1c6267fa99d4468f8248c8bc2eb907ad"

       print("======================>>>>>>>>>>>>>>>>索要元宝,300") 
	   local self = ShopMallCtrl;
		if(AppConst.getCurrentPlatform() == 'PC') then
			MessageTipsCtrl:ShowInfo("当前不能赠送！")
        	return
		end
		local shareContent = "300元代购分享"
		local imageUrl = 'http://static.hzjiuyou.com/img/shopBanana.png'
		local title = "棋牌"
		local downUrl = 'http://192.168.1.201:8080/xlw/dl/download.html'
		weChatFunction.weChatInviteFriendBtnClick(shareContent,imageUrl,title,downUrl)     
	end

	if go.name == "btnYuanBao500" then
       self.productId = "6ba6af9bf1da4df48b089ddf6e1c9572"

       print("======================>>>>>>>>>>>>>>>>索要元宝,500")  
	    local self = ShopMallCtrl;
		if(AppConst.getCurrentPlatform() == 'PC') then
			MessageTipsCtrl:ShowInfo("当前不能赠送！")
        	return
		end
		local shareContent = "500元代购分享"
		local imageUrl = 'http://static.hzjiuyou.com/img/shopCherries.png'
		local title = "棋牌"
		local downUrl = 'http://192.168.1.201:8080/xlw/dl/download.html'
		weChatFunction.weChatInviteFriendBtnClick(shareContent,imageUrl,title,downUrl)           
	end

	if go.name == "btnYuanBao1000" then
       self.productId = "0c67869ba79d4b7cb0e833a02184ecaa"

       print("======================>>>>>>>>>>>>>>>>索要元宝,1000")                                           
	   local self = ShopMallCtrl;
		if(AppConst.getCurrentPlatform() == 'PC') then
			MessageTipsCtrl:ShowInfo("当前不能赠送！")
        	return
		end
		local shareContent = "1000元代购分享"
		local imageUrl = 'http://static.hzjiuyou.com/img/shopGrape.png'
		local title = "棋牌"
		local downUrl = 'http://192.168.1.201:8080/xlw/dl/download.html'
		weChatFunction.weChatInviteFriendBtnClick(shareContent,imageUrl,title,downUrl)     
	end	
end


--购买金币的按钮
function ShopMallCtrl.OnJinBiBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)                  --------------暂用音效
	ShopMallPanel.changeCoin:SetActive(true)              --打开金币购买二次确认界面
	if go.name == "btnJinBi10" or go.name == "SbtnJinBi10" then 
	   self.productId = 10001                      --100元宝10万金币       
	end
	if go.name == "btnJinBi30" or go.name == "SbtnJinBi30"  then
	   self.productId = 10002                      --300元宝30万金币     
	end
	if go.name == "btnJinBi50" or go.name == "SbtnJinBi50"  then 
	   self.productId = 10003                      --500元宝50万金币
	end
	if go.name == "btnJinBi100" or go.name == "SbtnJinBi100"  then
	   self.productId = 10004                      --1000元宝100万金币
	end
	if go.name == "btnJinBi150" or go.name == "SbtnJinBi150"  then 
	   self.productId = 10005                      --1500元宝150万金币 
	end
	if go.name == "btnJinBi200" or go.name == "SbtnJinBi200"  then                                           
	   self.productId = 10006                      --2000元宝200万金币
	end	
end

--元宝兑换金币消息返回
function ShopMallCtrl.OnConvertCoinRes(buffer)
    local self = ShopMallCtrl
	local data = buffer:ReadBuffer()
	local msg  = ConvertCoin_pb.ConvertCoinRes()	
	msg:ParseFromString(data)

	local errorCode = msg.errorCode  --错误码 0 对换成功， 1 元宝不足， 2 金币已达上限
	local costWing  = msg.costWing   --消耗的元宝数量
	local gainCoin  = msg.gainCoin   --获得的金币数量
    if errorCode == 0 then
    	
    	-- global.userVo.goldcoin = global.userVo.goldcoin + gainCoin
    	-- global.userVo.wing = global.userVo.wing - costWing
    	MessageTipsCtrl:ShowInfo("恭喜您获得了"..gainCoin.."金币！")
    end
    if errorCode == 1 then
    	MessageTipsCtrl:ShowInfo("元宝不足！")

    end
    if errorCode == 2 then
    	MessageTipsCtrl:ShowInfo("您的金币已达上限！")
    end
end


--支付宝支付按钮
function ShopMallCtrl.OnZhiFuBaoClick()
	
end

--微信支付按钮
function ShopMallCtrl.OnWeiXinClick()
	local productId = self.productId
	local urlInfo = 'roleId='..tostring(self.roleId)..'&unionId='..tostring(self.unionID)..'&openId='..tostring(self.openID)..'&diamond='..tostring(self.diamond)..'&product='..tostring(self.productId)
    local key = '&key=4ErswWe1qR1'
    weChatFunction.openWeChat('http://weixin.hzjiuyou.com/mallController/buyCardOrWing?',urlInfo,key)
end

--支付页面的返回按钮
function ShopMallCtrl.OnPayPageBackBtnClick()
	ShopMallPanel.payPage:SetActive(false)
end

--金币兑换确认按钮
function ShopMallCtrl.OnSureChangeCoinBtnClick()
	local change = ConvertCoin_pb.ConvertCoinReq()
	change.productId = self.productId
	local msg = change:SerializeToString()
	Game.SendProtocal(Protocal.ConvertCoin, msg)       --向服务端发送兑换金币请求
	ShopMallPanel.changeCoin:SetActive(false)
end

--金币兑换取消按钮
function ShopMallCtrl.OnCancleChangeCoinBtnClick()
	ShopMallPanel.changeCoin:SetActive(false)
end
