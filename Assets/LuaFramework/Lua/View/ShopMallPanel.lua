ShopMallPanel = {};
setbaseclass(ShopMallPanel, {BasePanel})

function ShopMallPanel:InitPanel()
	self.btnGoumai6 = self:Child("imgGoumai6/btnGoumai6");
	self.btnGoumai30 = self:Child("imgGoumai30/btnGoumai30");
	self.btnGoumai60 = self:Child("imgGoumai60/btnGoumai60");
	self.btnGoumai128 = self:Child("imgGoumai128/btnGoumai128");
	self.btnGoumai328 = self:Child("imgGoumai328/btnGoumai328");
	self.btnGoumai618 = self:Child("imgGoumai618/btnGoumai618");

 
    self.imgBG3 = self:Child("imgBG3");
    self.btnCopy = self:Child("imgBG3/paneTips/imgCopyBG/btnCopy");
    self.btnCancel = self:Child("imgBG3/paneTips/btnCancel");
    self.imgTips = self:Child("imgBG3/paneTips/imgTips")
-------------------------------------------------------------------------    
    self.MainShopMall = self:Child("mallBig");
    self.GameShopMall = self:Child("mallSmall");

    --新添加功能
    self.buyJinBi = self:Child("mallBig/buyJinBi");
    self.buyFangKa = self:Child("mallBig/buyFangKa");
    self.buyYuanBao = self:Child("mallBig/buyYuanBao");
    self.btnQuit = self:Child("mallBig/btnQuitMall");

    self.imgFangKa = self:Child("mallBig/btnRoomCard/imgFangKa");
    self.imgYuanBao = self:Child("mallBig/btnWing/imgYuanBao");
    self.imgJinBi = self:Child("mallBig/btnGold/imgJinBi");

    self.btnGold = self:Child("mallBig/btnGold");
    self.btnWing = self:Child("mallBig/btnWing");
    self.btnRoomCard = self:Child("mallBig/btnRoomCard");
------------------------------------------------------------------------- 主页面的大商城
    self.SbuyJinBi = self:Child("mallSmall/SbuyJinBi");
    self.SbuyFangKa = self:Child("mallSmall/SbuyFangKa");
    self.SbuyYuanBao = self:Child("mallSmall/SbuyYuanBao");
    self.btnClose = self:Child("mallSmall/btnCloseMall");

    self.SimgFangKa = self:Child("mallSmall/SbtnRoomCard/SimgFangKa");
    self.SimgYuanBao = self:Child("mallSmall/SbtnWing/SimgYuanBao");
    self.SimgJinBi = self:Child("mallSmall/SbtnGold/SimgJinBi");

    self.SbtnGold = self:Child("mallSmall/SbtnGold");
    self.SbtnWing = self:Child("mallSmall/SbtnWing");
    self.SbtnRoomCard = self:Child("mallSmall/SbtnRoomCard");
