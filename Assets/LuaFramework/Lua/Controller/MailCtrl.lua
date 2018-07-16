MailCtrl = {};
setbaseclass(MailCtrl,{BaseCtrl});

local playerName = nil
local goods = nil
local number = nil
local time = nil
local roleId = nil
local imgHead = nil
local selfMailMesg = {}
--启动事件--
function MailCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj);
	self:AddClick(MailPanel.btnBack, self.OnBackBtnClick);
  self:AddClick(MailPanel.btnGetAll,self.OnGetAllBtnClick);
	self:InitPanel();	 
end


--初始化界面
function MailCtrl:InitPanel()
   self:MailInfoReq();               --打开邮件后向服务器发送请求mail的信息
end
------------------------------------向服务端请求mail数据-----------------------
function MailCtrl:MailInfoReq()
  local msg = ""
  Game.SendProtocal(Protocal.MailInfo, msg)
end

-----------------------------------服务端数据返回------------------------------
function MailCtrl:MailInfoRes(buffer)
  local self = MailCtrl
  local data = buffer:ReadBuffer()
  local msg  = LoadMailList_pb.LoadMailListRes() 
  msg:ParseFromString(data)

  selfMailMesg = {msg.playerName,msg.goods,msg.time,msg.number,msg.roleId,msg.imgHead}
  resMgr:LoadPrefab('mailper',{'mail'},self.MailInfo)
end

---------------------------------------------------------------------------
function MailCtrl.MailInfo(objs)
  local parent = MailPanel.grid.transform
  local self = MailCtrl
  for i,v in ipairs(selfMailMesg) do
      local playerName = v.playerName
      local roleId     = v.roleId
      local goods      = v.goods --字符串
      local number     = v.number
      local time       = v.time
      local imgHead    = v.imgHead

      local go = newObject(objs[0])
      go.name = v.roleId                     
      go.transform:SetParent(parent)
      go.transform.localScale = Vector3.one
      go.transform.localPosition = Vector3.zero   

      local btnGet = MailPanel:GOChild(go,"btnGet")
      local textName = MailPanel:GOChild(go,"textName")
      local textLeftTime = MailPanel:GOChild(go,"time/textLeftTime")
      local imgHeadIcon = MailPanel:GOChild(go,"imgHead")
      local textGoods = MailPanel:GOChild(go,"goods/textGoods")
      local numberOfGoods =number
      self:RemoveClick(btnGet)
      self:AddClick(btnGet,self.OnGetGoodsClick)   --给这个预制体加一个点击事件
      
      self:SetText(textName,playerName)     --显示name
      self:SetText(textLeftTime,time)       --邮件发来的时间
      self:SetText(textGoods,"玩家"..playerName.."送给你"..numberOfGoods..goods)

      if(AppConst.getCurrentPlatform() == "PC") then                      --如果是pc端
        local url = "https://ps.ssl.qhimg.com/t01e9783b7417515cc0.jpg"
        weChatFunction.SetPic(imgHeadIcon,roleId,url)
      else                                                                --如果不是pc端
        weChatFunction.SetPic(imgHeadIcon,roleId,imgHead)
      end

  end
end


------------------------------------点击邮件上的获取按钮----------------------
function MailCtrl:OnGetGoodsClick(go)
  Game.MusicEffect(Game.Effect.joinRoom)
  --点击获取按钮向服务器发送请求获取信息把id传过去
  self.localId = go.name
  --发送向服务端请求领取邮件内物品的数据
end




---------------------------------一键获取按钮按钮------------------------------
function MailCtrl:OnGetAllBtnClick()
  Game.MusicEffect(Game.Effect.joinRoom)
  
end

--------------------------------------返回按钮---------------------------------
function MailCtrl:OnBackBtnClick()
  Game.MusicEffect(Game.Effect.joinRoom)
   local self = MailCtrl
   self:Close()
end
