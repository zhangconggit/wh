require "Model/Vo/UserVo"
require "Model/Vo/roomRedDragonVo"
require "Model/Vo/RoomVo"
require "Model/Vo/SingleSettlementVo"
require "Model/Vo/TotalSettlementVo"
require "Model/Vo/NoticeInfoVo"
require "Model/Vo/VersionNoticeInfoVo"
require "Model/Vo/RoomUserVo"
require "Model/Vo/JoinRoomUserVo"
require "Model/Vo/SystemVo"
require "Model/Vo/PlayChess"
require "Model/Vo/ReLoadVo"
require "Model/Vo/SignOperateChess"
require "Model/Vo/RoomTenHalfVo"
require "Model/Vo/RoomJinHuaVo"
require "Model/Vo/RoomNiuVo"
require "Model/Vo/RoomCatchVo"
require "Model/Vo/roomWuZiQiVo"

Global = {
	userVo = nil,
	roomRedDragonVo = nil,
	roomVo = nil,
	-- 麻将房间信息
	roomTenHalfVo = nil,
	-- 十点半房间信息
	singleSettlementVo = nil,
	totalSettlementVo = nil,
	applyDisRoomVo = nil,
	noticeInfoVo = nil,
	versionNoticeInfoVo = nil,
	clientCheckInfoVo = nil,
	roomUserList = nil,
	joinRoomUserVos = { },
	firstMoChess = nil,
	systemVo = nil,
	playChess = nil,
	reloadVo = nil,
	signOperateChess = nil,
	isDebug = false,
	isUserType = 0,
	currentDiamond = 0,
	methodText = '',
	-- 临时变量
	objDNXB = nil,
	setPosition = { },
	roleInfoTable = { },
	-- jifen
	gpsMsgInfo = { },
	-- GPS
	isSendGPS = false,
	-- 是否发送过GPS
	gpsMsgLocation = "0/0/0",
	NoticeMsg = { },
	-- 公告
	isregister = false,-- 是否第一次注册
}

Global.__index = Global

function Global:New()
	local self = { };
	setmetatable(self, Global);
	return self;
end


function getRoleIndexById(roleId)
	local roomNum = getLength(global.joinRoomUserVos);
	for i = 1, roomNum do
		if (global.joinRoomUserVos[i].roleId == roleId) then
			return global.joinRoomUserVos[i].index;
		end
	end
	return 0;
end

-- 根据位置获取ID
function getRoleIdByIndex(roleIndex)
	local roomNum = getLength(global.joinRoomUserVos);
	for i = 1, roomNum do
		if (global.joinRoomUserVos[i].index == roleIndex) then
			return globale.joinRoomUserVos[i].roleId;
		end
	end
	return 0;
end

-- 金币元宝格式化
function formatNumber(numStr)
	if numStr ~= nil and numStr ~= '' then
		if numStr / 10 ^ 8 >= 1 then
			numStr = math.floor(numStr / 10 ^ 6)
			return string.format("%.2f", numStr / 10 ^ 2) .. '亿'
		elseif numStr / 10 ^ 4 >= 1 then
			numStr = math.floor(numStr / 10 ^ 2)
			return string.format("%.2f", numStr / 10 ^ 2) .. '万'
		else
			return tostring(numStr)
		end
	else
		return numStr
	end
end

-- 金币元宝格式化
function formatNumbers(numStr)
	if numStr ~= nil and numStr ~= '' then
		if tonumber(numStr) >= 100000000 then
			return string.format(tonumber(numStr) / 100000000) .. '亿'
		elseif tonumber(numStr) >= 10000 then
			return string.format(tonumber(numStr) / 10000) .. '万'
		else
			return tostring(numStr)
		end
	else
		return numStr
	end
end

function setRoomInfo(localRoom, roomMessage, ...)
	local roomInfoArray = string_split(localRoom:GetText(roomMessage), '\n')
	local arg = { ...}
	for i = 1, #arg do
		if arg[i] ~= '' then
			roomInfoArray[i] = arg[i]
		end
	end
	local roomInfo = ''
	localRoom:SetText(roomMessage, roomInfo)
	for i = 1, #roomInfoArray do
		roomInfo = roomInfo .. roomInfoArray[i] .. '\n'
	end
	localRoom:SetText(roomMessage, roomInfo)
end

