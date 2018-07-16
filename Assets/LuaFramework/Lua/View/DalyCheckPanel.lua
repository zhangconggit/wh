--文件：活动界面
DalyCheckPanel = {};
setbaseclass(DalyCheckPanel, {BasePanel})

function DalyCheckPanel:InitPanel()

    --签到按钮
    --self.btnCheck    = self:Child("btnCheck"); 
    self.btnCheckOne    = self:Child("imgMaskOne/imgDayOne/imgOne");
    self.btnCheckTwo    = self:Child("imgMaskTwo/imgDayTwo/imgTwo");
    self.btnCheckThree    = self:Child("imgMaskThree/imgDayThree/imgThree");
    self.btnCheckFour    = self:Child("imgMaskFour/imgDayFour/imgFour");
    self.btnCheckFive    = self:Child("imgMaskFive/imgDayFive/imgFive");
    self.btnCheckSix    = self:Child("imgMaskSix/imgDaySix/imgSix");
    self.btnCheckSeven    = self:Child("imgMaskSeven/imgDaySeven/imgSeven");
    self.btnDalyMask    = self:Child("DalymaskBg");

    --返回按钮                       
	self.btnBack     = self:Child("btnBack");


    --周一到周日的遮罩标记,需要签到的时候关闭,其他的时候打开
	self.imgMaskOne    = self:Child("imgMaskOne/imgDayOne");
	self.imgMaskTwo    = self:Child("imgMaskTwo/imgDayTwo");
	self.imgMaskThree  = self:Child("imgMaskThree/imgDayThree");
	self.imgMaskFour   = self:Child("imgMaskFour/imgDayFour");
	self.imgMaskFive   = self:Child("imgMaskFive/imgDayFive");
	self.imgMaskSix    = self:Child("imgMaskSix/imgDaySix");
	self.imgMaskSeven  = self:Child("imgMaskSeven/imgDaySeven");

    self.imgYiLingOne    = self:Child("imgMaskOne/imgDuiHaoOne");
    self.imgYiLingTwo    = self:Child("imgMaskTwo/imgDuiHaoTwo");
    self.imgYiLingThree    = self:Child("imgMaskThree/imgDuiHaoThree");
    self.imgYiLingFour    = self:Child("imgMaskFour/imgDuiHaoFour");
    self.imgYiLingFive    = self:Child("imgMaskFive/imgDuiHaoFive");
    self.imgYiLingSix    = self:Child("imgMaskSix/imgDuiHaoSix");
    self.imgYiLingSeven    = self:Child("imgMaskSeven/imgDuiHaoSeven");

    self.imgWeiLingOne    = self:Child("imgMaskOne/imgWeiLing");
    self.imgWeiLingTwo    = self:Child("imgMaskTwo/imgWeiLing");
    self.imgWeiLingThree    = self:Child("imgMaskThree/imgWeiLing");
    self.imgWeiLingFour    = self:Child("imgMaskFour/imgWeiLing");
    self.imgWeiLingFive    = self:Child("imgMaskFive/imgWeiLing");
    self.imgWeiLingSix    = self:Child("imgMaskSix/imgWeiLing");
    self.imgWeiLingSeven    = self:Child("imgMaskSeven/imgWeiLing");



end
