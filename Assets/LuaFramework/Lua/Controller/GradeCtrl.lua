--文件：查看战绩界面控制

GradeCtrl = {}
setbaseclass(GradeCtrl, {BaseCtrl})

local gradeDetailType = nil
local selfGradeMasg = nil
local DradeObjList = nil
--启动事件--
function GradeCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj)

	self:AddClick(GradePanel.btnQuit,self.BtnQuit);
    self:AddClick(GradePanel.btnShop,self.OnShopBtnClick);

    self:AddOnValueChanged(GradePanel.btnJinBi , self.OnJinBiBtnClick);
	self:AddOnValueChanged(GradePanel.btnYuanBao , self.OnYuanBaoBtnClick);
	self:AddOnValueChanged(GradePanel.btnFangKa , self.OnFangKaBtnClick);


	--self:AddOnValueChanged(GradePanel.togZhajinhua , self.OntogZhajinhuaClick);
	--self:AddOnValueChanged(GradePanel.togNiuniu , self.OntogNiuniuClick);
	gradeDetailType = 2
	DradeObjList = {}
	selfGradeMasg = {}
	self:InitPanel()
	self:ZhanJiInfoReq()
end

--初始化面板--
function GradeCtrl:InitPanel(objs)
    --申请苹果审核
    if IS_APP_STORE_CHECK then

    end
	GradePanel.txtNull:SetActive(false)
	GradePanel.imgMask:SetActive(false)
end

--发送请求战绩的信息--
function GradeCtrl:ZhanJiInfoReq()
	--打开阻挡层
	BlockLayerCtrl:UsualOpen("BlockLayer")
	local zhanjiInfo = ZhanJiInfo_pb.ZhanJiInfoReq()
	zhanjiInfo.pageNum = 1
	zhanjiInfo.moneyType = 2
	local msg = zhanjiInfo:SerializeToString()
	Game.SendProtocal(Protocal.ZhanJiInfo, msg)
end
--关闭事件--
function GradeCtrl.BtnQuit(obj)
	Game.MusicEffect(Game.Effect.buttonBack)
	local self = GradeCtrl
	MainSencePanel.btnS:SetActive(true)                --这句不可少
    MainSencePanel.ChooseRoom:SetActive(false)         
	NoticeTipsCtrl:Open('NoticeTips')                  --打开消息提示
	MainSencePanel.fartherOfMainSence:SetActive(true)  --显示一级界面部分内容
	self:Close('Grade')
	GradeDetailCtrl:Close('GradeDetail')
end

