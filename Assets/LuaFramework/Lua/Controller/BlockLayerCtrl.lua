--阻挡层逻辑（菊花）
BlockLayerCtrl = {}
setbaseclass(BlockLayerCtrl,{BaseCtrl})

function BlockLayerCtrl:UsualOpen(name, callback)
	BaseCtrl.UsualOpen(self, name, callback)
	self:Invoke("Close", 10)
end

function BlockLayerCtrl:Close(isRemove)
	if not isRemove and self.isSpec then return end
	BaseCtrl.Close(self, isRemove)
	self.isSpec = false
end

function BlockLayerCtrl:OpenSpec()
	BaseCtrl.UsualOpen(self, "BlockLayer")
	self.isSpec = true
	self:Invoke("CloseSpec", 10)
end

function BlockLayerCtrl:CloseSpec()
	self.isSpec = false
	BaseCtrl.Close(self)
end