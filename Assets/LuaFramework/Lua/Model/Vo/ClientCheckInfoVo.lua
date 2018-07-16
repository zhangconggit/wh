 
--声明，这里声明了类名还有属性，并且给出了属性的初始值。
ClientCheckInfoVo = {
	playNum 			= 0,		--玩游戏的次数，用于查看战绩
	isFirst				= '';
	isGameOver			= 0;
	DXNB				= nil;
	playMethod			='';
}

ClientCheckInfoVo.__index = ClientCheckInfoVo

function ClientCheckInfoVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, ClientCheckInfoVo); 
    return self;  
end