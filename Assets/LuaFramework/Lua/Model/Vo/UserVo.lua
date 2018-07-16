 
--声明，这里声明了类名还有属性，并且给出了属性的初始值。
UserVo = {
 roleId  = 0,
 name    = '',
 gender  = '',
 diamond = '',
 headImg = '',
 roleIp  = '',
 goldcoin = '',
 wing = '',
 signDays = '',    --玩家已经签到的天数
 isSign = '',      --玩家是否签到
 signature = '',   --个性签名(新加)
 iconList = {imgId = 0, imgSprite = nil}
}

UserVo.__index = UserVo

function UserVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, UserVo); 
    return self;  
end

 