--金币战绩测试--
function GradeCtrl.GradeJinBiInfo(objs)
	local parent = GradePanel.gridJinBiParent.transform
	local self = GradeCtrl
	for i,v in ipairs(selfGradeMasg[gradeDetailType]) do
		local id = v.id
		local roomNum = v.roomNum
		local startTime = getTimeFormat(v.startTime)
		local info = v.zhanjiInfo
		local gameType = v.gameType 
		--local numberTable = { } 可以将自定编号为键,服务器传递的id为值,在游戏界面中显示键,搜索时向服务器发送值...
		--生成预制--
		local go = newObject(objs[0])
		go.name = id
		go.transform:SetParent(parent)
		go.transform.localScale = Vector3.one
		go.transform.localPosition = Vector3.zero
		DradeObjList[id] = go

		--获取组件--
		local imgWin 			= GradePanel:GOChild(go,"imgWin")
		local imgLose 			= GradePanel:GOChild(go,"imgLose")
		local imgDraw 			= GradePanel:GOChild(go,"imgDraw")

		local imgHuaShui 			= GradePanel:GOChild(go,"imgHuaShui")
		local imgZhaJinHua 			= GradePanel:GOChild(go,"imgZhaJinHua")
		local imgNiuNiu 			= GradePanel:GOChild(go,"imgNiuNiu")
		local imgRed 			    = GradePanel:GOChild(go,"imgRed")
		local imgZhuoMaZi 			= GradePanel:GOChild(go,"imgZhuoMaZi")
		local imgTenHalf 			= GradePanel:GOChild(go,"imgTenHalf")
		local imgWuZiQi 			= GradePanel:GOChild(go,"imgWuZiQi")
		--local txtRoomNum 		= GradePanel:GOChild(go,"txtRoomNum")
		local txtTime 			= GradePanel:GOChild(go,"txtTime")
		local txtNum 			= GradePanel:GOChild(go,"imgNum/txtNum")
		
		--赋值信息--
		--self:SetText(txtRoomNum,roomNum)
		self:SetText(txtTime,startTime)
        self:SetText(txtNum ,'编号 : '..id)

		txtPlayerName1 = GradePanel:GOChild(go,"txtPlayerName1")
		txtPlayerName2 = GradePanel:GOChild(go,"txtPlayerName2")
		txtPlayerName3 = GradePanel:GOChild(go,"txtPlayerName3")
		txtPlayerName4 = GradePanel:GOChild(go,"txtPlayerName4")
		txtPlayerName5 = GradePanel:GOChild(go,"txtPlayerName5")
		txtPlayerName6 = GradePanel:GOChild(go,"txtPlayerName6")

		txtPlayerFen1 = GradePanel:GOChild(go,"txtPlayerName1/txtPlayerFen1")
		txtPlayerFen2 = GradePanel:GOChild(go,"txtPlayerName2/txtPlayerFen2")
		txtPlayerFen3 = GradePanel:GOChild(go,"txtPlayerName3/txtPlayerFen3")
		txtPlayerFen4 = GradePanel:GOChild(go,"txtPlayerName4/txtPlayerFen4")
		txtPlayerFen5 = GradePanel:GOChild(go,"txtPlayerName5/txtPlayerFen5")
		txtPlayerFen6 = GradePanel:GOChild(go,"txtPlayerName6/txtPlayerFen6")

		if gameType == 1 then
			    imgHuaShui:SetActive(true)
		elseif gameType == 2 then
				imgTenHalf:SetActive(true)
		elseif gameType == 3 then
				imgZhaJinHua:SetActive(true)
		elseif gameType == 4 then
				imgZhuoMaZi:SetActive(true)
		elseif gameType == 5 then
				imgNiuNiu:SetActive(true)
		elseif gameType == 6 then
				imgWuZiQi:SetActive(true)
		elseif gameType == 7 then
				imgRed:SetActive(true)
		elseif gameType == 9 then
				imgXueZhan:SetActive(true)
		else
				imgXueZhan:SetActive(true)
		end

		self:SetText(txtPlayerName1,info.jifen)
		local txtPlayerNameList = {txtPlayerName1,txtPlayerName2,txtPlayerName3,txtPlayerName4,txtPlayerName5,txtPlayerName6}
		local txtPlayerFenList = {txtPlayerFen1,txtPlayerFen2,txtPlayerFen3,txtPlayerFen4,txtPlayerFen5,txtPlayerFen6}
		--缩短名字--
		for j = 1,#info do
			if info[j].name == nil then
				self:SetText(txtPlayerNameList[j],"")	
			else
				if info[j].jifen > 0 then
					self:SetText(txtPlayerNameList[j],self:GetShortName(6,info[j].name) ..':')
					self:SetText(txtPlayerFenList[j],"<color=#b41818><size=18>"..'+'..info[j].jifen .. "</size></color>")
				elseif info[j].jifen < 0 then
					self:SetText(txtPlayerNameList[j],self:GetShortName(6,info[j].name) ..':')	
					self:SetText(txtPlayerFenList[j],"<color=#318c09><size=18>"..info[j].jifen .. "</size></color>")
			    elseif	info[j].jifen == 0 then
			    	self:SetText(txtPlayerNameList[j],self:GetShortName(6,info[j].name) ..':')
					self:SetText(txtPlayerFenList[j],"<color=#8B4232><size=18>"..info[j].jifen .. "</size></color>")
				end	
			end
		end
		
		--显示输赢--
		for j = 1, #info  do
			if global.userVo.roleId == info[j].roleId then
				if(info[j].jifen > 0) then
					imgLose:SetActive(false)
					imgDraw:SetActive(false)
				elseif(info[j].jifen < 0) then
					imgWin:SetActive(false)
					imgDraw:SetActive(false)
				else
					imgLose:SetActive(false)
					imgWin:SetActive(false)
				end
			end
		end
	end
	--关闭阻挡层
	BlockLayerCtrl:Close()
