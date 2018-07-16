 --声明，这里声明了类名还有属性，并且给出了属性的初始值。
RoomTenHalfVo = {
 id         = 0,
 isFangzhu  = 0, --是否是创建房间房主 1为房主
 tenHalfTotal      = 0,
 isTen2     = 0,
 isFive3    = 0,
 isFive5    = 0,
 isTen5 	= 0,
 isWang  	= 1, --0代表没有王，1代表有王 
 isMaster   = 0,
 isRobot    = 0,
 --新添加
 baseNum	 = 0,	--底金
 qualified   = 0,   --合格金额
 moneyType   = 0,   --金币OR元宝 1金币 2元宝
}

RoomTenHalfVo.__index = RoomTenHalfVo

function RoomTenHalfVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, RoomTenHalfVo); 
    return self;  
end

 