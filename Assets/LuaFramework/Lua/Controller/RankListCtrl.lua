RankListCtrl = {};
setbaseclass(RankListCtrl, {BaseCtrl})

------------------------------------一些变量-------------------------------------
local roleId = nil                   --玩家id
local index  = nil                   --玩家排名
local playerName = nil               --玩家name
local ZiJiID = nil                 --自己的name
local headImg = nil                  --玩家头像
local goldcoin = nil                 --玩家金币数量
local wing = nil                     --玩家元宝数量
local singleSign = nil     
local RankInfoJinbiList = {}  
local RankInfoYuanbaoList = {} 
local JinBiIndex = nil               --自己的金币排行
local YuanBaoIndex = nil             --自己的元宝排行

------------------------------------启动事件-------------------------------------
function RankListCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self,obj);
	self:AddClickNoChange(RankListPanel.btnCloseMask, self.OnCloseMaskBtnClick);
	self:AddClick(RankListPanel.btnJinBiPaiHang,self.OnPaiHangBtnClick)
	self:AddClick(RankListPanel.btnYanBaoPaiHang,self.OnPaiHangBtnClick)
	self:AddClick(RankListPanel.btnBack,self.OnQuitBtnClick)   --这里是退出按钮
	self:AddClick(RankListPanel.btnBackTanChuang,self.OnBackTanKuangClick)
	self:AddClickNoChange(RankListPanel.btnAboutMask,self.OnBackTanKuangClick)
	obj.transform.localPosition = Vector3.New(0,90,0);
    RankListPanel.aboutPersonalMessage:SetActive(false)   --玩家信息弹窗
    RankListPanel.imgJinBiPaiHang:SetActive(true)
    RankListPanel.imgYuanBaoPaiHang:SetActive(false)  --默认显示设置
    BlockLayerCtrl:UsualOpen("BlockLayer")            --打开转圈标记
      
    self:RankInfoReq()                                --排行榜请求
    RankListPanel.rankParentJinBi:SetActive(true)
	RankListPanel.rankParentYuanBao:SetActive(false)
    selfRankMasg = {}
    self:RankInfoReq2()
end

----------------------------------------初始化面板-----------------------------------------
function RankListCtrl:InitPanel(info)
	local image	= RankListPanel.imgHeadIcon
	local sprite = info.image:GetComponent("Image").sprite                   --玩家头像设为主界面的头像,在MainsenceCtrl里调用
	weChatFunction.GetSprite(image,sprite)                 
	self:SetText(RankListPanel.txtXiJiYuanBaoNumber,tostring(info.wing))     --元宝
    self:SetText(RankListPanel.txtZiJiJinBiNumber,tostring(info.goldcoin))   --金币
    self:SetText(RankListPanel.textZiJiName,info.name)
    ZiJiID = info.roleId
                        --name
    if info.onTheList == true then

	    self:SetText(RankListPanel.textZiJiId,info.index)             --Id
    else
	  	self:SetText(RankListPanel.textZiJiId,'未上榜')
    end
end

--------------------------------排行榜信息的请求,放在OnCreate里面------------------------------
function RankListCtrl.OnCloseMaskBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = RankListCtrl;
	self:Close();
end


function RankListCtrl.RankInfoReq()
	local paihangInfo = RankingOrder_pb.RankingReq() --向服务器请求数据
	paihangInfo.rankType = 1                         --排行类型,1是金币排行,2是元宝排行,默认金币排行
	local msg = paihangInfo:SerializeToString()
	Game.SendProtocal(Protocal.RankList, msg)
end

function RankListCtrl.RankInfoReq2()
	local paihangInfo = RankingOrder_pb.RankingReq() --向服务器请求数据
	paihangInfo.rankType = 2                         --排行类型,1是金币排行,2是元宝排行,默认金币排行
	local msg = paihangInfo:SerializeToString()
	Game.SendProtocal(Protocal.RankList, msg)
end



