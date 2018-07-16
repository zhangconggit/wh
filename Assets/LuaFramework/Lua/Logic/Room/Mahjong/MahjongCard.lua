require "Common/define"
-- 声明，这里声明了类名还有属性，并且给出了属性的初始值。
MahjongCard = {
	index = 0,
	chessInfoVo = nil,
	gameObject = nil,
	transform = nil,
	colorType = 0,
	num = 0,
	id = 0,
	hasMo = false,
}

local this = MahjongCard;
MahjongCard.__index = MahjongCard;

function MahjongCard:New()
	local self = { };
	-- 初始化self，如果没有这句，那么类所建立的对象改变，其他对象都会改变
	setmetatable(self, MahjongCard);
	return self;
end

-- 背面平放（竖着）  背面平放（横着）        侧面-左面；    侧面 - 右面； 4 背面 --对面
-- 0 ----——            1 -------              2|--|      	3|--|            |------|
--  |    |            |        |              |  |       	 |  |            |      |
--  |    |            |________|			  |  |       	 |  |			 |      |
--- |___ |                                    |——|       	 |__|            |------|
function MahjongCard:setStatic(stc)

	self.static = stc;

	if self.static == 0 then
		self.transform.rotation = Quaternion.Euler(Vector3.New(-90, 0, 0));
	elseif self.static == 1 then
		self.transform.rotation = Quaternion.Euler(Vector3.New(-90, 0, 90));
	elseif self.static == 2 then
		self.transform.rotation = Quaternion.Euler(Vector3.New(0, 90, 0));
	elseif self.static == 3 then
		self.transform.rotation = Quaternion.Euler(Vector3.New(0, -90, 0));
	elseif self.static == 4 then
		self.transform.rotation = Quaternion.Euler(Vector3.New(0, 180, 0));
	end

end