------------------------------------------------------------------------- 游戏内商城



    --商城按钮以下
    self.btnFangKa5 = self:Child("mallBig/buyFangKa/btnFangKa5");
    self.btnFangKa10 = self:Child("mallBig/buyFangKa/btnFangKa10");
    self.btnFangKa20 = self:Child("mallBig/buyFangKa/btnFangKa20");
    self.btnFangKa30 = self:Child("mallBig/buyFangKa/btnFangKa30");
    self.btnFangKa50 = self:Child("mallBig/buyFangKa/btnFangKa50");
    self.btnFangKa100 = self:Child("mallBig/buyFangKa/btnFangKa100");         --外商城房卡购买

    self.btnYuanBao10 = self:Child("mallBig/buyYuanBao/btnYuanBao10");
    self.btnYuanBao50 = self:Child("mallBig/buyYuanBao/btnYuanBao50"); 
    self.btnYuanBao100 = self:Child("mallBig/buyYuanBao/btnYuanBao100");
    self.btnYuanBao300 = self:Child("mallBig/buyYuanBao/btnYuanBao300");
    self.btnYuanBao500 = self:Child("mallBig/buyYuanBao/btnYuanBao500");
    self.btnYuanBao1000 = self:Child("mallBig/buyYuanBao/btnYuanBao1000");    --外商城元宝购买

    self.btnJinBi10 = self:Child("mallBig/buyJinBi/btnJinBi10");
    self.btnJinBi30 = self:Child("mallBig/buyJinBi/btnJinBi30");
    self.btnJinBi50 = self:Child("mallBig/buyJinBi/btnJinBi50");
    self.btnJinBi100 = self:Child("mallBig/buyJinBi/btnJinBi100");
    self.btnJinBi150 = self:Child("mallBig/buyJinBi/btnJinBi150");
    self.btnJinBi200 = self:Child("mallBig/buyJinBi/btnJinBi200");            --外商城金币购买

    self.SbtnFangKa5 = self:Child("mallSmall/SbuyFangKa/SbtnFangKa5");
    self.SbtnFangKa10 = self:Child("mallSmall/SbuyFangKa/SbtnFangKa10");
    self.SbtnFangKa20 = self:Child("mallSmall/SbuyFangKa/SbtnFangKa20");
    self.SbtnFangKa30 = self:Child("mallSmall/SbuyFangKa/SbtnFangKa30");
    self.SbtnFangKa50 = self:Child("mallSmall/SbuyFangKa/SbtnFangKa50");
    self.SbtnFangKa100 = self:Child("mallSmall/SbuyFangKa/SbtnFangKa100");         --内商城房卡购买

    self.SbtnYuanBao10 = self:Child("mallSmall/SbuyYuanBao/SbtnYuanBao10");
    self.SbtnYuanBao50 = self:Child("mallSmall/SbuyYuanBao/SbtnYuanBao50"); 
    self.SbtnYuanBao100 = self:Child("mallSmall/SbuyYuanBao/SbtnYuanBao100");
    self.SbtnYuanBao300 = self:Child("mallSmall/SbuyYuanBao/SbtnYuanBao300");
    self.SbtnYuanBao500 = self:Child("mallSmall/SbuyYuanBao/SbtnYuanBao500");
    self.SbtnYuanBao1000 = self:Child("mallSmall/SbuyYuanBao/SbtnYuanBao1000");    --内商城元宝购买

    self.SbtnJinBi10 = self:Child("mallSmall/SbuyJinBi/SbtnJinBi10");
    self.SbtnJinBi30 = self:Child("mallSmall/SbuyJinBi/SbtnJinBi30");
    self.SbtnJinBi50 = self:Child("mallSmall/SbuyJinBi/SbtnJinBi50");
    self.SbtnJinBi100 = self:Child("mallSmall/SbuyJinBi/SbtnJinBi100");
    self.SbtnJinBi150 = self:Child("mallSmall/SbuyJinBi/SbtnJinBi150");
    self.SbtnJinBi200 = self:Child("mallSmall/SbuyJinBi/SbtnJinBi200");            --内商城金币购买

    self.btnZhiFuBao = self:Child("payPage/btnZhiFuBao");             --支付宝
    self.btnWeiXin = self:Child("payPage/btnWeiXin");                 --微信
    self.payPage = self:Child("payPage");
    self.btnPayPageBack = self:Child("payPage/btnPayPageBack");       --支付页面的返回

    --元宝兑换金币
    self.btnSure = self:Child("changeCoin/btnSure");                  --确定兑换
    self.btnCancle = self:Child("changeCoin/btnCancle");              --取消兑换
    self.changeCoin = self:Child("changeCoin");                        --二次确认界面

    --元宝赠送
    self.btnGiveYuanBao10 = self:Child("mallBig/buyYuanBao/btnGiveYuanBao10");
    self.btnGiveYuanBao50 = self:Child("mallBig/buyYuanBao/btnGiveYuanBao50");
    self.btnGiveYuanBao100 = self:Child("mallBig/buyYuanBao/btnGiveYuanBao100");
    self.btnGiveYuanBao300 = self:Child("mallBig/buyYuanBao/btnGiveYuanBao300");
    self.btnGiveYuanBao500 = self:Child("mallBig/buyYuanBao/btnGiveYuanBao500");
    self.btnGiveYuanBao1000 = self:Child("mallBig/buyYuanBao/btnGiveYuanBao1000");

    self.GiveYuanbao        = self:Child("GiveYuanbao")                         --赠送元宝确认界面
    self.btnGiveSure        = self:Child("GiveYuanbao/btnGiveSure")             --确认赠送
    self.btnGiveCancle      = self:Child("GiveYuanbao/btnGiveCancle")           --取消赠送
    self.txtID              = self:Child("GiveYuanbao/txtID")                   --输入的玩家ID

    --元宝索要
    self.btnDemandYuanBao10 = self:Child("mallBig/buyYuanBao/btnDemandYuanBao10");
    self.btnDemandYuanBao50 = self:Child("mallBig/buyYuanBao/btnDemandYuanBao50");
    self.btnDemandYuanBao100 = self:Child("mallBig/buyYuanBao/btnDemandYuanBao100");
    self.btnDemandYuanBao300 = self:Child("mallBig/buyYuanBao/btnDemandYuanBao300");
    self.btnDemandYuanBao500 = self:Child("mallBig/buyYuanBao/btnDemandYuanBao500");
    self.btnDemandYuanBao1000 = self:Child("mallBig/buyYuanBao/btnDemandYuanBao1000");

end