--------------------------------------金币排行设置玩家信息--------------------------------------
function RankListCtrl.RankInfo(objs)
	--for i = 1, #RankInfoJinbiList do
 	--	RankInfoJinbiList[i]:Destroy()
	--end
	--RankInfoJinbiList = {}

	local parent = RankListPanel.rankParentJB.transform
	local self = RankListCtrl
	for i,v in ipairs(selfRankMasg[1]) do         --1代表按金币排行信息 
		roleId = v.roleId 
		index  = v.index                    --玩家排名
		playerName = v.name                 --玩家name
		headImg = v.headImg                 --玩家头像
		goldcoin = v.goldcoin               --玩家金币数量
		wing = v.wing                       --玩家元宝数量
        singleSign = v.singleSign           --玩家签名
		--生成预制--
		local go = newObject(objs[0])
		go.name = v.roleId                     
		go.transform:SetParent(parent)
		go.transform.localScale = Vector3.one
		go.transform.localPosition = Vector3.zero
		self:RemoveClick(go)
		self:AddClick(go,self.RankPersonDetailClick)   --给这个预制体加一个点击事件
		--获取组件--
		local imgHead  			= RankListPanel:GOChild(go,"imgHeadIcon")
		local textNiCheng    	= RankListPanel:GOChild(go,"textNiCheng")
		local textgoldcoin      = RankListPanel:GOChild(go,"textPerGoldCoinNumber")
		local textPaiMing       = RankListPanel:GOChild(go,"textPaiMing")
		local imgOne            = RankListPanel:GOChild(go,"imgHuangGuanOne")
		local imgTwo            = RankListPanel:GOChild(go,"imgHuangGuanTwo")
		local imgThree          = RankListPanel:GOChild(go,"imgHuangGuanThree")
		local imgJin            = RankListPanel:GOChild(go,"imgJinKuang")
		local imgYin            = RankListPanel:GOChild(go,"imgYinKuang")
		local imgTong           = RankListPanel:GOChild(go,"imgTongKuang")
		local imgLow            = RankListPanel:GOChild(go,"imgLowKuang")
		--设置玩家信息--	
        self:SetText(textNiCheng,playerName)
        self:SetText(textgoldcoin,goldcoin)
        self:SetText(textPaiMing,index)
        if roleId == ZiJiID then
	          self:SetText(RankListPanel.textZiJiId,index)  
	          JinBiIndex = index          --Id
        end
        --weChatFunction.SetPic(headImg,roleId,global.userVo.headImg)       --设为微信头像
        if(AppConst.getCurrentPlatform() == "PC") then                      --如果是pc端
		    local url = "https://ps.ssl.qhimg.com/t01e9783b7417515cc0.jpg"
		    weChatFunction.SetPic(imgHead,roleId,url)
	    else                                                                --如果不是pc端
		    weChatFunction.SetPic(imgHead,roleId,headImg)
	    end
	    --设置皇冠的显示--
	    if index == 1 then
          imgOne:SetActive(true)
          imgTwo:SetActive(false)
          imgThree:SetActive(false)
          imgJin:SetActive(true)
          imgYin:SetActive(false)
          imgTong:SetActive(false)
          imgLow:SetActive(false)
        elseif index == 2 then
          imgOne:SetActive(false)
          imgTwo:SetActive(true)
          imgThree:SetActive(false)
          imgJin:SetActive(false)
          imgYin:SetActive(true)
          imgTong:SetActive(false)
          imgLow:SetActive(false)
        elseif index == 3 then
          imgOne:SetActive(false)
          imgTwo:SetActive(false)
          imgThree:SetActive(true)
          imgJin:SetActive(false)
          imgYin:SetActive(false)
          imgTong:SetActive(true)
          imgLow:SetActive(false)
        else
          imgOne:SetActive(false)
          imgTwo:SetActive(false)
          imgThree:SetActive(false)
          imgJin:SetActive(false)
          imgYin:SetActive(false)
          imgTong:SetActive(false)
          imgLow:SetActive(true)
        end
        --table.insert(RankInfoJinbiList,go)
	end
	BlockLayerCtrl:Close()          --加载完成后关闭转圈
end