end
--元宝战绩测试
function GradeCtrl.GradeYuanBaoInfo(objs)
	local parent = GradePanel.gridYuanBaoParent.transform
	local self = GradeCtrl
	for i,v in ipairs(selfGradeMasg[gradeDetailType]) do
		local id = v.id
		local roomNum = v.roomNum
		local startTime = getTimeFormat(v.startTime)
		local info = v.zhanjiInfo
		local gameType = v.gameType 
		--local numberTable = { } 可以将自定编号为键,服务器传递的id为值,在游戏界面中显示键,搜索时向服务器发送值...
		--生成预制--
		local go = newObject(objs[0])
		go.name = id
		go.transform:SetParent(parent)
		go.transform.localScale = Vector3.one
		go.transform.localPosition = Vector3.zero
		DradeObjList[id] = go

		--获取组件--
		local imgWin 			= GradePanel:GOChild(go,"imgWin")
		local imgLose 			= GradePanel:GOChild(go,"imgLose")
		local imgDraw 			= GradePanel:GOChild(go,"imgDraw")

		local imgHuaShui 			= GradePanel:GOChild(go,"imgHuaShui")
		local imgZhaJinHua 			= GradePanel:GOChild(go,"imgZhaJinHua")
		local imgNiuNiu 			= GradePanel:GOChild(go,"imgNiuNiu")
		local imgRed 			    = GradePanel:GOChild(go,"imgRed")
		local imgZhuoMaZi 			= GradePanel:GOChild(go,"imgZhuoMaZi")
		local imgTenHalf 			= GradePanel:GOChild(go,"imgTenHalf")
		local imgWuZiQi 			= GradePanel:GOChild(go,"imgWuZiQi")
		--local txtRoomNum 		= GradePanel:GOChild(go,"txtRoomNum")
		local txtTime 			= GradePanel:GOChild(go,"txtTime")
		local txtNum 			= GradePanel:GOChild(go,"imgNum/txtNum")
		
		--赋值信息--
		--self:SetText(txtRoomNum,roomNum)
		self:SetText(txtTime,startTime)
        self:SetText(txtNum ,'编号 : '..id)

		txtPlayerName1 = GradePanel:GOChild(go,"txtPlayerName1")
		txtPlayerName2 = GradePanel:GOChild(go,"txtPlayerName2")
		txtPlayerName3 = GradePanel:GOChild(go,"txtPlayerName3")
		txtPlayerName4 = GradePanel:GOChild(go,"txtPlayerName4")
		txtPlayerName5 = GradePanel:GOChild(go,"txtPlayerName5")
		txtPlayerName6 = GradePanel:GOChild(go,"txtPlayerName6")

		txtPlayerFen1 = GradePanel:GOChild(go,"txtPlayerName1/txtPlayerFen1")
		txtPlayerFen2 = GradePanel:GOChild(go,"txtPlayerName2/txtPlayerFen2")
		txtPlayerFen3 = GradePanel:GOChild(go,"txtPlayerName3/txtPlayerFen3")
		txtPlayerFen4 = GradePanel:GOChild(go,"txtPlayerName4/txtPlayerFen4")
		txtPlayerFen5 = GradePanel:GOChild(go,"txtPlayerName5/txtPlayerFen5")
		txtPlayerFen6 = GradePanel:GOChild(go,"txtPlayerName6/txtPlayerFen6")

		if gameType == 1 then
			    imgHuaShui:SetActive(true)
		elseif gameType == 2 then
				imgTenHalf:SetActive(true)
		elseif gameType == 3 then
				imgZhaJinHua:SetActive(true)
		elseif gameType == 4 then
				imgZhuoMaZi:SetActive(true)
		elseif gameType == 5 then
				imgNiuNiu:SetActive(true)
		elseif gameType == 6 then
				imgWuZiQi:SetActive(true)
		elseif gameType == 7 then
				imgRed:SetActive(true)
		elseif gameType == 9 then
				imgXueZhan:SetActive(true)
		else
				imgXueZhan:SetActive(true)
		end

		self:SetText(txtPlayerName1,info.jifen)
		local txtPlayerNameList = {txtPlayerName1,txtPlayerName2,txtPlayerName3,txtPlayerName4,txtPlayerName5,txtPlayerName6}
		local txtPlayerFenList = {txtPlayerFen1,txtPlayerFen2,txtPlayerFen3,txtPlayerFen4,txtPlayerFen5,txtPlayerFen6}
		--缩短名字--
		for j = 1,#info do
			if info[j].name == nil then
				self:SetText(txtPlayerNameList[j],"")	
			else
				if info[j].jifen > 0 then
					self:SetText(txtPlayerNameList[j],self:GetShortName(6,info[j].name) ..':')
					self:SetText(txtPlayerFenList[j],"<color=#b41818><size=18>"..'+'..info[j].jifen .. "</size></color>")
				elseif info[j].jifen < 0 then
					self:SetText(txtPlayerNameList[j],self:GetShortName(6,info[j].name) ..':')	
					self:SetText(txtPlayerFenList[j],"<color=#318c09><size=18>"..info[j].jifen .. "</size></color>")
			    elseif	info[j].jifen == 0 then
			    	self:SetText(txtPlayerNameList[j],self:GetShortName(6,info[j].name) ..':')
					self:SetText(txtPlayerFenList[j],"<color=#8B4232><size=18>"..info[j].jifen .. "</size></color>")
				end	
			end
		end
		
		--显示输赢--
		for j = 1, #info  do
			if global.userVo.roleId == info[j].roleId then
				if(info[j].jifen > 0) then
					imgLose:SetActive(false)
					imgDraw:SetActive(false)
				elseif(info[j].jifen < 0) then
					imgWin:SetActive(false)
					imgDraw:SetActive(false)
				else
					imgLose:SetActive(false)
					imgWin:SetActive(false)
				end
			end
		end
	end
	--关闭阻挡层
	BlockLayerCtrl:Close()
