 --声明，这里声明了类名还有属性，并且给出了属性的初始值。
RoomVo = {
 id         = 0,
 total      = 0,
 modeType   = 0,
 roomNum    = 0,
 isSelf     = 0,
 isFeng     = 0,
 isRed      = 0,
 isFishNum  = 0,
 isFangzhu  = 0, --是否是创建房间房主 1.房主 2.加入房间的人3.比赛场
 isPlayNum   = 0,
 isRobot     = 0,
 playMethod	 = '',
 lun		 = 0, 	--比赛场轮数
 vscount	 = 0,	--比赛场人数
 vsRoomNum	 = 0,	--比赛场房间号  不等于0 就是比赛场
 vsType		 = 0,	--比赛类型
 isBihu		 = 0,	--点必胡
 --新添加
 baseNum	 = 0,	--底金
 qualified   = 0,   --合格金额
 moneyType   = 0,   --金币OR元宝 1金币 2元宝
 mcreenings  = 0,   --1初级场 2中级场 3高级场 4......
 --血战麻将新添加
 jushu      = 8,    --局数
 baseScore  = 1,    --底分
 fanshu     = 2,    --番数
 --PlayMethod = '11,12,13,14', --玩法
 replaceCard = 0,  --是否换三张 0不换1换
 cardType   = '15,16,17',  --牌型
 dataResForWait = 0,	--观战玩家进入打牌数据
 star,
 PlayMethodZimo	= 11,
 PlayMethodDiangang	= 13,
}

RoomVo.__index = RoomVo

function RoomVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, RoomVo); 
    return self;  
end

 