 
--声明，这里声明了类名还有属性，并且给出了属性的初始值。
TotalSettlementVo = {
 roleId        = 0,
 index     = 0,
 name    = '',
 zimoCount    = 0,
 jiepaoCount     = 0,
 dianpaoCount = 0,
angangCount = 0,
minggangCount = 0,
jifen = 0,
}

TotalSettlementVo.__index = TotalSettlementVo

function TotalSettlementVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, TotalSettlementVo); 
    return self;  
end

 