end

function GradeCtrl.OnShopBtnClick()
	ShopMallCtrl:Open('ShopMall') 
    local self = GradeCtrl
	self:Close('Grade')
	GradeDetailCtrl:Close('GradeDetail')
end
--房卡战绩测试--
function GradeCtrl.GradeCardInfo(objs)
	local parent = GradePanel.gridCardParent.transform
	local self = GradeCtrl
	for i,v in ipairs(selfGradeMasg[gradeDetailType]) do
		local id = v.id
		local roomNum = v.roomNum
		local startTime = getTimeFormat(v.startTime)
		local info = v.zhanjiInfo
        local gameType = v.gameType
		--生成预制--
		local go = newObject(objs[0])
		go.name = id
		
		go.transform:SetParent(parent)
		go.transform.localScale = Vector3.one
		go.transform.localPosition = Vector3.zero
		DradeObjList[id] = go

		--获取组件--
		local btnXiangQing      = GradePanel:GOChild(go,"btnXiangQing")
		btnXiangQing.name = go.name
		local imgWin 			= GradePanel:GOChild(go,"imgWin")
		local imgLose 			= GradePanel:GOChild(go,"imgLose")
		local imgDraw 			= GradePanel:GOChild(go,"imgDraw")
		local txtTime 			= GradePanel:GOChild(go,"txtTime")
        local txtNum 			= GradePanel:GOChild(go,"imgNum/txtNum")

		local imgHuaShui 			= GradePanel:GOChild(go,"imgHuaShui")
		local imgZhaJinHua 			= GradePanel:GOChild(go,"imgZhaJinHua")
		local imgNiuNiu 			= GradePanel:GOChild(go,"imgNiuNiu")
		local imgRed 			    = GradePanel:GOChild(go,"imgRed")
		local imgZhuoMaZi 			= GradePanel:GOChild(go,"imgZhuoMaZi")
		local imgTenHalf 			= GradePanel:GOChild(go,"imgTenHalf")
		local imgWuZiQi 			= GradePanel:GOChild(go,"imgWuZiQi")

		if     gameType == 1 then
			    imgHuaShui:SetActive(true)
		elseif gameType == 2 then
				imgTenHalf:SetActive(true)
		elseif gameType == 3 then
				imgZhaJinHua:SetActive(true)
		elseif gameType == 4 then
				imgZhuoMaZi:SetActive(true)
		elseif gameType == 5 then
				imgNiuNiu:SetActive(true)
		elseif gameType == 6 then
				imgWuZiQi:SetActive(true)
		elseif gameType == 7 then
				imgRed:SetActive(true)
		elseif gameType == 9 then
				imgXueZhan:SetActive(true)
		else
				imgXueZhan:SetActive(true)
		end
					

		
		--local txtRoomNum 		= GradePanel:GOChild(go,"txtRoomNum")
		self:AddClick(btnXiangQing,self.GradeDetailClick)
		--赋值信息--
		--self:SetText(txtRoomNum,roomNum)
		self:SetText(txtTime,startTime)
        self:SetText(txtNum ,'编号 : '..id)

		txtPlayerName1 = GradePanel:GOChild(go,"txtPlayerName1")
		txtPlayerName2 = GradePanel:GOChild(go,"txtPlayerName2")
		txtPlayerName3 = GradePanel:GOChild(go,"txtPlayerName3")
		txtPlayerName4 = GradePanel:GOChild(go,"txtPlayerName4")
		txtPlayerName5 = GradePanel:GOChild(go,"txtPlayerName5")
		txtPlayerName6 = GradePanel:GOChild(go,"txtPlayerName6")

 
		txtPlayerFen1 = GradePanel:GOChild(go,"txtPlayerName1/txtPlayerFen1")
		txtPlayerFen2 = GradePanel:GOChild(go,"txtPlayerName2/txtPlayerFen2")
		txtPlayerFen3 = GradePanel:GOChild(go,"txtPlayerName3/txtPlayerFen3")
		txtPlayerFen4 = GradePanel:GOChild(go,"txtPlayerName4/txtPlayerFen4")
		txtPlayerFen5 = GradePanel:GOChild(go,"txtPlayerName5/txtPlayerFen5")
		txtPlayerFen6 = GradePanel:GOChild(go,"txtPlayerName6/txtPlayerFen6")

		self:SetText(txtPlayerName1,info.jifen)
		local txtPlayerNameList = {txtPlayerName1,txtPlayerName2,txtPlayerName3,txtPlayerName4,txtPlayerName5,txtPlayerName6}
		local txtPlayerFenList = {txtPlayerFen1,txtPlayerFen2,txtPlayerFen3,txtPlayerFen4,txtPlayerFen5,txtPlayerFen6}
		--缩短名字--
		for j = 1,#info do
			if info[j].name == nil then
				self:SetText(txtPlayerNameList[j],"")	
			else
				if info[j].jifen > 0 then
					self:SetText(txtPlayerNameList[j],self:GetShortName(10,info[j].name) ..':')
					self:SetText(txtPlayerFenList[j],"<color=#b41818><size=18>"..'+'..info[j].jifen .. "</size></color>")
				elseif info[j].jifen < 0 then
					self:SetText(txtPlayerNameList[j],self:GetShortName(10,info[j].name) ..':')	
					self:SetText(txtPlayerFenList[j],"<color=#318c09><size=18>"..info[j].jifen .. "</size></color>")
			    elseif	info[j].jifen == 0 then
			    	self:SetText(txtPlayerNameList[j],self:GetShortName(10,info[j].name) ..':')
					self:SetText(txtPlayerFenList[j],"<color=#8B4232><size=18>"..info[j].jifen .. "</size></color>")
				end	
			end
		end
		
		--显示输赢--
		for j = 1, #info  do
			if global.userVo.roleId == info[j].roleId then
				if(info[j].jifen > 0) then
					imgLose:SetActive(false)
					imgDraw:SetActive(false)
				elseif(info[j].jifen < 0) then
					imgWin:SetActive(false)
					imgDraw:SetActive(false)
				else
					imgLose:SetActive(false)
					imgWin:SetActive(false)
				end
			end
		end
	end
	--关闭阻挡层
	BlockLayerCtrl:Close()
