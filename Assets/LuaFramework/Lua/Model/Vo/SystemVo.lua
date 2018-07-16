 
--声明，这里声明了类名还有属性，并且给出了属性的初始值。
SystemVo = {
isMusicOn 			= '1';
isMusicEffectOn 	= '1';
isShakeOn 			= '1';
isBigCardOn 		= '1';
isNXFYOn 			= '1';
EffectSource   		= nil;
TalkSource			= nil;
BGSource			= nil;
CardSource			= nil;
isTalk				= '0';
}

SystemVo.__index = SystemVo

function SystemVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, SystemVo); 
    return self;  
end

 