------------------------------------------元宝排行设置玩家信息-----------------------------------
function RankListCtrl.RankYuanBaoInfo(objs)
	--for i = 1, #RankInfoYuanbaoList do
 	--	RankInfoYuanbaoList[i]:Destroy()
	--end
	--RankInfoYuanbaoList = {}

	local parent = RankListPanel.rankParentYB.transform
	local self = RankListCtrl
	for i,v in ipairs(selfRankMasg[2]) do         --2代表按元宝排行信息 
		roleId = v.roleId 
		index  = v.index                    --玩家排名
		playerName = v.name                 --玩家name
		headImg = v.headImg                 --玩家头像
		goldcoin = v.goldcoin               --玩家金币数量
		wing = v.wing                       --玩家元宝数量
		singleSign = v.singleSign           --玩家签名
		--生成预制--
		local go = newObject(objs[0])
		go.name = v.roleId                          --玩家的id
		go.transform:SetParent(parent)
		go.transform.localScale = Vector3.one
		go.transform.localPosition = Vector3.zero
		self:RemoveClick(go)                                                       
		self:AddClick(go,self.RankPersonDetailClick)   --给这个预制体加一个点击事件
		--获取组件--
		local imgHead  			= RankListPanel:GOChild(go,"imgHeadIcon")
		local textNiCheng    	= RankListPanel:GOChild(go,"textNiCheng")
		local textYuanBao       = RankListPanel:GOChild(go,"textPerGoldCoinNumber")
		local textPaiMing       = RankListPanel:GOChild(go,"textPaiMing")
		local imgOne            = RankListPanel:GOChild(go,"imgHuangGuanOne")
		local imgTwo            = RankListPanel:GOChild(go,"imgHuangGuanTwo")
		local imgThree          = RankListPanel:GOChild(go,"imgHuangGuanThree")
		local imgJin            = RankListPanel:GOChild(go,"imgJinKuang")
		local imgYin            = RankListPanel:GOChild(go,"imgYinKuang")
		local imgTong           = RankListPanel:GOChild(go,"imgTongKuang")
		local imgLow            = RankListPanel:GOChild(go,"imgLowKuang")
		--设置玩家信息--	
        self:SetText(textNiCheng,playerName)
        self:SetText(textYuanBao,wing)
        self:SetText(textPaiMing,index)

        if roleId == ZiJiID then                     --Id
	          YuanBaoIndex = index
	     end
        --weChatFunction.SetPic(headImg,roleId,global.userVo.headImg)       --设为微信头像
        if(AppConst.getCurrentPlatform() == "PC") then                      --如果是pc端
		    local url = "https://ps.ssl.qhimg.com/t01e9783b7417515cc0.jpg"
		    weChatFunction.SetPic(imgHead,roleId,url)
	    else                                                                --如果不是pc端
		    weChatFunction.SetPic(imgHead,roleId,headImg)
	    end
	    --设置皇冠的显示--
	    if index == 1 then
          imgOne:SetActive(true)
          imgTwo:SetActive(false)
          imgThree:SetActive(false)
          imgJin:SetActive(true)
          imgYin:SetActive(false)
          imgTong:SetActive(false)
          imgLow:SetActive(false)
        elseif index == 2 then
          imgOne:SetActive(false)
          imgTwo:SetActive(true)
          imgThree:SetActive(false)
          imgJin:SetActive(false)
          imgYin:SetActive(true)
          imgTong:SetActive(false)
          imgLow:SetActive(false)
        elseif index == 3 then
          imgOne:SetActive(false)
          imgTwo:SetActive(false)
          imgThree:SetActive(true)
          imgJin:SetActive(false)
          imgYin:SetActive(false)
          imgTong:SetActive(true)
          imgLow:SetActive(false)
        else
          imgOne:SetActive(false)
          imgTwo:SetActive(false)
          imgThree:SetActive(false)
          imgJin:SetActive(false)
          imgYin:SetActive(false)
          imgTong:SetActive(false)
          imgLow:SetActive(true)
        end
        --table.insert(RankInfoYuanbaoList,go)
	end
end

-----------------------------------------排行榜回调----------------------------------------------
function RankListCtrl.RankInfoRes(buffer)
	local self = RankListCtrl
	local data = buffer:ReadBuffer()
	local msg  = RankingOrder_pb.RankingRes()	
	msg:ParseFromString(data)

	local rankType = msg.rankType          --排行榜的类型,1金币,2元宝
	local rankMasg = {}
	rankMasg = msg.rankingUserInfoList     --rankMasg里存的发送来的用户的信息列表,可以有很多个用户
  
  	if #rankMasg == 0 then
		if rankType == 1 then
			selfRankMasg[rankType] = nil
			--JinBiIndex = msg.ranking
		elseif rankType == 2 then
			selfRankMasg[rankType] = nil
			--YuanBaoIndex=msg.ranking
		end
		--关闭阻挡层
		BlockLayerCtrl:Close()
		return
	end
	if rankType == 1 then 
		selfRankMasg[rankType] = rankMasg  --selfRankMasg[1]
		resMgr:LoadPrefab('ranklist',{'personJinBi'},self.RankInfo)
    end
    if rankType == 2 then
		selfRankMasg[rankType] = rankMasg  --selfRankMasg[2]
		resMgr:LoadPrefab('ranklist',{'personYuanBao'},self.RankYuanBaoInfo)
    end                      