end

--查看详细战绩--
function GradeCtrl.GradeDetailClick(go)
	Game.MusicEffect(Game.Effect.joinRoom)
	self = GradeCtrl
	self.clickID = go.name
	self.clickType = gradeDetailType
	GradeDetailCtrl:Open("GradeDetail")
end




--查看战绩回调--
function GradeCtrl.OnZhanJiInfoRes(buffer)
	self = GradeCtrl
	local data   = buffer:ReadBuffer()
	local msg = ZhanJiInfo_pb.ZhanJiInfoRes()
	msg:ParseFromString(data)
	local moneyType = msg.moneyType
	local gradeMasg = {}
	gradeMasg = msg.zhanJiInfo
    


	if #gradeMasg ~= 0 then
	  if moneyType == 0 then
		selfGradeMasg[gradeDetailType] = gradeMasg
		GradePanel.txtNull:SetActive(false)
		resMgr:LoadPrefab('grade',{'gridCardPlayerInfo'},self.GradeCardInfo)
	  elseif  moneyType == 1 then
	  	selfGradeMasg[gradeDetailType] = gradeMasg
		GradePanel.txtNull:SetActive(false)
		resMgr:LoadPrefab('grade',{'gridPlayerInfo'},self.GradeJinBiInfo)
	  elseif  moneyType == 2 then
         selfGradeMasg[gradeDetailType] = gradeMasg
		 GradePanel.txtNull:SetActive(false)
		 resMgr:LoadPrefab('grade',{'gridPlayerInfo'},self.GradeYuanBaoInfo)
	  end	

	else
		selfGradeMasg[gradeDetailType] = nil
		GradePanel.txtNull:SetActive(true)
		--关闭阻挡层
		BlockLayerCtrl:Close()
		return
	end	

