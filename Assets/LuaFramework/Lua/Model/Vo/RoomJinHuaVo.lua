 --声明，这里声明了类名还有属性，并且给出了属性的初始值。
RoomJinHuaVo = {
 id         	= 0,
 isFangzhu  	= 0, --是否是创建房间房主 1为房主
 jinHuaTotal    = 0,
 jinHuaPlayMethond    = 0,
 isLeopard   	= 0,
 isDouble    	= 0,
 isTop 			= 0,
 isCompare  	= 0, 
 isGuess   		= 0,
 --新添加
 baseNum	 = 0,	--底金
 qualified   = 0,   --合格金额
 moneyType   = 0,   --金币OR元宝 1金币 2元宝
}

RoomJinHuaVo.__index = RoomJinHuaVo

function RoomJinHuaVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, RoomJinHuaVo); 
    return self;  
end

 