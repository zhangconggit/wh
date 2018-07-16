DalyCheckCtrl = {};
setbaseclass(DalyCheckCtrl,{BaseCtrl});

--启动事件--
function DalyCheckCtrl:OnCreate(obj)
   --if valueByBool==false then
	    BaseCtrl.OnCreate(self, obj);
	  --self:AddClick(DalyCheckPanel.btnCheck, self.OnCheckBtnClick);	
    self:AddClick(DalyCheckPanel.btnCheckOne, self.OnCheckBtnClick);  
    self:AddClick(DalyCheckPanel.btnCheckTwo, self.OnCheckBtnClick);
    self:AddClick(DalyCheckPanel.btnCheckThree, self.OnCheckBtnClick);
    self:AddClick(DalyCheckPanel.btnCheckFour, self.OnCheckBtnClick);
    self:AddClick(DalyCheckPanel.btnCheckFive, self.OnCheckBtnClick);
    self:AddClick(DalyCheckPanel.btnCheckSix, self.OnCheckBtnClick);
    self:AddClick(DalyCheckPanel.btnCheckSeven, self.OnCheckBtnClick);

    self:AddClickNoChange(DalyCheckPanel.btnDalyMask, self.OnBackBtnClick);
    self:AddClick(DalyCheckPanel.btnBack,self.OnBackBtnClick);  
	  self:InitPanel();	
     -- MessageTipsCtrl:ShowInfo("今天您已经签到过了，请明天再来！")
end


--初始化界面
function DalyCheckCtrl:InitPanel()
    self.tableZheZhao = {DalyCheckPanel.imgMaskOne,DalyCheckPanel.imgMaskTwo,
                      DalyCheckPanel.imgMaskThree,DalyCheckPanel.imgMaskFour,
                      DalyCheckPanel.imgMaskFive,DalyCheckPanel.imgMaskSix,
                      DalyCheckPanel.imgMaskSeven}

     self.tableWeiLing = {DalyCheckPanel.imgWeiLingOne,DalyCheckPanel.imgWeiLingTwo,
                      DalyCheckPanel.imgWeiLingThree,DalyCheckPanel.imgWeiLingFour,
                      DalyCheckPanel.imgWeiLingFive,DalyCheckPanel.imgWeiLingSix,
                      DalyCheckPanel.imgWeiLingSeven}

     self.tableYiLing = {DalyCheckPanel.imgYiLingOne,DalyCheckPanel.imgYiLingTwo,
                      DalyCheckPanel.imgYiLingThree,DalyCheckPanel.imgYiLingFour,
                      DalyCheckPanel.imgYiLingFive,DalyCheckPanel.imgYiLingSix,
                      DalyCheckPanel.imgYiLingSeven}                 

    --初始化的时候显示已签到的遮罩
     local n = tonumber(global.userVo.signDays) 
     for i=1,n,1 do
       self.tableZheZhao[i]:SetActive(false)
       self.tableYiLing[i]:SetActive(true)
     end
     --初始化的时候显示待签到的遮罩
     print(global.userVo.isSign)
    if global.userVo.isSign == false then
     --if n+2<=7 then
        for i=n+2,7,1 do
         self.tableZheZhao[i]:SetActive(false)  
         self.tableWeiLing[i]:SetActive(true)
        end
      --end
    else
        for i=n+1,7,1 do
         self.tableZheZhao[i]:SetActive(false)  
         self.tableWeiLing[i]:SetActive(true)
        end      
    end
end



--点击每日签到
--点击签到发送签到请求
function DalyCheckCtrl.OnCheckBtnClick()
  local self = DalyCheckCtrl
	--Game.MusicEffect(Game.Effect.joinRoom)
  local msg = ""
  Game.SendProtocal(Protocal.DalyCheck, msg)
end

--服务器返回
function DalyCheckCtrl.OnCheckRes(buffer)
  --签到消息返回并做出响应表现
  local self = DalyCheckCtrl
  local data = buffer:ReadBuffer()
  local msg  = ShareSign_pb.SignRes()  
  msg:ParseFromString(data)
  
  local ReardType = msg.type          --0 谢谢参与 1金币 2元宝 3房卡 4物品
  local itemID    = msg.itemID        --此处填写具体的物品ID
  local quantity  = msg.quantity      --奖励物品的数量
  local isSign    = msg.isSign        --今天是否签到 true 已签到 false 未签到
  
 
  --玩家点击签到的时候，服务端告诉你今天是否已经签到
  --如果还没签到，那么签到并且签到天数加1
  --如果已经签到就returen
  print("-------------------------签到消息返回并做出响应表现------------------------------",isSign)
  if isSign == false then  
    global.userVo.signDays = global.userVo.signDays + 1 
  else
    self.tableZheZhao[global.userVo.signDays]:SetActive(false)
    self.tableYiLing[global.userVo.signDays]:SetActive(true)
    MessageTipsCtrl:ShowInfo("今天您已经签到过了，请明天再来！")
    return
  end 

  --前面判定还没签到，继续往下走
  for i=1,global.userVo.signDays,1 do
    print("-----------------------------------前面判定还没签到，继续往下走---------------------------------",i,global.userVo.signDays)
    --self.tableZheZhao[i]:SetActive(false)
    --self.tableYiLing[i]:SetActive(true)
  end
  if ReardType == 0 then
    MessageTipsCtrl:ShowInfo("谢谢参与")
  elseif ReardType == 1 then
    MessageTipsCtrl:ShowInfo("恭喜你获得金币*"..quantity)
  elseif ReardType == 2 then
    MessageTipsCtrl:ShowInfo("恭喜你获得元宝*"..quantity)
  elseif ReardType == 3 then
    MessageTipsCtrl:ShowInfo("恭喜你获得房卡*"..quantity)
  end
  global.userVo.isSign = true
end

--点击返回按钮
function DalyCheckCtrl.OnBackBtnClick(go)
  --Game.MusicEffect(Game.Effect.buttonBack)
  local self = DalyCheckCtrl
  self:Close()
end