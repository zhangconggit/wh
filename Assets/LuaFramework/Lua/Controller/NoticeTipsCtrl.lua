--公告

NoticeTipsCtrl = {};
setbaseclass(NoticeTipsCtrl,{BaseCtrl});
local selfMsg 		= nil;		--播放信息
local selfDelay 	= 0;		--间隔时间（计算time）
local selfMovetime 	= nil;
local selfStaytime 	= nil;
local selfMoveTo 	= nil;
local lastInterval = 30;		--记录上一次公告间隔
local time 			=1;			--循环次数
local sequence

--启动事件--
function NoticeTipsCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self,obj);
	-- obj.transform.localPosition = Vector3.New(356,217,0);
	obj.transform.localPosition = Vector3.New(100,240,0);
	if Game.GetSceneName() == "main" then
		obj.transform.localPosition = Vector3.New(100,240,0);
	end
	if Game.GetSceneName() == "mahjong" then
		obj.transform.localPosition = Vector3.New(30,217,0);
	end
	if Game.GetSceneName() == "room" then
		obj.transform.localPosition = Vector3.New(30,217,0);
	end
	NoticeTipsPanel.txtNotice.transform.localPosition = Vector3.New(270,-20,0);
	self:InitPanel(); 
end

--初始化面板--
function NoticeTipsCtrl:InitPanel()
	NoticeTipsPanel.imgTitle:SetActive(false)
	global.NoticeMsg[1] = { 
    	id = 000,
    	content = "本游戏禁止赌博，一旦发现进行封号处理，严重者报送公安机关。<color=#e74606>本游戏绝无外挂, 凡举报经核实无误奖励".." 100万</color>", 
    	-- content = "本游戏禁止赌博，一旦发现进行封号处理，严重者报送公安机关。",
		interval = 30, 
		beginTime = 0, 
		endTime = 0
	};
	selfMsg = global.NoticeMsg[1].content;
	local length = #selfMsg/3;
    self:SetText(NoticeTipsPanel.txtNotice,selfMsg);
    selfMoveTo  = -((length * 25) + 265);
    selfMovetime = global.NoticeMsg[1].interval ;
    selfStaytime = global.NoticeMsg[1].interval ;
    time = 1;

    if Game.GetSceneName() == "mahjong" or Game.GetSceneName() == "room" then
		self.gameObject:SetActive(false)
	end

	self.curId = 1
	self:StartMsgAnim()		
end

--公告播放
function NoticeTipsCtrl:StartMsgAnim()
	sequence = DG.Tweening.DOTween.Sequence();
	sequence:Append(NoticeTipsPanel.txtNotice.transform:DOLocalMove(Vector3.New(selfMoveTo,-20,0),selfMovetime ,false))
			:Insert(selfStaytime ,NoticeTipsPanel.txtNotice.transform:DOLocalMove(Vector3.New(270,-20,0),0,false))
			:SetLoops(time)
			:OnComplete(function()
				self.curId = self.curId + 1
				end)
			:OnKill(function()
				if self.isClose then
					return
				end
				if self.curId > #global.NoticeMsg then
					self.curId = 1
				end
				for i = 1, #global.NoticeMsg do 
					if tostring(os.time()) <= tostring(global.NoticeMsg[i].endTime) and tostring(os.time()) >= tostring(global.NoticeMsg[i].beginTime) then

						if i == self.curId then
							if Game.GetSceneName() == "mahjong" or Game.GetSceneName() == "room" then
								if self.gameObject then 
									self.gameObject:SetActive(true) 
								end
							end
							if Game.GetSceneName() == "room" then
								if self.gameObject then 
									self.gameObject:SetActive(true) 
								end
							end
							selfMsg = global.NoticeMsg[i].content;
							lastInterval = global.NoticeMsg[i].interval;
							time = 1
							break
						end
					else
						if Game.GetSceneName() == "mahjong" or Game.GetSceneName() == "room" then
							if self.gameObject then 
								self.gameObject:SetActive(false) 
							end
						end
						selfMsg = global.NoticeMsg[1].content;
						if math.floor(lastInterval/30) < 1 then
							time =  1
						else
							time =  math.floor(lastInterval/30)
						end
					end
				end
				local length = #selfMsg/3;
				if self.gameObject then 
					self:SetText(NoticeTipsPanel.txtNotice,selfMsg); 
				end
			    selfMoveTo  = -((length * 25) + 265);
			    selfMovetime = length ;
			    selfStaytime = length ;
			    if self.gameObject then
			    	self:StartMsgAnim()
			    end
		    end);