end

 --@brief 切割字符串，并用“...”替换尾部
 --@param sName:要切割的字符串
 --@return nMaxCount，字符串上限,中文字为2的倍数
 --@param nShowCount：显示英文字个数，中文字为2的倍数,可为空
 --@note         函数实现：截取字符串一部分，剩余用“...”替换


function GradeCtrl:GetShortName(long,sName)
	local nMaxCount = long
	local nShowCount = long
     if sName == nil or nMaxCount == nil then
         return
     end
     local sStr = sName
     local tCode = {}
     local tName = {}
     local nLenInByte = #sStr
     local nWidth = 0
     if nShowCount == nil then
        nShowCount = nMaxCount - 3
     end
     for i=1,nLenInByte do
         local curByte = string.byte(sStr, i)
         local byteCount = 0
         if curByte>0 and curByte<=127 then
             byteCount = 1
         elseif curByte>=192 and curByte<223 then
             byteCount = 2
         elseif curByte>=224 and curByte<239 then
             byteCount = 3
         elseif curByte>=240 and curByte<=247 then
             byteCount = 4
         end
         local char = nil
         if byteCount > 0 then
             char = string.sub(sStr, i, i+byteCount-1)
             i = i + byteCount -1
         end
         if byteCount == 1 then
             nWidth = nWidth + 1
             table.insert(tName,char)
             table.insert(tCode,1)
             
        elseif byteCount > 1 then
             nWidth = nWidth + 2
             table.insert(tName,char)
             table.insert(tCode,2)
         end
     end
     
    if nWidth > nMaxCount then
         local _sN = ""
         local _len = 0
         for i=1,#tName do
             _sN = _sN .. tName[i]
             _len = _len + tCode[i]
             if _len >= nShowCount then
                 break
             end
         end
         sName = _sN .. ".."
     end
     return sName
 end