end


--------------------------点击排行榜的金币和元宝按钮-----------------------------
function RankListCtrl.OnPaiHangBtnClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	local self = RankListCtrl
	if go.name == "btnJinBiPaiHang" then                              
       RankListPanel.imgJinBiPaiHang:SetActive(true)
       RankListPanel.imgYuanBaoPaiHang:SetActive(false)
           if JinBiIndex~=nil then
	            self:SetText(RankListPanel.textZiJiId,JinBiIndex)             --Id
           else
	  	        self:SetText(RankListPanel.textZiJiId,'未上榜')
	  	   end
	   RankListPanel.rankParentJinBi:SetActive(true)
	   RankListPanel.rankParentYuanBao:SetActive(false)  
	   --self:RankInfoReq() 
	end
	if go.name == "btnYanBaoPaiHang" then
       RankListPanel.imgJinBiPaiHang:SetActive(false)
       RankListPanel.imgYuanBaoPaiHang:SetActive(true)
           if YuanBaoIndex~=nil then
	            self:SetText(RankListPanel.textZiJiId,YuanBaoIndex)             --Id
           else
	  	        self:SetText(RankListPanel.textZiJiId,'未上榜')
	  	   end
	   RankListPanel.rankParentJinBi:SetActive(false)
	   RankListPanel.rankParentYuanBao:SetActive(true)
	   --self:RankInfoReq2()
    end
end


-------------------------------点击返回按钮--------------------------------------
function RankListCtrl.OnQuitBtnClick(go)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = RankListCtrl;
	self:Close('RankList');
end

-------------------------------查看单个玩家信息----------------------------------
function RankListCtrl.RankPersonDetailClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	RankListPanel.aboutPersonalMessage:SetActive(true)
	local self = RankListCtrl
	print("**************************************************************")
	print(go.name)   --根据这个id向服务端请求玩家信息
	print("**************************************************************")
    
    local data   = RankingRoleInfo_pb.RankingRoleInfoReq()
    data.roleId  = go.name
    local msg    = data:SerializeToString()
    Game.SendProtocal(Protocal.RankRoleInfo, msg)
    
end
 
--查看单个玩家信息消息返回
function RankListCtrl.RankingRoleInfoRes(buffer)
	local self      = RankListCtrl
    local data      = buffer:ReadBuffer()
    local msg       = RankingRoleInfo_pb.RankingRoleInfoRes()  
    msg:ParseFromString(data)

	local imgOtherHead = msg.headImg
	local textOtherName = msg.name
	local textOtherId = msg.roleId
	local sex = msg.gender
	local textQianMing = msg.singleSign
	local textGoldCoin = msg.goldcoin
	local textGoldYuanBao = msg.wing
	local textGoldFangKa = msg.diamond

	self:SetText(RankListPanel.textOtherName,textOtherName)
	self:SetText(RankListPanel.textOtherId,textOtherId)
	self:SetText(RankListPanel.textQianMing,textQianMing)
	self:SetText(RankListPanel.textGoldCoin,textGoldCoin)
	self:SetText(RankListPanel.textGoldYuanBao,textGoldYuanBao)
	self:SetText(RankListPanel.textGoldFangKa,textGoldFangKa)
    
    if sex == 1 then --1男，2女
    	RankListPanel.imgSexMan:SetActive(true)
    	RankListPanel.imgSexWomen:SetActive(false)
    else
    	RankListPanel.imgSexMan:SetActive(false)
    	RankListPanel.imgSexWomen:SetActive(true)
    end 
    
    if(AppConst.getCurrentPlatform() == "PC") then                      --如果是pc端
		local url = "https://ps.ssl.qhimg.com/t01e9783b7417515cc0.jpg"
		weChatFunction.SetPic(RankListPanel.imgOtherHead,roleId,url)
	else                                                                --如果不是pc端
		weChatFunction.SetPic(RankListPanel.imgOtherHead,roleId,imgOtherHead)
	end

end



----------------------------------弹框的返回按钮---------------------------------------
function RankListCtrl.OnBackTanKuangClick()
	Game.MusicEffect(Game.Effect.joinRoom)
	RankListPanel.aboutPersonalMessage:SetActive(false)
end

