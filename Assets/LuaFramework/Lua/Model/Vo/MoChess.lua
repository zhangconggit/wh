 
--声明，这里声明了类名还有属性，并且给出了属性的初始值。
MoChess = {

}

MoChess.__index = MoChess

function MoChess:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, MoChess); 
    return self;  
end