--金币
 function GradeCtrl.OnJinBiBtnClick(go,bool)
	local self = GradeCtrl

	if bool  then
		Game.MusicEffect(Game.Effect.joinRoom)
		GradePanel.imgMask:SetActive(false)
		GradePanel.gridJinBiPanel:SetActive(true)
		GradePanel.gridCardPanel:SetActive(false)
		GradePanel.gridYuanBaoPanel:SetActive(false) 

		gradeDetailType = 1

			--if DradeObjList ~= nil or #DradeObjList ~=0 then
			for k,v in pairs(DradeObjList) do
				self:RemoveClick(DradeObjList[k])
				DradeObjList[k]:Destroy()
			end
			DradeObjList = {}
		   -- end

		
		if selfGradeMasg[gradeDetailType] == nil then
			BlockLayerCtrl:UsualOpen("BlockLayer")
			local zhanjiInfo = ZhanJiInfo_pb.ZhanJiInfoReq()
			zhanjiInfo.pageNum = 1
			zhanjiInfo.moneyType = 1
			local msg = zhanjiInfo:SerializeToString()
			Game.SendProtocal(Protocal.ZhanJiInfo, msg)
			return
		end

		if selfGradeMasg[gradeDetailType] == nil then
			GradePanel.txtNull:SetActive(true)
			--关闭阻挡层
			BlockLayerCtrl:Close()
			return
		else
			GradePanel.txtNull:SetActive(false)
			BlockLayerCtrl:UsualOpen("BlockLayer")
		end
		resMgr:LoadPrefab('grade',{'gridPlayerInfo'},self.GradeJinBiInfo)
	end
end
--元宝
function GradeCtrl.OnYuanBaoBtnClick(go,bool)
	local self = GradeCtrl
	    if bool  then
		Game.MusicEffect(Game.Effect.joinRoom)
		GradePanel.imgMask:SetActive(false)
		GradePanel.gridYuanBaoPanel:SetActive(true)
		GradePanel.gridJinBiPanel:SetActive(false)
		GradePanel.gridCardPanel:SetActive(false) 
		gradeDetailType = 2

		  --if DradeObjList ~= nil or #DradeObjList ~=0 then
			for k,v in pairs(DradeObjList) do
				self:RemoveClick(DradeObjList[k])
				DradeObjList[k]:Destroy()
			end
			DradeObjList = {}

		  --end
		  if selfGradeMasg[gradeDetailType] == nil then
			BlockLayerCtrl:UsualOpen("BlockLayer")
			local zhanjiInfo = ZhanJiInfo_pb.ZhanJiInfoReq()
			zhanjiInfo.pageNum = 1
			zhanjiInfo.moneyType = 2
			local msg = zhanjiInfo:SerializeToString()
			Game.SendProtocal(Protocal.ZhanJiInfo, msg)
			return
		  end
		  if selfGradeMasg[gradeDetailType] == nil then
			 GradePanel.txtNull:SetActive(true)
			--关闭阻挡层
			 BlockLayerCtrl:Close()
			return
		 else
			GradePanel.txtNull:SetActive(false)
			BlockLayerCtrl:UsualOpen("BlockLayer")
		 end
		 resMgr:LoadPrefab('grade',{'gridPlayerInfo'},self.GradeYuanBaoInfo)
	end
end

