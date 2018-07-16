 --声明，这里声明了类名还有属性，并且给出了属性的初始值。
RoomCatchVo = {
 id         	= 0,
 isFangzhu  	= 0, --是否是创建房间房主 1为房主
 catchTotal    = 0,
  --新添加
 baseNum	 = 0,	--底金
 qualified   = 0,   --合格金额
 moneyType   = 0,   --金币OR元宝 1金币 2元宝
}

RoomCatchVo.__index = RoomCatchVo

function RoomCatchVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, RoomCatchVo); 
    return self;  
end
