 
--声明，这里声明了类名还有属性，并且给出了属性的初始值。
WatchBattleUserVo = {
index  = 0,
roleId    = 0,
name  = '',
ip = '',
headImg = '',
jifen = 0,
sex = '',
diamond = 0,
isOnline = true,
curPaiMing = 0,
isTrusteeship = false,
goldcoin = 0,
wing = 0,
whetherWatch = false,
isReady = false,
}

WatchBattleUserVo.__index = WatchBattleUserVo

function WatchBattleUserVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, WatchBattleUserVo); 
    return self;  
end

 