function getPanelInfo(roleId)
	local num = 0;
	local roleInfo = { }
	for i = 1, #global.joinRoomUserVos do
		log(tostring(global.joinRoomUserVos[i].roleId));
		if roleId == global.joinRoomUserVos[i].roleId then
			num = i;
			log(tostring(num) .. '----num');
		end
	end
	-- 调取头像信息面板--
	roleInfo = { name = global.joinRoomUserVos[num].name, roleId = global.joinRoomUserVos[num].roleId, roleIp = global.joinRoomUserVos[num].ip }
	-- RoleInfoCtrl:GetInfo(global.joinRoomUserVos[num].name,global.joinRoomUserVos[num].roleId,global.joinRoomUserVos[num].ip);
	RoleInfoCtrl:Open("RoleInfo", function()
		RoleInfoCtrl:InitPanel(roleInfo)
	end );
end

-- 根据id获得玩家信息
function getOtherRoleInfo(roleId)
	local num = 0;
	local roleInfo = { }
	for i = 1, #global.joinRoomUserVos do
		log(tostring(global.joinRoomUserVos[i].roleId));
		if tostring(roleId) == tostring(global.joinRoomUserVos[i].roleId) then
			num = i;
			log(tostring(num) .. '----num');
			break
		end
	end
	-- 调取头像信息面板--
	roleInfo = { name = global.joinRoomUserVos[num].name, roleId = global.joinRoomUserVos[num].roleId, roleIp = global.joinRoomUserVos[num].ip }
	return roleInfo;
end

-- 根据主机ID取其他玩家的ID
function getOtherPlayerInfo(location)
	-- 本端的roleid
	local myRoleId = global.userVo.roleId;
	-- 获取当前端的索引
	local myIndex = getRoleIndexById(myRoleId);
	log(tostring(myIndex) .. '我的索引');
	log(tostring(getLength(global.joinRoomUserVos)) .. '加入房间人数');
	local len = getLength(global.joinRoomUserVos)
	local index = 0
	-- 获取右边人的ID
	if location == 'R' then
		index = index + 1
		if index > len then
			index = 1
		end
		-- 获取左边人的ID
	elseif location == 'L' then
		index = index - 1
		if index < 1 then
			index = len
		end
		-- 获取对面人的ID
	elseif location == 'U' then
		index = index + 2
		if index > len then
			index = index - len
		end
	end
	return getRoleIdByIndex(index);
end

-- function getWatchBattleRoleIndexById(roleId)
-- 	local roomNum = getLength(global.watchBattleUserVo);
-- 	for  i = 1, roomNum do
-- 		if(global.watchBattleUserVo[i].roleId == roleId) then
-- 			return global.watchBattleUserVo[i].index;
-- 		end
-- 	end
-- 	return 0;
-- end

-- -- 根据位置获取ID
-- function getWatchBattleRoleIdByIndex(roleIndex)
-- 	local roomNum = getLength(global.watchBattleUserVo);
-- 	for  i = 1, roomNum do
-- 		if(global.watchBattleUserVo[i].index == roleIndex) then
-- 			return global.watchBattleUserVo[i].roleId;
-- 		end
-- 	end
-- 	return 0;
-- end



-- function getWatchBattlePanelInfo ( roleId )
-- 	local num = 0;
-- 	local roleInfo = {}
-- 	for i = 1, #global.watchBattleUserVo do
-- 		log(tostring(global.watchBattleUserVo[i].roleId));
-- 		if roleId == global.watchBattleUserVo[i].roleId then
-- 			num = i;
-- 			log(tostring(num)..'----num');
-- 		end
-- 	end
-- 	--调取头像信息面板--
-- 	roleInfo = {name = global.watchBattleUserVo[num].name,roleId = global.watchBattleUserVo[num].roleId, roleIp = global.watchBattleUserVo[num].ip}
-- 	--RoleInfoCtrl:GetInfo(global.joinRoomUserVos[num].name,global.joinRoomUserVos[num].roleId,global.joinRoomUserVos[num].ip);
-- 	RoleInfoCtrl:Open("RoleInfo",function()
-- 			RoleInfoCtrl:InitPanel(roleInfo)
-- 		end);	
-- end

