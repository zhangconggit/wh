--声明，这里声明了类名还有属性，并且给出了属性的初始值。
RoomUserVo = {
 index     = 0,
 roleId    = 0,
 name      = '',
 ip        = '',
 headImg   = '',
}

RoomUserVo.__index = RoomUserVo

function RoomUserVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, RoomUserVo); 
    return self;  
end
