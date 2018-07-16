 
--声明，这里声明了类名还有属性，并且给出了属性的初始值。
VersionNoticeInfoVo = {
 type        = 0,  --版本公告类型 1=版本 2=官方
 content     = '',
 noticeV    = '', --公告的版本号
}

VersionNoticeInfoVo.__index = VersionNoticeInfoVo

function VersionNoticeInfoVo:New() 
    local self = {};    --初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
    setmetatable(self, VersionNoticeInfoVo); 
    return self;  
end

 