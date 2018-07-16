
RankListPanel = {};
setbaseclass(RankListPanel, {BasePanel})

function RankListPanel:InitPanel()
 
    self.btnJinBiPaiHang = self:Child("imgTitleTwoBg/btnJinBiPaiHang");    --金币按钮
    self.btnYanBaoPaiHang = self:Child("imgTitleTwoBg/btnYanBaoPaiHang");  --元宝按钮
    self.btnBack = self:Child("btnBack");                                     --返回
    self.btnAboutMask = self:Child("aboutPersonalMessage/imgAboutMask");
    self.btnCloseMask = self:Child("imgMaskBG");
    
    self.imgJinBiPaiHang = self:Child("imgTitleTwoBg/imgJinBiPaiHang");    --金币图片
    self.imgYuanBaoPaiHang = self:Child("imgTitleTwoBg/imgYuanBaoPaiHang");--元宝图片

    self.imgHeadIcon = self:Child("aboutZiJi/maskHead/imgHeadIcon");       --头像img
    self.textZiJiName = self:Child("aboutZiJi/textZiJiName");              --name
    self.textZiJiId = self:Child("aboutZiJi/textZiJiId");                  --ID
    self.txtXiJiYuanBaoNumber = self:Child("aboutZiJi/imgYuanBao/txtXiJiYuanBaoNumber"); --元宝数量
    self.txtZiJiJinBiNumber = self:Child("aboutZiJi/imgJinBi/txtZiJiJinBiNumber");       --金币数量

    self.rankParentJB = self:Child("rankParent/ScrollView/Viewport/Content");           --生成金币预制体的父物体
    self.rankParentJinBi  = self:Child("rankParent");    
    self.rankParentYB = self:Child("rankParentYuanBao/ScrollView/Viewport/Content");    --生成元宝预制体的父物体                
    self.rankParentYuanBao = self:Child("rankParentYuanBao");

    --查看玩家个人信息
    self.aboutPersonalMessage = self:Child("aboutPersonalMessage");
    self.btnBackTanChuang = self:Child("aboutPersonalMessage/btnBackTanChuang");
  	self.imgOtherHead = self:Child("aboutPersonalMessage/imgOtherHead");    --头像
    self.textOtherName = self:Child("aboutPersonalMessage/textOtherName");   --名称
    self.textOtherId = self:Child("aboutPersonalMessage/textOtherId");       --id
    self.imgSexMan = self:Child("aboutPersonalMessage/imgSexMan");           --男    
    self.imgSexWomen = self:Child("aboutPersonalMessage/imgSexWomen");       --女
    self.textQianMing = self:Child("aboutPersonalMessage/imgTextBg/textQianMing"); --签名
    self.textGoldCoin = self:Child("aboutPersonalMessage/imgGoldCoin/textGoldCoin"); --金币
    self.textGoldYuanBao = self:Child("aboutPersonalMessage/imgYuanBao/textGoldYuanBao"); --元宝
    self.textGoldFangKa = self:Child("aboutPersonalMessage/imgFangKa/textGoldFangKa");    --房卡

end