--房卡
function GradeCtrl.OnFangKaBtnClick(go,bool)
	local self = GradeCtrl
	if bool  then
		Game.MusicEffect(Game.Effect.joinRoom)
		GradePanel.imgMask:SetActive(false)
		GradePanel.gridJinBiPanel:SetActive(false)
		GradePanel.gridYuanBaoPanel:SetActive(false)
		GradePanel.gridCardPanel:SetActive(true) 
		gradeDetailType = 0
		--if DradeObjList ~= nil or #DradeObjList ~=0 then
			for k,v in pairs(DradeObjList) do
				self:RemoveClick(DradeObjList[k])
				DradeObjList[k]:Destroy()
			end
			DradeObjList = {}
		--end
		if selfGradeMasg[gradeDetailType] == nil then
			BlockLayerCtrl:UsualOpen("BlockLayer")
			local zhanjiInfo = ZhanJiInfo_pb.ZhanJiInfoReq()
			zhanjiInfo.pageNum = 1
			zhanjiInfo.moneyType = 0
			local msg = zhanjiInfo:SerializeToString()
			Game.SendProtocal(Protocal.ZhanJiInfo, msg)
			return
		end
		if selfGradeMasg[gradeDetailType] == nil then
			GradePanel.txtNull:SetActive(true)
			--关闭阻挡层
			BlockLayerCtrl:Close()
			return
		else
			GradePanel.txtNull:SetActive(false)
			BlockLayerCtrl:UsualOpen("BlockLayer")
		end
		resMgr:LoadPrefab('grade',{'gridCardPlayerInfo'},self.GradeCardInfo)
	end
end

--[[function GradeCtrl.OntogZhajinhuaClick(go,bool)
	--未完成功能全都不显示
    if IS_COMPLETE_FUNCTION then
        GradePanel.imgMask:SetActive(true)
        return 
    end
	local self = GradeCtrl
	if bool  then
		Game.MusicEffect(Game.Effect.joinRoom)
		GradePanel.imgMask:SetActive(false)
		GradePanel.gridMahjongPanel:SetActive(false)
		GradePanel.gridCardPanel:SetActive(true) 
		gradeDetailType = 3
		if DradeObjList ~= nil then
			for k,v in pairs(DradeObjList) do
				self:RemoveClick(DradeObjList[k])
				DradeObjList[k]:Destroy()
			end
			DradeObjList = {}
		end
		if selfGradeMasg[gradeDetailType] == nil then
			BlockLayerCtrl:UsualOpen("BlockLayer")
			local zhanjiInfo = ZhanJiInfo_pb.ZhanJiInfoReq()
			zhanjiInfo.pageNum = 1
			zhanjiInfo.gameType = 3
			local msg = zhanjiInfo:SerializeToString()
			Game.SendProtocal(Protocal.ZhanJiInfo, msg)
			return
		end
		if selfGradeMasg[gradeDetailType] == nil then
			GradePanel.txtNull:SetActive(true)
			--关闭阻挡层
			BlockLayerCtrl:Close()
			return
		else
			GradePanel.txtNull:SetActive(false)
			BlockLayerCtrl:UsualOpen("BlockLayer")
		end
		resMgr:LoadPrefab('grade',{'gridCardPlayerInfo'},self.GradeCardInfo)
	end
end--]]


--[[function GradeCtrl.OntogNiuniuClick(go,bool)
	local self = GradeCtrl
	if bool  then
		Game.MusicEffect(Game.Effect.joinRoom)
		GradePanel.imgMask:SetActive(false)
		GradePanel.gridMahjongPanel:SetActive(false)
		GradePanel.gridCardPanel:SetActive(true) 
		gradeDetailType = 5
		if DradeObjList ~= nil then
			for k,v in pairs(DradeObjList) do
				self:RemoveClick(DradeObjList[k])
				DradeObjList[k]:Destroy()
			end
			DradeObjList = {}
		end
		if selfGradeMasg[gradeDetailType] == nil then
			BlockLayerCtrl:UsualOpen("BlockLayer")
			local zhanjiInfo = ZhanJiInfo_pb.ZhanJiInfoReq()
			zhanjiInfo.pageNum = 1
			zhanjiInfo.gameType = 5
			local msg = zhanjiInfo:SerializeToString()
			Game.SendProtocal(Protocal.ZhanJiInfo, msg)
			return
		end
		if selfGradeMasg[gradeDetailType] == nil then
			GradePanel.txtNull:SetActive(true)
			--关闭阻挡层
			BlockLayerCtrl:Close()
			return
		else
			GradePanel.txtNull:SetActive(false)
			BlockLayerCtrl:UsualOpen("BlockLayer")
		end
		resMgr:LoadPrefab('grade',{'gridCardPlayerInfo'},self.GradeCardInfo)
	end--]]
