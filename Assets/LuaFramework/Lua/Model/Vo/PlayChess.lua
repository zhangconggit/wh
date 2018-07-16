 
--声明，这里声明了类名还有属性，并且给出了属性的初始值。
PlayChess = {
	id 			= 0,		--牌的id
	color 		= 0,		--牌的花色
	num 		= 0,		--牌的数值
	used 		= 0,		--牌是否被用过
}

PlayChess.__index = PlayChess

function PlayChess:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, PlayChess); 
    return self;  
end