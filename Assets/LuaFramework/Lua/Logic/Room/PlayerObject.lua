require "Controller/BaseCtrl"
PlayerObject = {
}

setbaseclass(PlayerObject, { Invoker })

function PlayerObject:New(data, obj)
	local newObject = { }
	setmetatable(newObject, { __index = self })
	newObject:Init(data, obj)
	return newObject
end

function PlayerObject:Init(data, obj)
	-- 玩家手牌
	self.cards = { }
	-- 玩家打下去的牌
	self.playedCards = { }
	-- 玩家下注
	self.betCoins = { }
end

-- 打牌
function PlayerObject:PlayCard()

end

function PlayerObject:Destroy()
	for i, v in ipairs(self.cards) do
		v:Destroy()
	end
	self.cards = nil

	for i, v in ipairs(self.playedCards) do
		v:Destroy()
	end
	self.playedCards = nil
end

function PlayerObject:DoScale(obj)
	local ease = DG.Tweening.Ease
	-- local sequence = DG.Tweening.DOTween.Sequence()	--动画序列
	-- local rotateMod = DG.Tweening.RotateMode.Fast		--旋转模型
	local img = obj.transform:GetComponent("Image")
	img.rectTransform:DOScale(Vector3.New(1, 1, 1), 0.5):SetEase(ease.OutBounce):SetDelay(0.5)
	-- img.rectTransform:DOScale(Vector3.zero,0.3)
end

function PlayerObject:PlayEffect(time, img)
	img.rectTransform:DOScale(Vector3.zero, time):OnComplete( function()
		img:SetActive(false)
	end )
end