BaseCtrl = {
	isClose = true,
}
setbaseclass(BaseCtrl, { Invoker })

function BaseCtrl:Open(name, callback, isUsual)
	self.isClose = false
	if name and(not self.name) and(not self.isCreate) then
		if not isUsual then
			BlockLayerCtrl:UsualOpen("BlockLayer")
		end

		print('BaseCtrl:Open11111111', name, self.name, self.isCreate, isUsual)
		self.name = name
		CtrlManager.AddCtrl(name, self)
		local CreatePanel
		if isUsual then
			CreatePanel = panelMgr.CreateUsualPanel
		else
			CreatePanel = panelMgr.CreatePanel
		end
		CreatePanel(panelMgr, name, function(obj)
			if not isUsual then
				BlockLayerCtrl:Close()
				print('BaseCtrl:Open222222222', name)
			end
			-- if self.isClose then
			-- 	destroy(obj)
			-- else
			print('BaseCtrl:Open777777777777', name)
			self:OnCreate(obj)
			print('BaseCtrl:Open66666666666666', name)
			if self.isClose then
				obj:SetActive(false)
			else
				if callback then
					print('BaseCtrl:Open88888888888888888', name)
					callback()
					print('BaseCtrl:Open99999999999999', name)
				end
			end
			self.isCreate = true
			print('BaseCtrl:Open3333333333', name)
			-- end
		end )
		print('BaseCtrl:Open44444444444', name)
	else
		if self.gameObject then
			--print('BaseCtrl:Open55555555555', self.gameObject.name)
			self.gameObject:SetActive(true)
			local rect = self.gameObject:GetComponent('RectTransform')
			rect:SetAsLastSibling()
			if callback then
				callback()
			end
		end
	end
end

function BaseCtrl:UsualOpen(name, callback)
	self:Open(name, callback, true)
end

function BaseCtrl:OnCreate(obj)
	self.gameObject = obj
	self.lua = self.gameObject:GetComponent('LuaBehaviour')
end

function BaseCtrl:Close(isRemove)
	self.isClose = true
	if isRemove then
		if self.name then
			CtrlManager.RemoveCtrl(self.name)
		end
		self.isCreate = false
		self.lua = nil
		print("-----------------------------------置空置空置空置空置空置空------------------")
		if self.gameObject then
			destroy(self.gameObject)
			self.gameObject = nil
		end
		if self.name then
			panelMgr:ClosePanel(self.name)
		end
		self.name = nil
	else
		if self.gameObject then
			self.gameObject:SetActive(false)
		end
	end
	self:CancelInvoke()
end

function BaseCtrl:SetText(go, str)
	self.lua:SetText(go, tostring(str))
end

function BaseCtrl:SetTextMesh(go, str)
	self.lua:SetTextMesh(go, tostring(str))
end

function BaseCtrl:GetInputText(go)
	return self.lua:GetInputText(go)
end

function BaseCtrl:SetInputText(go, str)
	return self.lua:SetInputText(go, tostring(str))
end

function BaseCtrl:GetText(go)
	return self.lua:GetText(go)
end

function BaseCtrl:SetProgress(go, per)
	self.lua:SetProgress(go, per)
end

function BaseCtrl:AddClick(go, func)
	self.lua:AddClick(go, func)
end

function BaseCtrl:AddClickNoChange(go, func)
	self.lua:AddClickNoChange(go, func)
end

function BaseCtrl:AddOnValueChanged(go, func)
	self.lua:AddOnValueChanged(go, func)
end


function BaseCtrl:AddOnScrollValueChange(go, func)
	self.lua:AddOnScrollValueChange(go, func)
end

function BaseCtrl:RemoveClick(go)
	self.lua:RemoveClick(go)
end

function BaseCtrl:AddOnEndEdit(go, func)
	self.lua:AddOnEndEdit(go, func)
end