-- 根据主机ID取其他玩家的ID
-- function getWatchBattleOtherPlayerInfo(location)
-- 	-- 本端的roleid
-- 	local myRoleId = global.userVo.roleId;
-- 	-- 获取当前端的索引
-- 	local myIndex = getRoleIndexById(myRoleId);
-- 	log(tostring(myIndex)..'我的索引');
-- 	log(tostring(getLength(global.watchBattleUserVo))..'加入房间人数');
-- 	local len = getLength(global.watchBattleUserVo)
-- 	local index = 0
-- 	--获取右边人的ID
-- 	if location == 'R' then
-- 		index = index + 1
-- 		if index > len then
-- 			index = 1
-- 		end
-- 	--获取左边人的ID
-- 	elseif location == 'L' then
-- 		index = index - 1
-- 		if index < 1 then
-- 			index = len
-- 		end
-- 	--获取对面人的ID
-- 	elseif location == 'U' then
-- 		index = index + 2
-- 		if index > len then
-- 			index = index - len
-- 		end
-- 	end
-- 	return getWatchBattleRoleIdByIndex(index);
-- end

-- 根据索引获取位置
function getOtherPlayerLocation(index, isDeal)

	-- 本端的roleid
	local myRoleId = global.userVo.roleId;
	-- 获取当前端的索引
	local myIndex = getRoleIndexById(myRoleId);

	local len = global.roomVo.isPlayNum
	if isDeal and len == 3 then
		myIndex = 1
	end
	local dr = { 'D', 'R', 'U', 'L' }
	if not isDeal and len == 3 then
		dr = { 'D', 'R', 'L' }
	end
	local num = index - myIndex
	if num < 0 then
		num = num + len
	end
	return dr[num + 1]
end

-- 获取列表长度--
function getLength(tb)
	local count = 0
	for k, v in pairs(tb) do
		count = count + 1;
	end
	return count;
end

-- 时间戳转换--
function getTimeFormat(t)
	return os.date("%Y-%m-%d %H:%M:%S", t / 1000)
end

