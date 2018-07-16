 --声明，这里声明了类名还有属性，并且给出了属性的初始值。
roomRedDragonVo = {
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
}

roomRedDragonVo.__index = roomRedDragonVo

function roomRedDragonVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, roomRedDragonVo); 
    return self;  
end

 