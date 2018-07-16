-- 声明，这里声明了类名还有属性，并且给出了属性的初始值。
RoomNiuVo = {
	id = 0,
	isFangzhu = 0,
	-- 是否是创建房间房主 1为房主
	niuTotal = 0,
	isWang = 0,
	isMaster = 0,
	totalJushu = 20,
	king = true,
	--leaderZhuang = false,
	niuniuGameType = 1,
	maxNum = 6,
	baseScore = "1-4",
	special = "11|12|13|14|15|16|17",
	maxZhuang = 4,
	maxPush = 40,
	seniorInfo = "",
	doubleRule = 1,
	-- 新添加
	moneyType = 0,
	baseNum = 0,
	qualified = 0,
}

RoomNiuVo.__index = RoomNiuVo

function RoomNiuVo:New()
	local self = { };
	-- 初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
	setmetatable(self, RoomNiuVo);
	return self;
end

 
 