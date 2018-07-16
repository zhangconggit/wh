 
--声明，这里声明了类名还有属性，并且给出了属性的初始值。
ApplyDisRoomVo = {
 roleId         = 0,		--玩家id
 name     		= '',		--昵称
 state   		= nil,		--操作状态 true=同意 false=拒绝
 time			= 0,		--等待时间
--其他玩家的信息--
 otherPlayerInfo = {
	id 			= 0,		--玩家id
	name 		= 0,		--昵称
	state 		= nil,		--操作状态
	},
}

ApplyDisRoomVo.__index = ApplyDisRoomVo

function ApplyDisRoomVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, ApplyDisRoomVo); 
    return self;  
end