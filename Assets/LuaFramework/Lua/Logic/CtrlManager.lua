--文件：控制器管理

require "Common/define"

CtrlManager = {};
local this = CtrlManager;
local ctrlList = {};	--控制器列表--

--初始化控制器--
function CtrlManager.Init()
	logWarn("CtrlManager.Init----->>>");
	for _, v in pairs(CtrlNames) do
		dofile("Controller/" .. v)
	end

	return this;
end


--添加控制器--
function CtrlManager.AddCtrl(ctrlName, ctrlObj)
	ctrlList[ctrlName] = ctrlObj;
end

--移除控制器--
function CtrlManager.RemoveCtrl(ctrlName)
	ctrlList[ctrlName] = nil;
end

function CtrlManager.RemoveAll()
	for k, v in pairs(ctrlList) do
		v:Close(true)
		ctrlList[k] = nil
	end
end