end

--收到服务器拉取公告列表消息
function NoticeTipsCtrl.OnGetNoticeInfoRes(buffer)
    global.NoticeMsg = {};
    global.NoticeMsg[1] = { 
    	id = 000,
    	-- content = "本游戏禁止赌博，一旦发现进行封号处理，严重者报送公安机关。", 
    	content = "本游戏禁止赌博，一旦发现进行封号处理，严重者报送公安机关。<color=#e74606>本游戏绝无外挂, 凡举报经核实无误奖励".." 100万</color>", 
		interval = 30, 
		beginTime = 0, 
		endTime = 0
	};
	--table.insert(global.NoticeMsg, info)

	local data   = buffer:ReadBuffer();
	local msg    = Announce_pb.AnnounceRes();

	msg:ParseFromString(data);

	local AnnounceInfo = msg.announceInfo;
	if AnnounceInfo then
	  local len = table.maxn(AnnounceInfo)
		for i = 1,len,1 do
			local noticeInfoVo   = NoticeInfoVo:New();
			noticeInfoVo.id  = AnnounceInfo[i].id;
			noticeInfoVo.content    = AnnounceInfo[i].content;
			noticeInfoVo.interval  = AnnounceInfo[i].interval;
			noticeInfoVo.beginTime = AnnounceInfo[i].beginTime;
			noticeInfoVo.endTime = AnnounceInfo[i].endTime;

			local info = {
				id = noticeInfoVo.id,
				content = Util.ReplaceSpecialWord(noticeInfoVo.content), 
				interval = noticeInfoVo.interval, 
	            beginTime = noticeInfoVo.beginTime, 
	            endTime = noticeInfoVo.endTime 
		    };
		    table.insert(global.NoticeMsg, info)
		end
    end
end

--收到服务器添加公告列表消息
function NoticeTipsCtrl.OnAddNoticeInfoRes(buffer)
	local data   = buffer:ReadBuffer();
	local msg    = Announce_pb.AnnounceInfo();	
	msg:ParseFromString(data);
	
	local AnnounceInfo = msg;
	
	local noticeInfoVo   = NoticeInfoVo:New();
	
	noticeInfoVo.id  = AnnounceInfo.id;
	noticeInfoVo.content    = AnnounceInfo.content;
	noticeInfoVo.interval  = AnnounceInfo.interval;
	noticeInfoVo.beginTime = AnnounceInfo.beginTime;
	noticeInfoVo.endTime = AnnounceInfo.endTime;	
	
    local info = { 
    	id = noticeInfoVo.id,
    	content = Util.ReplaceSpecialWord(noticeInfoVo.content), 
		interval = noticeInfoVo.interval, 
		beginTime = noticeInfoVo.beginTime, 
		endTime = noticeInfoVo.endTime 
	};
	table.insert(global.NoticeMsg, info)
end

--收到服务器删除公告列表消息
function NoticeTipsCtrl.OnDelNoticeInfoRes(buffer)

	local data   = buffer:ReadBuffer();
	local msg    = LongTypeReturn_pb.LongTypeReturnRes();	
	msg:ParseFromString(data);
	local longVal = msg.longVal;

	for i, v in ipairs(global.NoticeMsg) do
		if v.id == longVal then
			table.remove(global.NoticeMsg, i)
			break
		end
	end   
end

--收到服务器拉取版本公告消息
function NoticeTipsCtrl.OnGetVersionNoitceInfoRes(buffer)
	local data   = buffer:ReadBuffer();
	local msg    = VersionNotice_pb.VersionNoticeRes();	
	msg:ParseFromString(data);
	
	local VersionNoticeInfo = msg.VersionNoticeInfo[1];
	
	local versionNoticeInfoVo   = VersionNoticeInfoVo:New();
	
	versionNoticeInfoVo.type  = VersionNoticeInfo.type;
	versionNoticeInfoVo.content    = VersionNoticeInfo.content;
	versionNoticeInfoVo.noticeV  = VersionNoticeInfo.noticeV;

	global.versionNoticeInfoVo = versionNoticeInfoVo;						--全局存储用户信息
end