errorCode = {
	[1001] = '用户已存在',
	[1002] = '用户不存在',
	[1003] = '角色不存在',
	[1004] = '房间不存在',
	[1005] = '游戏已开始',
	[1006] = '房间人已满',
	[1007] = '你没有房间',
	[1008] = '操作异常',
	[1009] = '没有这张牌,怎么打的',
	[1010] = '不该你打牌啊亲',
	[1011] = '你已经有房间里,不能再创建',
	[1012] = '你没有房间，不能解散',
	[1013] = '房间已被房主{0}解散',
	[1014] = '你不是房间的创建者，不能解散',
	[1015] = '你已经在房间里，不能再加入',
	[1016] = '你走错协议了',
	[1017] = '消耗房卡全局配置异常',
	[1018] = ' 您的账户在其他地方登陆，请注意账户安全',
	[1019] = '当前局数已经打完了',
	[1020] = '现在还不能查看总战绩',
	[1021] = '玩家{0}申请解散房间，请等待其他玩家选择(超过{1}分钟未做选择，则默认同意)',
	[1022] = '玩家{0}申请解散房间，请选择是否同意(超过{1}分钟未做选择，则默认同意)',
	[1023] = '玩家{0}拒绝解散房间，牌局继续',
	[1024] = '玩家{0}同意，解散房间成功',
	[1025] = '房间{0}超过{1}分钟未全部做出选择，已默认解散',
	[1026] = '有玩家解散房间,你怎么还点的开始游戏',
	[1027] = '房间已存在',
	[1028] = '你有标签操作，请先操作标签',
	[1029] = '查看战绩没有数据',
	[1030] = '找不到邮件信息',
	[1031] = '房卡为0.领个毛线啊',
	[1032] = '消耗货币类型错误',
	[1033] = '很抱歉,您的房卡不足 ',
	[1034] = '找不到回放记录',
	[1035] = '数据错误（碰杠胡过路杠。signMap不为空的）',
	[1036] = '标签操作数据异常（signMap找不到roleid）',
	[1037] = '错误的登陆类型',
	[1038] = '找不到session',
	[1039] = '游客登陆一个设备只能有一个账号，账号为空了',
	[1040] = '服务器升级维护中，请耐心等待',
	[1041] = '拉取微信信息的时候。openid为null',
	[1042] = '微信登录的userid不能为空',
	[1043] = '不该你下注',
	[1044] = '发牌同步超出人数',
	[1045] = '资源同步超出人数',
	[1046] = '请等待其他玩家发牌流程结束',
	[1047] = '当前局已打完',
	[1048] = '重连userid不能为空',
	[1049] = "你没有权限",
	[1050] = "找不到被赠送的人",
	[1051] = "赠送的房卡不能小于0",
	[1052] = "不能给自己赠送啊",
	[1053] = "当前局没有结束。怎么点的开始游戏",
	[1054] = "资源同步此房间找不到此人",
	[1055] = "当前牌已被使用过不能打牌",
	[1056] = "管理人员只能给代理赠送赠送",
	[1057] = "代理只能给玩家赠送",
	[1058] = "下的鱼错误",
	[1059] = "重连的时候用户不存在,请联系客服",
	[1060] = "重连的时候角色不存在",
	[1061] = "重连的时候session不存在",
	[1062] = "你不是房主，不能开始游戏",
	[1063] = "不该你操作",
	[1064] = "最多5张牌",
	[1065] = "你已经不能补牌了",
	[1066] = "其他玩家都已经爆牌，不能点比牌，自动结算",
	[1067] = "你不是庄，不能比牌",
	[1068] = "1个人不能开始游戏",
	[1069] = "其他人没有准备好，你怎么开始操作是否当庄了",
	[1070] = "你当前不是庄，不允许操作",
	[1071] = "你是庄，不能执行抢庄操作",
	[1072] = "你已当完庄了。",
	[1073] = "你已抢过庄。",
	[1074] = "庄不能下注。",
	[1075] = "分享类型错误。",
	[1076] = "房间没开始。你怎么操作的",
	[1077] = "你已经弃牌",
	[1078] = "你已经看过牌了",
	[1079] = "闷的轮数不够，不能看牌",
	[1080] = "比牌找不到对方索引",
	[1081] = "双方都看牌以后才能比牌",
	[1082] = "自己跟自己不能比牌",
	[1083] = "轮数小于比牌轮数",
	[1084] = "必须在游戏中才能操作",
	[1085] = "分数错误",
	[1086] = "比牌的时候找不到上一个人的操作索引",
	[1087] = "下注已达上线",
	[1088] = "只有3个人的时候才能开始游戏",
	[1089] = "房间内所有人都准备了才可以开始",
	[1090] = "手里没有这张牌，怎么打出去的",
	[1091] = "不符合出牌规则",
	[1092] = "红桃3先出",
	[1093] = "下家报单了，不能放水哦",
	[1094] = "最大不能连到2",
	[1095] = "房卡不足，不能报名",
	[1096] = "你已经有房间了，不能加入比赛",
	[1097] = "比赛已经开始，不能退出比赛",
	[1098] = "比赛场数据异常",
	[1099] = "你已经在比赛报名中，不能重复报名",
	[1100] = "不在比赛中，不能放弃比赛",
	[1101] = "找不到比赛场",
	[1102] = "比赛场找不到玩家",
	[1103] = "你已经放弃了比赛",
	[1104] = "数据异常。有比赛场数据",
	[1105] = "托管数据传输错误",
	[1106] = "托管状态下不能操作",
	[1107] = "天炸必须先出",
	[1108] = "比赛场房间超时，请联系开发人员",
	[1109] = "托管状态下不能打牌",
	[1110] = "期数获取错误",
	[1111] = "房卡夺宝模板错误",
	[1112] = "当期数据异常",
	[1113] = "你已经参与了当期的夺宝",
	[1114] = "当期夺宝人数已满",
	[1115] = "当期夺宝已开奖",
	[1116] = "关闭夺宝面板,玩家不在列表中",
	[1117] = "注册新用户参数错误",
	[1118] = "点炮必胡模式必须要胡",
	[1119] = "你已经下注了",
	[1120] = "还有其他人没有下注完，不能亮牌",
	[1121] = "目前没有自由匹配房间",
	[1122] = "自由匹配房间配置属性错误",
	[1123] = "很抱歉角色金币不足",
	[1124] = "很抱歉角色元宝不足",
	[1125] = "扣除金币或者元宝错误",
	[1126] = "角色元宝或者金币不足",
	[1127] = "消耗金币或者元宝全局配置异常",
	[1200] = "不能换牌",
	[1201] = "不允许的下注数",
	[1202] = "已经换牌",
	[1203] = "抢庄倍数不对",
	[1204] = "不能加入匹配场",
	[9999] = "即将停服更新，详见系统公告",
	[999] = "不允许PC端登录",
	[1210] = "学费设置过多，不能超过100000！！！",
	[1211] = "学费设置过少，最低10000！！！",
	[1212] = "红中不要打！！！",
}