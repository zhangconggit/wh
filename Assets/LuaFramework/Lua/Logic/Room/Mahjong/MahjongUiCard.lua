require "Common/define"
-- 声明，这里声明了类名还有属性，并且给出了属性的初始值。

MahjongUiCard = {
	index = 0,
	chessInfoVo = nil,
	gameObject = nil,
	transform = nil,
	colorType = 0,
	num = 0,
	id = 0,
	image = nil,
}

local this = MahjongUiCard;
MahjongUiCard.__index = MahjongUiCard;

function MahjongUiCard:New()
	local self = { };
	-- 初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
	setmetatable(self, MahjongUiCard);
	return self;
end

function MahjongUiCard:setStatic(stc)

end

