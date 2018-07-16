RotaryTableCtrl = {};
setbaseclass(RotaryTableCtrl,{BaseCtrl});

--启动事件--
function RotaryTableCtrl:OnCreate(obj)
	BaseCtrl.OnCreate(self, obj);
    --点击抽奖按钮
	self:AddClick(RotaryTablePanel.btnStart,self.OnStartClick)
	--返回按钮
    self:AddClick(RotaryTablePanel.btnBack,self.OnBackBtnClick)

	self:InitPanel();
end


--初始化面板
function RotaryTableCtrl:InitPanel()

end

--点击抽奖按钮
function RotaryTableCtrl.OnStartClick()
	local self = RotaryTableCtrl

	local msg = ""
    Game.SendProtocal(Protocal.LuckDraw, msg)
    
end

--点击返回按钮
function RotaryTableCtrl.OnBackBtnClick()
  Game.MusicEffect(Game.Effect.joinRoom)
  --RotaryTableCtrl:Close('RotaryTable')
  local self = RotaryTableCtrl
	--指针根据服务端发的数据进行一定角度的旋转
	--local sequence = DG.Tweening.DOTween.Sequence()	              --动画序列
	--local rotateMod = DG.Tweening.RotateMode.FastBeyond360		  --旋转模型
	--local zeroRotate = Vector3.New(0,0,-360)                        --这里的720度是暂定的,根据服务器的奖励来定
	--sequence:Append(RotaryTablePanel.imgPointer.transform:DORotate(zeroRotate,2,rotateMod))
	RotaryTablePanel.imgPointer.transform.rotation = Quaternion.AngleAxis(0, Vector3.right) --指针位置复原
end



function RotaryTableCtrl.OnRewardRes(buffer)
  local self = RotaryTableCtrl
  local data = buffer:ReadBuffer()
  local msg  = ShareSign_pb.LuckDraw()  
  msg:ParseFromString(data)

  local rewardType = msg.type                  --先假定有四种奖励
  local rewardNumber = msg.quantity              --玩家获得的奖励的数量
  local rotateAngle = 0                        --转盘转动的角度

  if rewardType == 0 then
  	rotateAngle = tonumber(45)
  end

  if rewardType == 1 then
  	rotateAngle = tonumber(135)
  end

  if rewardType == 2 then
  	rotateAngle = tonumber(225)
  end

  if rewardType == 3 then
  	rotateAngle = tonumber(315)
  end

  --指针根据服务端发的数据进行一定角度的旋转
	local sequence = DG.Tweening.DOTween.Sequence()	              --动画序列
	local rotateMod = DG.Tweening.RotateMode.FastBeyond360		  --旋转模型
	local zeroRotate = Vector3.New(0,0,-rotateAngle)                     --这里的720度是暂定的,根据服务器的奖励来定
	sequence:Append(RotaryTablePanel.imgPointer.transform:DORotate(zeroRotate,2,rotateMod))
	
	--当动画播放结束的时候要弹出玩家获得奖励的提示框
	--sequence:Append(RotaryTablePanel.imgPointer.transform:DOScale(0,0))

end


