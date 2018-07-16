Main = { }

function Main:Start()
	print("=======Main.lua, Main.start=======Util.ClearMemor=====")
	Util.ClearMemory()
	print("=======Main.lua, Main.start=======begin open MainSence=====")
	MainSenceCtrl:Open("MainSence")
	-- CreateRoomCtrl:Open("CreateRoom", function()
	--     CreateRoomCtrl:Close()
	-- end)
	JoinRoomCtrl:Open("JoinRoom", function()
		JoinRoomCtrl:Close()
	end )
	if MainSenceCtrl.isOpenGrade then
		GradeCtrl:Open("Grade")
		GradeDetailCtrl:Open('GradeDetail')
		MainSenceCtrl.isOpenGrade = false
	end

	if GameMatchSettleCtrl.isOpenGameMatch then
		MainSenceCtrl:Open('GameMatch')
		GameRoomCardMatchCtrl:Open("GameRoomCardMatch")
		GameMatchSettleCtrl.isOpenGameMatch = false
	end

	-- 清理一些战斗状态
	global.roleInfoTable = { }
	global.joinRoomUserVos = { }
	global.setPosition = { }
	Room.gameType = RoomType.None
end

function Main:Update()
end